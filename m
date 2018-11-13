Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5CE22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5CE22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbeKMOlw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:41:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:49803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeKMOlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:41:51 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MTTKZ-1fwoXc1d7X-00SPVx; Tue, 13
 Nov 2018 05:45:31 +0100
From:   Qian Cai <cai@gmx.us>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Kernel panic - not syncing: corrupted stack end detected inside
 scheduler
Message-Id: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
Date:   Mon, 12 Nov 2018 23:45:29 -0500
Cc:     linux-mm@kvack.org
To:     linux kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:yqiCHGE6Xbdz7cOLhx9fXdx5TcLys+HxJKgp5FnT2YU7gRmFP7N
 SMqz3CaGydtxjwDNpPyXI7u4MCNofjkQZMJrxYpIs0ntOVKE0rhzRgvAjhBcLwH7jcs3DzG
 GzejQRpAkCrCGtABMQXtzHgeLHGCArpzmGNvcXROB/AkRwnzhZQ+bF8zotrBqUAlw4egu2I
 bVVDFjiWnYUIxBJM/v+6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zbTAHMPU8bg=:gvpodrPnOXFa/qmz3zBbcJ
 4n1Azea9XIIyborXkcWvKITfXRWvdOm+YXLbv2RXKPO+GQnT87Zms0PrX2jaMA8R8n5EBSNfo
 6E7Mc5zxB0+vJudF2IkiD5A8AtUpQSjlWMpeJEgTvTQIi8KhFdP0DOWEoyZZ02BVnFkvALrfV
 A1x4Dupcgyml8W0/aBSnf2lki+z04SjYysUJcWvyvUrmfScIgB0tNHYsnVSQyVNh+Asy5UXWP
 2JqM/V4seqMMF8Bk8pFTGlxZH2vbNQX565iC95yFrKNciPVU6M7k5+5Ai25vDLMoX0G1KVQAL
 PuS1z4BJhDvIKroZRGjdCKh4vHmXmWyyvl7ajBQGxz9XNRN/eqWdjv0CH6g+ogPCd9qRP38gg
 eOFj5zRK+V87ytIRLuIB1knLlYePFqXuTXbX7OO4eea1r4blUS5ddqkhsLJmub3TjkgKIdHUH
 BotbevMCTmpbSRPEcidnrVShpe64SXCOwQaHK8wDjTJgSOGtYwurSfGdcW9YObHpgoG5r03gr
 5SmNbR3dkqMwyWslSyOv+nU+BTMx3SbdrPSfX3iVm0StKoqRJGdlVG1VT1/Uh/7Y0p3I8mjWz
 D05I7U1h2y6e6VYhlnFU4+nD88oT0jsyeCmTX0y/a9+xEyd3mZWwsAT50KTyoEB/igV7UH7M6
 CPjdUXS7WGqpE3nVj629HqFNDIsZZi44ciF3Uq/rpYh9wOa0u8iqyv1DAysrRGH7CC37/0t3E
 IZZbnaty27/aMB+0IDiUfv3NR727pkpDKHVHppOF+HjCmstnDPxt5erPuFHRKsywQBaoZRptI
 LRbqogZMlZZtJxmmHi10NUxfAuyFH2pXm0+40QOrRXZukFhFMu7t58BRSYdz44wUAjE3Oga+B
 AqOK6AQbFbgaOEbPIEVFr8HPGm2KF4O7JdUBGL9BmE/NqN8Oj5Ia8u4D6XOPbK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running LTP oom01 [1] test triggered kernel panic on an aarch64 server with the latest mainline (rc2).

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c

[ 3433.338741] Kernel panic - not syncing: corrupted stack end detected inside scheduler
[ 3433.347644] CPU: 49 PID: 2189 Comm: in:imjournal Kdump: loaded Tainted: G        W         4.20.0-rc2+ #15
[ 3433.357298] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
[ 3433.364523] Call trace:
[ 3433.366993]  dump_backtrace+0x0/0x2c8
[ 3433.370659]  show_stack+0x24/0x30
[ 3433.373980]  dump_stack+0x118/0x19c
[ 3433.377473]  panic+0x1b8/0x31c
[ 3433.380530]  schedule+0x0/0x240
[ 3433.383672]  schedule+0xdc/0x240
[ 3433.386905]  io_schedule+0x24/0x48
[ 3433.390313]  get_request+0x3b0/0xb68
[ 3433.393891]  blk_queue_bio+0x3a4/0xcd8
[ 3433.397642]  generic_make_request+0x440/0x7d8
[ 3433.402000]  submit_bio+0xbc/0x300
[ 3433.405409]  __swap_writepage+0xa54/0xd00
[ 3433.409420]  swap_writepage+0x44/0xb0
[ 3433.413086]  pageout.isra.12+0x580/0xd80
[ 3433.417011]  shrink_page_list+0x2480/0x36f0
[ 3433.421196]  shrink_inactive_list+0x388/0xb98
[ 3433.425555]  shrink_node_memcg+0x344/0x9c0
[ 3433.429653]  shrink_node+0x200/0x940
[ 3433.433231]  do_try_to_free_pages+0x234/0x7d0
[ 3433.437589]  try_to_free_pages+0x228/0x6b0
[ 3433.441689]  __alloc_pages_nodemask+0xcbc/0x2028
[ 3433.446309]  alloc_pages_vma+0x1a4/0x208
[ 3433.450235]  __read_swap_cache_async+0x4fc/0x858
[ 3433.454855]  read_swap_cache_async+0xa4/0x100
[ 3433.459214]  swap_cluster_readahead+0x598/0x650
[ 3433.463746]  shmem_swapin+0xd4/0x150
[ 3433.467324]  shmem_getpage_gfp+0xf50/0x1c48
[ 3433.471509]  shmem_fault+0x140/0x340
[ 3433.475086]  __do_fault+0xd0/0x440
[ 3433.478490]  do_fault+0x54c/0xf48
[ 3433.481807]  __handle_mm_fault+0x4c0/0x928
[ 3433.485905]  handle_mm_fault+0x30c/0x4b8
[ 3433.489832]  do_page_fault+0x294/0x658
[ 3433.493584]  do_translation_fault+0x98/0xa8
[ 3433.497769]  do_mem_abort+0x64/0xf0
[ 3433.501258]  el0_da+0x24/0x28
