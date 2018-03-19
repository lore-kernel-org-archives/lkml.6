Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497420-2-15570333454741442218
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
    t=1521497419; b=QRmL/14jCYNEgV76VQ1Imb3uI9rpMEyu0ykO9vktm08IAEK
    giBwVRTq73/bx9j9QJB1Aodn9SGmONMy/N5yz0L5xQGe37W4ZE9u/hLz2M9v+bxY
    Q235Z1IPOIL6cw3t5sfBPnTOC2Hv7eCOWVzhFtSDrEDBFk5lwe7mmeopgpCkYMpS
    ETBCcK3LDhZ+rD4dQTAJb0dL741Cry8Nj5SmvAVMe7SFwmTuR+RUKhJpHjg3mznF
    8xqOStV53CcZtc9apMcYXb/X4t0yjxIKyhhwLWSTIzbRQ/cvGfK6D0lsujl3wqye
    Mi0SwzJZJj37pDeT5bmWyt712q/zgA9Pphp3oCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497419; bh=hnAcOm
    PNjjvSdfr6O0O6CMleSwN8R30LUBVyoVryoK8=; b=IKYJM9gVdDsQJ2cWsWwfBi
    t/BYUjMigRXUskQmQ5h2ReeU3AEdoFdN63h90kb8AISlfxtrUGzul/cESbfDAjNd
    UoAryuRaLjrfKHwUdcEXnzvgnM1qnH7MRQXcxftYIDijDlid03Kd0hNdpxRnLXGi
    vFIC9sjvV81pqGWLucLdayiyibiNNU7gRE3extUBPqu1Rqu8lT3h1ISqgM5zMd92
    mPOW037r7kGmJdxE5xvYx+KtJ5uP+57pFhRaFfBLd/0SHIh8V9N8aDCaK7tlvWua
    4C2e0CosAasHWueBvUBvI2H7o2QBJlSIr/WiqzfUTN1/7QJPBCJMMQUAYQ8jBSEw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m5Rcx+8W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeegjeenucevlhhushhtvghrufhiiigvpeeihe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m5Rcx+8W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeegjeenucevlhhushhtvghrufhiiigvpeeihe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934154AbeCSWJ6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:09:58 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:46720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934309AbeCSPyq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 15/97] rds; Reset rs->rs_bound_addr in
 rds_add_bound() failure path
Thread-Topic: [PATCH AUTOSEL for 4.14 15/97] rds; Reset rs->rs_bound_addr in
 rds_add_bound() failure path
Thread-Index: AQHTv5qWBlhqf5IVzU61eePwHDEzDA==
Date: Mon, 19 Mar 2018 15:54:39 +0000
Message-ID: <20180319155411.12348-15-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:53TTg8WaP1pfGO10Z+5pngNjL1Rh+tkv/n0m6PkMjMkPIaKar8q9bOkUyRaQBckyezoFyNfJFpAa1qsXdgufGyrImstFWCn1WyAT+CcRZQqYNPkYPzaL//479fKlt23cwyhwdPAKLdO0AuQVod3slKFmoJ+A/O0IjwqjF8a+NJ54vhtFieiS/m2WpEpqcas4FLwERFe5FJ1cR8gj+uJcVFwCyZ1JoM3mf3fRHYUKTjLNh3UQwtU7mZzJ4fEsFqPY;20:1WUU9vv6uwT0HFyWyvkedsRhAQ01JztkFD/tuW9N1d6XHs32YuccAJMYzJqUxcU9IJ5Gg+S3GvEMuNi4oFM5ckjfg3+8WKZeL0CVqq3Q6b5Z3oz35MV5xf5SUI7XSZzwZ1QFVRGFQjJ5e4FSnqbC75xV2gayKvFgm/iM+iWQPDE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 022a4281-a670-4757-3436-08d58db1b8e4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806A5AE57207B6784DE6D5EFBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(59450400001)(102836004)(6506007)(53936002)(86362001)(575784001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: u1wqhhIkFl+J8IwhugkDzHrlX7QNjoYuzzV/n9jMSZoY+TMIIB7MNFy84o0x7OZYwlDeXp3Lh2qoj/x4ujq2hPohjei/YM2HyEHslzZFVAMjrDnt1EyxXyVjAsgmjS4LgPvWajoKrMUYVW6ikAtPwEVwbfI0wsY2oh+/dcrRGUO4V34VcON79eoyOb670SPopgYMBU/feX8a2c4YrDJNNP6qWuM9d7P4TqjEc9LTVzlghrpApf/Ltgw1CoY1srMoU4UTbrhA33oi44oVMH2i7lZSnTd43qsV1aHClbRKOcnzvoM+ErV28pT7j6e3LBYcGnEm6xzqdlwpZEbqKW3Jgw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022a4281-a670-4757-3436-08d58db1b8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:39.2003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

[ Upstream commit 7ae0c649c47f1c5d2db8cee6dd75855970af1669 ]

If the rds_sock is not added to the bind_hash_table, we must
reset rs_bound_addr so that rds_remove_bound will not trip on
this rds_sock.

rds_add_bound() does a rds_sock_put() in this failure path, so
failing to reset rs_bound_addr will result in a socket refcount
bug, and will trigger a WARN_ON with the stack shown below when
the application subsequently tries to close the PF_RDS socket.

     WARNING: CPU: 20 PID: 19499 at net/rds/af_rds.c:496 \
		rds_sock_destruct+0x15/0x30 [rds]
       :
     __sk_destruct+0x21/0x190
     rds_remove_bound.part.13+0xb6/0x140 [rds]
     rds_release+0x71/0x120 [rds]
     sock_release+0x1a/0x70
     sock_close+0xe/0x20
     __fput+0xd5/0x210
     task_work_run+0x82/0xa0
     do_exit+0x2ce/0xb30
     ? syscall_trace_enter+0x1cc/0x2b0
     do_group_exit+0x39/0xa0
     SyS_exit_group+0x10/0x10
     do_syscall_64+0x61/0x1a0

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/rds/bind.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rds/bind.c b/net/rds/bind.c
index 75d43dc8e96b..5aa3a64aa4f0 100644
--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -114,6 +114,7 @@ static int rds_add_bound(struct rds_sock *rs, __be32 ad=
dr, __be16 *port)
 			  rs, &addr, (int)ntohs(*port));
 			break;
 		} else {
+			rs->rs_bound_addr =3D 0;
 			rds_sock_put(rs);
 			ret =3D -ENOMEM;
 			break;
--=20
2.14.1
