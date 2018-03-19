Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474452-2-319907167480366031
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
    t=1521474452; b=K6ZXFA9eN6U1Wha+TGxShJa3jh/YCnuySN3BOcx0z03Gxwl
    84TVQ/sXEaRABQtSvPKgoNeEFMjtuRbqUpDPYaagZmiUH/Sdr35EJN3Noz+u8wzh
    adJUeHdOyRIEo8KaAZwEY+iuPnOeVqdICjUf7ykvOW9O68y/plwf1NBQmnv3NgWH
    yPPxoxKMR4I74A6IzewNO9CkUFq0lnKKhUcldbH8HbveA4/T7rglR49neMBDhXdp
    Jg8M4LcV7HQSXlE+hNgl1HOwdF3VxorFh6cUYcjoByTKUNkf3GQ9pVXBd/aFTPb3
    h1uEdxx15psBbbjwbVBVolWf0AXhErbxmtr3vUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474452; bh=WTpJM7
    PJ41R+sdlpTRgoiRqub7yEydE/M74x4QHFbeo=; b=BdZTJJX10Do48BL/Vcqd7s
    cCZFftgMOgRb6Vr28OuIK0Nlqxk/MPl+xXVyzgAvyW4QioL1Kegi8GwQyf0SEzd9
    5LewdtRSK3kqxhPAf4m0sEd+pMn4JuF9cpAq3fIY2sk3EJ71nH6Mu03Y1gFeV63A
    qj2bw33iIXu9wRrbmhYXsKUmJj+bhRMhDNWEKGDIGpgInL9Lc2RqGCMzelsbzjzg
    LKpCyGHXxaDiW7CjHd+Jo7frS2iX4Qt7Lj+Y0Ruc+adiG1e9n1mdu+Tiaub6AWQf
    dJ+6EpegQMzg3PhGldC4fM34PuownkyOLtDwMEqwyKur1hmw7FHiNZI03vIUI4jA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ctp6udjm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehiedunecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ctp6udjm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehiedunecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeCSPr0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:26 -0400
Received: from mail-cys01nam02on0128.outbound.protection.outlook.com ([104.47.37.128]:6976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932578AbeCSPrT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 014/124] net: hns3: fix for getting
 auto-negotiation state in hclge_get_autoneg
Thread-Topic: [PATCH AUTOSEL for 4.15 014/124] net: hns3: fix for getting
 auto-negotiation state in hclge_get_autoneg
Thread-Index: AQHTv5mMvxU06Y0p6EahUVaoFrFv/A==
Date: Mon, 19 Mar 2018 15:47:12 +0000
Message-ID: <20180319154645.11350-14-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:Mhl02+iG009m/7NasDebRN3yNjY5MnFfbaRVyDnjM4bDbTnbTc5xqkfW6r5rxVeWnXBHYr5NAoSmPqtLKKoJgGj6NIjmlvHV18QCapn5FTJA785seoGudaCCv483kM3+LKsc3zCC6aCCJOPiiUsm0qAipi97HXn34rWzcm+9SxSbtlI1Zw+Ke0SujCknlIwmo/LipAP4ODDvV3y+pmUrFSx7U1mEcjw4KdTGwUJ+e2JBYU2hmX21zvCVoShZ16j8;20:lbHfj9yIR4m0Zx0uFqyMneNSRVEBG/IOo7zdSLhrMVZyuiUkoQ09PWrbstMM8U+oyh7rK3EhDBABvubBx9sgNUXWC2xQbP1vYYTps59SWuKvONiDbsDwqs4Zzj84d4CWp864QzFZE77rxWh8/UkJjH0ti5lpey/QILgVjHj8oyU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7470cffe-c319-4783-0bd2-08d58db0aec6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013655AAD12F827DDAA723BFBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eWTdFyEj5XYvSRZ5JlQIqy15LmOpncUHIY7Cau2qpBYXIq11GLITBzNIJ79cniGu8P+A5FsYV9EIf0ETen4ShuTbbTLC+4qZ0AJurq8dmRoTfLICeFKkmW5j3lvfLfpDGSPeNllu3kHO89RxdPxlKnSB2aA+mPzTx/sC5lozcS7pbpNU7EHQAJEXXql4QCr5KuH3TDUZd48Pvo6sMOKDbyc9j4ilrmVpyuDGsSWYg+A45B6K2vRujhfaegOaDfH9ktSxHKXHpFHGXG8Q+BNyIyLU7V+Ft30ENCloxM3Svv2xwKXj2QZtomByLSE6ZEiFMUd3pIPtWWexPOCGhOCdBg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7470cffe-c319-4783-0bd2-08d58db0aec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:12.7507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fuyun Liang <liangfuyun1@huawei.com>

[ Upstream commit 27b5bf49f0924fd62d2b1ef8467b40773973da34 ]

When phy exists, we use the value of phydev.autoneg to represent the
auto-negotiation state of hardware. Otherwise, we use the value of
mac.autoneg to represent it.

This patch fixes for getting a error value of auto-negotiation state in
hclge_get_autoneg().

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibili=
ty Layer Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/driv=
ers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 59ed806a52c3..3a3c7fe50e13 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2189,6 +2189,10 @@ static int hclge_get_autoneg(struct hnae3_handle *ha=
ndle)
 {
 	struct hclge_vport *vport =3D hclge_get_vport(handle);
 	struct hclge_dev *hdev =3D vport->back;
+	struct phy_device *phydev =3D hdev->hw.mac.phydev;
+
+	if (phydev)
+		return phydev->autoneg;
=20
 	hclge_query_autoneg_result(hdev);
=20
--=20
2.14.1
