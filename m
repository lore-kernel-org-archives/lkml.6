Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeBTXow (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:44:52 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41876 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeBTXou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:44:50 -0500
X-Google-Smtp-Source: AH8x2248zvNuHNfdaFkzXZdlvcHPXSefl1t7HD9y3puckvNhpOUh3J1ymfmLZFkVF8siw4y8r+w70Q==
Date: Tue, 20 Feb 2018 15:44:43 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Cc: linux-metag@vger.kernel.org, James Hogan <jhogan@kernel.org>
Subject: metag build errors in mainline kernel
Message-ID: <20180220234443.GA27059@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following errors are seen when building the kernel with the latest
available metag toolchain (4.2.4 (IMG-1.4.0.700)). Kernel version tested
is (v4.16-rc2-64-gaf3e79d29555).

metag:allmodconfig

arch/metag/kernel/devtree.c:54: error: implicit declaration of function 'pr_info'

arch/metag/kernel/perf/perf_event.c:831: error: label ‘out’ used but not defined
arch/metag/kernel/perf/perf_event.c:822: warning: unused variable ‘cpu’

metag:meta2_smp_defconfig

kernel/time/hrtimer.c: In function 'hrtimer_run_softirq':
time/hrtimer.c:1431: error: unable to find a register to spill in class 'Yr_REGS'
time/hrtimer.c:1431: error: this is the insn:
(insn:HI 41 40 99 2 kernel/time/hrtimer.c:576 (set (mem/s/j:DI (plus:SI (reg/f:SI 15 D1.7 [orig:84 D.45290 ] [84])
                (const_int 368 [0x170])) [0 <variable>.offset+0 S8 A128])
	(reg:DI 99 [ <variable>.offset ])) 211 {*sto_di_1_1_off12} (nil)
    (expr_list:REG_DEAD (reg:DI 99 [ <variable>.offset ])
	(nil)))
kernel/time/hrtimer.c:1431: confused by earlier errors, bailing out

Guenter
