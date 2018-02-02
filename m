Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeBBTyp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:54:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52386 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752567AbeBBTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:54:35 -0500
Date: Fri, 2 Feb 2018 19:54:02 +0000
From: Roman Gushchin <guro@fb.com>
To: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH net] Revert "defer call to mem_cgroup_sk_alloc()"
Message-ID: <20180202195357.GA8169@castle.DHCP.thefacebook.com>
References: <20180202165754.8551-1-guro@fb.com>
 <1517594367.3715.130.camel@gmail.com>
 <20180202180624.GA11596@castle.DHCP.thefacebook.com>
 <1517596744.3715.137.camel@gmail.com>
 <20180202190426.GA15313@castle.DHCP.thefacebook.com>
 <1517600096.3715.138.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1517600096.3715.138.camel@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [2620:10d:c092:200::1:ff89]
X-ClientProxiedBy: HE1P190CA0036.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::25)
 To SN2PR15MB1088.namprd15.prod.outlook.com (2603:10b6:804:22::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c698f2c3-c819-4f23-0947-08d56a76c03d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN2PR15MB1088;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;3:U+m6lYp3QIlbfffhO9lA+VLH/vbnrh1NFjCS1lCV99cS0a/YiKn/1uzKV6lS4CvoCmvrnnZkwE82a85C85sMnWhIM0Kk8kp31y6hETtotdUdO6FUwyKHknSB6Gas9dJxSrWzObMWCNinF6JFP0scUGK4uI+PVm3lypIfwMPKNCr8AtZwiSI5ENd9TUv1Y6lS0d/sAUCBzTYdAKphb6Pi9d6SrdLC7AT+RQF69ooWL8ixFpiZmc6eAT8meoDt6ExR;25:BJi8Sa8cm4Elj/64yu0jI54htOHnblkB61+8jbZOnT2Lod70GODgELdkpg2wxu26Kw0JkW474ss4QFsHDJStS3dE9S1u0ifkwKmN8rcTZIt9OiiSFRNd/tR1a4fbbbSrbQYeJvPbAAIhRwmxNDY57TjD+ON2zHAJk3RVZgo2WEwBamYDN6x7a7febQnM8HwOrHW1XhKJwaEpl195WagaxE6PYPc8qjV/QBXEoTgy0Br9fudA///c8GXeT9nLccVleruZkEJ1hqyir1GKTiZkiYNZfQtBofDlzx2eJsN0T0UJUl+TESQQVoeAT0mcucuerwnk5YqIYG80M2UFAc9NVg==;31:+OhpYcUTF5Fo+sZYsZ1PlMdVuKTKtkXNg9cVVDWCuyshMQHTupIwos3P84NxfYX2W1WzkQvaAKEhMWu3qnE2xX23h9SPTjGo3wuIorBYNeU3AUDgeKqNJd4Dq/ZD0jE2R6MJDkg6r3fbsbN+G2pycDrMUsLD0brxgc3D/93z3Nyqw1cz7w8QYwyyrAVMNvMH4Y23fvDEF3j4MDgttgjdx505CRiFP8WyuWJ4ZS+vfqE=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1088:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;20:r+BZjFzDs7FM7HXmu0pv6o6k8/I4AzvZigUya6NZnL+bEo36nFB/fwkLBzzXccYnbucczC6hTcgYb+K/DSusKYhw2W1Ch5gm2bU8drd6FcDB2+4kV3DrQX3yrO6MmkTTdeTzAZF1f3AU3VyM0VHzBZ5evF0vs2uZI19Y2sphjvTA/LD29n1YlsotTvN1rU+8OLu5TyS83uHg7+BPX4YVwo+Jgw+kG/Vl/ZcamAY9AHrW4Ty+GmROl/J6cSczVRC6AYTxL5kWUzhOg28qkbjt1uti9yPItWuCvYMQMgv2xeMn+0Mj3eGRxH+NASWBqkxuJ0n/GOAbydvCR/FFvU9O2chUX2Iemtd2k1Fo6zCMqaniltO1fXHKqw4Hngi8FdaEloaYZgm3ad1OmJJg8cFEWXg5ci8KfiKJeHd/Zu/F2sb73P7KM8Dmyk9ZSw2TQdeKXcEjszixjWk/QEEF8EKAT/SDyjAbkfBekvXpNXEEp6oCEOzXbcJq4yOl3uSTQfNR;4:mncGhXV4u8AK9qdBrx7R6p15bd/VwqEQj0nX6wv0rHFr+IpVbrR4BOR/tel3JH+u1iXzTU2/kec61XO4/QV4ITwmlrUb3dRFk+WhUHirUezz7AlwkzLgGXtnWwTbcVI42i4Nn6F+dz+uWoiW2tDkia3d6bXG0HET9f4lZhUqHx007Okb9UjUmXCQN7o4qbwg5QimrMNL24SxLa5UIkmweBK/HNzF7dyrgAXFkaLXx9BADIp5y75WIXyN1Llr0sEm2S67zgjMydb2NDoZXqjtLgnJFnwvICXr2HeKvQ7kpp0QgyyILC5CGgLTZH1EiPMCQ2ZsZw7k9bz/FylmcoKvqQWL61Wa/L8PP0+91dC2T50MVpau1MPdKmGlJzpz8+iu
X-Microsoft-Antispam-PRVS: <SN2PR15MB1088C4B98F9FA4C0D19AAF28BEF90@SN2PR15MB1088.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(11241501184)(2400082)(944501161)(3002001)(10201501046)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR15MB1088;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1088;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(377424004)(54534003)(53936002)(6666003)(52116002)(59450400001)(2906002)(6506007)(186003)(8676002)(23726003)(50466002)(478600001)(53546011)(305945005)(575784001)(7736002)(8936002)(386003)(1076002)(81166006)(6116002)(68736007)(4326008)(16526019)(83506002)(5660300001)(54906003)(97736004)(93886005)(58126008)(7696005)(76176011)(52396003)(106356001)(16586007)(33656002)(25786009)(55016002)(47776003)(2950100002)(6916009)(86362001)(105586002)(316002)(81156014)(9686003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1088;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1088;23:q626jCtHd0BGdLH/WUJKUq1D33QJ6DtfDIRTov9jl?=
 =?us-ascii?Q?Qzi06Jk8gIPqyKtjTJsdfdZt5HqqZuLYTFzaD/z+ZUb/acvvbqwiKu3UJVfQ?=
 =?us-ascii?Q?D3V2n3glRZRlNcfIZ0TwgijtYT3M7DLpDT4Q3qcuM3pFtSWpi4yDpFRkoDAa?=
 =?us-ascii?Q?m2eOCpB8kZFlQKuXE4tIdSvHMDf5WPjpvFG7DoEqREcIF9NxDoybnQOk8bhJ?=
 =?us-ascii?Q?xTev8rh3po+n3SmcC/Z7MkQ/8OSUhO6sSpNVlnSF3mUC4+djvo5R5HTbkwm2?=
 =?us-ascii?Q?aOjVDyDbj7LRJS+Elk2U3D8rbvCWzFr0GI19H/7udiyDNIepyo65Ur8s/JeQ?=
 =?us-ascii?Q?3X3wry3+2zyUe6BwAbEqNr1xTgaZCtK0oXgpkWbdjgfiUAJJBW83MwEfQDW9?=
 =?us-ascii?Q?Y8sg97ZiEFOuoK0R4fPuZUTkO3NrI2jp6PkAKQHtIQqdFahVW/OcGmju23pH?=
 =?us-ascii?Q?aeA7iZ8pjlH3hgBgTALHcD8K6v/Zs9ZfEn5zOOI7WiCwSe3FBHMCsKUz3ZmN?=
 =?us-ascii?Q?41Y6iz7gMgcfwZ1f3hX+RuHX/+DvnzLrpa+9+Ur2ew8N584hgGvlw4YZGsqZ?=
 =?us-ascii?Q?OCxAJ+2G8RMrOUi8wM65JtARZB2mJxOofZUeoWOPTMr90b708CgSaEf/0jdG?=
 =?us-ascii?Q?efOshVmxRcFLx7FJukiJLBVPEz5/0Jo5NQFjX0QFzHlWflFP82Z6JxqKk4Ee?=
 =?us-ascii?Q?FT/Sjakm7P+ovWbTeKLyVtXM2IZk6uVrJxkM7A+CNOE82soGTjNS2HRhcAJ3?=
 =?us-ascii?Q?juwCLc/GyWgLBx3Ws9Cd2X2r6ifNpFdCYK21BVfZxdH4qj21b7UWqmq4vTDB?=
 =?us-ascii?Q?svyHNPoXvA/p5jBIpUHebqIoD4xFOvsGIrolaBcwg04QXP5tx1WTFF49nuFB?=
 =?us-ascii?Q?hx73Vbx/Y77QeFgojtR9fT8Gzz+oH/f+ibaDBWRQwiT9Lqinf7KofRL4kCfi?=
 =?us-ascii?Q?/wPWCttd9htZ/kDC0V+slCn8LSG5CKPxKNd5+btZyMv2rVhKYuHPhQkr2Ccl?=
 =?us-ascii?Q?Htg0oMuLv/3h9ZVMOxaJgRVufL7Mm7NpFKj2IpvHrHSnJ8TCYnbylO87J9Jo?=
 =?us-ascii?Q?Fnf84OXDjvK68RYE5KDFqXwxDhmfU2ingli+o7eJSbuu/WTnGbkyJloAEl9e?=
 =?us-ascii?Q?B5CK+XKNBQaarkfztXOq0c+BcwlZYD6pSmaqm/MohhdMjeF42r1XhVhtS51j?=
 =?us-ascii?Q?jNx1BfPNlZIqsevY3sEeXnV4c0ChtMyf0RZdu60qoJDAhCMpuSZEdwKhh8IZ?=
 =?us-ascii?Q?fi1KT2P1NbJekaSrr1L+XbEbaFNKFQyNYYZHN582CzgEjaq5nn+VEyOgaGoS?=
 =?us-ascii?Q?PFRlcs4S1p8vWX/HIWPFII=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;6:6i6MyXIIqEUOkgcy7cQuzLIO9YjG2PiSB8QWJevzCffI0GLaEK3KSp0WJMCt21SK6F4+tEllBbcYrorSDn27x/KCNlPjIQEal8pCEiNBx8zspBU52lyslAYWRojipl7Bg6iKLIruijReGQHBvpzK85AbSsxmKHLYBbKcZm2UwDokG1NMZJs/S6d9nusb6EoPQRk6e7nHThAMxXyf2eCaKNDatyA/EqaX/V6joelS/mqHKTxG8ESbNp+BpU0mowx2rMxOzscxijU8CieKAMpyVTDM19pI6B/K0jOuRyXVEIdEr2eKzRCOVHexZTqQelqI7DCx30zCl+1LJLdcKyhem+H0gd89304j4WrakSIGXy8=;5:p1AV+ryC6uN0+3JdCIrgvoz01Bpwd+XhgsdCgoXvUc1shQ4/qcBdVxKqYaePs8HBA/IFZP8kYMYftoeVeD2Kt0UAwozKw3orsREp91hLLPXQkGGYa4oyIOMJTc23WW6BpfOxvWqPYtZfkNECGqgnoH4c0hZGG3s44ipBOIgkOzM=;24:7OsbTHmq6bGBYySoYOa6yR0YxLFaWTWsQ6GHf/lSs6Wp/D1gkqnZ6r5IvceQcIDlrV3qZEEHxQ2nopH6kcv+9QbkOMMMqWmCMhpVbxVj3TE=;7:2czIeCF5+0FqT9/QyumEqEbEzn5F9pb3Xr4OxHnNqIM0lndpPiwC4AoaLn8XiujXXFTR26Kp3g2tekQRH+W0gCk4Z/kh9GiLDhOcgJICcUw65ErMIK8SB02CL2ZHSV+EWoHTHc4YXCFG79fRE+KPLZJUVKnepfMzn+EjSGUeaHn5YIFy2vNQlYqmNL4224MoWlaH0wwYDuZdGtpp57u6DTocBMKzvkf+DfUdIPg5v9eW+WEmYCAd1IqI/lQKH07c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1088;20:MdwHCOZCd40AACBcZlIR6yLjWHuMGTMpKVgZ2wfa1zaBN+g0CfGBRKMhEX/HY44+6zFJYLx/djpjdSKqUu9GgPZyR3rynkrGU47SbdRvvTNhYkWQl5OXxBKui4Bg2Wf8KQTlqcG17eQxS05DwkWdXRe8VuQnGT3pq3hTDi/YbEA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 19:54:13.8108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c698f2c3-c819-4f23-0947-08d56a76c03d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1088
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 11:34:56AM -0800, Eric Dumazet wrote:
> On Fri, 2018-02-02 at 19:04 +0000, Roman Gushchin wrote:
> > On Fri, Feb 02, 2018 at 10:39:04AM -0800, Eric Dumazet wrote:
> > > On Fri, 2018-02-02 at 18:06 +0000, Roman Gushchin wrote:
> > > > 
> > > > Idk, how even we can hit it? And if so, what scary will happen?
> > > > 
> > > > If you prefer to have it there, I definitely can return it,
> > > > but I see no profit so far.
> > > 
> > > I was simply curious this was not mentioned in the changelog.
> > > 
> > > A revert is normally a true revert, modulo the changes needed by
> > > conflicts and possible changes.
> > > 
> > > I personally do not care of this BUG_ON(), I had not put it in the
> > > first place.
> > 
> > Technically it's not a true revert, but you're totally right.
> > Let me add a note to the commit description.
> > 
> > Are you ok with the rest?
> 
> Sure !
> 
> Thanks.

Hello, David!

Can you, please, pull the patch below?
It should be applied for 4.14+.

Thank you!

Roman

--

>From a0a07f65a38105562bf424d7dc072a2bc4f1569e Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Fri, 2 Feb 2018 15:26:57 +0000
Subject: [PATCH net] Revert "defer call to mem_cgroup_sk_alloc()"

This patch effectively reverts commit 9f1c2674b328 ("net: memcontrol:
defer call to mem_cgroup_sk_alloc()").

Moving mem_cgroup_sk_alloc() to the inet_csk_accept() completely breaks
memcg socket memory accounting, as packets received before memcg
pointer initialization are not accounted and are causing refcounting
underflow on socket release.

Actually the free-after-use problem was fixed by
commit c0576e397508 ("net: call cgroup_sk_alloc() earlier in
sk_clone_lock()") for the cgroup pointer.

So, let's revert it and call mem_cgroup_sk_alloc() just before
cgroup_sk_alloc(). This is safe, as we hold a reference to the socket
we're cloning, and it holds a reference to the memcg.

Also, let's drop BUG_ON(mem_cgroup_is_root()) check from
mem_cgroup_sk_alloc(). I see no reasons why bumping the root
memcg counter is a good reason to panic, and there are no realistic
ways to hit it.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
---
 mm/memcontrol.c                 | 14 ++++++++++++++
 net/core/sock.c                 |  5 +----
 net/ipv4/inet_connection_sock.c |  1 -
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0ae2dc3a1748..0937f2c52c7d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5747,6 +5747,20 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	if (!mem_cgroup_sockets_enabled)
 		return;
 
+	/*
+	 * Socket cloning can throw us here with sk_memcg already
+	 * filled. It won't however, necessarily happen from
+	 * process context. So the test for root memcg given
+	 * the current task's memcg won't help us in this case.
+	 *
+	 * Respecting the original socket's memcg is a better
+	 * decision in this case.
+	 */
+	if (sk->sk_memcg) {
+		css_get(&sk->sk_memcg->css);
+		return;
+	}
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(current);
 	if (memcg == root_mem_cgroup)
diff --git a/net/core/sock.c b/net/core/sock.c
index 1033f8ab0547..e50e7b3f2223 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1683,16 +1683,13 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		newsk->sk_dst_pending_confirm = 0;
 		newsk->sk_wmem_queued	= 0;
 		newsk->sk_forward_alloc = 0;
-
-		/* sk->sk_memcg will be populated at accept() time */
-		newsk->sk_memcg = NULL;
-
 		atomic_set(&newsk->sk_drops, 0);
 		newsk->sk_send_head	= NULL;
 		newsk->sk_userlocks	= sk->sk_userlocks & ~SOCK_BINDPORT_LOCK;
 		atomic_set(&newsk->sk_zckey, 0);
 
 		sock_reset_flag(newsk, SOCK_DONE);
+		mem_cgroup_sk_alloc(newsk);
 		cgroup_sk_alloc(&newsk->sk_cgrp_data);
 
 		rcu_read_lock();
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 12410ec6f7f7..881ac6d046f2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -475,7 +475,6 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 		}
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
-	mem_cgroup_sk_alloc(newsk);
 out:
 	release_sock(sk);
 	if (req)
-- 
2.14.3
