Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89810C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52364216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52364216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbeKNChD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:37:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:36939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeKNChD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:37:03 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MIhDo-1gKOmP3TmC-002JUc; Tue, 13 Nov 2018 17:38:10 +0100
Message-ID: <1542127087.12945.14.camel@gmx.us>
Subject: WARNING: CPU: 31 PID: 15473 at lib/iov_iter.c:1109
 iov_iter_pipe+0xe0/0xe8
From:   Qian Cai <cai@gmx.us>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 13 Nov 2018 11:38:07 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BWeNQwBTpLjghCicMGrKaU3NQeD7Sn0OfeMqjSGZrSAvihUWO02
 kLdwltZX3s41mT6dliOITSzOMG/Mww2vlvoNH7HatxmO7qINuidZL80zvmHLGQkpRA48Hfy
 7Wr4Dxw5zoW3YGLZkXXGtIwZibbIfBVa8lyOJLcEXDvfRACAAenjl6M0eO9M7qxrPAbbBu9
 vl/HiuR8gwX1euQN2cP2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fhz91G+4t9s=:ENrHkCF+KAqp3y+6iGikeB
 IrRLki7vUS//yKteIB+marC1NpU605MePPxAR2CsHLo26o08N0hAIKi+tlK+pptjSocHG9zPa
 Oww3mCYFI8ZUxSuxuGEzu/kFxwdWFzJt1XNDkhmp4fjRNVegOf91Wcs4G3v4TjoCyNt8VBPNK
 u/U1SKd+plPox7RnrI6f2VZ9Xn9pO6iyINP3LQczw1SEOroHzb0un+Ih+ZofHPsFyLhcgAmBd
 trpe01RDaQ4FTkwIWH+oYMy9T1inecaSN345bELne6q+ByS/DWjSAlkVLPDbCkE89ojOizKXE
 qE32jxhVbRWPgEQ1SLhK3M9sfQ8yfG4r7YX8DwDjCWdwt7+QeR/YoOykmqnP+a57PVeaV9FLX
 BKZGwr9QyQdZDxh1Rh2kiKzkCd7oSM30OGMs5Ynv/mKkKcHnLzehXkkXSoo72UeLQPsLiDJOU
 ju/wNQ6lVDezFm3yZubUCMh2ul5pZvF0XdhhJ5i0HKrhGWrUdgM/W1NT/gfjHR5QAu+7joq5V
 RWZuAGVWlRZWDYfxRBkdWZmqtoxVIA4TTKgHo3iexhk9gkdYSckOSQDtup9JiTnrMLP3h4umn
 VBPY7R/XEoKFeqaWRTc0hUMEAwyTTplf3UT1kb8pqA56KukbB8ELdqHD1+MW4/ZR46/GAPwxU
 CSHtPWB4PH3WEZRfoLAue+wRXG7F8Y2NkraB+rC7aAajOhJoqj2IS8VspRhNC7OhPo6cWmsnO
 /v9sSx+KYLYL8wjFG+9wohmBCcAjAJb6oie7poH7yiY0VVx8bJhU9WBlJpbJ13/6ROU2arfan
 KENSFcwQb8aa/zz7yGQa3FyFQVU9YRQBMzZxtEwudBC1U+WuOqoDAzB8nT885GltLAus5zvlx
 B+909tolzdUoEiru9e556nNbCuGtSpoV0a5m9fv2rs0vAhC9IHw+fRQFYC/3Gc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the trinity fuzzer with a non-root user on an aarch64 server with the
latest mainline (rc2) generated this,

[  378.743211] WARNING: CPU: 31 PID: 15473 at lib/iov_iter.c:1109
iov_iter_pipe+0xe0/0xe8
[  378.751590] Modules linked in: bridge 8021q garp mrp stp llc dlci tcp_diag
inet_diag af_key pptp gre l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel
udp_tunnel pppoe pppox ppp_generic slhc crypto_user ib_core nfnetlink
scsi_transport_iscsi atm sctp vfat fat ghash_ce sha2_ce sha256_arm64 sha1_ce ses
enclosure ipmi_ssif sg ipmi_si ipmi_devintf sbsa_gwdt ipmi_msghandler
sch_fq_codel xfs libcrc32c marvell mpt3sas mlx5_core raid_class hibmc_drm
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ixgbe
hisi_sas_v2_hw igb hisi_sas_main libsas hns_dsaf mlxfw devlink hns_enet_drv mdio
i2c_designware_platform i2c_algo_bit i2c_designware_core ehci_platform
scsi_transport_sas hns_mdio hnae dm_mirror dm_region_hash dm_log dm_mod
[  378.816574] CPU: 31 PID: 15473 Comm: trinity-c168 Kdump: loaded Tainted:
G        W         4.20.0-rc2+ #16
[  378.826317] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50
06/01/2018
[  378.833542] pstate: 60000005 (nZCv daif -PAN -UAO)
[  378.838344] pc : iov_iter_pipe+0xe0/0xe8
[  378.842268] lr : iov_iter_pipe+0x40/0xe8
[  378.846191] sp : ffff801e101a78e0
[  378.849506] x29: ffff801e101a78e0 x28: ffff801e101a7c48 
[  378.854823] x27: 0000000000000004 x26: ffff801668e511c0 
[  378.860139] x25: 0000000000000003 x24: ffff801e0f989148 
[  378.865456] x23: ffff801e0f989150 x22: 0000000000000010 
[  378.870778] x21: 000000005ffffffd x20: ffff801e0f989080 
[  378.876098] x19: ffff801e101a79b0 x18: 0000000000000000 
[  378.881415] x17: 0000000000000001 x16: 0000000000000000 
[  378.886732] x15: 0000000000000000 x14: 0000000000000000 
[  378.892047] x13: 0000000000000000 x12: ffff1003c2034f38 
[  378.897363] x11: 1ffff003c2034f37 x10: ffff1003c2034f37 
[  378.902678] x9 : 0000000000000000 x8 : 00000000f1f1f1f1 
[  378.907994] x7 : dfff200000000000 x6 : 00000000f2f2f2f2 
[  378.913309] x5 : 00000000f2f2f200 x4 : dfff200000000000 
[  378.918625] x3 : 000000005ffffffd x2 : 0000000000000003 
[  378.923942] x1 : ffff801e0f989150 x0 : 0000000000000010 
[  378.929259] Call trace:
[  378.931712]  iov_iter_pipe+0xe0/0xe8
[  378.935294]  generic_file_splice_read+0xb0/0x308
[  378.939914]  do_splice_to+0xa4/0xd8
[  378.943406]  splice_direct_to_actor+0x164/0x3b8
[  378.947942]  do_splice_direct+0x148/0x1c8
[  378.951959]  do_sendfile+0x2e4/0x568
[  378.955539]  __arm64_sys_sendfile64+0x14c/0x268
[  378.960076]  el0_svc_handler+0xd4/0x198
[  378.963914]  el0_svc+0x8/0xc
[  378.966796] irq event stamp: 56628
[  378.970202] hardirqs last  enabled at (56627): [<ffff2000084cf7c4>]
quarantine_put+0xbc/0x170
[  378.978729] hardirqs last disabled at (56628): [<ffff200008081490>]
do_debug_exception+0xd8/0x190
[  378.987605] softirqs last  enabled at (56380): [<ffff200008082210>]
__do_softirq+0x7c8/0x9c8
[  378.996048] softirqs last disabled at (56373): [<ffff20000812dbe4>]
irq_exit+0x25c/0x2f0
[  379.004139] ---[ end trace 598902d30712b79d ]---
