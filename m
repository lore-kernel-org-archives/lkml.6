Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476471-2-3535506972822249839
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
    t=1521476470; b=aw2AsqEr+HSn577bMDaG0+Do0xGAzGfubIxAe404dSbR4gp
    HlAnk+xcaU1s2qeIBmr9arEx78fO3RTl/YgRtiWniyYLAAiKM/e8oFTPmRb0fc8I
    YiOYn2KM9fINIb1iWAE3lDElmHY+qekvannIwXRqstNXadKzYVTZdgjJS5yfYdtR
    HemsYehq1/Uit8RF7dOdLVskywl+2KmK/xR/TwzVIbJHy8a1/Y8K4/FheaI/sjNI
    YAuu1RUo4pHHE7efTYpqd7IPq1+4sqh0E/s2SdBeM94Nbem5iag/thFXSyKcSqtw
    YNA/xYnduKQNRLJ0xZMIZDq8M7Jud3WjA+fR2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476470; bh=lPymUS
    s9k8xtWPZafdqDnPm3aFMWoLfVrCnfDJaLPwc=; b=aVMemuXGAxH65aIcIkVh8M
    /q6vc8ZE2jCCnEO1soPuaV+C0JZ0v3mMr7ezitaRXRGlzSYGet3veJtDyKzjLr+t
    HkDQmqM5wB5zynyQNl/eLUZakcJZb26zRw/9WZPMChUf1fUErBHf9h6P5MTVDsWi
    n5pp2z7vaSdtieG4ZXaIwrAJv+6qze4/AKXuFKuNOUead5psKMoANAPK9mSh2aM0
    1MXTy0KVgV4cEUbhtxgtEmj4i3zGV0IKZKgVJLn9ZL2OV3yjSHqrdNrZRe/peo0L
    MUkGCP6bpytv8/IzMsyRjj8S+eLDOoSfWECUyI05ErHMz31NbEaqjA/QX/Ac4ABw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i5MZqUk0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtvdejnecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i5MZqUk0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtvdejnecuvehluhhsthgvrhfuihiivgepge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935390AbeCSQVF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:21:05 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:53605
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966941AbeCSQOT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 085/102] sctp: fix recursive locking warning
 in sctp_do_peeloff
Thread-Topic: [PATCH AUTOSEL for 3.18 085/102] sctp: fix recursive locking
 warning in sctp_do_peeloff
Thread-Index: AQHTv50vjCs3tnLzOkWXV4pZYjei/A==
Date: Mon, 19 Mar 2018 16:13:15 +0000
Message-ID: <20180319161117.17833-85-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:l+80nkaGwXRY3JXt39Xof50uzdiFns27p9XJwuA9p3iuE23ADD91bMz8zkz3PGGGLGNUrpdVRtNphBQxjqPh18e1q1Sp20wcmg7HHkmJaqoFGx821opVLBZfZc9CyRA2GLTM8gRADcPA2NjtXrDJ9DmGltp4uyoyqELYchE5KDbOOHhtHW2NBNWmd4gfdsyUc4ADpKy1428nKcSzc3ByviQS601De2CZjTDNLRQB0ilMMAuZeKDu7GE+PCGPUYCC;20:RZYP1evrgLQSGw4DsZNNeJORYg6+myF5jll1RmFPCem0JjT+en5Zme2iLsi3Ion9HWzhTUXI5yxM2sQjoph2l7WdgjKUG9wLR1xCpzey51plu5cjZDLRfrMMDbgVXFZXwJwv8Q0cRTYgjZ3KDNi+DINAOQqng2fJd3+wV7+DndI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e23f44a4-e1e6-48de-8d8f-08d58db47226
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10638F79030F11EA733EB6A1FBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(575784001)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(59450400001)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(6666003)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(39060400002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: amPKlhG9WTiMQljBQu4W6iTHSxZl8BaCrN9OFmb9H4Hne7+JHtrmu6SmeuevNID1zbZ3eQWVe+RzPvBoDayCLXEyk4yh/SshNX7XKanYbAncW30CR3G87ly8X68i8foP9JG6j3UUoHbtnwc7AfDgAe3nqQsquCWijQmq/z/QaG/va9614I3ia9g1YZaZDztEOT1+s2SCFHtq1KxDpMFf6OMfi6V3AIJAwXzv0vbWs+njXNF8amAuCg0M25wiCJZIBhSL9NZgS/6YXJqmc9ipO0IWVPsEFrOMcs46DfTbA3iAP7IcKKoARtzBoQT1d+Xp0BFXnTKpKIE3yWwcryzelA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23f44a4-e1e6-48de-8d8f-08d58db47226
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:15.3672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index 225019397bc6..f389cd2425df 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1513,7 +1513,7 @@ static void sctp_close(struct sock *sk, long timeout)
=20
 	pr_debug("%s: sk:%p, timeout:%ld\n", __func__, sk, timeout);
=20
-	lock_sock(sk);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	sk->sk_shutdown =3D SHUTDOWN_MASK;
 	sk->sk_state =3D SCTP_SS_CLOSING;
=20
@@ -1564,7 +1564,7 @@ static void sctp_close(struct sock *sk, long timeout)
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
