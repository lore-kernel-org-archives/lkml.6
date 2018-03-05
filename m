Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932872AbeCEHK2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:10:28 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51522 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932646AbeCEHK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:10:26 -0500
X-Google-Smtp-Source: AG47ELstGwsMgSWsbpjvCrLBkRFmJSRk0drXfrggAnl7lnK7QRKKf08riazxRIhiRkpwUaz/20cNbg==
Date: Mon, 5 Mar 2018 08:10:21 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "zhenwei.pi" <zhenwei.pi@youruncloud.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] x86/kconfig: Remove residual "no-hlt" boot parameter
 reference
Message-ID: <20180305071021.5lxgjnnwdidkq7re@gmail.com>
References: <1520216154-13737-1-git-send-email-zhenwei.pi@youruncloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520216154-13737-1-git-send-email-zhenwei.pi@youruncloud.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* zhenwei.pi <zhenwei.pi@youruncloud.com> wrote:

> The "no-hlt" boot parameter has been removed ~5 years ago :
> 	The commit 27be457000211a6903968dfce06d5f73f051a217
> 	("x86 idle: remove 32-bit-only "no-hlt" parameter, hlt_works_ok flag")
> 
> Remove a stale reference from the documentation as well.
> 
> Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>
> ---
>  arch/x86/Kconfig | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eb7f43f..bdb17b7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2494,19 +2494,18 @@ menuconfig APM
>  
>  	  1) make sure that you have enough swap space and that it is
>  	  enabled.
> -	  2) pass the "no-hlt" option to the kernel
> -	  3) switch on floating point emulation in the kernel and pass
> +	  2) switch on floating point emulation in the kernel and pass
>  	  the "no387" option to the kernel
> -	  4) pass the "floppy=nodma" option to the kernel
> -	  5) pass the "mem=4M" option to the kernel (thereby disabling
> +	  3) pass the "floppy=nodma" option to the kernel
> +	  4) pass the "mem=4M" option to the kernel (thereby disabling
>  	  all but the first 4 MB of RAM)
> -	  6) make sure that the CPU is not over clocked.
> -	  7) read the sig11 FAQ at <http://www.bitwizard.nl/sig11/>
> -	  8) disable the cache from your BIOS settings
> -	  9) install a fan for the video card or exchange video RAM
> -	  10) install a better fan for the CPU
> -	  11) exchange RAM chips
> -	  12) exchange the motherboard.
> +	  5) make sure that the CPU is not over clocked.
> +	  6) read the sig11 FAQ at <http://www.bitwizard.nl/sig11/>
> +	  7) disable the cache from your BIOS settings
> +	  8) install a fan for the video card or exchange video RAM
> +	  9) install a better fan for the CPU
> +	  10) exchange RAM chips
> +	  11) exchange the motherboard.

That description is stale in other ways as well (nobody uses floppies anymore), 
I'd just remove it altogether, starting with this:

                                                                If you get
          random kernel OOPSes or reboots that don't seem to be related to
          anything, try disabling/enabling this option (or disabling/enabling
          APM in your BIOS).
	  [...]

Thanks,

	Ingo
