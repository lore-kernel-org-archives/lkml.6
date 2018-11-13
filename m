Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72742C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB21216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB21216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbeKNClv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:41:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:33731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbeKNClv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:41:51 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0Lqyi7-1frNUR3RHX-00egXo; Tue, 13 Nov 2018 17:42:57 +0100
Message-ID: <1542127374.12945.16.camel@gmx.us>
Subject: kernel BUG at include/linux/mm.h:519!
From:   Qian Cai <cai@gmx.us>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org
Date:   Tue, 13 Nov 2018 11:42:54 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tGRlydk6XO3AI12hV02hnyAhht4dBhqTeV6qamZkqLhiOqDfkdP
 aFo7qDBGqjl6PgmI1p53IC4Zb511rKleRbtTsOkK4MPaZv+z7FmCesctpvpcehkWtvoIs5N
 TKSgK2yS/0Jcq7/qyFriLfcBaC1IcUbKIEtbHNj5dNdsuqPfAuh/W7Kpape3/yTk85exMzX
 Oxb/U6CLfr0TkxkMxsGqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oUHo6FBP2PA=:Xg3I5po9pr1cQhhK2QvXkp
 cbPPajaLjtJZuMOgEiFzrmHuEKLatTYixR31a4gG94wTA5sBpxRqkV9GLTTi8QmylNrxQDvtB
 D4UvXvepA4VY5ZAGPOAXG5tjHVg+FVaNoc3Q1Xooi6WtY3ieGIgfIUyj32EkuCD+cFJA/Kzoj
 lgF8JiGv6TZQvKVfvShRF3HqtGdPzxfh+6Q1bfRXSnvjSeFqnEsJS8mJYZLVpLkiMfkICdTZm
 Q99qE5AbzIIQwBiB/M2+W1DJ2J1W8AAncPIgD4AHEq5iKoVrMmOz1mXY1Cw2/9YV4sRBcpb88
 MByjV7Td7LtIyxw607tLC6s+jx3cxgUyOq5Y+++Sj8inFCmH9OOsp1hpbhcHWDbp3CYWPDUjN
 ifIUdky3s+FcAQ0e6TVh1R4xEAvMbwmP7feonn/esxmaPu9XXkvlNGlRmdtgtwPFgt0S6HXEx
 igxfxXtIMIzsZdaVJXcpSBREeWhDe2++hrZPGGLNS+hwvaegkTc+Wt6YIlzmstnOIU1vrME2Y
 m1TXZiAJS2KfAvS4flkbxUMoq4AFfVgryPXC4Gk2Psh11qAz4GF3xYERgEp5UEBLa2Bx1hwun
 LvDhLQhh71HLQjkEYVlayX0DqEiJUShb3H50ocgzpALkwQP6UkP/DdVCCRn3agnCLt1NApLEr
 kjCY8i2HOCQwoQshAK/ZeuDM67d9pVHF0xCqcohbNArO0J/1H/B2db6W805W5QOi0qvgx4ixq
 kbzV3xrJmxL6sdR/u4jUXR9Jp5qSTd2myFdAQdvp5BSorm1b9RnR7TN2iiYCr77+Gi3RkRbfz
 ghbwjMBlTEk1V5cWsRbunJuoaf07hWLwCq8iyfRKF42WtPfdVEypg4uJfs4BOYOpPz5pMHZJX
 HeY7euklV+vkpzjVbw69cnUjzpU977VJM1EPk1U7x8vqbnIv950au0J8JXIau+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the trinity fuzzer with a non-root user on an aarch64 server with the
latest mainline (rc2) triggered this,

