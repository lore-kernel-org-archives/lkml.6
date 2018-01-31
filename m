Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbeAaEEf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 23:04:35 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:41587 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeAaEEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 23:04:34 -0500
X-Google-Smtp-Source: AH8x224F2Gi7CxaN5J4A8BuxTWtGjMGXX0ewfZK9+16ie5MEG10+++y5Vc9HFkbeIJsXHAeEBfS92Q==
Date: Tue, 30 Jan 2018 20:04:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Michal Simek <monstr@monstr.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Microblaze boot failure in -next due to 'of/fdt: use
 memblock_virt_alloc for early alloc'
Message-ID: <20180131040431.GA27622@roeck-us.net>
References: <20180109194412.GA15823@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109194412.GA15823@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2018 at 11:44:12AM -0800, Guenter Roeck wrote:
> Hi,
> 
> microblaze and microblazeel images fail to boot in -next.

This still fails in in -next.

Guenter

> Error log is:
> 
> Early console on uartlite at 0x84000000
> bootconsole [earlyser0] enabled
> Ramdisk addr 0x00000000, 
> FDT at 0x9065323c
> Linux version 4.15.0-rc7-next-20180109 (groeck@jupiter.roeck-us.net) (gcc
> version 4.8.0 (GCC)) #1 Tue Jan 9 00:00:13 PST 2018
> bootmem alloc of 12644 bytes failed!
> Kernel panic - not syncing: Out of memory
> ---[ end Kernel panic - not syncing: Out of memory
> 
> git bisect points to commit 0fa1c579349f ("of/fdt: use memblock_virt_alloc
> for early alloc"). Reverting this commit fixes the problem. Bisect log is
> attached.
> 
> Guenter
> 
> ---
> # bad: [392a60393b9051d37534bbfd9c9275a3e3b93fd9] Revert "xdp: generic XDP handling of xdp_rxq_info"
> 	[ this is on top of next-20180109 ]
> # good: [b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d] Linux 4.15-rc7
> git bisect start 'HEAD' 'v4.15-rc7'
> # good: [9da4bdd3a63316ea34855132136f33c5b028a345] Merge remote-tracking branch 'crypto/master'
> git bisect good 9da4bdd3a63316ea34855132136f33c5b028a345
> # good: [82258c330b115f7155052cbf3b8fda7b13bc07ef] Merge remote-tracking branch 'security/next-testing'
> git bisect good 82258c330b115f7155052cbf3b8fda7b13bc07ef
> # bad: [d010115491f19e71169b880e2f8f314c177a4a67] Merge remote-tracking branch 'extcon/extcon-next'
> git bisect bad d010115491f19e71169b880e2f8f314c177a4a67
> # bad: [f94aedf26a459e4213625a74d481474b1582db4d] Merge remote-tracking branch 'clockevents/clockevents/next'
> git bisect bad f94aedf26a459e4213625a74d481474b1582db4d
> # good: [4181937ec3d18493339eda525c051fbaec49c639] Merge branch 'efi/core'
> git bisect good 4181937ec3d18493339eda525c051fbaec49c639
> # good: [93bb10a7f680548f381bf6a830636fe81bcfa375] Merge branch 'x86/pti'
> git bisect good 93bb10a7f680548f381bf6a830636fe81bcfa375
> # good: [3807a90ce7e01fa96a726968da299b902dee10e0] Merge remote-tracking branch 'vfio/next'
> git bisect good 3807a90ce7e01fa96a726968da299b902dee10e0
> # good: [a6111c81eafc86ebc8ba436c13b3cf0eb3d6c964] Merge remote-tracking branches 'spi/topic/sirf', 'spi/topic/sun6i' and 'spi/topic/xilinx' into spi-next
> git bisect good a6111c81eafc86ebc8ba436c13b3cf0eb3d6c964
> # good: [4df6da430da4db957ea51a6c30e404a751b0aed5] clocksource/drivers/stm32: Add the timer delay
> git bisect good 4df6da430da4db957ea51a6c30e404a751b0aed5
> # good: [d7e9ab3c6d76c6480d6b40525375995c0d8526fc] mmc: Don't reference Linux-specific OF_GPIO_ACTIVE_LOW flag in DT binding
> git bisect good d7e9ab3c6d76c6480d6b40525375995c0d8526fc
> # bad: [0fa1c579349fdd90173381712ad78aa99c09d38b] of/fdt: use memblock_virt_alloc for early alloc
> git bisect bad 0fa1c579349fdd90173381712ad78aa99c09d38b
> # good: [33314a1387009361e6cfcfaa772abe3b90d11321] dt-bindings: h8300 clocksource: correct spelling of pulse
> git bisect good 33314a1387009361e6cfcfaa772abe3b90d11321
> # good: [af6074fc9aa4b29517375634189ada1869eea598] of: Use SPDX license tag for DT files
> git bisect good af6074fc9aa4b29517375634189ada1869eea598
> # first bad commit: [0fa1c579349fdd90173381712ad78aa99c09d38b] of/fdt: use memblock_virt_alloc for early alloc
