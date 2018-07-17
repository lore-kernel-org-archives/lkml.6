Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0EBECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5542920C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5542920C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbeGQMap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:30:45 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33042 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731117AbeGQMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:30:44 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HBsphQ020708;
        Tue, 17 Jul 2018 04:57:49 -0700
Received: from il-exch02.marvell.com ([199.203.130.102])
        by mx0b-0016f401.pphosted.com with ESMTP id 2k7gpg8wvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Jul 2018 04:57:49 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by IL-EXCH02.marvell.com
 (10.4.102.221) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 17 Jul
 2018 14:57:47 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 17 Jul 2018 04:57:44 -0700
Received: from [10.4.50.2] (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id 60F173F703F;
        Tue, 17 Jul 2018 04:22:22 -0700 (PDT)
To:     <torvalds@linux-foundation.org>
References: <CA+55aFwuAojr7vAfiRO-2je-wDs7pu+avQZNhX_k9NN=D7_zVQ@mail.gmail.com>
Subject: Re: dvb usb issues since kernel 4.9
CC:     <corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <gregkh@linuxfoundation.org>, <griebichler.josef@gmx.at>,
        <hannes@redhat.com>, <jbrouer@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mchehab@s-opensource.com>,
        <mingo@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <peterz@infradead.org>, <riel@redhat.com>,
        <stern@rowland.harvard.edu>, <dmaengine@vger.kernel.org>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <nadavh@marvell.com>, <thomas.petazzoni@bootlin.com>,
        Omri Itach <omrii@marvell.com>
From:   Hanna Hawa <hannah@marvell.com>
Message-ID: <1d3d0fe3-bc02-7720-15ac-6bc06e00067c@marvell.com>
Date:   Tue, 17 Jul 2018 14:54:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFwuAojr7vAfiRO-2je-wDs7pu+avQZNhX_k9NN=D7_zVQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a software developer working in Marvell SoC team.
I'm facing kernel panic issue while running raid 5 on sata disks 
connected to Macchiatobin (Marvell community board with Armada-8040 SoC 
with 4 ARMv8 cores of CA72)
Raid 5 built with Marvell DMA engine and async_tx mechanism 
(ASYNC_TX_DMA [=y]); the DMA driver (mv_xor_v2) uses a tasklet to clean 
the done descriptors from the queue.

The panic (see below) occurs while building the RAID-5 (mdadm) or while 
writing/reading to the raid partition.

After some debug/bisect/diff, found that patch "softirq: Let ksoftirqd 
do its job" is problematic patch.

- Using v4.14.0 and problematic patch reverted - no timout issue.
- Using v4.14.0 (including softirq patch) and the additional fix 
proposed by Linus - no timeout issue.

As others have reported in this thread, the softirq change is causing 
some regression.
Would it be possible to either revert the patch or apply a fix such as 
the one proposed by Linus ?

Below panic message:
[   25.371495] mv_xor_v2 f0400000.xor: dma_sync_wait: timeout!
[   25.377101] Kernel panic - not syncing: async_tx_quiesce: DMA error 
waiting for transaction
[   25.377101]
[   25.386973] CPU: 0 PID: 1417 Comm: md0_raid5 Not tainted 4.14.0 #16
[   25.393264] Hardware name: Marvell Armada 8040 DB board (DT)
[   25.398946] Call trace:
[   25.401410] [<ffff000008089310>] dump_backtrace+0x0/0x380
[   25.406831] [<ffff0000080896a4>] show_stack+0x14/0x20
[   25.411904] [<ffff00000890fa78>] dump_stack+0x98/0xb8
[   25.416976] [<ffff0000080c8ef0>] panic+0x118/0x280
[   25.421788] [<ffff000008386a44>] async_tx_quiesce+0x74/0x78
[   25.427382] [<ffff000008386ca4>] async_memcpy+0x1a4/0x2a0
[   25.432806] [<ffff000008747f9c>] async_copy_data.isra.16+0x1b4/0x280
[   25.439186] [<ffff00000874b6fc>] raid_run_ops+0x514/0x1320
[   25.444694] [<ffff000008751550>] handle_stripe+0x1040/0x2848
[   25.450377] [<ffff000008752f98>] 
handle_active_stripes.isra.28+0x240/0x460
[   25.457279] [<ffff000008753468>] raid5d+0x2b0/0x450
[   25.462177] [<ffff00000875ead4>] md_thread+0x104/0x160
[   25.467338] [<ffff0000080e638c>] kthread+0xfc/0x128
[   25.472234] [<ffff000008085354>] ret_from_fork+0x10/0x1c
[   25.477571] Kernel Offset: disabled
[   25.481073] CPU features: 0x002000
[   25.484487] Memory Limit: none
[   25.487556] ---[ end Kernel panic - not syncing: async_tx_quiesce: 
DMA error waiting for transaction
[   25.487556]

Thanks,
Hanna
