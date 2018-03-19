Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480758-2-11540495292661278024
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
    t=1521480758; b=jBSfUwbab1sMkRf1oP8GdTjxvnC/OtmEGXPJfa19E/L1fO4
    nOOZcpgPYzlCUMermhdRm9v4u2NhMpxyjvlwZHy6xqqmNpPqXw2lzQ5YcgiHZIZW
    rpjb9GCAhaKC4UwpzaAPBY1IE93+RDmBihhiBrT9gBRg759I4drkyzG7YswUE7ST
    62sG618dZYaFsJz+8/VbCSECGtdVqp9s5shEe0AmzXm40m6aapNnmaTKF/eTQqe3
    TpBS/50FAHieKBM86UrLxtJH1PzGmBsLgEbqEOBPpHaC4iQEtU5wlrnEhC548kSm
    GQIGF5SLQtpARevecSeLIzBXlOvRjUvsIfk39Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480758; bh=Md1elU
    7Gd196QbBQ1PLvdzI6sOBdlXmhnivuEq3fXKM=; b=t6wSSTeS6D5Ay2+mudz9mB
    GMyVeIFJh8nZBqylBKEM5bmZyBNHX/jIeRmoFdA9fJLsbnBSxGL03+rWfZz2SnY0
    ex/RcpZPcP+LEwi+21Lv+6DERcr7I1ovfNSWC1mwu/qidZ7aSdl1lz3NFM6F1atO
    XxGvoEJFyemTlr8bFZe/WN/aGMRK4dh2D+03uQcBTObzRrztC8PaYjkzJA0L6esT
    bVU5lk49vNH4WLjw76Sn23iAOVNwtxHfRklKxAcQZ0w3Zc39wDiVMJx4Vdh912sD
    iAfPCeI1TO0soujcvBh5UNfPy/etGM+A8DsGYtiAWcLP7qI/IxVmnmHKDobPQiLw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZyD7NYYk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleejleenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZyD7NYYk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleejleenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966032AbeCSQG7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:06:59 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:28800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966068AbeCSQGu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 014/167] lockd: fix lockd shutdown race
Thread-Topic: [PATCH AUTOSEL for 4.4 014/167] lockd: fix lockd shutdown race
Thread-Index: AQHTv5weIA1aKYuLVkGhTGr3AdNjXQ==
Date: Mon, 19 Mar 2018 16:05:37 +0000
Message-ID: <20180319160513.16384-14-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:ooKJLa6qAyme7Hqk411aqJ84C7zPBaN/0Y1cmY82OBCE7UT4dUe6ZPLUmi5cWOrmC92sLfHeWSlOAT4jquG0Ba43DoMGNrFnnNnVaxKUbIVZRplJ4a8hC/HGo16zDZA5F+hhZUuPhVESxkcFMQ0qBdFfPhW3G+LzuLFh8z2BgJ1nVmb+EGA0uRWni1KU1u9fAeB+djdxsfZ3HuWn4AJ14XtCVqfpjrkomrqA/m49CDqpDhjUGCvt8PDibyeZAXrB;20:CZjCFwl36ubqha76Oo1qGK8AxETQ51KSlvP1+AKrIWUR8nrxZZ4XU5HNUxckVzqiG9wfPmT9UZaU+UpCp2DyOW0nlJWabgDiMq8n4/Fv6G2aYU4IVl2qsEYYPMD2UEQR8u1vGsHmxGHIV9Nq+DTM6sP6w+TxxsVEsLEeKS7sjrw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03b6f2cd-6fbb-434d-c789-08d58db36a53
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920455D13D1350653746583FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: aCdqN6KpbYU4lqVJzypZ3KNVDJzpEU+z+8dsIzNkcJWlG1F6IIdnBV7otZU/F57eDcb42MsKduc1atZAem00H3d5FJmkwexSEuH06Dey+sd5scqsgka7cZ+BD01Ne04Jnuf4BZcdph4X05d5tRV39fwlZlkooZBlmMJa5b1oWRoG33iRBm30oD0Y09BoemQOr72l1i1Py1knzNjCTCteWO6fddflcpZTLvzO9HtRRjU4zxuoY78rX2Mzbm2VK3Ctv01QBUiTvJ1JGv5+zY11Q6+je74nrc2fm4A7imXDR4kRQ4T78aAx9XBzG/aJOP77JddwfEFu60ByrXhw3kl+yg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b6f2cd-6fbb-434d-c789-08d58db36a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:38.0145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "J. Bruce Fields" <bfields@redhat.com>

[ Upstream commit efda760fe95ea15291853c8fa9235c32d319cd98 ]

As reported by David Jeffery: "a signal was sent to lockd while lockd
was shutting down from a request to stop nfs.  The signal causes lockd
to call restart_grace() which puts the lockd_net structure on the grace
list.  If this signal is received at the wrong time, it will occur after
lockd_down_net() has called locks_end_grace() but before
lockd_down_net() stops the lockd thread.  This leads to lockd putting
the lockd_net structure back on the grace list, then exiting without
anything removing it from the list."

So, perform the final locks_end_grace() from the the lockd thread; this
ensures it's serialized with respect to restart_grace().

Reported-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/lockd/svc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 5f31ebd96c06..a2edb0049eb5 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -129,6 +129,8 @@ lockd(void *vrqstp)
 {
 	int		err =3D 0;
 	struct svc_rqst *rqstp =3D vrqstp;
+	struct net *net =3D &init_net;
+	struct lockd_net *ln =3D net_generic(net, lockd_net_id);
=20
 	/* try_to_freeze() is called from svc_recv() */
 	set_freezable();
@@ -173,6 +175,8 @@ lockd(void *vrqstp)
 	if (nlmsvc_ops)
 		nlmsvc_invalidate_all();
 	nlm_shutdown_hosts();
+	cancel_delayed_work_sync(&ln->grace_period_end);
+	locks_end_grace(&ln->lockd_manager);
 	return 0;
 }
=20
@@ -267,8 +271,6 @@ static void lockd_down_net(struct svc_serv *serv, struc=
t net *net)
 	if (ln->nlmsvc_users) {
 		if (--ln->nlmsvc_users =3D=3D 0) {
 			nlm_shutdown_hosts_net(net);
-			cancel_delayed_work_sync(&ln->grace_period_end);
-			locks_end_grace(&ln->lockd_manager);
 			svc_shutdown_net(serv, net);
 			dprintk("lockd_down_net: per-net data destroyed; net=3D%p\n", net);
 		}
--=20
2.14.1
