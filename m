Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476360-2-2956104707116355073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521476360; b=RunI2ddKdNt5PXb4emjxTZ/OyePSv3ZX5GrsTbO2lY1bN05
    QzynLgWsrzdAyqFm4Timrp5Ji4HIiO6+RSc1C2SyBBvFJUJlDpUD+eK8QwrpgGFq
    KSgmZ/sbGwxLE9g7QAAENsdsjXgcKrazABoPtbrZPhSuC0uyremPMwcN19nYy/Cw
    dJrzeJPSAgrU5QoYAXG+5RAA9nomMqqzkCJphmzGTwvntJhfII3IbegEXRqSx7EV
    UTtesl32ogoFwNUQybTiipRKluN/acz+bO2ekGJvH35XaHhummqsGsgkReXGnvyD
    oMp/lTLzz6GBPwIi9zRlDlNtXkUgiC8748tDV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476360; bh=rM7mWT
    AoZ9VQoiXCXcDoR8Im/EAIRS87pJluNyqjKNo=; b=BKfzEpY7QC0zGbNikwewaC
    PViIn3yJME2A30ggJ9M0s/j8HBpwC1VmSuSq3KwV3lSIiCoW+5a3jvPA+bu12E8N
    aNjIhV+JbD1WTD14P4YsWf8qv99MK1XwJ6ah1lBOQt8CUCN9DnvLEfe2j2JFSM32
    tX5ZdUSBC2UhLqVz2Hsh4ZLm2Ky+t35IertQ0gPY/6sOMFjSjQlek475VBw9H9/X
    2C0Ub8CU4P9cLldOgtqbhLkJEho49Tvj5NXDPVGtni5fWdIFeaOzvqAuEbACq1YP
    hhhEcsGgPaya36Tw8HqwzuiS9395Xxn8BK4nwoabRKLPjCX9hY6pQt66vHbMA02w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V2P27tHp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtgeegnecuvehluhhsthgvrhfuihiivgepjeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V2P27tHp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtgeegnecuvehluhhsthgvrhfuihiivgepjeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966938AbeCSQSq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:18:46 -0400
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:37504
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966971AbeCSQO3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 091/102] vxlan: dont migrate permanent fdb
 entries during learn
Thread-Topic: [PATCH AUTOSEL for 3.18 091/102] vxlan: dont migrate permanent
 fdb entries during learn
Thread-Index: AQHTv50zlb7jTnXG70GqGuZoV2TXHA==
Date: Mon, 19 Mar 2018 16:13:22 +0000
Message-ID: <20180319161117.17833-91-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:TCk9gOClfVD3bhkUV8EB66Jq38TN3hTDyYwmZ86hq61g4Mvkp3Z5Rx0QrMSIayutPnw4gwwE9o/MG2MhZKHn6zjmGMS/cYX1kE0PKfwcm+6q+iUti+jKsr6GZVkjU6zdP6QJnZvNCIwna2udSZEAJ0J+gqvkjj53njPKQVehT4BCkHMjSaMK7LJ3ybM0BsV/7pMOLw5nGp+P99C9CuLvQ/sXXt5IiBaAdLdSj9F0N1Sq5t20rakrklB9IanNhP0B;20:H+N0uyXRrHXCWFKgtSRDs4J36RqqrtY2CSwNQ/CqlGFleIJRnuVz+T1kmujIZAvfnxg7TmbDumP12Woqj2YdxE6un6TSzvwPMhu+1ghCdAOZI8jZVJfNmRA4v5CkkVegGdsuJlG7dTZmEOmuKZhuElMY7NlPAX0PuOg9ZgqbjHs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d00eaad-c68f-4144-c2c7-08d58db476c9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112BFE1172FBDD1365695B0FBD40@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(199004)(189003)(53936002)(26005)(14454004)(36756003)(2501003)(186003)(305945005)(86362001)(107886003)(316002)(7736002)(6506007)(110136005)(5250100002)(4326008)(2900100001)(25786009)(102836004)(105586002)(72206003)(10090500001)(54906003)(2950100002)(478600001)(99286004)(106356001)(6436002)(3280700002)(3660700001)(10290500003)(66066001)(2906002)(6486002)(76176011)(81166006)(81156014)(8676002)(68736007)(8936002)(5660300001)(6666003)(22452003)(86612001)(6116002)(3846002)(1076002)(97736004)(59450400001)(6512007)(22906009)(192303002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: o+45pwq86Fz4NhEBuzpNe8JaK7Nw3ms3WydKHAOs4fG3+FuYz3Y0GGDpZflK5JvDaEnYD91udU/XABbz8L71A0zjfeHxSBya8lHjUmgc97sxKo5dOeqsOqwg63mx0Yv4BuorG+5LFdSmjvIo2AmQr4xrMMMCc36P80y6PPs3C0d6XPB+Poe1wwXC1yvMTmTMOM+prIyktbBxoAvRHL2wpdn248/VtpIYZ6bBziNw7R6KXfF/keUYbHNt+j0GEHDmU6EzkUzjKZMxxAO2Jlfl+hPDiCOcQ64AY5OG4Ici/LS6kEYOvnHRE8cBpV40viM4KkgRhiVqVBMNHTwDXEtIhA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d00eaad-c68f-4144-c2c7-08d58db476c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:22.5483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roopa Prabhu <roopa@cumulusnetworks.com>

[ Upstream commit e0090a9e979de5202c7d16c635dea2f005221073 ]

This patch fixes vxlan_snoop to not move permanent fdb entries
on learn events. This is consistent with the bridge fdb
handling of permanent entries.

Fixes: 26a41ae60438 ("vxlan: only migrate dynamic FDB entries")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/vxlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 2dc89582575a..3db77c274098 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -985,7 +985,7 @@ static bool vxlan_snoop(struct net_device *dev,
 			return false;
=20
 		/* Don't migrate static entries, drop packets */
-		if (f->state & NUD_NOARP)
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return true;
=20
 		if (net_ratelimit())
--=20
2.14.1
