Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37E32086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547456723;
	bh=Y4Zmd+oGVfsCSlTymsoH6JK+rl66AdTTVZwYKk/tRQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gSK0HvzNGLdPpdQnqKG/0XgaIXodUwj9qJivs9/nHb7p7b0ijIHgfwOc7u+cdorub
	 uEsZmEIZaFUZDYRG+ueyLWFykmS4sIskCGGm1rybAvPXHu1bZuzWH/Ok027E1pJD1R
	 7R0Ed6IYdyjHRKwUUXhnAc+xYCPn4MgI6uhBCIEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfANJFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:05:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45482 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANJFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:05:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so18259924ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 01:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B3yeXNADdUT3tvPE58CoKhKcUyQIi+GuM9fymG8S/bQ=;
        b=qG7DK715MDp3iUanEJi8PFOq08mKU3UlVpaQI4gFyXlCiWLjJ01Hmvf5F2gUFB3skD
         J0eg1GxrFaUNrn/9HpjbcTQneeLFeoczr5VitXedSTausu1wdp3c+l18vsV0mY7vawRJ
         7vmidEP+Yrw9KBpVhnY75k6dVunGhh1+qp/jdKfmfaTd1RGB50tPsIje+faemDq1pZNC
         3qyaJxGph+ExTFFbGIpBP3eLsK6dtVsWsL0MK0QKZZqGtdy0gOyJ+wUkAk51gU3V318C
         nZOtdbd+G/rWxpv6klnJ/guuIwRMHhp2ib1S4MeLDRW+2W3DajTeFBr4yay0h5hdlhiT
         cuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=B3yeXNADdUT3tvPE58CoKhKcUyQIi+GuM9fymG8S/bQ=;
        b=pAv0j08VfiV3ttqbDUQbEgL4Ta3uWx38229jYMhWq92savKt87ThKLJqmu35g7AA1H
         qzEzQY2wfApmgwoel0l2iMyPw+eCNmDTmT2zeCelgQhLTHEldoKVFOSkvLAHpF+FrfIp
         Adu9IDGVUKmrBHjgUBRNrD8MEwcAMNnjpiHB3NgqiEO4kQ3MyFnnpPWsh1YqxnSaGq1U
         CjZX7wo/FEF+g99gDlOoQkWoUAMoBWzoR05/lN9B6DKm3Rh0tyvVwY0flwXG+R/F9wQJ
         kLSh7L9Mknfjqmle5C49iyH9MsjqBHZJXwGtuA8uOp4E3DlplMU8Qw/JT3dGdjWFROlg
         kqMQ==
X-Gm-Message-State: AJcUuke6c7gpc5LvDSaPkI/KR5Rg5bv3jaZSbsC/v7XHKSOmMyuQR65x
        alOfkcGuXjvk+X5wsuXvlnk=
X-Google-Smtp-Source: ALg8bN4x+Dd9jcyDibyR3xfPMdLEanv/rzHDQ4p9geTOjRbLZKZliRx85WWoxH6zAy/t+a9ImveL7Q==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr15271260ljj.61.1547456719286;
        Mon, 14 Jan 2019 01:05:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y1-v6sm17335041ljh.39.2019.01.14.01.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 01:05:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1giyBJ-0000J7-IV; Mon, 14 Jan 2019 10:05:17 +0100
Date:   Mon, 14 Jan 2019 10:05:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2]  greybus: gpio: Switch to the gpio descriptor
 interface
Message-ID: <20190114090517.GB3691@localhost>
References: <cover.1547219996.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547219996.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:03:16PM +0530, Nishad Kamdar wrote:
> This patch series converts uses of the old GPIO API to the GPIO
> descriptor API. It also converts the GPIO driver to use the
> GPIO irqchip library GPIOLIB_IRQCHIP instead of repimplementing
> the same.
> 
> Changes in v6:
>  - Patchset now contains two patches as the patch
>    1 has been accepted.

All three patches look good now, but since Greg picks these up directly
and applies them to the staging tree, it is best if you submit all three
patches (with my reviewed-by tag) in a series.

One last resend as v7?

Thanks again for doing this.

Johan
