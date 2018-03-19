Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481650-2-15753332972008937913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481650; b=JS7icIBsP8IhmX8cP95+gGBLmibG10ni7fOeM9FUBkn8J1/
    aqLP0Hn7LhJyNsQg8bYGdRcgphC00J+oASUHZNP6E3COnP3vOYQDjHNY6WhH4+Pi
    ehwa9OImkEkUxoIJZl2QEdxKWRYeD06fzdEuKETe7OyXyWOB81T5UErxIvPLWVp+
    Mqa0hUYFglSv5JfVDi+n9krEFBqBXkVPgnwYJU54eos79iraib3oTz4GD0P8yQdk
    cWxzJSJLw9uxzXmJb7pvxVzG6OXJ8NG/zy0Cf578vIZflVQAu84fjancGsYi/mTa
    q2dPiZbaLnaFyLAuzlP1UkIOmHmikl6DoExcueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481650; bh=WtKl03
    ZRKFBWKPybZN8v8cxhIEveF0ncTXHx7txnuWM=; b=wT2JFnUkPnlexX09FnG0dx
    /hoMgRa7A5dRBDH33462INWw2XmBFx6+Y2Y+BbtczOEjlpvZtEHvr0akqoZ0VZmX
    lkOvDkdwNZuIyMhcvmFfHXhF6MYOWEECl1F5uGjjaaAlXp+3pRwo2bRc0+VfWZSf
    xZkw/q+tlLOY4wBSMAkvHaA8cwzlseS5IBIZh95ANdTZUlL+GwYUhOz1Nlps8y8u
    FyQwJj4Ky36Ngc1gbCEsCA9YoU0kVMMdeq/b8hKKQTpT1QS+gEO/GkEIbJhHus55
    TjOSrDogCq+FazCi8sEEH9cb92SVLZKTWTQwRUR7J4LUnHhR/k2GQ8vbhhg8qHPQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P1N9wKzt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltddvgeenucevlhhushhtvghrufhiiigvpeehke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P1N9wKzt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltddvgeenucevlhhushhtvghrufhiiigvpeehke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965782AbeCSRrA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:47:00 -0400
