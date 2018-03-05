Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933295AbeCEKFX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:05:23 -0500
Received: from mondschein.lichtvoll.de ([194.150.191.11]:43279 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933072AbeCEKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:05:18 -0500
From: Martin Steigerwald <martin@lichtvoll.de>
To: Sven Joachim <svenjoac@gmx.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.16-rc4
Date: Mon, 05 Mar 2018 11:05:16 +0100
Message-ID: <5552043.iprGPZeTD1@merkaba>
In-Reply-To: <878tb7eyf8.fsf@turtle.gmx.de>
References: <CA+55aFxXg8hi+T_DNCG_OrAotqSheyREw-Njf9XgUD1vXqAyHQ@mail.gmail.com> <878tb7eyf8.fsf@turtle.gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven.

Sven Joachim - 05.03.18, 09:09:
> On 2018-03-04 15:15 -0800, Linus Torvalds wrote:
> > Hmm. A reasonably calm week - the biggest change is to the 'kvm-stat'
> > tool, not any actual kernel files.
> > 
> > But there's small changes all over, with architecture updates (x86,
> > s390, arm, parisc) and drivers (media, md, gpu, sound) being the bulk
> > of it.  But there's some filesystem fixes (mostly btrfs),
> > documentation updates etc too.
> > 
> > Go test,
> 
> Huh, this version does not build for me:
> 
> ,----
> 
> |   CALL    scripts/checksyscalls.sh
> |   DESCEND  objtool
> |   CC       /usr/local/src/linux/tools/objtool/check.o
> | 
> | In file included from check.c:26:0:
> | check.c: In function 'read_retpoline_hints':
> | warn.h:57:3: error: format '%ld' expects argument of type 'long int', but
> | argument 5 has type 'unsigned int' [-Werror=format=]| 
> |    "%s: warning: objtool: " format "\n", \
> |    ^
> | 
> | check.c:1135:3: note: in expansion of macro 'WARN'
> | 
> |    WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned
> |    long)); ^~~~
> | 
> | check.c:1135:44: note: format string is defined here
> | 
> |    WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned
> |    long));|    
> |                                           ~~^
> |                                           %d
> | 
> | cc1: all warnings being treated as errors
> | mv: cannot stat '/usr/local/src/linux/tools/objtool/.check.o.tmp': No such
> | file or directory /usr/local/src/linux/tools/build/Makefile.build:96:
> | recipe for target '/usr/local/src/linux/tools/objtool/check.o' failed
> | make[3]: *** [/usr/local/src/linux/tools/objtool/check.o] Error 1
> 
> `----
> 
> This might be because I still use a 32-bit userland with a 64-bit
> kernel.

Building just fine here with a 64-bit userland on Debian Sid and also working 
just fine, so far:

% cat /proc/version
Linux version 4.16.0-rc4-tp520-btrfstrim+ (martin@merkaba) (gcc version 7.3.0 
(Debian 7.3.0-5)) #42 SMP PREEMPT Mon Mar 5 10:22:42 CET 2018

Of course a build failure may be triggered by different configuration or any 
number of other reasons than using 32-bit userland.

Retpoline protection is active here:

% grep . /sys/devices/system/cpu/vulnerabilities/*
/sys/devices/system/cpu/vulnerabilities/meltdown:Mitigation: PTI
/sys/devices/system/cpu/vulnerabilities/spectre_v1:Mitigation: __user pointer 
sanitization
/sys/devices/system/cpu/vulnerabilities/spectre_v2:Mitigation: Full generic 
retpoline

Thanks,
-- 
Martin
