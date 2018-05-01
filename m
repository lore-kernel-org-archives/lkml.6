Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756315AbeEAR4u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:56:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756285AbeEAR4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:56:48 -0400
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org>
Date: Tue, 1 May 2018 10:56:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2018 05:57 PM, Ulf Magnusson wrote:
> Hello,
> 
> Kconfiglib (https://github.com/ulfalizer/Kconfiglib) now has a
> terminal menuconfig implementation, implemented in plain curses
> (which is in the Python standard library).
> 
> The interface should feel familiar to people used to mconf. It has
> some features that mconf lacks:
> 
>   - Seamless resizing
> 
>   - Unicode support
> 
>   - Runs on Windows (via 'pip install windows-curses', which uses
>     PDCurses)
> 
>   - Improved information displays:
> 
>     * All expressions are split into readable chunks
> 
>     * Menus and comments have information displays
> 
>   - Relatively easy-to-read and easy-to-tweak code.
> 
>     Kconfiglib automatically invalidates symbols as needed, and
>     values can never get stale, which helps.
> 
> Some upcoming features are mouse support and a search feature that
> can jump directly to the definition of a symbol. The jump-to feature
> will use a "show-all" mode in case the symbol isn't visible.
> 
> See the Kconfiglib GitHub page for screenshots. The menuconfig
> implementation is at
> https://github.com/ulfalizer/Kconfiglib/blob/master/menuconfig.py.
> The docstring at the top has some more information.

Hi,

I'm probably missing some python additive (I hope it's that easy), but
menuconfig.py is not liking the "degree" symbol in drivers/net/can/peak_canfd/Kconfig:

config CAN_PEAK_PCIEFD
	depends on PCI
	tristate "PEAK-System PCAN-PCIe FD cards"
	---help---
	  This driver adds support for the PEAK-System PCI Express FD
	  CAN-FD cards family.
	  These 1x or 2x CAN-FD channels cards offer CAN 2.0 a/b as well as
	  CAN-FD access to the CAN bus. Besides the nominal bitrate of up to
	  1 Mbit/s, the data bytes of CAN-FD frames can be transmitted with
	  up to 12 Mbit/s. A galvanic isolation of the CAN ports protects the
	  electronics of the card and the respective computer against
	  disturbances of up to 500 Volts. The PCAN-PCI Express FD can be
	  operated with ambient temperatures in a range of -40 to +85 °C.


kconfiglib.KconfigSyntaxError: 
Malformed ascii in drivers/net/can/peak_canfd/Kconfig
Context: b't temperatures in a range of -40 to +85 \xc2\xb0C.\n'
Problematic data: b'\xc2'
Reason: ordinal not in range(128)


thanks,
-- 
~Randy
