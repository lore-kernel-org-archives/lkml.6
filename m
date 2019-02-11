Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE642C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF1F218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z/k3IgKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfBKQkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:40:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43732 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfBKQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:40:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1BGdNLB153613;
        Mon, 11 Feb 2019 16:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xVlSpdxAiEOWrF9rZBB9nJ/vhVQixF3fC9iq1fvxlCM=;
 b=z/k3IgKpx4JA7hv7Ehnzq2Lwmtp66mnZk2x8QOlB5+NmB9QF/idZEkUv8q9L7PeSOOSl
 RRTM1GlxK3/MSX3/Y0TDbxcYkTVhGhj6ejMuJ0+Y4qqHTjQdKfMRQaigd7vKBcRju126
 QdZPS1SCKBZiqKd162nFrrgYeqZ9sK1Bp4TLhlulwer/ElMqKHhUFBzeugjGtkX13sRE
 7CcilMYjcrG+nh6hc5HvaSyzreqOackE5F7A/rQOoSmUX0IvZ4esZM3gdZWvN0PjYGJG
 3vQAdwRPdVpi9wAEE2Wg9J5lvIM693DuAyMk+lAqVnZPzGGN18vvr9phQ90PjrY5+xqk 5Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qhrek6vbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 16:40:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1BGe21D023750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 16:40:02 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1BGe1bk001374;
        Mon, 11 Feb 2019 16:40:01 GMT
Received: from dhcp-10-175-202-251.vpn.oracle.com (/10.175.202.251)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Feb 2019 08:40:00 -0800
Date:   Mon, 11 Feb 2019 16:39:50 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-202-251.vpn.oracle.com
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
cc:     Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Song Liu <songliubraving@fb.com>,
        Rafael Tinoco <rafael.tinoco@linaro.org>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: bpf: test_tunnel.sh: BUG: unable to handle kernel NULL pointer
 dereference
In-Reply-To: <CA+G9fYu-RXRUPyTeAfSQjXXbtGQeTkbhns9-L5ZVhm12G3xhmQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1902111627170.7885@dhcp-10-175-202-251.vpn.oracle.com>
References: <CA+G9fYu-RXRUPyTeAfSQjXXbtGQeTkbhns9-L5ZVhm12G3xhmQ@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019, Naresh Kamboju wrote:

