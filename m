Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754688AbeCVMgT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:36:19 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:54204 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCVMgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:36:16 -0400
Date: Thu, 22 Mar 2018 13:35:57 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>
Cc: Nick Terrell <terrelln@fb.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel-team@fb.com,
        Chris Mason <clm@fb.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Message-ID: <20180322123557.4eu4huhldqn6bid6@angband.pl>
References: <20180322012943.4145794-1-terrelln@fb.com>
 <C0384AAE-FF89-4BAA-8EFC-FB3B0A8F02AB@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C0384AAE-FF89-4BAA-8EFC-FB3B0A8F02AB@exactcode.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 12:09:45PM +0100, René Rebe wrote:
> Should this currently just work without any arch change on e.g.
> ppc64, sparc64 et al.? I could do a test build and boot if that is
> of any value, ...

Initrd: no reason it wouldn't work, although for anything related to the
boot process testing is a very good idea.  If you test, you'd really want to
apply that printk patch I posted, it's too easy to accidentally get a silent
fallback to gzip or uncompressed.  I wonder, perhaps such a printk could be
permanently added, at a low message priority?

Kernel itself: needs per-arch porting, but it's not advertised in kconfig
outside x86 so that's not a problem.  

If you are knowledgeful about bootloaders on ppc64, sparc64, etc, such
information would be great.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
