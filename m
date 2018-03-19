Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479863-2-6158960091238786172
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
    t=1521479862; b=r2IVjXXp2yODEUJrbz8WTagC9B0yns62baUOKJUDYoQygmX
    JIGm1whxlzC/zedtX2MgiOBcEmAP/nrh0mnwR/iYxl8ItyW4EzC8W1gSj03Bk1F7
    h1VLmDRagh6FfCTxXnF5qc+5ArWDzlaKp1qcr4z388Hd/WM7vbsBBleX7FyLnLwC
    d49geCJCsrgH26JgpzLHyLq1FilWqJIuWvAIA4JEg8Id1thBP5tSuAS8RtTL5Or4
    ZWp7xxMMCE7VK8zFv9sBJ8TijfpBBCGHMVkaAmSqvQXQ8GUDz3dEp5HoN2TfvimA
    6skXxSsgA+Tfoyb1TZ2fegzcgN/wWXA8PhKVCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479862; bh=QlOX8O
    o+za4EKvmb6VmlVF41sLbCRqzFUR0dzcrkF+g=; b=IMdiJ2wzn77148V/NSA1Cq
    U6KUhTkiUjFImNMsTDDZlq53SrPiqqy18ZVlDSWzW4hqDZ4aziB7bGMkFBLKy11L
    3bCOQgJS/+FeJ/MxQQ8AxhTA0kRMTMgPuuNrfAOMijMqO+P5jYRDRH6dieKNS0BD
    tIT5BRtLq69mk5BwGbD6pXoz3hpP6r5bkpL8Fe2WXEoFiWapexgxFqWhlGmR18S3
    q2NpFEra4RUZi4ull5V8VDKVhQ0kNgnhQXRE6K+fjXoa+hbU3V0PcgU8bNslug9c
    6z3eAOwpl36AD+tQnKltstRzlXK/wdM3rD+nn+Yor6bdYgPfLgZgnYb7a3KjYcPQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dS3SJGMH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeihedvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dS3SJGMH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeihedvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966526AbeCSQJw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:52 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:46817
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966440AbeCSQJT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nithin Sujir <nsujir@tintri.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 079/167] bonding: Don't update slave->link
 until ready to commit
Thread-Topic: [PATCH AUTOSEL for 4.4 079/167] bonding: Don't update
 slave->link until ready to commit
Thread-Index: AQHTv5xQnR7SqNNY80W7KEl5EKULnQ==
Date: Mon, 19 Mar 2018 16:07:01 +0000
Message-ID: <20180319160513.16384-79-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:IgfNHhR9JTLxlA/jyYD+XpY5HCMxqz57XP8KBtgd1BqWNahJNqPEsPTX5E3bRUsME55WaX+bC424arbTrbDxkP0Gf946M8LfdLQTd2WpZQHdlKWx95JeG2hZmo5Z25zExamUb5fgqOUPXcVMAT25tYO8A4KTg3USIN09IgJsfxLnd13n9jH11hIDK8emR0oeSaSrm/64Hgz9XGoB7ZFWB6TzY+ALNUstkWLOvGf8RNauku/Cqe7JRRtOdnVdgn1N;20:+9kTdfmcu57AgfiPIubAIELzU66EhP7GajfjjMwRjG6m2QFaTYXZuzbBs5zDGpM31c2xfhDWYkyhZ5gouxsy7NRxTx/ySJivs9i5rBNwDDY5zDiKFfb+BRocJwlki4XrygLZyj5+Zd7jwW6SjU3il6qleB42IeXRAOZ4rgUgWo4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4de586d-3177-4420-5acc-08d58db3bc03
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096548F3CB1C63AFF52DE6E9FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(72170088055959)(89211679590171)(211936372134217)(153496737603132)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(15650500001)(86612001)(10090500001)(478600001)(53936002)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RPw5fqJskVMZSRZIZhRSpRWnD9ZPqzv/QvAQ8dUX6RJrv13yAB4CdtybhgaYJbJsXEjQQ/d5Ky2pxmPecvuGm5N8XR46szCdFkSiCKT3CcWIdkokX4aSSClYTSnBGC6eDp0ciQo76ujKpdGN5y5w0sJF7RkaIN2YjisNlVjaeNnL4/+YqywE6+Asuzj2GHKphNUKNuV9GuoQauOVdWlzmcdgk2gAJ5mJn9/ToYCzh6B+mB54AoFoWUmTsOFWBxkEJ6rClCuqF6rWeU9HfYU1Ti/XOvwkXwAkTR3vvTZdXtqIPG923/oTVjJDkXxF5p0+HvtfDjhi/mlnGC3glW7QuA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4de586d-3177-4420-5acc-08d58db3bc03
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:01.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nithin Sujir <nsujir@tintri.com>

