Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EC1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A762B22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A762B22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbeKNM70 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:59:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:58425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbeKNM70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:59:26 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MhMg2-1g967H0bVy-00Maqt; Wed, 14
 Nov 2018 03:58:09 +0100
From:   Qian Cai <cai@gmx.us>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Unable to handle kernel paging request for data at address
 0xc000000001da0000
Message-Id: <B26EE8AA-96E9-4E15-B0BF-751F455C883E@gmx.us>
Date:   Tue, 13 Nov 2018 21:58:06 -0500
Cc:     catalin Marinas <catalin.marinas@arm.com>,
        linuxppc-dev@lists.ozlabs.org
To:     linux kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:Dw3ZBUp5ClTy6bqRi/fJQB9Ozue3oFEZpOBq7Khhhq7yzLp+6ZY
 TOM7y09d9tWTGXH3U1sfyg6DqoybZ35f7kfzxpOiPMyl06seF8bGyq20cT+duNOItmR+8Kh
 ZMKKvv/eMW34UYhKji5GsWeZC8LcwazBSsnveRQKYs/rka/dihW3/JVKRN+lsrL2El2q2vp
 IS6gTOg7mYmlFJ+RN91aQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WpzcpwaBvnc=:gmZ/w5+vJxLb1OieRVWF6D
 /iUr54yvlFSeGCxuh4vp1avB6V3NjaEJtToGaUbrEz3Okcq7qaeJTneuQixI/igfz/oNrBcg0
 wL8+S78u+qtt9OXPeRs+oHKXR9aa+ZcPOccstOEQYgN88wne4wCJlZaSzOaJw3SMXKK+FQFhs
 1AOGrNxyYBNYFIDqLXzsF9AyUBKFlI4kYw/WUVqGDnN8WK8r+/ErNNbk/uDVE7+fxUXRziH2H
 aRjYJR2K27NEkC5R6s6h0avAC3qoY07WfhgZWdZA9LmK2Cf9/WCW/TWO1tZiFPBcewq26AfNs
 WA/WesXN81w+dNjEUNyVP4NGe536d97+yO06Pb2Fu3jt26W+JWVBL/du8d8SLbcGxd+gs+d30
 +FUIe450ihOZJyk58U6mczbH2loWXV2JcaRDKVYxGKulovWU2/ZQ5vCbyY8t8b+HMkdOIiMau
 tlTH8lMd6/C+mha1liauTiSL1YgniwO9U7aR5bsr2wIlMVI8BTfhJXZafFmxT4mb1xmVt6GTn
 OTzJmDBfPMpOYrRCL8m29R+hdO/WbU6qIVgh39q6TtJnC923CVLU6UwMZY+7ouDn5uBWvKgZ6
 pJPfJG3BvkbCli6sQy4oJAoILF0m+T9Kc1mVkqNI9nlds38f1cDoA2D9X8PtdSX57u8oOSJ5R
 ztvzdnf9YI4DlfK3cvP98R03CRQT+jRS6dbXq3u7MAiMte7C/mP5Vuykd9Dxm9YeQ735zaa7z
 EgaTdvu4UWMvFjcsPvehBcARtxKhzCti9sAiEIAsMul/RjbXap4Rzc+qmwHbP8AR0qhxHYib+
 23XZLnjeABZclsuulX9gzO5KiN60F3JRXLydVS3Q5ca2hSNDswbLDuliEFS3BhS/fqDCaaKCS
 sITrpCR/hZi/B6f33RuQU+A/HG2A5CwYe2VrzZTluy41VbFMImZbfE62r1Qz7M
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running some container workloads on an IBM power9 server with the latest mainline (rc2) triggered this,

[ 1283.894167] Unable to handle kernel paging request for data at address 0xc000000001da0000
[ 1283.894215] Faulting instruction address: 0xc000000000487ab8
[ 1283.894223] Oops: Kernel access of bad area, sig: 11 [#1]
[ 1283.894227] LE SMP NR_CPUS=2048 DEBUG_PAGEALLOC NUMA pSeries
[ 1283.894235] Modules linked in: nf_conntrack_netlink xt_mark tun udp_diag tcp_diag inet_diag netlink_diag af_packet_diag unix_diag nft_chain_nat_ipv6 nf_nat_ipv6 xt_conntrack ipt_MASQUERADE nft_counter xt_comment nft_compat nft_chain_nat_ipv4 nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables veth bridge stp llc nfnetlink overlay sg pseries_rng xfs libcrc32c sd_mod ibmvscsi ibmveth scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
[ 1283.894275] CPU: 0 PID: 226 Comm: kmemleak Kdump: loaded Not tainted 4.20.0-rc2+ #1
[ 1283.894281] NIP:  c000000000487ab8 LR: c000000000487ab0 CTR: 0000000000000000
[ 1283.894287] REGS: c0000005e94f3970 TRAP: 0300   Not tainted  (4.20.0-rc2+)
[ 1283.894291] MSR:  800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 24000822  XER: 00000000
[ 1283.894302] CFAR: c000000000487a04 DAR: c000000001da0000 DSISR: 40000000 IRQMASK: 1 
GPR00: c000000000487ab0 c0000005e94f3bf8 c000000001c93400 0000000000000000 
GPR04: c0000005d9380a90 0000000000000001 00000000e7d83172 c0000005d9380a90 
GPR08: 0000000078811199 c0000005f1665ac8 c0000005d9380080 fffffffffce6b398 
GPR12: 0000000000000000 c000000002de0000 c0000000001717b8 c0000005efa49ab8 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000001b85220 
GPR24: c00000046a1d8848 c00000046a1d1b88 0000000000000000 0000000000000000 
GPR28: c000000001da0ff9 c000000000f3b620 c000000001b85108 c000000001da0000 
[ 1283.894352] NIP [c000000000487ab8] scan_block+0xa8/0x190
[ 1283.894357] LR [c000000000487ab0] scan_block+0xa0/0x190
[ 1283.894361] Call Trace:
[ 1283.894365] [c0000005e94f3bf8] [c000000000487ab0] scan_block+0xa0/0x190 (unreliable)
[ 1283.894372] [c0000005e94f3c58] [c000000000487c00] scan_large_block+0x60/0xa0
[ 1283.894378] [c0000005e94f3c98] [c00000000048857c] kmemleak_scan+0x24c/0xa10
[ 1283.894384] [c0000005e94f3d48] [c000000000489960] kmemleak_scan_thread+0xec/0x12c
[ 1283.894391] [c0000005e94f3db8] [c00000000017196c] kthread+0x1bc/0x1d0
[ 1283.894397] [c0000005e94f3e28] [c00000000000b860] ret_from_kernel_thread+0x5c/0x7c
[ 1283.894402] Instruction dump:
[ 1283.894408] 7fa3eb78 4883847d 60000000 60000000 60000000 60000000 3bff0008 7fbcf840 
[ 1283.894416] 409d00b8 4bfffeed 2fa30000 409e00ac <e87f0000> e93e0108 7fa91840 419dffdc 
[ 1283.894425] ---[ end trace 8e9576ac10ae13a1 ]---
[ 1283.897274] 
[ 1283.897288] Sending IPI to other CPUs
[ 1285.021354] IPI complete
[ 1285.042568] kexec: Starting switchover sequence.
