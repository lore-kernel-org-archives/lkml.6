Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438BFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C3320857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C3320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeGaAdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:33:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57887 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaAdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:33:07 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkH4t-0008RI-Ix; Tue, 31 Jul 2018 00:55:47 +0200
Date:   Tue, 31 Jul 2018 00:55:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexei Colin <acolin@isi.edu>
cc:     Alexandre Bounine <alex.bou9@gmail.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] x86: factor out RapidIO Kconfig menu;
In-Reply-To: <20180730225035.28365-3-acolin@isi.edu>
Message-ID: <alpine.DEB.2.21.1807310054180.1725@nanos.tec.linutronix.de>
References: <20180730225035.28365-1-acolin@isi.edu> <20180730225035.28365-3-acolin@isi.edu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018, Alexei Colin wrote:

> The menu entry is now defined in the rapidio subtree.

This could be folded into the patch which actually adds the rapidio
specific Kconfig to avoid kconfig complaining about double entries.

But either way is fine for me.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Paul Walters <jwalters@isi.edu>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexei Colin <acolin@isi.edu>
> ---
>  arch/x86/Kconfig | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 27fce7e84357..6f057000e486 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2828,14 +2828,6 @@ config AMD_NB
>  
>  source "drivers/pcmcia/Kconfig"
>  
> -config RAPIDIO
> -	tristate "RapidIO support"
> -	depends on PCI
> -	default n
> -	help
> -	  If enabled this option will include drivers and the core
> -	  infrastructure code to support RapidIO interconnect devices.
> -
>  source "drivers/rapidio/Kconfig"
>  
>  config X86_SYSFB
> -- 
> 2.18.0
> 
> 
