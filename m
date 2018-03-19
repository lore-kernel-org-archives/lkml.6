Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494234-2-10618273287720901007
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
    t=1521494233; b=rVnIBwb8YTPCgsQzlsComkMFDn1yCoPfz2UOBOluSgUXcqQ
    7wNHsYYmzjcUZK/GyLsE/x0vQD0PJil2FqDFI+ORXEJCUzLT8iVwVnIS/MkQFg+C
    A6z3YuEWuyOcftPcPZsRyx5iaq7CU9LA9yzqirQ/9dfxfr3vd6o1sGbROkVYGajM
    Uptu6CQ+GDuMrPP0bSUWLhAiWieyGS8l3pJXLLcpXPbVOGn3LWiG5MdfNFF/Tats
    Rs7A4owsHehuHSMoUgl5EBlHQN46RfaaB2KapraddpvLlhG+UiDJ3UizVFUIaC0e
    YNDYAZii6Rt2Yx6m7KYbhr8LpxoQYnH5gJFHBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494233; bh=e+IuJx
    neHLAkEk7j2ptxzwbyYI+vB4XNHsIEMzFykGo=; b=Q2fmmegeaRJGAWxeU7RB/c
    gW3PevFGDvqgrKOc6OHb3+Uuu39CzhUIt5smzoxn3A87LwDZsU5Bz4JuHjp0mKJg
    Jcu0P/BPBDzd3Fn9WIicTlR+MTlYS9eOpjQm02FNqSeBV3i8rZ7kNeFkT/2hkYKS
    sHQq03cqMxoC7Kshm2Jne4u1BnI66gxCbP0IqIs5UvykOSjF46w4sdScp+dKMpH0
    TsO5BhgBp9oG+XOjhFmU055wssYhp0AYP17Ql5t96wWujEWwM728yYigROuSFj9l
    jcVIPtRHBuzGuPqSs5oSfpFX+J00GfJxj12TXz9BG2jRKvgNdh/3Rv4F6o33JiWQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XirfkMlD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheelkeenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XirfkMlD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheelkeenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935987AbeCSVQW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:16:22 -0400
Received: from mail-dm3nam03on0109.outbound.protection.outlook.com ([104.47.41.109]:6335
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965253AbeCSQBM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nithin Sujir <nsujir@tintri.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 113/281] bonding: Don't update slave->link
 until ready to commit
Thread-Topic: [PATCH AUTOSEL for 4.9 113/281] bonding: Don't update
 slave->link until ready to commit
Thread-Index: AQHTv5tZeSqgJUL0nkO1QN/T9YFpiw==
Date: Mon, 19 Mar 2018 16:00:07 +0000
Message-ID: <20180319155742.13731-113-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:+2DfRXZjLT+n5vG2yhHqVgnr9mIP6QZExa6PTfLQPpw5KplftNu41GeS3QwHnqSVGbPHw7uPG4gx/H/ev26byxFYew5u8w6HoggqXeiSQz5YqeOIW4eDxTVinmeW/e8sAIIbZsGSP3jpYYn1KKiXSb7YvPUsM72r20FycAJM9qlQEtqW+ZEIaK0KP/KQe6e6OVyotVg7e3GKosejwdLlSOYVc7X1GDm9RrAil06y6quZH7gBh/Dx0QJq3tmihHUL;20:+rdyllfDJv826XkeuBVomqWRVqxTW5cUwogQ4SDweJEoIg5lKTSU+FvKRSkbhVvUgqSXEBrBuoWiydMCtpQGKilDZiQoa83J/V5waqVblxhdkwe9Zy/NKsV+Qpb9R/nrWUyj/o3cBatH//n3m2CaWYxUz4Tv2QrkIrEXWMNuPjk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf6ce29c-8ebe-4f9e-f0e6-08d58db29bad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10158150A742F9F0735EC2E9FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(72170088055959)(89211679590171)(211936372134217)(153496737603132)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(15650500001)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: waKB/s1Cw55POksTt5GnmtXHt7gePABwjVe8F7soJIRgt1ivWfpEKWnxWZv9hsgj8SqRjneo/7BB9ykHEDdV0wSGNM75U9+69y/Ud6vUIHpdYZM5Y4R5rk1XER54acUIUhWBzCTH6cWzGHWlOxJ/CC3ZQeUXkh+NbQEWSwaMrVOTuFKx6ASeEAYukG9KuAw8Fx1SkAn+nGdNiMoKHFQq5QgyTFMMpYvM911mdlDfsLTSC2GJjDry9ALxk73XVK6jz2yP/i3Fn1pp64yPQZ8QbA57wzunDxYQZmVSiLbe0IQQYOrHW3R/8ZC+z0p1+yujXEkoldV24lgD+0/1mdsrvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6ce29c-8ebe-4f9e-f0e6-08d58db29bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:07.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 63d61c084815..6dcab3127613 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2600,11 +2600,13 @@ static void bond_loadbalance_arp_mon(struct work_st=
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
@@ -2631,7 +2633,7 @@ static void bond_loadbalance_arp_mon(struct work_stru=
ct *work)
 			if (!bond_time_in_interval(bond, trans_start, 2) ||
 			    !bond_time_in_interval(bond, slave->last_rx, 2)) {
=20
-				slave->link  =3D BOND_LINK_DOWN;
+				slave->new_link =3D BOND_LINK_DOWN;
 				slave_state_changed =3D 1;
=20
 				if (slave->link_failure_count < UINT_MAX)
@@ -2662,6 +2664,11 @@ static void bond_loadbalance_arp_mon(struct work_str=
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
