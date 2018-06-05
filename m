Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeFESG4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:06:56 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:28416 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbeFESGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:06:55 -0400
Subject: building in 32bit chroot on x86_64 host broken (was: Linux 4.17)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org>
Date: Tue, 5 Jun 2018 20:52:01 +0259
MIME-Version: 1.0
In-Reply-To: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WatchGuard-Spam-ID: str=0001.0A0C0201.5B16D13F.00BB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have a 32bit x86 and a 64bit x86_64 install on the system.

With linux source up to 4.16.x I could do:

setarch i686 (or use command linux32)
chroot /path/to/32bit/
(/dev, /proc, /sys, /run is bind mounted in the chroot)

Then I could build a 32bit kernel in the chroot without booting the 
32bit system...

(host is running a 4.14 longterm kernel)

but building from 4.17 source in the chroot I get:


$ uname -m
i686
$ make oldconfig
scripts/kconfig/conf  --oldconfig Kconfig
*
* Restart config...
*
*
* Linux/x86 4.17.0 Kernel Configuration
*
64-bit kernel (64BIT) [Y/n/?] (NEW)




So it does not pick up 32bit anymore ...

Is this intentional ? If so, why ? If not, how can I fix it ?

--
Thomas
