Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477761-2-9962959738864274473
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
    t=1521477761; b=Bp89jzGAoMyIIDKoijBAfFc3U9NqCLTbMFSb9cvAGPka/pS
    UD5KlOd6mwmIwwa/RadgaWAxfWDXNEQYJzPiRR8matXaV3rvEW3Uu48XzSUV5JeX
    3HOSQXRhHUk9SXKtWDEbBOo67Hq6S+K0F5CprQ+OQ96QoqDWBkOxlBCQND9uNDP5
    pWyHLivSWqv9Y+RhkNm+flaedJp0ckVyo7H/tboJrMm0HyMNKmhMPQzTjHK4VjKd
    /C9XTT3abB3Q3y3IjBkIiTwJ2pITYq/9GMKVi7Cnz+EK6tvG7C93QHHrVcgC9J6e
    bNjvIVXlpdD8tzfACoc+lwed4t2A0dpFnnu/g0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477761; bh=SxVwjJ
    SC3kb38YyVs6t2Mx/I/TdO5b77I595pvcgOi8=; b=EACY1uq4hfLyHM6lb0Jmbh
    rbq7d2xMRJxZmJVuFVztUmettjQesaF5/vAJGnAlUA9xaXjmb45ohnXSMYGQVxPB
    4xRJm+g3B8NZoCWEVPqXkbNq8A/vy8U5WoRVmTcyL6TCQJVdzgYth8zOPBVgkEFI
    eVAXlwa+1w6PDFTxvNuZ5xwy4wRT58Zwj0dPBni+1ewXnIjv/U2AqQlqAm6tTJP9
    pc3SdzTL4IoamUTJ93wJLvRVf94rU7BWBVymSrFrSxhKmVyIAyd6cbp3wFoRq05W
    xgwTPL6KJHXi7pEkHHuX9JHo9N7pyiRctcFF36I7DYt6vXF/HtHUH9jUsq9smkbA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h5ZNwaPT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeiuddtnecuvehluhhsthgvrhfuihiivgepfeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h5ZNwaPT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeiuddtnecuvehluhhsthgvrhfuihiivgepfeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965200AbeCSQlU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:41:20 -0400
Received: from mail-dm3nam03on0095.outbound.protection.outlook.com ([104.47.41.95]:57888
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965090AbeCSQM4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nithin Sujir <nsujir@tintri.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 047/102] bonding: Don't update slave->link
 until ready to commit
Thread-Topic: [PATCH AUTOSEL for 3.18 047/102] bonding: Don't update
 slave->link until ready to commit
Thread-Index: AQHTv50UP6K1ofynb0O/Yme3zz0fyA==
Date: Mon, 19 Mar 2018 16:12:30 +0000
Message-ID: <20180319161117.17833-47-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:EMTwt81GmJufNHGDUHFTlBan1YuDt6FAuSOGGouBmUiqJIef6mv5YfuFRhH9QwERz8kfBvJ4o67FuURAcPnyXZtOG9f+wHpLnmVnQxO9fjMoSpqIhn2SiIUk9FeS67WPGjcUZDBVxEfrmGlyTN716DvHb/0rNztaMR1uh53pR5qRJPK7vFZj4L1MXtSk9dZQaHBVSp4OaI6PB8WLeOQBUXBVf+w5OLmOYxWO6OYBwfzAk56Vs+xge1HUHL6u38SL;20:F1YO4PRQ/LQWb5lak/eBXM/p6+lsTXAET7j+iSSs/jQBKD/87dExep83vFyuaREhEetpScmNmY4/zh1M+f56HTj1Ts52mqfccjgTgR0IUTwpB2IgUKtkYQRfMJxe8eiWTZ+Yxh/MrxQlb1spYRwcDPZBZG2CAIJIEYJ+hdmz7ns=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5afdf37-c28f-4364-4b84-08d58db445c8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032883B39AA58AE707DBFC9FBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(72170088055959)(89211679590171)(211936372134217)(153496737603132)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(15650500001)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(59450400001)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Y0SGFRFrESxsPpbqSpKa8XjrWA9PcALauCA8K3zmFodPBuvh9h0B5muzFt9tcZ/T96LEN/t/dLgubcYDT26ViepaPqR/8jdGzBKjVaAv4b6Ap+0YjO25WEM4uSrEPLaORfee1jcowmm2mYh7/Sc9+iDoQvYOnc9rUdT68OR3PNzaVsJkAqOboAvSB/yaGol8PyPB9RBwdy3CrBJUQU51V4sO+ti4sR4SwpMenxOoWDnUok4cYy50ExOEXgvNjE90KoQaN8Khlw4hKkiORDq8dieLpBb2EbnpZsyXYCMTsLTYKymgdqmNf0cYq0IuUkDPFixhsbv9BGJfqKiHEev6lQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5afdf37-c28f-4364-4b84-08d58db445c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:30.2234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index 566054c0eb9a..09f86bf560cc 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2425,11 +2425,13 @@ static void bond_loadbalance_arp_mon(struct work_st=
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
@@ -2456,7 +2458,7 @@ static void bond_loadbalance_arp_mon(struct work_stru=
ct *work)
 			if (!bond_time_in_interval(bond, trans_start, 2) ||
 			    !bond_time_in_interval(bond, slave->last_rx, 2)) {
=20
-				slave->link  =3D BOND_LINK_DOWN;
+				slave->new_link =3D BOND_LINK_DOWN;
 				slave_state_changed =3D 1;
=20
 				if (slave->link_failure_count < UINT_MAX)
@@ -2487,6 +2489,11 @@ static void bond_loadbalance_arp_mon(struct work_str=
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