[ Upstream commit 797a93647a48d6cb8a20641a86a71713a947f786 ]

In the loadbalance arp monitoring scheme, when a slave link change is
detected, the slave->link is immediately updated and slave_state_changed
is set. Later down the function, the rtnl_lock is acquired and the
changes are committed, updating the bond link state.

However, the acquisition of the rtnl_lock can fail. The next time the
monitor runs, since slave->link is already updated, it determines that
link is unchanged. This results in the bond link state permanently out
of sync with the slave link.

This patch modifies bond_loadbalance_arp_mon() to handle link changes
identical to bond_ab_arp_{inspect/commit}(). The new link state is
maintained in slave->new_link until we're ready to commit at which point
it's copied into slave->link.

NOTE: miimon_{inspect/commit}() has a more complex state machine
requiring the use of the bond_{propose,commit}_link_state() functions
which maintains the intermediate state in slave->link_new_state. The arp
monitors don't require that.

Testing: This bug is very easy to reproduce with the following steps.
1. In a loop, toggle a slave link of a bond slave interface.
2. In a separate loop, do ifconfig up/down of an unrelated interface to
create contention for rtnl_lock.
Within a few iterations, the bond link goes out of sync with the slave
link.

Signed-off-by: Nithin Nayak Sujir <nsujir@tintri.com>
Cc: Mahesh Bandewar <maheshb@google.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>
Acked-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/bonding/bond_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 2cb34b0f3856..233304ad837f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2555,11 +2555,13 @@ static void bond_loadbalance_arp_mon(struct work_st=
ruct *work)
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		unsigned long trans_start =3D dev_trans_start(slave->dev);
=20
+		slave->new_link =3D BOND_LINK_NOCHANGE;
+
 		if (slave->link !=3D BOND_LINK_UP) {
 			if (bond_time_in_interval(bond, trans_start, 1) &&
 			    bond_time_in_interval(bond, slave->last_rx, 1)) {
=20
-				slave->link  =3D BOND_LINK_UP;
+				slave->new_link =3D BOND_LINK_UP;
 				slave_state_changed =3D 1;
=20
 				/* primary_slave has no meaning in round-robin
@@ -2586,7 +2588,7 @@ static void bond_loadbalance_arp_mon(struct work_stru=
ct *work)
 			if (!bond_time_in_interval(bond, trans_start, 2) ||
 			    !bond_time_in_interval(bond, slave->last_rx, 2)) {
=20
-				slave->link  =3D BOND_LINK_DOWN;
+				slave->new_link =3D BOND_LINK_DOWN;
 				slave_state_changed =3D 1;
=20
 				if (slave->link_failure_count < UINT_MAX)
@@ -2617,6 +2619,11 @@ static void bond_loadbalance_arp_mon(struct work_str=
uct *work)
 		if (!rtnl_trylock())
 			goto re_arm;
=20
+		bond_for_each_slave(bond, slave, iter) {
+			if (slave->new_link !=3D BOND_LINK_NOCHANGE)
+				slave->link =3D slave->new_link;
+		}
+
 		if (slave_state_changed) {
 			bond_slave_state_change(bond);
 			if (BOND_MODE(bond) =3D=3D BOND_MODE_XOR)
--=20
2.14.1
