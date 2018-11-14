Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46732C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2E02082A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2E02082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbeKNMvL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:51:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:39925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731950AbeKNMvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:51:11 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MFu0Y-1gIxdL4514-00EwEZ; Wed, 14
 Nov 2018 03:49:58 +0100
From:   Qian Cai <cai@gmx.us>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: BUG: KASAN: slab-out-of-bounds in try_to_unmap_one+0x1c4/0x1af0
Message-Id: <4519B305-F61A-4C10-B55A-910A3EFB94AA@gmx.us>
Date:   Tue, 13 Nov 2018 21:49:52 -0500
Cc:     linux-mm@kvack.org
To:     linux kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:C/asWk810z/c4IQ7b8LLX9uubR+0q8CNY6kdObcNdQeGdXgelEh
 xEAGbBimjCqlvdAU7Aod2RICiKLBH1wg4Ltw/DQ2TEE5fqXF7nftnazL17Blh+6AQ3Xok2D
 vPWdLWVbhPTwVhLVpVrgOHV1zI+vhLLLSHHeZK/DUObpudo5xqk6SQu+T5yrJU/N0kbVU4v
 wezZWY2iKgaG3k3VrSh2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VzIBWjFwTC8=:NyYqAeh+jZkdaVmHHjvgEJ
 AgA7IF3rK4sGrzG2E0+GYepPTAHX+Wd2Y4ekKdaJUyC4AriEb4qq22FymL0zlCbggw33W1JZR
 dSWo/mJ0XSgGd0gnwsnEjVJ5oZL0IPEttmbVK4XpYKRVDOVB3hMz465V6dXF5Ake40x1VOTog
 UVkYF9qhgn8KVyM3AIveg0+dnUMMKxvmAs81DfWzRz5hCE5+FufR8RU6yF3gr8Oy/o2e/DRvH
 rIb2XusA7eWG12jZlbYmoUTCZ5Bo3U+IJqP7fw2cv3iAvdEBJFA2zicCOtCA48P3CLK1JtaZ/
 EZ0xS1UFUFZHOoTEnm6rsqI8xg551CGBfVYDpKEdTyWTbDVcvCGGtkJyiXFXlGfGY1knhdBUZ
 qnT5fT9+h6P/YZ1sl5EioxMYzYiu284oefdRdU53lfv2WJH6zfzqW5Ag9RUpTwmC/Z8pWvHwN
 VFjGKFD8mKcFPcqo0P/VDtC4hEO/yD/W4CmfFvj9KefmYD7BCwfi5ULTT/d9zW8IOX0ON/1rr
 AtcBVz2vDVglpK5+4kw8RYX8ZXhirG83FZcJAFx+W8UUeqcfqQI/ZpeI36hvMs+e0ppnbc2Oc
 IDBJJonniyu1j4cCJB+ePRfE10TbnZwGHGC6dFb3PBVcuBkiRBVwXqLEGpI3pDeg5rsrGjjHt
 MaAImCTmSn08ApWUPuw9vabycD00CvKrNqZddefTczHyPDTX6ZNLpJvJvySDitqnizfl8Yo2l
 XLZ5eJRLzWJK6xOLCRIVQL90tweqhZQ94MDi1WEAwjZxevyQKgxoNzfIJAmji33Ql0+6slO70
 bU9K28cmaJcLuj8m8SICOFErHjKA4G7L5mTMAdRJbm6v8JoVza2NYbTaxhYZm6vr1cOoW80QN
 4HR4MH0EOy7qBhi57XI91lXeJklX9SsFU6fGyUblSxOlhGScQU/1IkF1A/uVr8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling kernel on an aarch64 server with the latest mainline (rc2) triggered this,

[ 1463.931841] BUG: KASAN: slab-out-of-bounds in try_to_unmap_one+0x1c4/0x1af0
[ 1463.938969] Write of size 32 at addr ffff80897ce87b58 by task kworker/u513:0/5209
[ 1463.946678] 
[ 1463.948656] CPU: 38 PID: 5209 Comm: kworker/u513:0 Kdump: loaded Tainted: G        W    L    4.20.0-rc2+ #4
[ 1463.958485] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.0.6 07/10/2018
[ 1463.968450] Workqueue: writeback wb_workfn (flush-253:0)
[ 1463.973848] Call trace:
[ 1463.976622]  dump_backtrace+0x0/0x2c8
[ 1463.980642] 
[ 1463.982239] Allocated by task 2:
[ 1463.985528]  kasan_kmalloc.part.1+0x40/0x108
[ 1463.989842]  kasan_kmalloc+0xb4/0xc8
[ 1463.993500]  kasan_slab_alloc+0x14/0x20
[ 1463.997630]  kmem_cache_alloc_node+0x140/0x430
[ 1464.002241]  copy_process.isra.2+0x39c/0x2e20
[ 1464.007009]  _do_fork+0x120/0xa28
[ 1464.010595]  kernel_thread+0x48/0x58
[ 1464.014206]  kthreadd+0x3dc/0x478
[ 1464.017698]  ret_from_fork+0x10/0x1c
[ 1464.021466] 
[ 1464.022981] Freed by task 1391:
[ 1464.026214]  __kasan_slab_free+0x114/0x228
[ 1464.030447]  kasan_slab_free+0x10/0x18
[ 1464.034305]  kmem_cache_free+0x9c/0x3a8
[ 1464.038284]  put_task_stack+0x94/0x110
[ 1464.042169]  finish_task_switch+0x3b0/0x488
[ 1464.046850]  __schedule+0x5e4/0xda0
[ 1464.050665]  schedule+0xdc/0x240
[ 1464.054012]  worker_thread+0x278/0xa70
[ 1464.058021]  kthread+0x1c4/0x1d0
[ 1464.061393]  ret_from_fork+0x10/0x1c
[ 1464.065051] 
[ 1464.067005] The buggy address belongs to the object at ffff80897ce88000
[ 1464.067005]  which belongs to the cache thread_stack of size 32768
[ 1464.080107] The buggy address is located 1192 bytes to the left of
[ 1464.080107]  32768-byte region [ffff80897ce88000, ffff80897ce90000)
[ 1464.092578] The buggy address belongs to the page:
[ 1464.097529] page:ffff7fe0225f3a00 count:1 mapcount:0 mapping:ffff8089c0014d80 index:0x0 compound_mapcount: 0
[ 1464.107724] flags: 0x1fffff0000010200(slab|head)
[ 1464.112648] raw: 1fffff0000010200 ffff7fe02266a408 ffff7fe022459408 ffff8089c0014d80
[ 1464.120496] raw: 0000000000000000 0000000000050005 00000001ffffffff 0000000000000000
[ 1464.128284] page dumped because: kasan: bad access detected
[ 1464.134011] 
[ 1464.135619] Memory state around the buggy address:
[ 1464.140576]  ffff80897ce87a00: fc fc fc fc fc fc fc fc fc fc fc fc f1 f1 f1 f1
[ 1464.148063]  00 f2 f2 f2 f2 f2^
[ 1464.168846]7c00: f2 f2 f2 f2
