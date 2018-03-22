Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCVC7I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:59:08 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:51846 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeCVC66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:58:58 -0400
Date: Thu, 22 Mar 2018 03:58:48 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Nick Terrell <terrelln@fb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kernel-team@fb.com, Chris Mason <clm@fb.com>,
        Rene Rebe <rene@exactcode.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Message-ID: <20180322025848.dnymbsvpep45s3bg@angband.pl>
References: <20180322012943.4145794-1-terrelln@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180322012943.4145794-1-terrelln@fb.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 06:29:41PM -0700, Nick Terrell wrote:
> This patch set adds support for a ZSTD-compressed kernel and ramdisk
> images in the kernel boot process. It only integrates the support with
> x86, though the first patch is generic to all architectures.

I'm running this patch set since October on amd64 armhf arm64, no
explosions -- besides the obvious when it's not applied yet I forget to
reconfigure initramfs-tools.  Which is getting tedious, so let's merge this
already. :)

I've tested initrd on all of these archs; here's a debug patch to check if
you're actually using it.

As for compressing the kernel itself: the second patch works as submitted
(ie, x86 only).  Porting it to other architectures is straightforward, but
eg. on arm, most boards use u-boot which insists on decompressing the kernel
by itself instead of passing control.  EFI/grub should work, but I haven't
tested that yet.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
