Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E13ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72F120936
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72F120936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeGPJTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:19:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729595AbeGPJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:19:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G8moZu032704
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:53:18 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8jaam7rn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:53:17 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <abdhalee@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 02:53:17 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 02:53:14 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G8rD1K7733504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 01:53:13 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE58C6E052;
        Mon, 16 Jul 2018 02:53:13 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24B256E04C;
        Mon, 16 Jul 2018 02:53:11 -0600 (MDT)
Received: from [9.109.249.91] (unknown [9.109.249.91])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 02:53:10 -0600 (MDT)
Subject: [4.18.0-rc4][bisected a063057d][mpt3sas] WARNING: CPU: 87 PID:
 18868 at block/blk-core.c:781 blk_cleanup_queue+0x20c/0x220
From:   Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     "bart.vanassche" <bart.vanassche@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>,
        mpe <mpe@ellerman.id.au>, dougmill@linux.vnet.ibm.com,
        MPT-FusionLinux.pdl@broadcom.com,
        sachinp <sachinp@linux.vnet.ibm.com>
Date:   Mon, 16 Jul 2018 14:23:09 +0530
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071608-8235-0000-0000-00000DD31558
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009372; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01061579; UDB=6.00545010; IPR=6.00839489;
 MB=3.00022157; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-16 08:53:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071608-8236-0000-0000-000041E612E5
Message-Id: <1531731189.15016.15.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=412 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting's

mpt3sas module unload triggered a warning at block/blk-core.c:781 on a
powerpc bare-metal running mainline kernel

WARN_ON_ONCE() was introduced with commit a063057 : block: Fix a race
between request queue removal and the block cgroup controller

Machine: Power8 Bare-metal
kernel : 4.18.0-rc4
test: module load/unload mpt3sas in a loop