> Kernel panic while running bpf: test_tunnel.sh on linux -next
> 5.0.0-rc4-next-20190129.
> 
> selftests: bpf: test_tunnel.sh
> [  273.997647] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> [  274.054068] ip (11458) used greatest stack depth: 11448 bytes left
> [  274.120445] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000000
> [  274.128285] #PF error: [INSTR]
> [  274.131351] PGD 8000000414a0e067 P4D 8000000414a0e067 PUD 3b6334067 PMD 0
> [  274.138241] Oops: 0010 [#1] SMP PTI
> [  274.141734] CPU: 1 PID: 11464 Comm: ping Not tainted
> 5.0.0-rc4-next-20190129 #1
> [  274.149046] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [  274.156526] RIP: 0010:          (null)
> [  274.160280] Code: Bad RIP value.
> [  274.163509] RSP: 0018:ffffbc9681f83540 EFLAGS: 00010286
> [  274.168726] RAX: 0000000000000000 RBX: ffffdc967fa80a18 RCX: 0000000000000000
> [  274.175851] RDX: ffff9db2ee08b540 RSI: 000000000000000e RDI: ffffdc967fa809a0
> [  274.182974] RBP: ffffbc9681f83580 R08: ffff9db2c4d62690 R09: 000000000000000c
> [  274.190098] R10: 0000000000000000 R11: ffff9db2ee08b540 R12: ffff9db31ce7c000
> [  274.197222] R13: 0000000000000001 R14: 000000000000000c R15: ffff9db3179cf400
> [  274.204346] FS:  00007ff4ae7c5740(0000) GS:ffff9db31fa80000(0000)
> knlGS:0000000000000000
> [  274.212424] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  274.218162] CR2: ffffffffffffffd6 CR3: 00000004574da004 CR4: 00000000003606e0
> [  274.225292] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  274.232416] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  274.239541] Call Trace:
> [  274.241988]  ? tnl_update_pmtu+0x296/0x3b0
> [  274.246085]  ip_md_tunnel_xmit+0x1bc/0x520
> [  274.250176]  gre_fb_xmit+0x330/0x390
> [  274.253754]  gre_tap_xmit+0x128/0x180
> [  274.257414]  dev_hard_start_xmit+0xb7/0x300
> [  274.261598]  sch_direct_xmit+0xf6/0x290
> [  274.265430]  __qdisc_run+0x15d/0x5e0
> [  274.269007]  __dev_queue_xmit+0x2c5/0xc00
> [  274.273011]  ? dev_queue_xmit+0x10/0x20
> [  274.276842]  ? eth_header+0x2b/0xc0
> [  274.280326]  dev_queue_xmit+0x10/0x20
> [  274.283984]  ? dev_queue_xmit+0x10/0x20
> [  274.287813]  arp_xmit+0x1a/0xf0
> [  274.290952]  arp_send_dst.part.19+0x46/0x60
> [  274.295138]  arp_solicit+0x177/0x6b0
> [  274.298708]  ? mod_timer+0x18e/0x440
> [  274.302281]  neigh_probe+0x57/0x70
> [  274.305684]  __neigh_event_send+0x197/0x2d0
> [  274.309862]  neigh_resolve_output+0x18c/0x210
> [  274.314212]  ip_finish_output2+0x257/0x690
> [  274.318304]  ip_finish_output+0x219/0x340
> [  274.322314]  ? ip_finish_output+0x219/0x340
> [  274.326493]  ip_output+0x76/0x240
> [  274.329805]  ? ip_fragment.constprop.53+0x80/0x80
> [  274.334510]  ip_local_out+0x3f/0x70
> [  274.337992]  ip_send_skb+0x19/0x40
> [  274.341391]  ip_push_pending_frames+0x33/0x40
> [  274.345740]  raw_sendmsg+0xc15/0x11d0
> [  274.349403]  ? __might_fault+0x85/0x90
> [  274.353151]  ? _copy_from_user+0x6b/0xa0
> [  274.357070]  ? rw_copy_check_uvector+0x54/0x130
> [  274.361604]  inet_sendmsg+0x42/0x1c0
> [  274.365179]  ? inet_sendmsg+0x42/0x1c0
> [  274.368937]  sock_sendmsg+0x3e/0x50
> [  274.372460]  ___sys_sendmsg+0x26f/0x2d0
> [  274.376293]  ? lock_acquire+0x95/0x190
> [  274.380043]  ? __handle_mm_fault+0x7ce/0xb70
> [  274.384307]  ? lock_acquire+0x95/0x190
> [  274.388053]  ? __audit_syscall_entry+0xdd/0x130
> [  274.392586]  ? ktime_get_coarse_real_ts64+0x64/0xc0
> [  274.397461]  ? __audit_syscall_entry+0xdd/0x130
> [  274.401989]  ? trace_hardirqs_on+0x4c/0x100
> [  274.406173]  __sys_sendmsg+0x63/0xa0
> [  274.409744]  ? __sys_sendmsg+0x63/0xa0
> [  274.413488]  __x64_sys_sendmsg+0x1f/0x30
> [  274.417405]  do_syscall_64+0x55/0x190
> [  274.421064]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  274.426113] RIP: 0033:0x7ff4ae0e6e87
> [  274.429686] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 80 00
> 00 00 00 8b 05 ca d9 2b 00 48 63 d2 48 63 ff 85 c0 75 10 b8 2e 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 53 48 89 f3 48 83 ec 10 48 89 7c
> 24 08
> [  274.448422] RSP: 002b:00007ffcd9b76db8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002e
> [  274.455978] RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 00007ff4ae0e6e87
> [  274.463104] RDX: 0000000000000000 RSI: 00000000006092e0 RDI: 0000000000000003
> [  274.470228] RBP: 0000000000000000 R08: 00007ffcd9bc40a0 R09: 00007ffcd9bc4080
> [  274.477349] R10: 000000000000060a R11: 0000000000000246 R12: 0000000000000003
> [  274.484475] R13: 0000000000000016 R14: 00007ffcd9b77fa0 R15: 00007ffcd9b78da4
> [  274.491602] Modules linked in: cls_bpf sch_ingress iptable_filter
> ip_tables algif_hash af_alg x86_pkg_temp_thermal fuse [last unloaded:
> test_bpf]
> [  274.504634] CR2: 0000000000000000
> [  274.507976] ---[ end trace 196d18386545eae1 ]---
> [  274.512588] RIP: 0010:          (null)
> [  274.516334] Code: Bad RIP value.
> [  274.519557] RSP: 0018:ffffbc9681f83540 EFLAGS: 00010286
> [  274.524775] RAX: 0000000000000000 RBX: ffffdc967fa80a18 RCX: 0000000000000000
> [  274.531921] RDX: ffff9db2ee08b540 RSI: 000000000000000e RDI: ffffdc967fa809a0
> [  274.539082] RBP: ffffbc9681f83580 R08: ffff9db2c4d62690 R09: 000000000000000c
> [  274.546205] R10: 0000000000000000 R11: ffff9db2ee08b540 R12: ffff9db31ce7c000
> [  274.553329] R13: 0000000000000001 R14: 000000000000000c R15: ffff9db3179cf400
> [  274.560456] FS:  00007ff4ae7c5740(0000) GS:ffff9db31fa80000(0000)
> knlGS:0000000000000000
> [  274.568541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  274.574277] CR2: ffffffffffffffd6 CR3: 00000004574da004 CR4: 00000000003606e0
> [  274.581403] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  274.588535] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  274.595658] Kernel panic - not syncing: Fatal exception in interrupt
> [  274.602046] Kernel Offset: 0x14400000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  274.612827] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
> [  274.620387] ------------[ cut here ]------------
> 
> The above log is from x86_64 device.
> 

 
I'm also seeing the same panic during test_tunnel.sh execution
on x86_64.

