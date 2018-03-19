Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521476061-2-6189604667133945305
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
    t=1521476061; b=UMBvu7n3sjzypK7HlPL7QFERcFwYQIoEMQ4DVHzKmVKZb5Z
    qVJjzMtqFMHCDEtZqcp9mzwFuIVhbhAAOPLy6RZ7+NbwHH0k4NGyUZcdiep05b4E
    glxoOgkMALreCrv6vWR21FhwqciIyLhVwQFEC85dy0LzccF9YLo5bTNSiJ/j7gDy
    5mW7hsXBZee14u3X70UoAWWjguxv0IvAfbKpbQNnfmyNo1naslt7vWl/YuQh6MSM
    ke8lvzC8L6cijuLX6Dl26id7VY9hhoVqggH7G4MmNN+6IU38qOQF0xbSB4EU67Eu
    HBoJCBV8HiNSjcur1/T6db5d1z+IcbYv4vrx4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476061; bh=NxcCcd
    gqaJPeJOZ7z83Ck3yE+DnW36Lk9SBJQcXNWQw=; b=KUU40/OaWnLskPMpIIpPr1
    QtpymWq55OtBxrWphncziKNj5fe3gDoo53/gGedFiMC+15fnik1SW+5MMsN8bxv6
    xwE1cytHfMeV9K1LnXGuzR9shXxsGKyHmzKF7g5bg+1CbuBtEOotrJhPXrYlMavf
    fAuO/Ri8yLNIws/LPuKQkLqT19FJFwooZhsXY5hgL9kbCHgnADz+nJC7gySx6mHL
    ell/T876oFur+3ydz/DXmuRKDSvXXCJBRe6RPejduhfWakFWn0IWGFk1JWzkveam
    Bsqhm1N2Jx8OxujHySkOgGcXF0oMW/ISy821xjXCvSLtM7m9gBzxH5S/hWMqvTQw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pqe423pp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefledtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pqe423pp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefledtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966942AbeCSQOS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:14:18 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:50448
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966145AbeCSQOL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 076/102] net: phy: avoid genphy_aneg_done()
 for PHYs without clause 22 support
Thread-Topic: [PATCH AUTOSEL for 3.18 076/102] net: phy: avoid
 genphy_aneg_done() for PHYs without clause 22 support
Thread-Index: AQHTv50pen/Qpt4iAUGqbSwa4FWTlg==
Date: Mon, 19 Mar 2018 16:13:04 +0000
Message-ID: <20180319161117.17833-76-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:CNCPMMl48QgIamYEISIcrBjBZ9YQC4GXWTG2DQST63sNw483aCBLV4SGo8ZTSU4o03fpiHnNXXdqIX3QBCJcoJY1moYu36y8oIHceUPjvXzNJp9wsCh86cZJSYP7nd+rQCeNURZJwXakoxHRK0xMSPn9WyINq1buUWsMpZXwWvO/hKDOZNuHnev3GrVKhbfK3h1SukK0e+F7DKI6ZIP49je2I7uVgwGwAE6C3qtq3VJ6PnqH6EJe07q5Zi2s3+wb;20:QR0IpYWqTdd1GhImzYCJLuu4qOKMlvITaPsXdiAwuQbjnUyIfTGKt9kPN3I5AfUcMMHy3vdkiDL0NCCC80wLItndGI3rwANST3XRmm5vZgYagbEmsbdpA7UPjvOwLbNbzl0tnyqTfCArt2LVSttNNYDn448bZABUymidUbkt+SE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c825ced-94cd-4ad1-adfb-08d58db46ed0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10635E5868D88AB9B1A3BB0CFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(59450400001)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vrPRwRWOpGDnb0OP8BmI82rp5ck92IkjGmpyOt+xAulC7CK1dP0Wcfcg4iiE2JcKg7TVUqalT7OWJ0tX03sYsPLFjtrJwPKU0pIiBsbzhGIckyDZ0HpcfQc+u2NhQHLzwQrlURprschV6nXG6ZKlq0S8QMV2nLu2aDeIxeBVmt+cD6NPji34V228faH3u6x15Rs7syPVGMOn1HNfviX2i4K3Tj8jtUxaASE4Jps2AhHk8hanuBmmJYRDDeCdP+YNZ3Jn0SHC+pGDzCKjtPVV3u5pEVYhMOJPrqcfOpIxJ50NgLFJ/9DPHoApz2iGkGAfft6zrEQrPgM6j2Gz/zDJHQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c825ced-94cd-4ad1-adfb-08d58db46ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:04.4325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index 7ae062743bad..59a6973fe760 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -123,6 +123,12 @@ static inline int phy_aneg_done(struct phy_device *phy=
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
