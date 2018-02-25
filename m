Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeBYXgw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 18:36:52 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34853 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeBYXgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 18:36:51 -0500
X-Google-Smtp-Source: AG47ELtTUTRs7evoY7yJJ+QMwUF24PZPoSM6dVtrDNeHEKNvygb6WbibbyvZAc2bRwVUOTF/uteOwnOWX0f+yYYypNw=
MIME-Version: 1.0
From: Pradyumna Kaushik <pkaushi1@binghamton.edu>
Date: Sun, 25 Feb 2018 18:36:49 -0500
Message-ID: <CAO6sEsCoWpiR+B=GcpQfp1CFiTa2YkoyxEEMezP_Dr2faq-EeQ@mail.gmail.com>
Subject: Inconsistent values of perfevent hardware counters when measuring
 power consumption of DRAM using RAPL
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently noticed a large inconsistency in the data retrieved from
the perf_event hardware counters pertaining to the power consumption
of DRAM.
This inconsistency was noticed upon a kernel upgrade from 4.4.0 to 4.14.20.

Machine specs,
Dual Socket.
Processor specs: Intel(R) Xeon(R) CPU E5-2650 v3, 2.30 GHz (10 cores
with 2 threads per core).
So, overall it's a 20 core, 40 thread machine.
TDP of the machine -- 210 Watts (105 Watts for each Xeon processor)

In my research lab, we use performance co-pilot to measure power
consumption of the CPU and DRAM through the use of perfevent hardware
counters and RAPL.

Old results
Ubuntu Xenial
Kernel Version: 4.4.0
idle power consumption of CPU -- 33.34 Watts
idle power consumption of DRAM -- 14.76 Watts

New results (after kernel upgrade):
Ubuntu Xenial
Kernel Version: 4.14.20
Idle power consumption of CPU -- 33.23 Watts
Idle power consumption of DRAM -- 59.15 Watts

Can anyone give me some insight as to why this is the case?

-- 
Thanks and Regards
Pradyumna Kaushik

Graduate Student
Department of Computer Science
Thomas J. Watson School of Engineering and Applied Science
Binghamton University
