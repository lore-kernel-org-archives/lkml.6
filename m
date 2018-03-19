Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475852-2-566654169197833825
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
    t=1521475852; b=GI7Zx8bpNmNUQg1g4CbkiacYOUaZTM7B3nVGhqhOlhQte5P
    WUDlA0aL9gD8i2s9DXwlxKC7S/eD2BxDhFtUyCRrRypiL0EZ0tILxO1i69/EjPWX
    Hjtzq573MhLK2YWMvnbuBAoAb8QEarA1mEKed/muKH77lYXHLwZKlNBE1PexOiqf
    PHevwYrDKmWckfFPqvtPM9FwhQbLKajE5roew6RwrnYN5wt1vh6XI0tSW3Hd4RAF
    tZcg+IP+y0Ut48+ezl7bRzRg9n8NdttHU7cVAayExPkpyg/8g5OHbHAb4pRq8Ar8
    G0b/t43v/VJp4nLDoAWYrl8DN3CWBFMYshVwZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475852; bh=D27Ovv
    Rfz64TjNWdJ/Px/q+uL4drMsAOmDjTzL5L128=; b=Ep0fcVqU9TwosoVZeEY7FB
    kv87pUJWg1cTRAVSOdfIHWidRILbeuyAu6g0JVXRG8Z3qNmrdMR+LCA64zFp7rAM
    l7wMMcRacSu4NujDayiuJa5ah6ReBXdL/PKFOQYLnLxFCZNOWnfedE3iyW1txeqK
    52+mCpWosqC+ArKyRrvbrYCHKUnDISiYkdco6vt+WxJTo2hR+LoD8hKsg+9lXKrF
    5ceXpI+Ybx+HCWjYZQFI+hr80BRHOLcUZgrQ+RbvKbIk9+/FY4eSKOTKoDrEfkYS
    Hm93/niEr0ifRWqTYSiPqGzAtbm0Yl19+cjm28VfiDk3Ay6taODZrDzg9uSrLnCA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RpVmBv9t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkeehnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RpVmBv9t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkeehnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966659AbeCSQKp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:45 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:9825
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966590AbeCSQKO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 118/167] cxgb4: fix incorrect cim_la output
 for T6
Thread-Topic: [PATCH AUTOSEL for 4.4 118/167] cxgb4: fix incorrect cim_la
 output for T6
Thread-Index: AQHTv5xtuGaKiCQ2dUCGhpFDfQdbGQ==
Date: Mon, 19 Mar 2018 16:07:50 +0000
Message-ID: <20180319160513.16384-118-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:vBc+b0PLzJFaJ/eMRS6m5MtAgBAanFHNA1Btf5aUMC7n5Ta1wUJ9NnuEUqxENAvkTWeIZvniFZa00Bd+T6+2+ZGDvPhi+8oHDEELc86K5J6VRzTARz+/lpvP/v8/BCjetHr9GFCjopkCxMylxNGjymfT0jsZsLjh99JQkZjtAJhayk2yFUkDQzwsWaVPtn1a0FQgKhE2nX02jf2U8VNsagdATPqIUPB6Okzu+F/LS+YyeoDqr3Y3zI/c+Q4ORYHd;20:x5J0Sn9kGoycgLaH16/9+aaEcNsbGloaJOVBDarMj6p3QcnhLSN6HJYBWfhBJ5xeGVSO107vg0ziTdVRxxw7glOi7rnO5k393faxyBCe/ogYIP1Z7LzPLbfSLGT32i6S70ougnp7TIIy7Qv+USHIhc5KVuoF59Ai6vGwjjZl68M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3870d125-50e1-4c2f-bd8e-08d58db3df1e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919FE9A3F7343963750241EFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(43544003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OdFKceN1I3+itWYPTmox37TzjqnmDDw2os4NvO5cSNTI5o84Syzhyv/t9Axab4clhajnpmM53ffSB7o7kp+5S0OoepdQdEUHC1V1fl+OVTfOGVXTrCRvnhj/47ont8A3ikIi6YX+FbAj2qasHYLEJV6zEFgA54MYVJDSvzdlftg3RoHBIAC2T01eWVngf/zI2mSFRQWCy8SyYVg3L3miY7xVlqGf7nSAzaSAZZup0urC0/ZaRWT8GJzWHLv5MMQ8u7KRz9foaLz4WQ6igAL48IGV3oud/sybVyjt63ZWXfnkzQ8Pf4OQpXiICNSYtYlBAFymwXburvvsxyPQTiPOSg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3870d125-50e1-4c2f-bd8e-08d58db3df1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:50.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ganesh Goudar <ganeshgr@chelsio.com>

[ Upstream commit a97051f4553551d13e586ab3cb6ae13093a44a81 ]

take care of UpDbgLaRdPtr[0-3] restriction for T6.

Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ether=
net/chelsio/cxgb4/t4_hw.c
index a1b9d6c74309..de23f23b41de 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -7711,7 +7711,16 @@ int t4_cim_read_la(struct adapter *adap, u32 *la_buf=
, unsigned int *wrptr)
 		ret =3D t4_cim_read(adap, UP_UP_DBG_LA_DATA_A, 1, &la_buf[i]);
 		if (ret)
 			break;
-		idx =3D (idx + 1) & UPDBGLARDPTR_M;
+
+		/* Bits 0-3 of UpDbgLaRdPtr can be between 0000 to 1001 to
+		 * identify the 32-bit portion of the full 312-bit data
+		 */
+		if (is_t6(adap->params.chip) && (idx & 0xf) >=3D 9)
+			idx =3D (idx & 0xff0) + 0x10;
+		else
+			idx++;
+		/* address can't exceed 0xfff */
+		idx &=3D UPDBGLARDPTR_M;
 	}
 restart:
 	if (cfg & UPDBGLAEN_F) {
--=20
2.14.1
