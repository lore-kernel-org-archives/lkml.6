Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0EAC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC23F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548061184;
	bh=PPuvBMrSVw1Xcs84+S5r+Q9irSrkyMU09zf97ia5EVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ahEtDA2fVI9D80fwFFC10c7CVeTSlH1zK1tosAOfcrsVJLQmH2Dyc1gd7TeRwiF2W
	 QeaKlF38mrWwUS0frCBTdzFo1yrS3PFQxe+13ksSpSr/nD1ae7PlY1nSiKB4DtegrH
	 JLDzn3hO6p+hnRjuSKlNgC65DpdQP0zEvSkIX9Vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfAUI7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:59:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33892 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfAUI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:59:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so14935237lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CBPf8HOT93sc0oj4tv290B2Z61lA88aXyyFQdOpSyj0=;
        b=L0XpPMLh/BcT5cCFI6UjEtPTYOtZ21aByEWcmMT2uSdSm5Pxl1ejuHCBuynx8VG0lV
         7dlZy4wrIRE1W1lwzBVwhWgl0s0JmjNW9iPoVirn1R8zxjq3n6+U9yyCjznVe2q2bHDD
         DR4T24OP6+NkZLejso+lQ8Ut3Ek/gM7Y4V81sx/zcGxlWe/DvP+V86INGMOOKBU6LEaz
         lgFu+uEbQrZX92mj0kXK/afY2WcZwNJ7NDJaq1RknV57LjWIs03O7eJ/DOfrliiVpal2
         r85O8EVmGuWw7yKXEnD9z7IHtjGS8PuVg2TIVl2ZvIKweJEQZcSxRmBi9VQTJZr9+xWD
         h7Kw==
X-Gm-Message-State: AJcUukc9kmBtvufMYrFlksR+iMU2i4OkQ5OGhoqQPw4MVQ2n3banZbl/
        Nbzj9tOG4GiSygnMaLrAYQs=
X-Google-Smtp-Source: ALg8bN6DKFlyHHbNBuQhh2Rrhe5wmbHn3TVTP5Dk7mbkg+PFyUtFlFcm4QqTdAZEMeiq0GYOAGEGAQ==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr18472269lfj.83.1548061179965;
        Mon, 21 Jan 2019 00:59:39 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2130011ljj.91.2019.01.21.00.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 00:59:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1glVQc-0000Re-GR; Mon, 21 Jan 2019 09:59:34 +0100
Date:   Mon, 21 Jan 2019 09:59:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/5] riscv: treat cpu devicetree nodes without status as
 enabled
Message-ID: <20190121085934.GH3691@localhost>
References: <20190118140308.9599-1-johan@kernel.org>
 <20190118140308.9599-5-johan@kernel.org>
 <alpine.DEB.2.21.999.1901190140510.8813@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.1901190140510.8813@utopia.booyaka.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 01:43:58AM +0000, Paul Walmsley wrote:
> On Fri, 18 Jan 2019, Johan Hovold wrote:
> 
> > Follow the Linux convention and treat devicetree nodes without a status
> > property as enabled rather than disabled, while also allowing "ok" as a
> > shorthand for "okay".
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
> 
> ... although I probably would have phrased the commit message slightly 
> differently - something like "Use of_device_is_available() in 
> riscv_of_processor_hartid(), in place of an open-coded test."  That frames 
> the change as one that removes custom code in place of an existing 
> standard function for the same purpose.

You're right, and that was my motivation too. In the end I decided to
highlight the side effect in case someone was perhaps unknowingly
relying on the current behaviour.

Thanks for the review!

Johan
