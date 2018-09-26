Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBA7214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qnRhVn5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBA7214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeIZVkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:40:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38585 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeIZVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:40:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180926152713euoutp018532f6a5fb6800a6f414a89ea954dbbb~X-LC5GJ7N0499004990euoutp01b
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:27:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180926152713euoutp018532f6a5fb6800a6f414a89ea954dbbb~X-LC5GJ7N0499004990euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537975633;
        bh=8D1VRG6tbmxh7o1j8p4wwdhVU16XYqw/2pjpCSQFnkk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qnRhVn5FsYUSwQB3tUcMm6XTkvhPhMqnOSLWm3rpIsrgD2TfHL4y7pHTjXcrm6FhP
         KitfmMSi5/sGGUEWMqXVCpVpPwOAzexpFLR08zXRzriG8IszshHvcD9ruSbgC66uJg
         a+/8kHvqHSxesDMMAQ2jUoINT6843Ze5X0/3sqY8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180926152713eucas1p211caf7787c179825d274b35335607d84~X-LCW9avg3125531255eucas1p2F;
        Wed, 26 Sep 2018 15:27:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.EB.04806.055ABAB5; Wed, 26
        Sep 2018 16:27:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180926152712eucas1p1c5f74a24ad299f43f473c662e994a522~X-LBvedqK1624116241eucas1p1X;
        Wed, 26 Sep 2018 15:27:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180926152712eusmtrp135acd83465bea99e90f0e9893ecac6ef~X-LBkRsHu1246712467eusmtrp1g;
        Wed, 26 Sep 2018 15:27:12 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-d7-5baba5507580
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.F9.04284.F45ABAB5; Wed, 26
        Sep 2018 16:27:12 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180926152711eusmtip20ff79f1d31933df400cb0bed72a8bd03~X-LA9d7RR0076400764eusmtip2R;
        Wed, 26 Sep 2018 15:27:11 +0000 (GMT)
Subject: Re: [PATCH] pxa168fb: prepare the clock
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Wed, 26 Sep 2018 17:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180910120351.164257-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned2ApaujDTqeWVhc+fqezeJE3wdW
        i8u75rBZ3Hs5m8WBxeN+93EmjyUHlzN6fN4kF8AcxWWTkpqTWZZapG+XwJUxf9ZCtoKPMhX7
        Hs5gaWBcJtHFyMkhIWAisfz6dfYuRi4OIYEVjBJzu+6yQjhfGCW+Ln3ODlIlJPCZUWL7XlmY
        jp1P5jBDFC1nlLh7uZkJwnnPKPFg5hwmkCphAQOJNz0nWEFsEQFliYmnFoLFmQUSJB4ePQNm
        swlYSUxsX8UIYrMIqEp8mtwNtI2DQ1QgQqL/jDpImFdAUOLkzCcsIDangKnEzENNbBBjDCSO
        LJrDCmHLS2x/C3IQyHHN7BK3XztA9JZJPGz4wgoyUkLARWLFQiuIEmGJV8e3sEPYMhKnJ/ew
        gJwvITCdUeLNr6VQznpGiTVnjjFBVFlLHD5+kRXCdpQ40veUBWIon8SNt4IQN/BJTNo2nRki
        zCvR0SYEUa0msWHZBjaYXV07V0Kd6SEx4Wcv8wRGxVlIvpyF5LNZSD5bwMi8ilE8tbQ4Nz21
        2DgvtVyvODG3uDQvXS85P3cTIzBxnP53/OsOxn1/kg4xCnAwKvHwctiuihZiTSwrrsw9xCjB
        wawkwntnyupoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rx8WmnRQgLpiSWp2ampBalFMFkmDk6p
        BkaftI8P735maOH+2sB0L8RqQVfZBDdlnVXqv/dbZDwOM+8wrzNmur5l/YWuRRIvOvSs9eY8
        DNP+r276aOpL69oL3lUL1r3pDLp8XcK3PHzh3k3iU07LJXfvuSwR4ND56YS3kHTX4fy4NReK
        iie12n9dM1Mwklf51XHtEzG/178Wlvuo/EaOaYISS3FGoqEWc1FxIgD1fUIdGAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Pd2ApaujDX59E7C48vU9m8WJvg+s
        Fpd3zWGzuPdyNosDi8f97uNMHksOLmf0+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j/qyFbAUfZSr2PZzB0sC4TKKLkZNDQsBEYueT
        OcxdjFwcQgJLGSVezT3L2MXIAZSQkTi+vgyiRljiz7UuNoiat4wSn299ZQRJCAsYSLzpOcEK
        YosIKEtMPLWQCaKog1Fi5YH9rCCDmAUSJFZ9TgKpYROwkpjYvgqsl1fATuLf0m3sIDaLgKrE
        p8ndYLaoQITErYcdLBA1ghInZz4BszkFTCVmHmpiA7GZBfQkdlz/xQphy0tsfzuHeQKj4Cwk
        LbOQlM1CUraAkXkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYERsO/Zz8w7GSxuDDzEKcDAq
        8fBy2K6KFmJNLCuuzD3EKMHBrCTCe2fK6mgh3pTEyqrUovz4otKc1OJDjKZAT0xklhJNzgdG
        a15JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBkb9lWsPXFpvHWTg
        b7hm8rKZV1oSjcrmvUptj9DReKFVPCux+FLxqp/hBw7dkxGcwrxGQeG4zqZ5affrj585/vns
        gib2TbYzuFZ1Te79xf3dRpEz/u2r7uAuwY2uCXy7Ra5fu1yW+tPAPPaz5Kf6x1lPZ+xl6Wzu
        VZP+9fd1/OSHGn9KrzkvP22jxFKckWioxVxUnAgA3COjM54CAAA=
