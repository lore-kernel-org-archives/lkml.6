Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609EC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496CB20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeB2X7xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfAUIEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:04:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53066 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfAUIEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:04:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so9795536wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zn+mYzQzEqwQHCFEAdrOQXPMQ3QYNEZOgWJdy3hOx4o=;
        b=qeB2X7xwjzn3CUw2dhxU0e/X3Jr09/YMZTyYUC3oMDOA1zazGB5YR013jiQw9sed9s
         eEsWiqZ5WVQT2EYQoCPJtYobDD10LdAQPUwvq8YPGUhoVixswFmlEG4K7htnEkPAYwnD
         9hDnwsSagg0CPBMLNxzBEvF7aAYiZYx8cI9lT6SSrTSCC/M/sM47JtHFcIfL5oEgRPFY
         5bRpFFLw0f3yrnVRhA4vFg96Fml06UpwL4TQp7sTPxB+/GJlohF1pNjTwepYKXIZkDwL
         FjRDbM6inqJxVIdUCJaITtPDxnUNq7+PYiWxeVsJzbuQSN8Jt1WYwRwdXlE0dSowL95g
         UWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zn+mYzQzEqwQHCFEAdrOQXPMQ3QYNEZOgWJdy3hOx4o=;
        b=GOf/bMw87pU/YCaZiRiCbaDOu3W8L+QCrH8Br0VTIH/imOtunrjnu4jvwHbwgvylIZ
         EcbG9Sce+u/0Oe9uYTRh6pCdS+QCSuSg+cJ0yMpwJXXAa2gjU+WxmMwql8+Ct1svoTXA
         de4QXt1oSm8cWCXKQrM3ruO6hL+loFe5yOZZH0x6n6tFpKZaidjAv8HigX2xKblpNz5r
         dCy3Ipn7Jq8bjaa5OSWNo/QJ3xccJ7dnQi851bSvBl++XhlBqGmDTO7SG5UuvdA6rlHk
         Rh9QXyr3iP7IrzjjMGzIrseWVKuO5LjKa/KQuWw70U4+pEMNepSuRlPpowSw6jWHLmuq
         8E0A==
X-Gm-Message-State: AJcUukd0DjlWn0bVPJa9ozeZeGgwZSOkms/dxPSQQHrbGLIlc86J0ys7
        WHn5jtipXXtcQtHeOIYFjQDZa+7dW9Dd9WyYQT1zST+Y
X-Google-Smtp-Source: ALg8bN4NoPH54Y62XEnwsxal8earNBQxget9c6efIW7qn1zpHPheQwy6042j5muRh4JMN0IGLnXPp2pWF/dd2LbOKfM=
X-Received: by 2002:a1c:b14:: with SMTP id 20mr24501716wml.103.1548057867289;
 Mon, 21 Jan 2019 00:04:27 -0800 (PST)
MIME-Version: 1.0
References: <1548030067-37105-1-git-send-email-yang.yang29@zte.com.cn>
In-Reply-To: <1548030067-37105-1-git-send-email-yang.yang29@zte.com.cn>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 21 Jan 2019 09:04:15 +0100
Message-ID: <CAFLxGvwEuw7tO8fV_K10f8B_SFOb9z7-+LyFMfjPWvwNGYkv2A@mail.gmail.com>
Subject: Re: [PATCH] jffs2: check dstlen for jffs2_zlib_compress()
To:     Yang Yang <yang.yang29@zte.com.cn>
Cc:     David Woodhouse <dwmw2@infradead.org>, wang.yi59@zte.com.cn,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        xue.zhihong@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 1:21 AM Yang Yang <yang.yang29@zte.com.cn> wrote:
>
> KASAN reports a BUG when download file in jffs2 filesystem.
> The board name is nxp-ls1043ardb-ls1043a.
> It is because when dstlen == 1, cpage_out will write array out of bounds.
> Actually, there's no meaning for jffs2_zlib_compress() to compress
> any data with length less than 3.
> In that case, data will not be compressed.

I sent already a patch for this:
https://patchwork.ozlabs.org/patch/1013958/

