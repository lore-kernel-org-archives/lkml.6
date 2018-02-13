Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933784AbeBMIuf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:50:35 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:41702 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933631AbeBMIue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:50:34 -0500
X-Google-Smtp-Source: AH8x227P5TaU30G8w/OIQLuxMsP3iYXOZEGwwYeZPI8DUpQ+Nu5dHySmNpuBcAm2WsRxihWSCL9ANA==
Date: Tue, 13 Feb 2018 09:50:30 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Thinkpad X1 Carbon 3rd - Reducing the compressed framebuffer size
Message-ID: <20180213085030.kiksdi2a7ksae5wz@pali>
References: <20180206152143.vea6si7ncjj7sxyq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180206152143.vea6si7ncjj7sxyq@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 February 2018 16:21:43 Pali Rohár wrote:
> Hi! I'm periodically getting following message in dmesg on Lenovo
> Thinkpad X1 Carbon 3rd generation:
> 
> [drm] Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.
> 
> In BIOS I already set GPU size to 512M, but this did not help. Also
> update to last BIOS version did not help.
> 
> So why this message is periodically print in dmesg? And what can I do
> with this problem?
> 
> And why cannot Linux kernel allocate itself more memory for GPU (if BIOS
> can/could do that)? Is not 512MB for GPU enough?

And here is output from lspci, which clearly says that 512MB is already
set for GPU:

$ lspci -v -s 00:02.0
00:02.0 VGA compatible controller: Intel Corporation HD Graphics 5500 (rev 09) (prog-if 00 [VGA controller])
        Subsystem: Lenovo HD Graphics 5500
        Flags: bus master, fast devsel, latency 0, IRQ 46
        Memory at e0000000 (64-bit, non-prefetchable) [size=16M]
        Memory at c0000000 (64-bit, prefetchable) [size=512M]
        I/O ports at 3000 [size=64]
        [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [d0] Power Management version 2
        Capabilities: [a4] PCI Advanced Features
        Kernel driver in use: i915
        Kernel modules: i915

-- 
Pali Rohár
pali.rohar@gmail.com
