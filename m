Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5610BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2620421841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwiwxgOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeLSOrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:47:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36340 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbeLSOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:47:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so9546811pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 06:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+RrlYuy13DpQ9eKQWWaHQi673orAx1g3SXGxVm8vSXc=;
        b=KwiwxgObJsSX+GRhaX3BWLdI63GdGCWUt53BMcfadfeHu8+34wt0Syo9eGzfIZusRi
         rssTj5kF/qUbF54xLziYD7WvI+0InhaNnEwivoqVenbTsX2SLx7KWt01NOmJPUSmuCJ9
         ZCa5WV6OoQ1gqIpGM8hqC6ga//Q2Zj8OkddIfOv3ZbuysGBo6yFM0TnftUvAkM3ieGPM
         S7NDJXqEhvfYPDX+nhk7wOHp7K5dzgESAYyTSBOk2srcX/4K28Fzyx/R1efMA5NGUxe0
         7soPtY9qGpdI1OxXfNcQicMZyGMvH+p78jZ8ZoJV0nFbuXD8smVoeltQsr0rfUSBkbsX
         lbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+RrlYuy13DpQ9eKQWWaHQi673orAx1g3SXGxVm8vSXc=;
        b=KUoYeqZDoK2K7bzYtuNZ7VYgpm22/EhQUB7rhk8YL2QXjvCI2uQ8dN1WdlxVL7G75+
         Hc1kgtCappI1K9VjDmR0I0sWizZVhpPRYiq+D7Y41+h+46OJISHLQztmza/udOwm4gpF
         e32k7UZk5J0ulKx7zXLZ4A08VNJLma3Xq0rNL0236/XaDDxYGwiIdvIx/JcGjvAWljj3
         Qx0WxlnOTNlv/X8IJw2TUtTuaOnoQE58FPHjWehmCIuPAjMshNPBGNXuXqWCJgSBALF0
         ABXu2Kzo5zL1xeIXgVKDZ4RzFPOZrIQGLj27B7kNrSRizoRKlBmt6ckAXQnAMEbxuU7h
         PmZg==
X-Gm-Message-State: AA+aEWZiF3mVaIlycXYzLaZmCW/19mWpBh0zyuDXQKyOTUd6Ch8wtGkr
        9hA5QsgzL4CDncZ3PEt+P6I=
X-Google-Smtp-Source: AFSGD/UUyn9Mtne+TcVYzd4Wv1QI6lZzrnnnuI28JjPanQeqcbSRSztEdI/T9myAwCzpadOkQVRpZA==
X-Received: by 2002:a65:500c:: with SMTP id f12mr18922924pgo.226.1545230840349;
        Wed, 19 Dec 2018 06:47:20 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
        by smtp.gmail.com with ESMTPSA id a90sm31000083pfj.109.2018.12.19.06.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:47:19 -0800 (PST)
Date:   Wed, 19 Dec 2018 23:47:18 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] openrisc: Fix broken paths to arch/or32
Message-ID: <20181219144718.GK3235@lianli.shorne-pla.net>
References: <20181203122047.12225-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203122047.12225-1-geert@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 01:20:47PM +0100, Geert Uytterhoeven wrote:
> OpenRISC was mainlined as "openrisc", not "or32".
> vmlinux.lds is generated from vmlinux.lds.S.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks,

Sorry for the delay.

I will queue this up.

-Stafford

> ---
>  arch/openrisc/kernel/entry.S | 2 +-
>  arch/openrisc/kernel/head.S  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
> index 0c826ad6e994cce3..ee6159d2ed22ec49 100644
> --- a/arch/openrisc/kernel/entry.S
> +++ b/arch/openrisc/kernel/entry.S
> @@ -240,7 +240,7 @@ handler:							;\
>   *	 occured. in fact they never do. if you need them use
>   *	 values saved on stack (for SPR_EPC, SPR_ESR) or content
>   *       of r4 (for SPR_EEAR). for details look at EXCEPTION_HANDLE()
> - *       in 'arch/or32/kernel/head.S'
> + *       in 'arch/openrisc/kernel/head.S'
>   */
>  
>  /* =====================================================[ exceptions] === */
> diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
> index 9fc6b60140f007be..31ed257ff06188ee 100644
> --- a/arch/openrisc/kernel/head.S
> +++ b/arch/openrisc/kernel/head.S
> @@ -1728,7 +1728,7 @@ _string_nl:
>  
>  /*
>   * .data section should be page aligned
> - *	(look into arch/or32/kernel/vmlinux.lds)
> + *	(look into arch/openrisc/kernel/vmlinux.lds.S)
>   */
>  	.section .data,"aw"
>  	.align	8192
> -- 
> 2.17.1
> 