[ 2058.662628] page:ffff7fe022fe7d80 count:0 mapcount:0 mapping:ffff808ea6153160
index:0x5a
[ 2058.670842] flags: 0x9fffff0000000004(uptodate)
[ 2058.675448] raw: 9fffff0000000004 dead000000000100 dead000000000200
0000000000000000
[ 2058.683254] raw: 000000000000005a 0000000000000000 00000001ffffffff
ffff801ec3d67680
[ 2058.691004] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
[ 2058.697954] page->mem_cgroup:ffff801ec3d67680
[ 2058.702355] ------------[ cut here ]------------
[ 2058.706974] kernel BUG at include/linux/mm.h:519!
[ 2058.711964] Internal error: Oops - BUG: 0 [#1] SMP
[ 2058.711966] irq event stamp: 223221
[ 2058.711972] irq event stamp: 466900
[ 2058.711976] irq event stamp: 124299
[ 2058.711990] hardirqs last  enabled at (223221): [<ffff2000080839fc>]
el1_irq+0xbc/0x140
[ 2058.712014] hardirqs last  enabled at (466899): [<ffff200008280500>]
tick_nohz_idle_exit+0x80/0xf0
[ 2058.712022] hardirqs last  enabled at (124299): [<ffff2000080839fc>]
el1_irq+0xbc/0x140
[ 2058.712031] hardirqs last disabled at (466900): [<ffff200008f9e0e4>]
__schedule+0x1d4/0xda0
[ 2058.712036] hardirqs last disabled at (124298): [<ffff2000080839b4>]
el1_irq+0x74/0x140
[ 2058.712046] softirqs last  enabled at (466894): [<ffff20000812cf5c>]
_local_bh_enable+0xb4/0xf0
[ 2058.712051] softirqs last  enabled at (124290): [<ffff200008082210>]
__do_softirq+0x7c8/0x9c8
[ 2058.712057] softirqs last disabled at (466893): [<ffff20000812d968>]
irq_enter+0x128/0x148
[ 2058.712065] softirqs last disabled at (124283): [<ffff20000812dbe4>]
irq_exit+0x25c/0x2f0
[ 2058.716762] Modules linked in: 8021q garp mrp af_key dlci bridge stp llc pptp
gre l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppoe pppox
ppp_generic slhc crypto_user ib_core nfnetlink scsi_transport_iscsi atm sctp
vfat fat ghash_ce sha2_ce sha256_arm64 sha1_ce ses enclosure ipmi_ssif sg
ipmi_si ipmi_devintf sbsa_gwdt ipmi_msghandler sch_fq_codel xfs libcrc32c
marvell mpt3sas raid_class mlx5_core hibmc_drm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops ttm drm ixgbe hisi_sas_v2_hw igb hisi_sas_main
libsas hns_dsaf mlxfw hns_enet_drv devlink i2c_designware_platform mdio
i2c_algo_bit ehci_platform scsi_transport_sas i2c_designware_core hns_mdio hnae
dm_mirror dm_region_hash dm_log dm_mod
[ 2058.720243] hardirqs last disabled at (223220): [<ffff2000080839b4>]
el1_irq+0x74/0x140
[ 2058.723721] CPU: 9 PID: 14438 Comm: trinity-c248 Kdump: loaded Tainted:
G        W         4.20.0-rc2+ #16
[ 2058.727197] softirqs last  enabled at (223218): [<ffff200008082210>]
__do_softirq+0x7c8/0x9c8
[ 2058.727205] softirqs last disabled at (223209): [<ffff20000812dbe4>]
irq_exit+0x25c/0x2f0
[ 2058.735193] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50
06/01/2018
[ 2058.906697] pstate: 20000005 (nzCv daif -PAN -UAO)
[ 2058.911487] pc : release_pages+0xa40/0xfa0
[ 2058.915578] lr : release_pages+0xa40/0xfa0
[ 2058.919667] sp : ffff801e7020e610
[ 2058.922975] x29: ffff801e7020e610 x28: 1ffff003ce041ce6 
[ 2058.928283] x27: ffff1003ce041cf6 x26: 0000000000000000 
[ 2058.933591] x25: ffff801e7020f328 x24: ffff801e7020e770 
[ 2058.938898] x23: ffff20000a103630 x22: 00000000fffffff8 
[ 2058.944206] x21: ffff80163deb0278 x20: dfff200000000000 
[ 2058.949513] x19: ffff7fe022fe7d80 x18: 0000000000000000 
[ 2058.954821] x17: 0000000000000000 x16: 0000000000000000 
[ 2058.960127] x15: 0000000000000000 x14: 6531303866666666 
[ 2058.965434] x13: 2066666666666666 x12: ffff04000172b58e 
[ 2058.970741] x11: 00000000f2f2f2f2 x10: dfff200000000000 
[ 2058.976049] x9 : ffff20000a0f9848 x8 : ffff808d0319da88 
[ 2058.981356] x7 : 00000000f2f2f204 x6 : 0000000041b58ab3 
[ 2058.986663] x5 : ffff1003ce041b5c x4 : dfff200000000000 
[ 2058.991970] x3 : dfff200000000000 x2 : 65a2459128144800 
[ 2058.997278] x1 : 65a2459128144800 x0 : 0000000000000000 
[ 2059.002588] Process trinity-c248 (pid: 14438, stack limit =
0x0000000037b8b477)
[ 2059.009889] Call trace:
[ 2059.012331]  release_pages+0xa40/0xfa0
[ 2059.016077]  free_pages_and_swap_cache+0x258/0x320
[ 2059.020862]  tlb_flush_mmu_free+0x5c/0xa0
[ 2059.024866]  tlb_flush_mmu+0x280/0x418
[ 2059.028610]  arch_tlb_finish_mmu+0xbc/0x138
[ 2059.032787]  tlb_finish_mmu+0xd4/0x120
[ 2059.036531]  exit_mmap+0x1c4/0x260
[ 2059.039928]  mmput+0x154/0x310
[ 2059.042977]  do_exit+0x7ec/0xd70
[ 2059.046200]  do_group_exit+0xc4/0x180
[ 2059.049857]  get_signal+0x544/0xce0
[ 2059.053341]  do_signal+0x104/0x358
[ 2059.056738]  do_notify_resume+0x19c/0x200
[ 2059.060741]  work_pending+0x8/0x14
[ 2059.064140] Code: 91000021 aa1303e0 911f8021 94015f13 (d4210000) 
[ 2059.070371] SMP: stopping secondary CPUs
[ 2059.078701] Starting crashdump kernel...
[ 2059.082625] Bye!
