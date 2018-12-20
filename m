Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E117CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C7721720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yGu+duan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbeLTJMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:12:15 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37151 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730095AbeLTJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:12:12 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E040E1366;
        Thu, 20 Dec 2018 04:12:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 20 Dec 2018 04:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Vbnnli
        Gp531jjPhzbCTTx9b2B6EF2CDqOv8StUEXlYM=; b=yGu+duanBdwXgA30UttJy7
        +igXQBkrEeHyUdNELY+qeyWnfrjyS3oRaNESBw9ydQtW//waQVMtD3RtyxiG0wGU
        m+lAmwb8ocRuDzZK5SLQbyPMhPUrxvU/sRQGGZpkZ5IUSXGyGrVJ4+/WqEIHrO4i
        7x+WI1wmXKsKv+0FRRFMXg/S95Ijm0Jkr+BILdSxOHF65NN4tK804ASiJpfGYlRB
        5srQnozlwB8CNZWnfS0F+gmLaU31pBXTfrcAdW80nwmoTdGK3manV3r5HgEPN8yz
        2kgt7F53gQe7WWqcdEyYCdZbzcC1hd0pRGeAqblOS3NB5hDgNrNM67uUqs5DxiwA
        ==
X-ME-Sender: <xms:6VwbXHNOGMRIwCQCj022AlYRU9GTUCAsP0kG7aHbirS9XQDgvMoHGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudejfedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehttdertddtredvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehi
    ughoshgthhesihguohhstghhrdhorhhgqeenucfkphepudelfedrgeejrdduieehrddvhe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:6VwbXLDOSoayJKUshrtGVQci6WVBkb_dhF-rWjJeieBArcduSwbqIA>
    <xmx:6VwbXJM3bYDj5ork8aw_RZnHXV4euYDF__AISz5NgxezfAXGrASWFw>
    <xmx:6VwbXIzLoOaeJ1-dofWur-PUAwcvepKu_t2ZeUbFsWfGWEx_oVTRfg>
    <xmx:6lwbXIsNTC3UyIbu4RI59NFfqjs04K_jUklJEei7ruTrALqZ2XQMZw>
Received: from localhost (unknown [193.47.165.251])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3FD0FE4625;
        Thu, 20 Dec 2018 04:12:09 -0500 (EST)
Date:   Thu, 20 Dec 2018 11:12:07 +0200
From:   Ido Schimmel <idosch@idosch.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>, willemb@google.com
Cc:     Michael S Tsirkin <mst@redhat.com>, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at
 net/core/flow_dissector.c:764 __skb_flow_dissect
Message-ID: <20181220091207.GA25942@splinter>
References: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Willem

