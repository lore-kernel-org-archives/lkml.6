Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479111-2-4890845236581884526
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
    t=1521479110; b=BiHxcpU4Tvq3D9Aauebq5V7L2cz4k+86XFNa/72X5eObaP5
    FGtOQ5XGsnheguupgmc2KDLjMAmnAzdX5okwedpMYbuaewxUxKoMVEUIWp2y6CuV
    RPRp1ZkzcKmr41Qk5zEVL3c4VwpcDUkmzgH09MR2gbheRAJ82aNaYfs4oaE6I90H
    u326nvVFfe9oEI1eeSYqOzuqRX0ik6ksSMcfro0ooSgVV9A9pnIpcZLYLF2sPIFe
    U9wOIAHEH8gGXfbshS12CJxQpNHrqUx1Pc+Xv45AVBsnCZzqJPEo3xpSQEgORqQ+
    +CqHK6n3L6tw6nNupPJI68/zM7GEQ5Y/OBkdvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479110; bh=PYI25G
    OEYtEwLiz6aWIevU99da9KRatjgjtfvwsiR5g=; b=o0W8fQjW+YMkr2X3Xva6B5
    1Ab5Ode+VXheTPnBuRcVzFDzer/r5sWBo3IoQlLVeIpG9zk6Ztf065Mz4D0ATILh
    XT0+7ucwXRGP3azkH+3CnxaUbVnKEZCRjwU6MipZ/9E9bSccncpIafafM0nPh/tj
    v9aKAPASBEQESegl7FwQbxrPZPnKspUMMJh4d3T29kt8Rx5/xRttHnrzc0Lyw4YV
    StNIKELf6KEv3Yq/JhUHj2T3AK3hxWrtnBQP5VWejEBJbI1d15nQQ+Ek8tLTo52q
    AqDU/pRlznODXLaVZpif3u9rEfdy90xkiV5JEX1IdK5xix9I75si1mQam2V7HJZA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fLNjcqSt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkeeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fLNjcqSt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkeeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967647AbeCSRCA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:02:00 -0400
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:57012
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966702AbeCSQLD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 148/167] cpuidle: dt: Add missing
 'of_node_put()'
Thread-Topic: [PATCH AUTOSEL for 4.4 148/167] cpuidle: dt: Add missing
 'of_node_put()'
Thread-Index: AQHTv5yEycSkrKtB506IgDrY7h6WqQ==
Date: Mon, 19 Mar 2018 16:08:28 +0000
Message-ID: <20180319160513.16384-148-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:gonbH2XywMZbqeIgznuCIcHpYu4wOz/H1jLWdH9xBWgvjwh+jwQ2Wdl2e5wbVEQ05ActIcRuFlPLw6Vbd6Qd6OPwCUhB/YHsjYkDwXcm+yZg7gzBhk5jIKQsHRkQkDCt8Gredh7W2pD6HGpHMqmoi/e0CeIwEA9bncppwkL4VuYdWIkL0zJQHMBkTtqdCQdCV3tzWVXblBUpkQkQwpn+oZ7wML4pZ/cRiENeD6jXwNxtx145eqTPvi5jJoU1llk4;20:iNxBJMoqTRq6ehpTvkOyTZXMer5Y08uu+Kq5SbPFS7GLNbQIk0Hd8cbqAsj81p6Obfbkily6VG5CF8ClKIezov/X7m1Gndn3jafmftOL6nmaJNWrYOT8bVXm0/6I+sh08AvP2yF5DS+Iz0qA0QMmkt6Pz46DpSmS6nuy6h2s7PQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d47bea79-3d2f-452b-bd74-08d58db3fb01
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095EC23B3C97853DC3D6E20FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: p++jIAgPME2O1/9jqfNl73QHla11ywFvchmow1Erp1KZD64+DT5YvzTQoUOOI4vr3NuKiue3BCsns9PmZ1RZPcmvbaMO/GyzMk1WlhhyRM0gm5P/p77ffxzoVurPg9QpV1qNPEPMh0fTIknJNIzHprdNiWJaxKnAaevTTRlLPMTydJRRwYEFo5S6J79i09GKbl2byP85Nsys7TKiy+nHYTCMjAh61k7JYKUJOGMTmgihWEUxmneNKpCtcvemHPHVCJT7zwcI0FguWuD+yefFCRCMVvjVKfjKswN6Gj2TNJug8VRXVxQPerxRSVxwRW5WKvS56mO09Uz6o6SRy0Hvlg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47bea79-3d2f-452b-bd74-08d58db3fb01
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:28.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

[ Upstream commit b2cdd8e1b54849477a32d820acc2e87828a38f3d ]

'of_node_put()' should be called on pointer returned by
'of_parse_phandle()' when done. In this function this is done in all path
except this 'continue', so add it.

Fixes: 97735da074fd (drivers: cpuidle: Add status property to ARM idle stat=
es)
Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/cpuidle/dt_idle_states.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_sta=
tes.c
index a5c111b67f37..ea11a33e7fff 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -174,8 +174,10 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
=20
-		if (!of_device_is_available(state_node))
+		if (!of_device_is_available(state_node)) {
+			of_node_put(state_node);
 			continue;
+		}
=20
 		if (!idle_state_valid(state_node, i, cpumask)) {
 			pr_warn("%s idle state not valid, bailing out\n",
--=20
2.14.1
