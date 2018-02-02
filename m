Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeBBQ66 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:58:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38164 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752077AbeBBQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:58:35 -0500
From: Roman Gushchin <guro@fb.com>
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH net] Revert "defer call to mem_cgroup_sk_alloc()"
Date: Fri, 2 Feb 2018 16:57:54 +0000
Message-ID: <20180202165754.8551-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:7867]
X-ClientProxiedBy: CWXP265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::29) To BL2PR15MB1073.namprd15.prod.outlook.com
 (2603:10b6:201:17::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66fec73e-c0b8-4c63-4ab0-08d56a5e27f5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BL2PR15MB1073;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;3:kz7mqpzw25yIUbrnCTYLTdumasyESFIm3hm/rLnCy21kkNGqgTpoetAv36WPDvu+F+X9aTm8MRmAvu+IBhViO4nFqkzM4krPmxqjKOqUVfCWdtqmhhRMglRDd49fc7II8cI70UyQrQo1cQyQSjbU5IDFe4NhSI5PNvf0N3XB8ZaKetZMk7APbWfJ9XSt2BCibpe5RNIdwBxOkIpZXr/ybIsAJ069fnGx3nqo42oQQAHWFDh6cIsALZgYB022jbjK;25:xg35JLaHj2dzwCXmi5EMrR31NMiNLZGIqEeHpkEWAnUVIR4sq+J2NeZep2bXzGuDVXODjYjsO4QRXbdpIpU1yFCLn64I1KbV/+2k2XfOia9EHOpnbLoiYfHXSTpP2Dxo69NPDMH1FgCDWwrRw55ZDp1ennQQIBUNTGqa6p6TqUU+5SwrpJGX18w0yxoYVVFfhObesnrdAQdrTdTNqYVMdkT/lM0jSVITq2+g5sur7LsqFeZQH8RqnlPVQVEYB9rIMlPidOlO/KH+iSmTGaR+1e6fcm5OXH9Do6pnaQMUgNKeCcvPgu3C4wrKdZ6eGqVDx7pDTXge9MFfruEee54f9Q==;31:ORdDCmNoBtMo8vUF8T67SK4R5xKy+p0FAVQa7/m4LZi+CvwkKSSZknylZagxxJo708uu8x1/Tb53vataGZ22z2hnTQPc1uEGRSnWQw/OB3An8ECL/ClcvRqZzXEDS9EWN4jiHZCdY7AE7tGOZjpR+lkwG+GkPt8wdiQQdDaf9lFzUzQmyS/qTIEO4Fhao2knrYMnYQ+rrVE8FOtzziyvEkhavM7IEKFLRikxtXIWGEk=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1073:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;20:fuF4pU5mt5kMQdPEfgSIITyijxXZbARmc9mHUDrxZiNYSr4SvrUCWTEZSJmP9PI9OfE7hVrPg4AVVHGqbcva5FwQHBG6QSylUmkqeqGRrWobdS9ntpnyEmncMGi4v2+xY34jPeVYNuG1/E6PGdyIjCbzC7fWSbSOZfXUg0JyMEDcbvjr8kCo872TRrMZfHAalxjxMtCg7zuFTlC75YN86PNO/bJCCpBLSUNcQVMaKkf4YkLuVKDLyrSFGDcSf65c+X/nayPT+dbj3hdc5EMk3a1aoy4eZkIwWIo1UsrXl0zRFOTyLEjJBJ/VVBLxtyZJ4hwj1v5arS8kg5u/B5POMojBmNRDO31IpKszv8WgxVK1aKiaZGORLvBLNOCxMPJdn78+8/HtL2AcBEM08LqIVI9seLFNyfxZ+cbjIplWYZCJe/bf2QY3ssqBiDWimoq0wTcfYFeAoOAuQ+SGpjxqBv/xCBhksPozi1VgiFYa8ckpIFiZJl2ciCDgfkX9uySP;4:oecsvnXMg3koT9fM4E39ESeg5OdKKvDUoY7XAAedil4gG5arJdGJl0bCpCdK+OV4P0NYJXa6vbcdmqHeaJCh2MjFU0PHCDNo6Tzpt07ijxOjV5GeROxQL93VmEHtKVMkhDXzm4BnoYBtP2l4GnSmjzufZbCiUBuA4iJf3jQwt/LDgwLazCAuUykAdJIwgduuePrB0/HKmczLPIDhsJMwaVUoIjjbswd5MvJfuWYrVz99xdf+EV5M1lKXqUjbzb1s15UwlE96dXSC7G4mYWgTDCmY+aWQpqACEYJgE0uU71fd0074WnTr5XY2/xfsr+/zP2zr1DQFnEU790KWv/18F5J/ofET9twmQCEJTvwJpI2eQrK1vzSOZXBj9Izh4aYi
X-Microsoft-Antispam-PRVS: <BL2PR15MB107303AA7C0B73810CB6594BBEF90@BL2PR15MB1073.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(11241501184)(2400082)(944501161)(10201501046)(3002001)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL2PR15MB1073;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1073;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(396003)(39380400002)(366004)(189003)(199004)(47776003)(6116002)(1076002)(68736007)(50466002)(105586002)(48376002)(69596002)(2906002)(4326008)(6486002)(86362001)(50226002)(81166006)(8936002)(81156014)(8676002)(6512007)(5660300001)(53936002)(54906003)(6916009)(16586007)(25786009)(7736002)(36756003)(305945005)(52116002)(59450400001)(316002)(52396003)(51416003)(106356001)(186003)(478600001)(53416004)(16526019)(6506007)(97736004)(386003)(6666003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1073;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1073;23:enp/2A5ZOzavLYO32ANbCoWYbY07bl/VJWQb08t0C?=
 =?us-ascii?Q?BO3eGaHlQN+9ixbkt7IR0jAO4gGI/TjNShK33r9/Jj7M8YqOXntAZfOx7ueV?=
 =?us-ascii?Q?5f6rv6n1v7b6I7MxCHj4u95s6KEd3L+tRMv0QIKz437lUWKAlMvndmY8fxda?=
 =?us-ascii?Q?F5YrkpeMA1HsNPYqyy6Jf/t1qf3KXidYopkdowxO0qkPuvMGKWf2q2hQpN5u?=
 =?us-ascii?Q?VNXkQmw75Jd4Ixr0ZJoa26MWwAnBsYr/pLO4Nf/Y6MpAwvpCfHr7+R4cwl0/?=
 =?us-ascii?Q?NJCRdMWC3OQVh3Ib55RyWL9SisB8oePZ4YSLo6vx2wGDRE0PCab2axsQCBJP?=
 =?us-ascii?Q?PJytxANeVsag+UY/08Xaa4kGGY+xzguVNVClmscaRIyjTYAMUTfmBgeJv7re?=
 =?us-ascii?Q?DSvSfvq2QJ2KNeZAalGBIzaIgkx+2Srppn53V1N63qR7iMjptzO6zJGsC3zv?=
 =?us-ascii?Q?mezO2dbuxIprmPD8E+5YjnK7elrlrJCy3B8HRd76CeFEVqK+kKwFSNB9aw66?=
 =?us-ascii?Q?kiljgcYzJwA1CSEug2t2e5UTl6cFxu8Ypsgnrl0prDXMpYdpgdUoeexXHD4b?=
 =?us-ascii?Q?J15cCkUiark1dwIeOYZwpSgzSFpvDLRUuU4nFvHrDHOD51haw9w4J6a9gDar?=
 =?us-ascii?Q?5qnHvBrvcbkO9SBqZJtvsIXHmPyobdtBEoNPUi2CPbDiAjYXsEYHwj4D8vQ1?=
 =?us-ascii?Q?K9QHUaWxM0v8a1f+FPLpf/yOd13hiMZY8I0PsTteffNZ6eQbQyy3QbOlk9NB?=
 =?us-ascii?Q?D4GqixpfOdGTnAc+7sTaG9MnTvTDBGJlOITxwt7YEYwFbwL7KWKtJwHUWqc6?=
 =?us-ascii?Q?QkgC7TqZOvuRGTf8u8i0rGLy/N7NxrK8nEB/qPdwgtOF2P0xRUv+jlvmJFbL?=
 =?us-ascii?Q?xmvXqJgke9E3QDexiVteEX8Ir3M0Q7x3mqL42i2xhl7qvbyZdYE3ShbhwOeO?=
 =?us-ascii?Q?PAkYAjGVYz6rxbaeir4mHp8pJrEGxYrXszgI6Xbtas2Qrnnr7KWkKYyFn40b?=
 =?us-ascii?Q?J5JgBF7QuApg1VNicKGX/C9siPtlAXo96JB+CcOc/1l0qYEPi6ASpntDiLEY?=
 =?us-ascii?Q?iidAeRjh/tZu8/Vw/WBkAEAml0zE4qvnbsJ/gD3vzGjWnG5vRv+SKlayrdmZ?=
 =?us-ascii?Q?6RrNn9XGlrGW/6iXLfKtR2tWV/DEV1tF41s4pzQiKAZhN+NB+e9DA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;6:NG1bIJJkJKkvZPhBJrgfh5qTzyksmAWV7VC0ULRuLjHN7jzkZEnu70mXt8BFVsc81Oqu8CvFWq7P/2kWaGpXHDn8jXxlqMM1Uy9NKQEkoWulXW5JXW7qF5WMmDRh3N67deXfEwKNsUr9fM5DK66I8FeJXnLcrINeQOsql9Vfvj3j9ScyhzfO8epiUk3kPE7pa6dyQBxhmjySy++wt5/5JsrDOmCvPvJjsTVrnhd9FxIsLc2GHlNWxPjUjHBut7STVcbNmD0QPi69a9IqzQwweF8D76tTMm8Q2qECmyQvXRkmceVrbkK7n1KRF0mtKLfCXKdhtyUlcL9gVtr2xr6s8qsEFQ0AfqWHB33TELlEj0M=;5:9ZuCxagMoWK0cpvvZD0XcvUOT5dT1TOsN5icHxOZ2R25Dt8lfduGTm1otPVPA0j/X23uzhdx+/c/wUuuqd1+GbErDFank74LTVe2VgOGNujEdeOcT3sa589Z589/IyOMO/dLknJqGa9ArPYv0iuxYfn4M6Yn/h+3jqtQ8MfUaDg=;24:8lT4ElqkbwRERzi+97XrRizxj3qa7ktBC8oyEQirmbKnRbIMxw8KNW/+cRqeIqxlDmGoH2ev89cPuQzvBwL3QpGjgwBOZre0zJQftJNo6bk=;7:qE3bfLlmx4gtm27EB8+8A253UE7ZMW74MsaxWgC2S7YXfMIZa7cm436wY1VRZpvcILZ3KUVy8u7Qdpl2jsgc+OjzNFQoMt6UzqNNQPj6EUS3eG7PCrEDFDw/8l1N91+YvkpvTR0jQfchhKFd5nez5q0xWVBXxgU2UYdJhVQQL2sgZ4E+07JDOmyjSsEXo8pFcvuH3+/4NSopGw7lMT+RDNjRj+LayuCXtkngNQzBK+HciWa9A7Ut9kWZ+z7OWt7N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;20:Iaqb/Cb8zhmY7TscxLtwLfLZF8AGHdnSp7Kq93WaFD5lNvCKtz6Q1W4SS7VCpuPBfkmpqauIf07SfKb7jJ3gsx9T4EbYxX0UWphWXx9y1XRQqOf2iI56A5MAGm7VyVfNshMGZnas56mPlIx9dl9CRisk7NGvtfK8NxCu6GsVl8E=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 16:58:16.3430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fec73e-c0b8-4c63-4ab0-08d56a5e27f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
