Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9C4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BE120894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FEaOHIFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BE120894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeHBC02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:26:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40758 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeHBC02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:26:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so232683pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0+TPvcvDj4OiH5wST27toS9K/GzrzrQvBGoLJ6UyD+4=;
        b=FEaOHIFVG+wxPu2F9Bgxu4fQHhK++yZKjLUavWR7ytogk40rJJGEc73W2kjLirHkZS
         vZzuhGmUZDJge2N57cGFcpF1Z4EVivl8amE/tdksWDfEdI5ZELdnPtMn/WzEf4zbXW1e
         LF7N3tA6ZePA4Ys96IFwOzyYFQcuCidZfpn/uxVzs4/lp7mypmW/y9xUtcggy2AMj4t2
         rQO+FF+45freFlbQcp9YkmN+/OLBxQiCFfIe+CwP+ns5tmE6oAtc9HACZxQS6p1/8ka8
         lGFE3nGNMm+EF/cPxyfGRMmrW+Flr2GYoUxP20dsMazjmqKUYGO5PEV+UKCD16cYLnFB
         n06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0+TPvcvDj4OiH5wST27toS9K/GzrzrQvBGoLJ6UyD+4=;
        b=MzzF0P29+dYPfqLiEWNWZEccGPYczcb07l9kFgp/voqMe2xIOqBnbLchMh1b8DbqTa
         4Q7DXScye/BiFxIx1BwPUWwo8QGB87/xM0atOslQYlwqgLTmjGfyc4WgGzK/xr9w34xY
         cOa0Cyq85pNGrEXLNRrt+FPccztTN8NWh0aH4pZSRvw49gb42nKLP8PVZQ+eaMPFrSvD
         yQ3YvWRB2ux63U6VBWGF4d9ImWxgMXPlulz4Tq6qzaP+dKs6bYQJ9XJ3PmDBeEu5rj8Z
         dKjwuaS9n1xKquOA2JFWG8CgeC+ZiRwRkrne1Imt+VvwoqDFiTY+huvPqyAr5Zl3Fu9y
         v75g==
X-Gm-Message-State: AOUpUlF8TRuCOETMMfttexy8BWA2Z88Oq77qkGx+zkPk7NcC+h2q1+FI
        GagDmavRIxubz+b9U9YMaik1Jg==
X-Google-Smtp-Source: AAOMgpfnzh73RPvnekBP1E9qNQLxwNDsAEPW/URrQlHpok4/mFgbJ8WvJxiLNT+aCNNOdq/H24EswQ==
X-Received: by 2002:a65:4384:: with SMTP id m4-v6mr509314pgp.265.1533170281309;
        Wed, 01 Aug 2018 17:38:01 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c85-v6sm426975pfd.110.2018.08.01.17.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 17:38:00 -0700 (PDT)
Date:   Wed, 01 Aug 2018 17:38:00 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Aug 2018 17:37:47 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Add the directive for alignment of stvec's value
In-Reply-To: <1529545207-26999-1-git-send-email-zong@andestech.com>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com,
        greentime@adnestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     zong@andestech.com
Message-ID: <mhng-38cc8366-10dd-4ea1-993f-bd453640aa66@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 18:40:07 PDT (-0700), zong@andestech.com wrote:
> The stvec's value must be 4 byte alignment by specification definition.
> This directive avoids to stvec be set the non-alignment value by the
> following code in head.S
>
>  /* Point stvec to virtual address of intruction after satp write */
> la a0, 1f
> add a0, a0, a1
> csrw stvec, a0
>
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/kernel/head.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 396ec7b349ce..ae7b204f531c 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -94,6 +94,7 @@ relocate:
>  	or a0, a0, a1
>  	sfence.vma
>  	csrw sptbr, a0
> +.align 2
>  1:
>  	/* Set trap vector to spin forever to help debug */
>  	la a0, .Lsecondary_park

I don't think this is actually correct: you shouldn't be aligning the address 
at which stvec is set, but the address that stvec is set to.  If this is fixing 
anything then it's probably just by coincidence as it's causing 
.Lsecondary_park to be aligned.

I think this patch is the correct fix

    diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
    index 6e07ed37bbff..d1beecf1d060 100644
    --- a/arch/riscv/kernel/head.S
    +++ b/arch/riscv/kernel/head.S
    @@ -143,6 +143,7 @@ relocate:
     	tail smp_callin
     #endif

    +.align 2
     .Lsecondary_park:
     	/* We lack SMP support or have too many harts, so park this hart */
     	wfi

Thanks for pointing this out!
