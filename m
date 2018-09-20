Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4437BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0712152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+YeggtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0712152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbeITQz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:55:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36343 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeITQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:55:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so4285785pgo.3;
        Thu, 20 Sep 2018 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lsxbulnp4C7Omhz4nQ8GoMlTl35hYV15G1sKyXwihZs=;
        b=g+YeggtOfJmAjKqra2Zg0b0tkMB2NDlZF/kcVPwd4y81F2Qj5C4c8nCNhS5wXEMDET
         ZiXS3/1zgedEwPP+eQNduP4wu068YmdptbIs68sgS25byRCD99f2qDAZwhDfmTD59uJG
         R4epHr4bWlcUJYwQsjZyqghDwYB9HWR91pNfDM7dal6/9guCqGVBW+rY57L3fEU592Sz
         NxFquJgpZ0rpypMXGc3/sDnmzZEEVsxj0GNGprebG/95vUBPblcPa67JoZF9F9qQfMyL
         7USmFmMPAf+ePJBRueUOOFcfN5ULkJ+pG6u7MTNaA+ycnC1DfddtZh2nZV6gnUEBdWMp
         OHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lsxbulnp4C7Omhz4nQ8GoMlTl35hYV15G1sKyXwihZs=;
        b=SlXZqsEmIn8bxnj08UWWfex50Yb20Pwp+hMpPA9q5sXUV0y7h95NeptziZuQNrGamc
         XRshqVc4570RWeWytQ4Ab1PEMeq/KWRG9A40wigauH/f2JFigca0ym6/PSOL80VYLk+3
         3XchtX0hOZXuDlDHesi6Y3CRu/VEFvwNWQFWY7zAmmioK7yDP9CJjmL5GIO3a55xWuKj
         uoK/M7vYmZ4MuVFE+SS6gT4fuyl1jY+kEd/u8/dawsAOcOQmInJHoT5bpl9ef5s5cQt8
         YYTecaitdhOSvZ6hP/lvxJrGZX70DOBaeb3g9mAeBWLenR3Fn4n7jGzeV4Cc1l3Fj4Bi
         s2Ig==
X-Gm-Message-State: APzg51CbNb6hbnheLiD/jDUNrfU1XFn/RokpqKOWqoNT9FtYSKLZwZEE
        jjE2IJYDZbNt3c5dvZ2BskYPO3Ke8Fc=
X-Google-Smtp-Source: ANB0VdYsWs4bxrC0JTiZ/iBNRHL8tSwYw58zytPX5vnC94Ngl4pqFdgGjGeMFL7F/D0yAyfHEWRHUQ==
X-Received: by 2002:a62:9cd7:: with SMTP id u84-v6mr40902164pfk.90.1537441981012;
        Thu, 20 Sep 2018 04:13:01 -0700 (PDT)
Received: from rodete-laptop-imager.corp.google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id m27-v6sm33027135pff.152.2018.09.20.04.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 04:12:59 -0700 (PDT)
Date:   Thu, 20 Sep 2018 20:12:55 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix missing zero pages for memory tracking
Message-ID: <20180920111255.GA31303@rodete-laptop-imager.corp.google.com>
References: <20180919051846.234615-1-minchan@kernel.org>
 <20180919072916.GA1180@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919072916.GA1180@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Wed, Sep 19, 2018 at 04:29:16PM +0900, Sergey Senozhatsky wrote:
> On (09/19/18 14:18), Minchan Kim wrote:
> > We need to count zero filled pages as well as other pages in zram.
> 
> A nit,
> 
> 	'ZRAM_FLAG_SHIFT + 1' covers all ZRAM_SAME pages, not only
> zero filled pages.

Yub, that's what I want.
Currently, it covers only non-zero filled same page, which is
inconsistent and user easily miss zero-filled same page.