Message-Id: <20180926152712eucas1p1c5f74a24ad299f43f473c662e994a522~X-LBvedqK1624116241eucas1p1X@eucas1p1.samsung.com>
X-CMS-MailID: 20180926152712eucas1p1c5f74a24ad299f43f473c662e994a522
X-Msg-Generator: CA
X-RootMTR: 20180910120403epcas1p25706c846d95df1e47092ebb040f70a7f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180910120403epcas1p25706c846d95df1e47092ebb040f70a7f
References: <CGME20180910120403epcas1p25706c846d95df1e47092ebb040f70a7f@epcas1p2.samsung.com>
        <20180910120351.164257-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ added dri-devel@lists.freedesktop.org to Cc: ]

On 09/10/2018 02:03 PM, Lubomir Rintel wrote:

Some description (besides kernel warning itself) saying what the patch is
actually doing would be nice so I've updated the patch with:

	Add missing prepare/unprepare operations for fbi->clk,
	this fixes following kernel warning:

while merging it.

>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:874 clk_core_enable+0x2c/0x1b0
>   Enabling unprepared disp0_clk
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc8-00032-g02b43ddd4f21-dirty #25
>   Hardware name: Marvell MMP2 (Device Tree Support)
>   [<c010f7cc>] (unwind_backtrace) from [<c010cc6c>] (show_stack+0x10/0x14)
>   [<c010cc6c>] (show_stack) from [<c011dab4>] (__warn+0xd8/0xf0)
>   [<c011dab4>] (__warn) from [<c011db10>] (warn_slowpath_fmt+0x44/0x6c)
>   [<c011db10>] (warn_slowpath_fmt) from [<c043898c>] (clk_core_enable+0x2c/0x1b0)
>   [<c043898c>] (clk_core_enable) from [<c0439ec8>] (clk_core_enable_lock+0x18/0x2c)
>   [<c0439ec8>] (clk_core_enable_lock) from [<c0436698>] (pxa168fb_probe+0x464/0x6ac)
>   [<c0436698>] (pxa168fb_probe) from [<c04779a0>] (platform_drv_probe+0x48/0x94)
>   [<c04779a0>] (platform_drv_probe) from [<c0475bec>] (driver_probe_device+0x328/0x470)
>   [<c0475bec>] (driver_probe_device) from [<c0475de4>] (__driver_attach+0xb0/0x124)
>   [<c0475de4>] (__driver_attach) from [<c0473c38>] (bus_for_each_dev+0x64/0xa0)
>   [<c0473c38>] (bus_for_each_dev) from [<c0474ee0>] (bus_add_driver+0x1b8/0x230)
>   [<c0474ee0>] (bus_add_driver) from [<c0476a20>] (driver_register+0xac/0xf0)
>   [<c0476a20>] (driver_register) from [<c0102dd4>] (do_one_initcall+0xb8/0x1f0)
>   [<c0102dd4>] (do_one_initcall) from [<c0b010a0>] (kernel_init_freeable+0x294/0x2e0)
>   [<c0b010a0>] (kernel_init_freeable) from [<c07e9eb8>] (kernel_init+0x8/0x10c)
>   [<c07e9eb8>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>   Exception stack(0xd008bfb0 to 0xd008bff8)
>   bfa0:                                     00000000 00000000 00000000 00000000
>   bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>   bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>   ---[ end trace c0af40f9e2ed7cb4 ]---
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Patch queued for 4.19, thanks.

> ---
>  drivers/video/fbdev/pxa168fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index def3a501acd6..d059d04c63ac 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -712,7 +712,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
>  	/*
>  	 * enable controller clock
>  	 */
> -	clk_enable(fbi->clk);
> +	clk_prepare_enable(fbi->clk);
>  
>  	pxa168fb_set_par(info);
>  
> @@ -767,7 +767,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
>  failed_free_cmap:
>  	fb_dealloc_cmap(&info->cmap);
>  failed_free_clk:
> -	clk_disable(fbi->clk);
> +	clk_disable_unprepare(fbi->clk);
>  failed_free_fbmem:
>  	dma_free_coherent(fbi->dev, info->fix.smem_len,
>  			info->screen_base, fbi->fb_start_dma);
> @@ -807,7 +807,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
>  	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
>  		    info->screen_base, info->fix.smem_start);
>  
> -	clk_disable(fbi->clk);
> +	clk_disable_unprepare(fbi->clk);
>  
>  	framebuffer_release(info);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
