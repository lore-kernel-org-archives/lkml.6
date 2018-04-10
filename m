Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeDJPsr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:48:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:58935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751815AbeDJPsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:48:46 -0400
Message-ID: <1523375305.4909.0.camel@gmx.de>
Subject: Re: x86-tip.today (4cdf573) early instaboot
From: Mike Galbraith <efault@gmx.de>
To: Tom Lendacky <thomas.lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 10 Apr 2018 17:48:25 +0200
In-Reply-To: <430ee27a-fbef-9717-792b-bbd06b04996f@amd.com>
References: <1523347959.4724.2.camel@gmx.de>
         <20180410085917.bo526ueprf7zfare@gmail.com>
         <1523363877.4942.2.camel@gmx.de>
         <430ee27a-fbef-9717-792b-bbd06b04996f@amd.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:d9dFmYTr17k0HnQLxbkpgnMDrHmEp79srRpnbqV8CQJELBEubAZ
 39ZJ3VCXbJx2hTT4SSZ3OxHCBoaBw5D48qOAy/XTrXAe7DZ1kZM7qeucPTkEcUtBAzf0mtL
 osDr2Sa8KcLwmindt0eQvffxB2HrOGclPS8Hb+En5CtgBMbdEUXlBpK7nlqGiyRfo/6b8zp
 jv/sBhb0NwagZzLBRknpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O9c2UuTmtVo=:5a720INAMp0GfVWZptn299
 LUOitiIDJovD101qlPrZZjX1AhBjv7v07svSdBYKrFYDJUjje08XUpjaWsYRhKc2h3J65N0p8
 l4LQxGqH9V5Z66dY2gjPjKVhKH/qIiliAswdoHabrAHW9TULZHG6zk2OX3HngIwUBCWrnLgfY
 mvFANr1x5+G9tDtzIiXhmuJFrkjkQhVt3/3qKg21MPnE6R6F6yjiJ8Te88weJOtqdpGcSz6Cz
 7jNKau1CqnxcQsa9tTAf2DqC9vpjcVYBKrXtb36G6sedsR4o1yCdHN5nQ+XYqLsQ0mJhWY9dh
 T23FWNoXQglbYSmR5bya1cmblvxDYw1J6zR3NXalepXmPWdu975zEoWoLYfT2M0kyz8+B7YUb
 6b+dg+xf9KYYaxs19oejZh/cjWC9iPQXoHL5dl9H04WqZWj5yvI2Lxo5HhF5guLmbhLiVzGwk
 NchTLxbEdvb9/Fm1rEorVV0SSkU5sCCYghAZLp1A8co+MDQPLieZCFHusQ9Tu3CEc/pnsBziW
 MY8v+PgMhhUdT4C9GYXEtTY3PXz7Lwhhwa1baimP2WZ/E9K7th80mOcYyMZ3rzoiw2FvyOb6w
 AMwqBXaywvF7vxbQolPibutxr+px0IXRJpX+CzUoLsnBBpcb3u2KDIPkl98hljzkoIFKZhSBR
 KaYNIJPeRQbQjecyOZPVLLvjJc6dsg6BavV+l4gP4cZl676aPlgKSVLHvitZRDwQW9Epk0GOq
 nXIEkS+oSxSkrlo8RmZ3ZZq+EGwMc3N01fr/2KUlc8XZdPxO5O/LyW2SESgmSwxll7NTmHjgD
 3A+sE8TQ0jTpgHdW3081rHCxCNwDylWYsEzEbUMrE0TkVz/Yvw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 09:06 -0500, Tom Lendacky wrote:
> 
> Just out of curiosity, can you try the following patch and see if it
> fixes your reboot issue:

Yup, all better.

> diff --git a/arch/x86/boot/compressed/kaslr.c
> b/arch/x86/boot/compressed/kaslr.c
> index c5196d2..a0a50b9 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -55,7 +55,7 @@
>  extern unsigned long get_cmd_line_ptr(void);
> 
>  /* Used by PAGE_KERN* macros: */
> -pteval_t __default_kernel_pte_mask __read_mostly;
> +pteval_t __default_kernel_pte_mask __read_mostly = ~0;
> 
>  /* Simplified build-specific string for starting entropy. */
>  static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