trace logs:
-----------
sd 16:0:4:0: [sde] Attached SCSI disk
mpt3sas version 25.100.00.00 unloading
mpt3sas_cm0: IR shutdown (sending)
mpt3sas_cm0: IR shutdown (complete): ioc_status(0x0000), loginfo(0x00000000)
sd 16:1:0:0: RAID REMOVE
sd 16:1:0:0: RAID REMOVE DONE
mpt3sas_cm0: removing handle(0x0143), wwid(0x05b15ecf7afeb371)
mpt3sas_cm0: removing handle(0x000a), sas_addr(0x500304801f080d00)
mpt3sas_cm0: enclosure logical id(0x500304801f080d3f), slot(0)
mpt3sas_cm0: enclosure level(0x0000), connector name(     )
mpt3sas_cm0: removing handle(0x000b), sas_addr(0x500304801f080d01)
mpt3sas_cm0: enclosure logical id(0x500304801f080d3f), slot(1)
mpt3sas_cm0: enclosure level(0x0000), connector name(     )
mpt3sas_cm0: removing handle(0x000c), sas_addr(0x500304801f080d02)
mpt3sas_cm0: enclosure logical id(0x500304801f080d3f), slot(2)
mpt3sas_cm0: enclosure level(0x0000), connector name(     )
WARNING: CPU: 87 PID: 18868 at block/blk-core.c:781 blk_cleanup_queue+0x20c/0x220
Modules linked in: mpt3sas(-) ixgbe i40e ipt_MASQUERADE tun bridge stp
llc xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntrack nfnetlink
iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat
nf_conntrack iptable_mangle iptable_filter btrfs xor zstd_decompress
zstd_compress xxhash lzo_compress vmx_crypto raid6_pq powernv_rng
rng_core kvm_hv kvm nfsd ip_tables x_tables autofs4 xfs libcrc32c
qla2xxx nvme_fc nvme_fabrics raid_class mdio nvme_core
scsi_transport_sas [last unloaded: mpt3sas]
CPU: 87 PID: 18868 Comm: rmmod Not tainted 4.18.0-rc4-autotest-autotest #1
NIP:  c0000000004fff0c LR: c0000000004ffe10 CTR: 0000000000000000
REGS: c0000078cdcc3480 TRAP: 0700   Not tainted  (4.18.0-rc4-autotest-autotest)
MSR:  900000010282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 42008882  XER: 20000000
CFAR: c0000000004ffe18 IRQMASK: 0
GPR00: c0000000004ffe10 c0000078cdcc3700 c00000000109aa00 0000000000000000
GPR04: 000000007fffffff c0000078cdcc3690 0000000000000000 0000000000000000
GPR08: 0000000000000001 0000000300000004 0000000000000001 c000007fff76b484
GPR12: 0000000000008800 c000007fff76b480 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 000001002ee601e0 0000000010020098
GPR20: 0000000010020050 0000000010020038 0000000000000000 c000003b6ed86178
GPR24: c000003fd15b4000 0000000000000004 0000000000000003 c000003fd15b4000
GPR28: 0000000000000000 c000003fa4eef658 c000003fa4eef150 c000003fa4eeefa0
NIP [c0000000004fff0c] blk_cleanup_queue+0x20c/0x220
LR [c0000000004ffe10] blk_cleanup_queue+0x110/0x220
Call Trace:
[c0000078cdcc3700] [c0000000004ffe10] blk_cleanup_queue+0x110/0x220 (unreliable)
[c0000078cdcc3740] [c000000000684070] __scsi_remove_device+0x110/0x1d0
[c0000078cdcc3780] [c00000000068416c] scsi_remove_device+0x3c/0x60
[c0000078cdcc37b0] [c000000000684410] scsi_remove_target+0x220/0x280
[c0000078cdcc3820] [d00000000fd82554] sas_rphy_remove+0x94/0xa0 [scsi_transport_sas]
[c0000078cdcc3850] [d00000000fd8451c] sas_port_delete+0x4c/0x238 [scsi_transport_sas]
[c0000078cdcc38b0] [d00000001a533e30] mpt3sas_transport_port_remove+0x2d0/0x310 [mpt3sas]
[c0000078cdcc3950] [d00000001a522a10] _scsih_remove_device+0x100/0x2a0 [mpt3sas]
[c0000078cdcc3a10] [d00000001a527824] mpt3sas_device_remove_by_sas_address.part.44+0xb4/0x160 [mpt3sas]
[c0000078cdcc3a70] [d00000001a527964] _scsih_expander_node_remove+0x94/0x170 [mpt3sas]
[c0000078cdcc3af0] [d00000001a52a2f8] _scsih_flush_running_cmds+0x5f8/0x1040 [mpt3sas]
[c0000078cdcc3b90] [c00000000057c0c4] pci_device_remove+0x64/0x110
[c0000078cdcc3bd0] [c000000000624294] device_release_driver_internal+0x204/0x2e0
[c0000078cdcc3c20] [c00000000062440c] driver_detach+0x7c/0x100
[c0000078cdcc3c60] [c000000000622c18] bus_remove_driver+0x78/0x100
[c0000078cdcc3c90] [c0000000006250a0] driver_unregister+0x40/0x90
[c0000078cdcc3d00] [c00000000057a478] pci_unregister_driver+0x38/0x100
[c0000078cdcc3d50] [d00000001a53bc34] cleanup_module+0x50/0x391c [mpt3sas]
[c0000078cdcc3db0] [c0000000001aa61c] sys_delete_module+0x1bc/0x270
[c0000078cdcc3e30] [c00000000000b9e4] system_call+0x5c/0x70
Instruction dump:
ebc1fff0 ebe1fff8 7c0803a6 4e800020 7c0004ac 39400000 994d098c 4bfffe7c
7c0004ac 39400000 994d098c 4bffffa0 <0fe00000> 4bffff0c 7c0004ac 9b8d098c
---[ end trace 0e9e02a66337b6a8 ]---
mpt3sas_cm0: removing handle(0x000d), sas_addr(0x500304801f080d03)
mpt3sas_cm0: enclosure logical id(0x500304801f080d3f), slot(3)
mpt3sas_cm0: enclosure level(0x0000), connector name(     )
sd 16:0:4:0: [sde] Synchronizing SCSI cache
-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



