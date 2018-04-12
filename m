Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeDLAuf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 20:50:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52342 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeDLAud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 20:50:33 -0400
Date: Thu, 12 Apr 2018 01:50:29 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] proc: fixup (c) sign
Message-ID: <20180412005029.GQ30522@ZenIV.linux.org.uk>
References: <CA+55aFxrpn=GdgqgrczUdj-wndFdQvmfytwMiYL5=TQWhfpAjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFxrpn=GdgqgrczUdj-wndFdQvmfytwMiYL5=TQWhfpAjA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 03:41:26PM -0700, Linus Torvalds wrote:
> On Wed, Apr 11, 2018 at 1:24 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > It got sent from here as iso8859-1.
> 
> It's probably a good idea to just move away from Latin1 entirely, and
> encourage people to just use utf-8.
> 
> But yes, Andrew's scripts clearly do a horrible job at looking at
> email encoding, and that really should be fixed.
> 
> I worry less about silly copyright signs than about peoples actual
> _names_, but we've certainly seen problems there too.

FWIW, excluding the stuff obviously not in UTF8 (logo.gif and 
tools/power/cpupower/po/{de,fr}.po) we have

lib/fonts/font_7x14.c
lib/fonts/font_8x16.c
lib/fonts/font_8x8.c
lib/fonts/font_pearl_8x8.c
arch/s390/kernel/ebcdic.c
	crap in comments
arch/m68k/hp300/hp300map.map
drivers/tty/vt/defkeymap.map
	non-UTF8 - literals for compose statements
arch/arm/crypto/sha256_glue.c
arch/arm/crypto/sha256_neon_glue.c
kernel/events/callchain.c
	Latin1 copyright symbol (0xa9)
drivers/staging/rtl8188eu/include/odm.h
	Latin1 inverted ! (0xa1)
Documentation/devicetree/bindings/net/nfc/pn544.txt
	Latin1 superscript 2 (0xb2), in I²C
arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
	Latin1 o-umlaut (0xf6) in David Lanzendörfer
drivers/crypto/vmx/ghashp8-ppc.pl
	a bunch of Latin1 middle dots (0xb7), in comments inside string constant
used to produce asm output, no less
drivers/gpu/drm/amd/include/atombios.h
	several U+FFFD in there - buggered conversion to UTF8?
drivers/gpu/drm/r128/r128_drv.h
	ditto, but here it's possible to figure out what got buggered -
Michel D�zer <daenzerm@student.ethz.ch> that presumably should've been "Dänzer"
drivers/iio/dac/ltc2632.c
	Latin1 e-acute in Maxime Roussin-Bélanger
drivers/power/reset/ltc2952-poweroff.c
	ditto in René Moll
drivers/spi/spi-omap-100k.c
	a couple of U+FFFD in Juha Yrjölä <juha.yrjola@nokia.com> - o- and a-umlaut
In this case the actual spelling is trivially googled.
drivers/spi/spi-omap2-mcspi.c
	ditto
drivers/usb/misc/iowarrior.c
	U+FFFD in Stéphane Doyon <s.doyon@videotron.ca> - e-acute
drivers/visorbus/visorbus_main.c
	U+FFFD in place of copyright symbol
