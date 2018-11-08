Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C59ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5F720827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5F720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKICAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:00:12 -0500
Received: from mout.gmx.net ([212.227.15.19]:55893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbeKICAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:00:12 -0500
Received: from [66.187.233.206] ([66.187.233.206]) by web-mail.gmx.net
 (3c-app-mailcom-bs15.server.lan [172.19.170.183]) (via HTTP); Thu, 8 Nov
 2018 17:23:55 +0100
MIME-Version: 1.0
Message-ID: <trinity-7128b38b-7a1d-4584-aa34-174a2906ec88-1541694235634@3c-app-mailcom-bs15>
From:   "Qian Cai" <cai@gmx.us>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org
Subject: BUG: sleeping function called from invalid context at mm/slab.h:421
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 8 Nov 2018 17:23:55 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:jxssYBMFV0Azjh67OKQ56uEVR0IxnPylx96+lH8l4uMDA6/fX4ELkQUtrExGWIkanJ8Vn
 PqBUjaQ0NLGmf5Ft5CAEQGEm7LOX+bQ3tg5tdF4u0yn2yTgW8/3Trj/3MhhaBZlENbpSWv6me+Am
 0CGd3xrhxkEogI1LFp5zhudjloxBHiqENM/9k8XoqXmmgSVcK5lh0IHPspg2N6uVP7xbot2+/4Qn
 es5t2zD30WYeb/9LZtbVjPS9yRZrMjI0OKgCypiHoTXCEv0lx6XDTmvO2lnaW6h8+CJvM7rER+IL
 To=
X-UI-Out-Filterresults: notjunk:1;V01:K0:XPnk84UoQqE=:32qdnvUldL/PIsdPd1mtFU
 DqQxIXub7T7pN9ElsoU1e2KrS6YeU3MvAYm3mxOk5enOmcVHSG0HCTosMQDJlOK+C6hS2lwkL
 SW3DBoZIMYhCzwYrjWLjZVaxyEYQ9BGlxA/emVDehLUXArtPcxKtLjqOTBQnx8O4gry8QO1BY
 06Rd0u4YUHjwQdeudjyE9X1UtasgD5N/toD9WJUKnrYKswJVxVP2hY0DWlBrBaumsfCDbVqrx
 qxQdFomDeYl0iKjEGoolIVx2svF0q7s5io4w8xVVHo1gvCRAPmTBTF6yblt1qIZ/L2gvAnhzx
 LlKQk7/wCgVpMxib91+TilgIPHIqLmHodfpbSst/Ciypp3a7rdZ7F72cxQWXRVuNdP3KHIl7k
 D668HGEZBnGKwY6jZCTTtTkDreV1D1JbLev4UzVx7DkAVqvnfrW+aavOwYxG1rjIXpk8KnWcM
 6OIqpVdk2XdseyFHT6udxQphT76S92qjgwCSlwyKiV7RPIqIB4t30e3HI0nNJsGshdjofDLJo
 50j1J2cBBh//dJuuXanjSyxlHwyoSty9MJPpXCqSRWZMnQ8ex4UWex72nA9pkCr4A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just booting up the latest git master (b00d209) on an aarch64 server and saw this.

Nov  8 11:06:36 huawei-t2280-03 kernel: BUG: sleeping function called from invalid context at mm/slab.h:421
Nov  8 11:06:36 huawei-t2280-03 kernel: in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/1
Nov  8 11:06:36 huawei-t2280-03 kernel: no locks held by swapper/1/0.
Nov  8 11:06:36 huawei-t2280-03 kernel: irq event stamp: 0
Nov  8 11:06:36 huawei-t2280-03 kernel: hardirqs last  enabled at (0): [<0000000000000000>]           (null)
Nov  8 11:06:36 huawei-t2280-03 kernel: hardirqs last disabled at (0): [<ffff2000080e24ec>] copy_process.isra.32.part.33+0x460/0x1534
Nov  8 11:06:36 huawei-t2280-03 kernel: softirqs last  enabled at (0): [<ffff2000080e24ec>] copy_process.isra.32.part.33+0x460/0x1534
Nov  8 11:06:36 huawei-t2280-03 kernel: softirqs last disabled at (0): [<0000000000000000>]           (null)
Nov  8 11:06:36 huawei-t2280-03 kernel: CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.20.0-rc1+ #3
Nov  8 11:06:36 huawei-t2280-03 kernel: Call trace:
Nov  8 11:06:36 huawei-t2280-03 kernel: dump_backtrace+0x0/0x190
Nov  8 11:06:36 huawei-t2280-03 kernel: show_stack+0x24/0x2c
Nov  8 11:06:36 huawei-t2280-03 kernel: dump_stack+0xa4/0xe0
Nov  8 11:06:36 huawei-t2280-03 kernel: ___might_sleep+0x208/0x234
Nov  8 11:06:36 huawei-t2280-03 kernel: __might_sleep+0x58/0x8c
Nov  8 11:06:36 huawei-t2280-03 kernel: kmem_cache_alloc_trace+0x29c/0x420
Nov  8 11:06:36 huawei-t2280-03 kernel: efi_mem_reserve_persistent+0x50/0xe8
Nov  8 11:06:36 huawei-t2280-03 kernel: its_cpu_init_lpis+0x298/0x2e0
Nov  8 11:06:36 huawei-t2280-03 kernel: its_cpu_init+0x7c/0x1a8
Nov  8 11:06:36 huawei-t2280-03 kernel: gic_starting_cpu+0x28/0x34
Nov  8 11:06:36 huawei-t2280-03 kernel: cpuhp_invoke_callback+0x104/0xd04
Nov  8 11:06:36 huawei-t2280-03 kernel: notify_cpu_starting+0x60/0xa0
Nov  8 11:06:36 huawei-t2280-03 kernel: secondary_start_kernel+0xcc/0x178

Any idea?
