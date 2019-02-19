Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F0BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F72147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Kc0qe10u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfBSVU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:20:27 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36456 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfBSVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:20:26 -0500
Received: by mail-it1-f193.google.com with SMTP id h6so9981778itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Uqg/xYPEomUxikesUxTYEPTAFgGyOfSI+TIAf2ftQno=;
        b=Kc0qe10u05pcZIEfmEVDoAd7hILi0PQQM8NUSY2jRXtD0K3V3PHGrGRAj+M0FToP9Z
         EX1feDIY665LI7sez4XXdn25c366ydZYfcLo7z5ro4bQCgKRIjtap5gmYI0EOX1oSA0h
         24SmS9I1eYy3KgQe9tU8kIzskXBXG7himuAIh30RYRJp/xCd4Fmdi5KCZ5dw3Bkxb9Ur
         D82KasAkYIVETEAy7EEdZKHWAC4dJ687WuqtxJV+TQ/CUWNpIKITK/dzgqy5lJoXHhgl
         58t3PziKEiop22MQjV7H3kYq/982HWSh3NWbgRlPCBxgyGtqUPNq3Rb66R4PKJxXDH67
         n+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Uqg/xYPEomUxikesUxTYEPTAFgGyOfSI+TIAf2ftQno=;
        b=lwIz1WJ5LuQ8lVSYoWnScnscn5xL/2qPFTGqPzXd9bM6bmLhbA/frtRW3UVpJEfS5h
         z8yTSjaqWo3cCe1dtd2VMmsH8Yk2ljl0jExS9DErmn2d770SiZfNYSYt4Yc/BhyJ8WDZ
         AIPlNN4t9JqlmxyiR/sW2TiAKtKV/2vJi+SP15k6uSEWtvDerJ4UU8jT/f/oWjhoegsg
         IY2OKxdH9GSfkDrWROrTgCiOKNau4+ThH2ke6l6VwMvr1gBXYzSn84kwsyGVp+2m1QDy
         XqYk4C/FbnoCPp5hmCW2fl+Il2HoOEu3Sb0uL83aVGWPOaBACGExyLP0BGDyDTm2TdiW
         1ZZg==
X-Gm-Message-State: AHQUAuZrKIY1bi3wXLVDRxiOablc3vaYyDqVdFgfFjU0Y/tURL8i5aOH
        wfbxKH4Yhwt0E/ftPbiXDzCdSRMTmHY=
X-Google-Smtp-Source: AHgI3IY1uNVNzABy08WGld1sjIBciGkufmuS5oFks7K4seq+uKNdkYeTcp39KCn5WRPltLcrwYsBSA==
X-Received: by 2002:a5e:8513:: with SMTP id i19mr1911171ioj.21.1550611225842;
        Tue, 19 Feb 2019 13:20:25 -0800 (PST)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id 140sm1823908itv.32.2019.02.19.13.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 13:20:25 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Tue, 19 Feb 2019 13:20:23 -0800 (PST)
To:     Andreas Schwab <schwab@suse.de>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@pwsan.com, palmer@sifive.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] arch: riscv: fix logic error in parse_dtb
In-Reply-To: <mvmr2cjy7xx.fsf@suse.de>
Message-ID: <alpine.DEB.2.21.9999.1902191319390.6518@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1812171913510.29609@viisi.sifive.com> <mvmr2cjy7xx.fsf@suse.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Feb 2019, Andreas Schwab wrote:

> The function early_init_dt_scan returns true if a DTB was detected.
> 
> Fixes: 8fd6e05c7463 ("arch: riscv: support kernel command line forcing when no DTB passed")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 45e9a2f053dc..84f19ca6d88b 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -140,7 +140,7 @@ asmlinkage void __init setup_vm(void)
>  
>  void __init parse_dtb(unsigned int hartid, void *dtb)
>  {
> -	if (!early_init_dt_scan(__va(dtb)))
> +	if (early_init_dt_scan(__va(dtb)))
>  		return;
>  
>  	pr_err("No DTB passed to the kernel\n");
> -- 
> 2.20.1

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
Tested-by: Paul Walmsley <paul.walmsley@sifive.com> # FU540 HiFive-U BBL

- Paul
