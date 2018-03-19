Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475488-2-920142089032151539
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475487; b=MN3Jkmcyh1acHeV+a5W0ox/fnFjbAI4jDzo4XED7Irav4aa
    gu4NPff6jBou3TvCW+53Y0R78X2U9MIRlxAJGxz33yjuZMB6fA2eQmIQzErKGoRf
    JCC7DCfzccTWe51dpP8QbDBG7ccuTci5RfKwYt5au99t9v4VyMLhm9DNWH5sz0TW
    3r+Q+uovsn5ySFvu2haqvZnmJKsnHJIMu928SNzzuo3quiiwpI9IRdFyq6Dj2tNu
    g0kIDcvkSOlhygte87FtBzJE4PS2fMzjdsVFYXIBZPRVq4tK3fQpGwbfMgiCahk2
    2brIB/USh7v1A0ynsZJNU0fmcEM+BqVomMWZHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475487; bh=FZg4PE
    vQyIijECPNyKpFvADM+b4S5M8xDptkx0YEjQQ=; b=TIz4ZRXe3rI8R/inHpVoyp
    gVGi4DA0qVpi0xpNL7XxcfkaoIZiBONqUxPM50dHCcd4okocwzTW/MtwJCwZs31I
    3cTd8iGt5drF1HRNIJ3IBogw3xRqRnY+RYRfVWRT8sj5G/koQjLUw/ppwqHojibc
    IG0loXFxr2otULsHvw7nSRJah/k+BE5IoIDfCGpqMJM7RgUXSILObRHxXkySSHBq
    lyhdmgIL0FSupmgI6BzWAjSOK5/s9jiIsYyWcc3YiR3mIQDKmL6lHtS8oB8F52EC
    PHZBvyqqypVpQi0mqXulOydgXGbtrRgJGUcLzVx/E0hLjBsHPxy8WQyDUsWR5R7A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CYiKD3Pp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefleeinecuvehluhhsthgvrhfuihiivgepkeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CYiKD3Pp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefleeinecuvehluhhsthgvrhfuihiivgepkeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965681AbeCSQEn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:43 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:4621
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965345AbeCSQEi (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 215/281] net: phy: avoid genphy_aneg_done()
 for PHYs without clause 22 support
Thread-Topic: [PATCH AUTOSEL for 4.9 215/281] net: phy: avoid
 genphy_aneg_done() for PHYs without clause 22 support
Thread-Index: AQHTv5uhtjJvw8uW70GR94CagvCqdQ==
Date: Mon, 19 Mar 2018 16:02:07 +0000
Message-ID: <20180319155742.13731-215-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:iU5LA73j0/43ziJOJyAEMIc5QFDrxR7JnfoJ0/8frKBHA437CrUPoA0z7eXCjqliWSTk7Qm/3bIXYKtp5DswRQFm76SMwQSPlStACUzr+Ly9MfAJ+8vR79J/RHTcuDyRvhOHD/zT2bOElDx4phGdJR1R8RzHFFA90kKyVh0ZLGpU6NH1z40TgShbclfVnbfN+/puBDDL1z9zwNOIntPF3IuXn97is826yQavYVRrXuj350KWjzy4RgbBeRLuxl8f;20:k53EbuMSvh5OP6+JQccszwFRdETz1wMV2F9Ak2Ofhn6cJf3JEWC06uGVvOCm+aSvbDbe9zSzHVtsVXPqY5x7LnASfZze/fK+TJpMGKfRvLWlVIhY1QWwWaoGx1KZT2zE84bAulUj36Cvrq0XIF1I7JgCsKqIdT1KmQkPoi6B0Vk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd1e2007-8181-405d-b79c-08d58db31ccd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080579DE02EECCDFAFF2B49DFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(66066001)(22452003)(10290500003)(4326008)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(3660700001)(5660300001)(6116002)(6666003)(6506007)(59450400001)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: g0G099sUreF64sEH2eqlvvoLWUc8KcP1wi+pDIaAlWnhz23KDIxo/deqOZUS+xMuwhv4mjPinqMCD/DZvGy+zgVf8xLgYNvhsIg9BCA3ru4WdAORh1f4LKdTSbrHxiYyWTC+fndi1hBchzgBXk++G87uuqDWQs4Tmlp6e+mBLVouL9zPEfOAN6POsuTpsipZkFGOIeGLvOl3J0TFo+aEoyDHAhery9hm4Um+0t8/txtKBqHqOGWYgh/ad5dhcRbZbCMI/knOJ1NiuCVwZR3luU9YDYsH4UjXZwzoks/njEmnp52IqVRVLc1Fyk/Oh8GApz6EYY4hOssQ8f51xYNsDQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1e2007-8181-405d-b79c-08d58db31ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:07.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 41408ad519f7a2a1c5229e61f2a97f4df1b61adc ]

Avoid calling genphy_aneg_done() for PHYs that do not implement the
Clause 22 register set.

Clause 45 PHYs may implement the Clause 22 register set along with the
Clause 22 extension MMD.  Hence, we can't simply block access to the
Clause 22 functions based on the PHY being a Clause 45 PHY.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/phy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e2d9ca60e467..4d217649c8b1 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -148,6 +148,12 @@ static inline int phy_aneg_done(struct phy_device *phy=
dev)
 	if (phydev->drv->aneg_done)
 		return phydev->drv->aneg_done(phydev);
=20
+	/* Avoid genphy_aneg_done() if the Clause 45 PHY does not
+	 * implement Clause 22 registers
+	 */
+	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
+		return -EINVAL;
+
 	return genphy_aneg_done(phydev);
 }
=20
--=20
2.14.1