> [  393.799778] BUG: KASAN: slab-out-of-bounds in jffs2_rtime_compress+0x214/0x2f0 at addr ffff800062e3b281
> [  393.809166] Write of size 1 by task tftp/2918
> [  393.813526] CPU: 3 PID: 2918 Comm: tftp Tainted: G    B           4.9.115-rt93-EMBSYS-CGEL-6.1.R6-dirty #1
> [  393.823173] Hardware name: LS1043A RDB Board (DT)
> [  393.827870] Call trace:
> [  393.830322] [<ffff20000808c700>] dump_backtrace+0x0/0x2f0
> [  393.835721] [<ffff20000808ca04>] show_stack+0x14/0x20
> [  393.840774] [<ffff2000086ef700>] dump_stack+0x90/0xb0
> [  393.845829] [<ffff20000827b19c>] kasan_object_err+0x24/0x80
> [  393.851402] [<ffff20000827b404>] kasan_report_error+0x1b4/0x4d8
> [  393.857323] [<ffff20000827bae8>] kasan_report+0x38/0x40
> [  393.862548] [<ffff200008279d44>] __asan_store1+0x4c/0x58
> [  393.867859] [<ffff2000084ce2ec>] jffs2_rtime_compress+0x214/0x2f0
> [  393.873955] [<ffff2000084bb3b0>] jffs2_selected_compress+0x178/0x2a0
> [  393.880308] [<ffff2000084bb530>] jffs2_compress+0x58/0x478
> [  393.885796] [<ffff2000084c5b34>] jffs2_write_inode_range+0x13c/0x450
> [  393.892150] [<ffff2000084be0b8>] jffs2_write_end+0x2a8/0x4a0
> [  393.897811] [<ffff2000081f3008>] generic_perform_write+0x1c0/0x280
> [  393.903990] [<ffff2000081f5074>] __generic_file_write_iter+0x1c4/0x228
> [  393.910517] [<ffff2000081f5210>] generic_file_write_iter+0x138/0x288
> [  393.916870] [<ffff20000829ec1c>] __vfs_write+0x1b4/0x238
> [  393.922181] [<ffff20000829ff00>] vfs_write+0xd0/0x238
> [  393.927232] [<ffff2000082a1ba8>] SyS_write+0xa0/0x110
> [  393.932283] [<ffff20000808429c>] __sys_trace_return+0x0/0x4
> [  393.937851] Object at ffff800062e3b280, in cache kmalloc-64 size: 64
> [  393.944197] Allocated:
> [  393.946552] PID = 2918
> [  393.948913]  save_stack_trace_tsk+0x0/0x220
> [  393.953096]  save_stack_trace+0x18/0x20
> [  393.956932]  kasan_kmalloc+0xd8/0x188
> [  393.960594]  __kmalloc+0x144/0x238
> [  393.963994]  jffs2_selected_compress+0x48/0x2a0
> [  393.968524]  jffs2_compress+0x58/0x478
> [  393.972273]  jffs2_write_inode_range+0x13c/0x450
> [  393.976889]  jffs2_write_end+0x2a8/0x4a0
> [  393.980810]  generic_perform_write+0x1c0/0x280
> [  393.985251]  __generic_file_write_iter+0x1c4/0x228
> [  393.990040]  generic_file_write_iter+0x138/0x288
> [  393.994655]  __vfs_write+0x1b4/0x238
> [  393.998228]  vfs_write+0xd0/0x238
> [  394.001543]  SyS_write+0xa0/0x110
> [  394.004856]  __sys_trace_return+0x0/0x4
> [  394.008684] Freed:
> [  394.010691] PID = 2918
> [  394.013051]  save_stack_trace_tsk+0x0/0x220
> [  394.017233]  save_stack_trace+0x18/0x20
> [  394.021069]  kasan_slab_free+0x88/0x188
> [  394.024902]  kfree+0x6c/0x1d8
> [  394.027868]  jffs2_sum_write_sumnode+0x2c4/0x880
> [  394.032486]  jffs2_do_reserve_space+0x198/0x598
> [  394.037016]  jffs2_reserve_space+0x3f8/0x4d8
> [  394.041286]  jffs2_write_inode_range+0xf0/0x450
> [  394.045816]  jffs2_write_end+0x2a8/0x4a0
> [  394.049737]  generic_perform_write+0x1c0/0x280
> [  394.054179]  __generic_file_write_iter+0x1c4/0x228
> [  394.058968]  generic_file_write_iter+0x138/0x288
> [  394.063583]  __vfs_write+0x1b4/0x238
> [  394.067157]  vfs_write+0xd0/0x238
> [  394.070470]  SyS_write+0xa0/0x110
> [  394.073783]  __sys_trace_return+0x0/0x4
> [  394.077612] Memory state around the buggy address:
> [  394.082404]  ffff800062e3b180: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> [  394.089623]  ffff800062e3b200: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> [  394.096842] >ffff800062e3b280: 01 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  394.104056]                    ^
> [  394.107283]  ffff800062e3b300: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [  394.114502]  ffff800062e3b380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [  394.121718] ==================================================================
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  fs/jffs2/compr_rtime.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/jffs2/compr_rtime.c b/fs/jffs2/compr_rtime.c
> index 406d9cc..c69f01e 100644
> --- a/fs/jffs2/compr_rtime.c
> +++ b/fs/jffs2/compr_rtime.c
> @@ -36,6 +36,8 @@ static int jffs2_rtime_compress(unsigned char *data_in,
>         unsigned short positions[256];
>         int outpos = 0;
>         int pos=0;
> +       if (*dstlen <= 3)
> +               return -1;
>
>         memset(positions,0,sizeof(positions));
>
> --
> 2.15.2
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Thanks,
//richard
