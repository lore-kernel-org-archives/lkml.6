Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750905AbeELK4J (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 06:56:09 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:42369 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeELK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 06:56:07 -0400
X-Google-Smtp-Source: AB8JxZpTaq0jiKC949u5Tke8XYDxwdJe3xyD70ktNdGDn3DR1ARsuDpCHZdi9JMWzW2NXhal/Vv1mg0lzoi2Dd+/fpY=
MIME-Version: 1.0
From: Gabriel C <nix.or.die@gmail.com>
Date: Sat, 12 May 2018 12:55:35 +0200
Message-ID: <CAEJqkgjMMMwK0Y7xSJCGVnbPor1MirA30HrN=U2EsGZNRQFs8A@mail.gmail.com>
Subject: commit bd9240a18edfbfa72e957fc2ba831cf1f13ea073 seems to break with
 intel-ucode 20180425
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: kevin.b.stanton@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

after updating ucode to 20180425 on my laptop I always hit the
'TSC_DEADLINE disabled' error and so early microcode update from
inird breaks.

Also I'm able to late load the microcode from command line but
not from initrd.

Going back to ucode 20180312 make things work again.

I've tested on latest 4.16.8 kernel for now.

lscpu output:

Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  2
Core(s) per socket:  2
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               78
Model name:          Intel(R) Core(TM) i7-6498DU CPU @ 2.50GHz
Stepping:            3
CPU MHz:             500.005
CPU max MHz:         3100.0000
CPU min MHz:         400.0000
BogoMIPS:            5184.00
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            4096K
NUMA node0 CPU(s):   0-3
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts
rep_good nopl xtopology no
nstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2
x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
lahf_lm abm 3dnowprefetch cpuid
_fault epb invpcid_single pti tpr_shadow vnmi flexpriority ept vpid
fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx
smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves ibpb ibrs
stibp dtherm ida arat pln pts hwp
hwp_notify hwp_act_window hwp_epp


Best Regards,

Gabriel C