Received: from mail-bl2nam02on0128.outbound.protection.outlook.com ([104.47.38.128]:47286
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965812AbeCSQFb (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 242/281] sctp: fix recursive locking warning
 in sctp_do_peeloff
Thread-Topic: [PATCH AUTOSEL for 4.9 242/281] sctp: fix recursive locking
 warning in sctp_do_peeloff
Thread-Index: AQHTv5u1Dn3frs3A00S1Z2G6dwWzmA==
Date: Mon, 19 Mar 2018 16:02:40 +0000
Message-ID: <20180319155742.13731-242-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:XN15MIfbg8h1cpa3DrAQg5UmVdCC9f1znA4XyKgcInxCMBnQ2+TcMGSBUMnIo4mWO8ap3nhx1z7z2FR3Zxo9i9Yemu7GHlKIrCth09MKl0fQF8XwB1GTyK7ANCu4iHAxPbrD/ye6/PXqTQlDV0BTnCgSBObnVJ6ss3p7E8tR8/z2rb4k8jV9GX5QfuIIiXUwg4tIxjmSG3h+D4C09XUZXXAVzm4X2sQdfKGzZG9d3tQnniUPzwx+JgZtnalO/TNw;20:dDgaSXq1IMIOsjQk69YjR+9PUL3gzpDLak2JMbH3f+lxmdzgIKSV6oXZBfzuzZRCRO9zkjXREJrF/z5i/Bm0viaS56LlQXNJwxe2zK40BYtu0IAgkO9WT2CXo1MmRxYaSjgqScKfBkRiIFzj5fECPnXBGoORV75g52V2XIWrIm4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa869916-f99c-480f-a9d5-08d58db33b1c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07271503DA594B8993D9B81BFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(39060400002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WabPsxpqJWyAnS6oKfzRx+B3xu3iShHndGz2oTwTtjqydyII90Eq9UbQuZFnzgnVlQN6r9Obk9aPNo+pNK/J7hK2ZuPJaZzqvS1WeQQba8pZfJAM7Qk1eDkKSv8JQ4wvLnGhYvJWrPCcYfxYQ4X3/4jaljYJfwDF+vNBcOfsMBRQ5fJgKbS0sOjo85ehlb0mvYTdaQr3jxuUhBPuazs4h5oPJEvrazofwBo8OROdZBq74nEX7mcTrCaGw235Ns21LhGAIauJs0no2DczaHSgMoAkFl11qSxGUTkD5M7EvcleXnR/r+T3jRAlhN4E2ASJcQuCogNiOvEv/LSgzWcSYA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa869916-f99c-480f-a9d5-08d58db33b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:41.0192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 6dfe4b97e08ec3d1a593fdaca099f0ef0a3a19e6 ]

Dmitry got the following recursive locking report while running syzkaller
fuzzer, the Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x2ee/0x3ef lib/dump_stack.c:52
 print_deadlock_bug kernel/locking/lockdep.c:1729 [inline]
 check_deadlock kernel/locking/lockdep.c:1773 [inline]
 validate_chain kernel/locking/lockdep.c:2251 [inline]
 __lock_acquire+0xef2/0x3430 kernel/locking/lockdep.c:3340
 lock_acquire+0x2a1/0x630 kernel/locking/lockdep.c:3755
 lock_sock_nested+0xcb/0x120 net/core/sock.c:2536
 lock_sock include/net/sock.h:1460 [inline]
 sctp_close+0xcd/0x9d0 net/sctp/socket.c:1497
 inet_release+0xed/0x1c0 net/ipv4/af_inet.c:425
 inet6_release+0x50/0x70 net/ipv6/af_inet6.c:432
 sock_release+0x8d/0x1e0 net/socket.c:597
 __sock_create+0x38b/0x870 net/socket.c:1226
 sock_create+0x7f/0xa0 net/socket.c:1237
 sctp_do_peeloff+0x1a2/0x440 net/sctp/socket.c:4879
 sctp_getsockopt_peeloff net/sctp/socket.c:4914 [inline]
 sctp_getsockopt+0x111a/0x67e0 net/sctp/socket.c:6628
 sock_common_getsockopt+0x95/0xd0 net/core/sock.c:2690
 SYSC_getsockopt net/socket.c:1817 [inline]
 SyS_getsockopt+0x240/0x380 net/socket.c:1799
 entry_SYSCALL_64_fastpath+0x1f/0xc2

This warning is caused by the lock held by sctp_getsockopt() is on one
socket, while the other lock that sctp_close() is getting later is on
the newly created (which failed) socket during peeloff operation.

This patch is to avoid this warning by use lock_sock with subclass
SINGLE_DEPTH_NESTING as Wang Cong and Marcelo's suggestion.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sctp/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 8cdd6bbe2efa..172465b7c0f4 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1519,7 +1519,7 @@ static void sctp_close(struct sock *sk, long timeout)
=20
 	pr_debug("%s: sk:%p, timeout:%ld\n", __func__, sk, timeout);
=20
-	lock_sock(sk);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	sk->sk_shutdown =3D SHUTDOWN_MASK;
 	sk->sk_state =3D SCTP_SS_CLOSING;
=20
@@ -1569,7 +1569,7 @@ static void sctp_close(struct sock *sk, long timeout)
 	 * held and that should be grabbed before socket lock.
 	 */
 	spin_lock_bh(&net->sctp.addr_wq_lock);
-	bh_lock_sock(sk);
+	bh_lock_sock_nested(sk);
=20
 	/* Hold the sock, since sk_common_release() will put sock_put()
 	 * and we have just a little more cleanup.
--=20
2.14.1
