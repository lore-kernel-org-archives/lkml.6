Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475385-2-2846536117255153843
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
    t=1521475384; b=QwQq9RtW/rZDV8v3FLdumOuzk70PSzsMkajZM+PcOT0fb7q
    3hKUAu+mw/RBdBlgUpphD3tPwauxc5qbPbh+YV7xVj71rQow9Ie3GX8LcH1TtD4q
    0ppKE4R9611qhDU/Bc7LzwIHekZJ2zb+Ite/ZXQTzwkVXzRUHFqaBnV2tDxudWCv
    Y15SbjdJrwWjBfzUb3Aqo9pRsIgkAb5Anj6Nf+hk2xXLvmNiAwFQ8Bk4Dr3qfhNL
    yXL2zCNsBHX3vZyyD9m0uTsk4qE0ddpXhetB2KWlmACbU4Aea4j6WkjSlO8c/izW
    EDkOVtD7Z/3nKuHUO1xFqbo6W/gE3oc//N14wCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475384; bh=Zl1zZD
    r/2OZw1GbkdTPIBPexdY2+8/2HgrMP+/ccqoo=; b=dD7gTVXlV0VmBrZEiUTFEG
    vMcEW8bYOZzxAhLWQErh6OLyHLJMEGKx+uhBhMqbjhREkt88g9kWItaHpGNh8M4K
    99jHBsj2PVR4RI8diE0rEBRbW41nYJeUtMJ7oxI+Km0vv03YUYtp84XGpc1QdaRX
    nFQb6xW3Pgw32VEvCPQPLr/FZCALu8z6q3G5k6qGBIYDY2OZL+n1J0dFvOzrGuff
    d9FZ4DcUynvVP+J5mXzXXUi0laK9N4FgDGfTzek6vSvnNWchpmMz42CB1nNyVfoS
    6RD/0Q+eLuTRMU2PYTAVSvwS4HikC7v4zdc1Vd+9Ae7H7j6eZtZI7cQ6nvXgS4vQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IqdF8Iv3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegtdehnecuvehluhhsthgvrhfuihiivgepudegvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IqdF8Iv3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegtdehnecuvehluhhsthgvrhfuihiivgepudegvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934990AbeCSQDB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:03:01 -0400
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:27264
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965474AbeCSQCs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arjun Vynipadath <arjun@chelsio.com>,
        Casey Leedom <leedom@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 162/281] cxgb4: FW upgrade fixes
Thread-Topic: [PATCH AUTOSEL for 4.9 162/281] cxgb4: FW upgrade fixes
Thread-Index: AQHTv5t8n9t8ldC3bkObhQyHOsBUPw==
Date: Mon, 19 Mar 2018 16:01:05 +0000
Message-ID: <20180319155742.13731-162-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:oHUyomCiMULyy7XLO1Fr/2fygqWGDXKCPH3ZCS+0iUxFsddOdQ7Hg9gQ9Y+Z9h0LT4MQ/hAbZZG70OCpHGdyFCwk0cj1SgdaE977txm6D3YJQpsrpRMnDz3hVRNQUhpiLtBQ8vzcw+2CjbLKVTBNq1/XmFdDEMKB8TbpU0+bX0pGclERO31KmLXOj3zfVM3fB8fZaAhJxUVOS6DLWuWiVSj3DcJifLcCp9XpyrIazECfrgZkb6pFRofc56x52tuy;20:2ndFKtQuP+g3JngguTgUifDMYOBruXOajEMLfhpKgGZkWka1+jo14+5akLJZC4scwuCjxJFlThkRkWSA8rpLopBsCyf+j+CE5sYOoyThz+kG7y9qYruH/hAC6ORWXRhMcxFX9mAIEcroicdhH0TAmH7b92FvvbMzqnW4t8sunIw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b1eecf2-9869-42d0-7990-08d58db2d8a3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072594C5E0723F94F6D98376FBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(575784001)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: M80llP5SuEGpLWvkWS1386QR8xxNgnjrr3d4D2dAUHpdRVOCeZJrgpDqnt3V5AAonulC50cPBhyNDdgeFE2ijpw6ol+XgrR9czt/g9wgb8A0FLmn+IFPlBqPhgZvYuDriI01/95yJUmSY+Cdf0ud8GOG2J8q/LDV//rxXxoL4YU+fSXVmBpDU0s16R39vjx1F/CfJivp97BNna+2r/jpVwYuGv5MTQNbosYpXGPr8fxRKjHlTR9qWS1L/JQMWfd1mIDAhIssX6AjEUBzAmZiPa+SVtJZHX+WjgeETnTntUuVxB+yXt6vPvFeO2ZiBknCEnUFO8D+uhRdokd6t+lIyQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1eecf2-9869-42d0-7990-08d58db2d8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:05.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arjun Vynipadath <arjun@chelsio.com>

[ Upstream commit 26747211486c5bc7dd014c3caab206576e00c0d0 ]

Disable FW_OK flag while flashing Firmware. This will help to fix any
potential mailbox timeouts during Firmware flash.

Grab new devlog parameters after Firmware restart. When we FLASH new
Firmware onto an adapter, the new Firmware may have the Firmware Device Log
located at a different memory address or have a different size for it.

Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ether=
net/chelsio/cxgb4/t4_hw.c
index 6fd3be69ff21..24d391899730 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -6185,13 +6185,18 @@ int t4_fw_upgrade(struct adapter *adap, unsigned in=
t mbox,
 	if (!t4_fw_matches_chip(adap, fw_hdr))
 		return -EINVAL;
=20
+	/* Disable FW_OK flag so that mbox commands with FW_OK flag set
+	 * wont be sent when we are flashing FW.
+	 */
+	adap->flags &=3D ~FW_OK;
+
 	ret =3D t4_fw_halt(adap, mbox, force);
 	if (ret < 0 && !force)
-		return ret;
+		goto out;
=20
 	ret =3D t4_load_fw(adap, fw_data, size);
 	if (ret < 0)
-		return ret;
+		goto out;
=20
 	/*
 	 * Older versions of the firmware don't understand the new
@@ -6202,7 +6207,17 @@ int t4_fw_upgrade(struct adapter *adap, unsigned int=
 mbox,
 	 * its header flags to see if it advertises the capability.
 	 */
 	reset =3D ((be32_to_cpu(fw_hdr->flags) & FW_HDR_FLAGS_RESET_HALT) =3D=3D =
0);
-	return t4_fw_restart(adap, mbox, reset);
+	ret =3D t4_fw_restart(adap, mbox, reset);
+
+	/* Grab potentially new Firmware Device Log parameters so we can see
+	 * how healthy the new Firmware is.  It's okay to contact the new
+	 * Firmware for these parameters even though, as far as it's
+	 * concerned, we've never said "HELLO" to it ...
+	 */
+	(void)t4_init_devlog_params(adap);
+out:
+	adap->flags |=3D FW_OK;
+	return ret;
 }
=20
 /**
--=20
2.14.1