On Thu, Dec 20, 2018 at 08:45:40AM +0100, Christian Borntraeger wrote:
> Folks,
> 
> I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
> Maybe someone has a quick idea.
> 
> [85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318

I managed to trigger this warning as well the other day, but from a
different call path:

[280155.348526] WARNING: CPU: 1 PID: 24819 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x314/0x16b0
[280155.348529] Modules linked in: dummy vrf intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul leds_mlxreg i2c_mux_reg i2c_mlxcpld crc32_pclmul mlxreg_hotplug mlxreg_io i2c_mux ghash_clmulni_intel iTCO_wdt gpio_ich iTCO_vendor_support mlx_platform aesni_intel aes_x86_64 crypto_simd cryptd glue_helper intel_cstate mac_hid lpc_ich ip_tables x_tables autofs4 mlxsw_spectrum mlxfw vxlan ip6_udp_tunnel udp_tunnel ip6_tunnel tunnel6 objagg psample parman bridge stp llc mlxsw_pci igb ahci mlxsw_core dca i2c_algo_bit libahci devlink i2c_ismt
[280155.348570] CPU: 1 PID: 24819 Comm: ip Not tainted 4.20.0-rc6-nn181213 #1
[280155.348572] Hardware name: Mellanox Technologies Ltd. MSN2100/SA001390, BIOS 5.6.5 06/07/2016
[280155.348576] RIP: 0010:__skb_flow_dissect+0x314/0x16b0
[280155.348579] Code: 85 19 0e 00 00 45 0f b7 6c 24 04 41 0f b7 44 24 06 4d 01 fd 48 85 db 4d 8d 14 07 74 0f 48 8b 43 18 48 85 c0 0f 85 e5 02 00 00 <0f> 0b 41 f6 04 24 40 0f 85 a4 02 00 00 c7 85 30 ff ff ff 00 00 00
[280155.348581] RSP: 0018:ffffa0df41fdf650 EFLAGS: 00010246
[280155.348584] RAX: 0000000000000000 RBX: ffff8bcded232000 RCX: 0000000000000000
[280155.348586] RDX: ffffa0df41fdf7e0 RSI: ffffffff98e415a0 RDI: ffff8bcded232000
[280155.348588] RBP: ffffa0df41fdf760 R08: 0000000000000000 R09: 0000000000000000
[280155.348590] R10: ffffa0df41fdf7e8 R11: ffff8bcdf27a3000 R12: ffffffff98e415a0
[280155.348591] R13: ffffa0df41fdf7e0 R14: ffffffff98dd2980 R15: ffffa0df41fdf7e0
[280155.348594] FS:  00007f46f6897680(0000) GS:ffff8bcdf7a80000(0000) knlGS:0000000000000000
[280155.348596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[280155.348598] CR2: 000055933e95f9a0 CR3: 000000021e636000 CR4: 00000000001006e0
[280155.348600] Call Trace:
[280155.348610]  fib_multipath_hash+0x28c/0x2d0
[280155.348613]  ? fib_multipath_hash+0x28c/0x2d0
[280155.348619]  fib_select_path+0x241/0x32f
[280155.348622]  ? __fib_lookup+0x6a/0xb0
[280155.348626]  ip_route_output_key_hash_rcu+0x650/0xa30
[280155.348631]  ? __alloc_skb+0x9b/0x1d0
[280155.348634]  inet_rtm_getroute+0x3f7/0xb80
[280155.348640]  ? __alloc_pages_nodemask+0x11c/0x2c0
[280155.348646]  rtnetlink_rcv_msg+0x1d9/0x2f0
[280155.348650]  ? rtnl_calcit.isra.24+0x120/0x120
[280155.348654]  netlink_rcv_skb+0x54/0x130
[280155.348657]  rtnetlink_rcv+0x15/0x20
[280155.348661]  netlink_unicast+0x20a/0x2c0
[280155.348664]  netlink_sendmsg+0x2d1/0x3d0
[280155.348669]  sock_sendmsg+0x39/0x50
[280155.348672]  ___sys_sendmsg+0x2a0/0x2f0
[280155.348677]  ? filemap_map_pages+0x16b/0x360
[280155.348682]  ? __handle_mm_fault+0x108e/0x13d0
[280155.348686]  __sys_sendmsg+0x63/0xa0
[280155.348688]  ? __sys_sendmsg+0x63/0xa0
[280155.348692]  __x64_sys_sendmsg+0x1f/0x30
[280155.348697]  do_syscall_64+0x5a/0x120
[280155.348701]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[280155.348704] RIP: 0033:0x7f46f5b80d04
[280155.348707] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 01 dc 2c 00 8b 00 85 c0 75 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 41 89 d4 53 48 89 f5
[280155.348709] RSP: 002b:00007fff82d62778 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[280155.348712] RAX: ffffffffffffffda RBX: 000000005c1900ae RCX: 00007f46f5b80d04
[280155.348713] RDX: 0000000000000000 RSI: 00007fff82d627e0 RDI: 0000000000000003
[280155.348715] RBP: 00007fff82d628d8 R08: 0000000000000001 R09: 0000000000000000
[280155.348717] R10: 00007f46f5bfccc0 R11: 0000000000000246 R12: 0000000000000001
[280155.348718] R13: 000055933eb90020 R14: 0000000000000000 R15: 00007fff82d63030
[280155.348722] ---[ end trace e14023d76a175374 ]---

Problem is the synthesized skb for output route resolution does not have
skb->dev or skb->sk set. When a multipath route is hit and
net.ipv4.fib_multipath_hash_policy is set the flow dissector is called
with this skb and the warning is triggered.

I plan to fix it by setting skb->dev to net->loopback_dev. I assume we
want to keep this warning to prevent call paths which will otherwise
silently fallback to standard flow dissector instead of the BPF one.

> [85109.572036] Modules linked in: vhost_net vhost macvtap macvlan tap vfio_ap vfio_mdev mdev vfio_iommu_type1 vfio kvm xt_CHECKSUM ipt_MASQUERADE tun bridge stp llc xt_tcpudp ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ip6table_filter ip6_tables iptable_filter dm_service_time rpcrdma sunrpc rdma_ucm rdma_cm configfs iw_cm ib_cm mlx4_ib ib_uverbs ib_core pkey ghash_s390 prng aes_s390 des_s390 des_generic sha512_s390 sha1_s390 zcrypt_cex4 zcrypt rng_core eadm_sch sch_fq_codel ip_tables x_tables mlx4_en mlx4_core sha256_s390 sha_common dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod autofs4
> [85109.572072] CPU: 30 PID: 197360 Comm: vhost-197330 Not tainted 4.20.0-20181213.rc6.git0.407d079170c1.300.fc29.s390x #1
> [85109.572074] Hardware name: IBM 2964 NC9 712 (LPAR)
> [85109.572075] Krnl PSW : 0704c00180000000 000000000092e320 (__skb_flow_dissect+0x1f0/0x1318)
> [85109.572078]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [85109.572080] Krnl GPRS: 000000000000002a 0000000000000000 000003e0385bfc84 0000000000d91e30
> [85109.572081]            000003e0385bfc84 0000000000000000 0000000000000000 0000000000d91e30
> [85109.572083]            000003e0385bfc84 000000000000000e 0000007e3eb88100 0000007ff3561e00
> [85109.572084]            0000000000000806 0000000000b4f288 000003e0385bfbb8 000003e0385bfab0
> [85109.572115] Krnl Code: 000000000092e312: e310b0180002	ltg	%r1,24(%r11)
>                           000000000092e318: a7740271		brc	7,92e7fa
>                          #000000000092e31c: a7f40001		brc	15,92e31e
>                          >000000000092e320: 91407003		tm	3(%r7),64
>                           000000000092e324: a7740257		brc	7,92e7d2
>                           000000000092e328: 5810f0b4		l	%r1,180(%r15)
>                           000000000092e32c: e54cf0c80000	mvhi	200(%r15),0
>                           000000000092e332: c01b00000008	nilf	%r1,8
> [85109.572129] Call Trace:
> [85109.572130] ([<0000000000000000>]           (null))
> [85109.572134]  [<000003ff800c81e4>] tap_sendmsg+0x384/0x430 [tap] 

I'm not familiar with tap code, so someone else will need to patch this
case, but it looks like:

tap_sendmsg()
    tap_get_user()
        skb_probe_transport_header()
	    skb_flow_dissect_flow_keys_basic()
	        __skb_flow_dissect()

skb->dev is only set later in the code.

> [85109.572137]  [<000003ff801acdee>] vhost_tx_batch.isra.10+0x66/0xe0 [vhost_net] 
> [85109.572138]  [<000003ff801ad61c>] handle_tx_copy+0x18c/0x568 [vhost_net] 
> [85109.572140]  [<000003ff801adab4>] handle_tx+0xbc/0x100 [vhost_net] 
> [85109.572145]  [<000003ff8019bbe8>] vhost_worker+0xc8/0x128 [vhost] 
> [85109.572148]  [<00000000001690b8>] kthread+0x140/0x160 
> [85109.572152]  [<0000000000a84266>] kernel_thread_starter+0x6/0x10 
> [85109.572154]  [<0000000000a84260>] kernel_thread_starter+0x0/0x10 
> [85109.572155] Last Breaking-Event-Address:
> [85109.572156]  [<000000000092e31c>] __skb_flow_dissect+0x1ec/0x1318
> [85109.572158] ---[ end trace 97c040a6691bc000 ]---