From poking around it looks like the skb's dst entry is being used
to calculate the mtu in:

mtu = skb_dst(skb) ? dst_mtu(skb_dst(skb)) : dev->mtu;

...but because that dst_entry  has an "ops" value set to md_dst_ops,
the various ops (including mtu) are not set:

crash> struct sk_buff._skb_refdst ffff928f87447700 -x
      _skb_refdst = 0xffffcd6fbf5ea590
crash> struct dst_entry.ops 0xffffcd6fbf5ea590
  ops = 0xffffffffa0193800
crash> struct dst_ops.mtu 0xffffffffa0193800
  mtu = 0x0
crash>

I confirmed that the dst entry also has dst->input set to
dst_md_discard, so it looks like it's an entry that's been
initialized via __metadata_dst_init alright.

I think the fix here is to use skb_valid_dst(skb) - it checks
for  DST_METADATA also, and with that fix in place, the
problem - which was previously 100% reproducible - disappears.

However what we should do in terms of path MTU setting for
such cases (use ip*_update_pmtu() perhaps?), I'm not sure.

The below patch resolves the panic and all tunnel tests pass
without incident.

Fixes: c8b34e680a09 ("ip_tunnel: Add tnl_update_pmtu in ip_md_tunnel_xmit")

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 net/ipv4/ip_tunnel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 893f013..5dcf50c 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -515,9 +515,10 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 		mtu = dst_mtu(&rt->dst) - dev->hard_header_len
 					- sizeof(struct iphdr) - tunnel_hlen;
 	else
-		mtu = skb_dst(skb) ? dst_mtu(skb_dst(skb)) : dev->mtu;
+		mtu = skb_valid_dst(skb) ? dst_mtu(skb_dst(skb)) : dev->mtu;
 
-	skb_dst_update_pmtu(skb, mtu);
+	if (skb_valid_dst(skb))
+		skb_dst_update_pmtu(skb, mtu);
 
 	if (skb->protocol == htons(ETH_P_IP)) {
 		if (!skb_is_gso(skb) &&
@@ -530,9 +531,11 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	else if (skb->protocol == htons(ETH_P_IPV6)) {
-		struct rt6_info *rt6 = (struct rt6_info *)skb_dst(skb);
+		struct rt6_info *rt6;
 		__be32 daddr;
 
+		rt6 = skb_valid_dst(skb) ? (struct rt6_info *)skb_dst(skb) :
+					   NULL;
 		daddr = md ? dst : tunnel->parms.iph.daddr;
 
 		if (rt6 && mtu < dst_mtu(skb_dst(skb)) &&
-- 
1.8.3.1

