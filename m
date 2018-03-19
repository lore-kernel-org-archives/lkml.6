Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521474897-2-11947613902589443106
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
    t=1521474897; b=DdLfkLXGCBDkF0pnOaLfrsqzZ6/HQ0rtALmgLioO9tylY/v
    ScqoYrEpmuV7nOJqwsvhGq3dyQpbfYNl1h/Jz1a0tneHHyupdZSgiapZhK6PytQA
    hEGUMcBupUKFheM+lrsvTxsuvGV/FWR/BGN1iFdoIosIP5BytKrqhNfkwQLA2iRc
    wSkPCGPqyqe+YbsBjCfdwRkqx31v89lsIacsamemR/O60XT9dI9wcIktvJ9UN8dh
    5txZklCCqmeP/OZinysRInjIFqHYPVAodN1nfe3XcPO5GUFYx8CxxH166wOzUiWf
    uw+O0OW6+pTr9J/yGwquunXV9CbhDp/Y9l4WJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474897; bh=iEBGG6
    5my9HsLORUSk7lUQymDFJiQ2Uzqlk/CF+rdj8=; b=XjJ2APsK/k64mHha7jnr3U
    JKc7hbkJ69q3SxmgkbbTZDFVq8MyqD0a1si0BIHVhRbtMh+IQR0SqJEXABWoH3hV
    c1zVut/M3shqRh55c2dXgGJPbXuruvBc3hLZsThpyxZRepoVYpkOuAlvSM4S8G9v
    h2jAgv6FSkzYf0/olOTy8Pwa5Jnk/vIpe0Jyj+0Wntbue287FQELNQr7wazJ5HNz
    mwFCCPfgTSVkAXjlW8JpVU/GeRIfuUS18XnlyF5EYwfNH5Q/wqEIZNLltsoG1S6V
    v3dVZENuImNdSN+D+AdhC5No/XBpWJCWZM1hYSy5pAiGijPvSqpo3bKvCv7GvhPQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UF5LoUPx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehvddunecuvehluhhsthgvrhfuihiivgepheei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UF5LoUPx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehvddunecuvehluhhsthgvrhfuihiivgepheei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbeCSPyx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:54:53 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:27808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934280AbeCSPyt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 13/97] net: hns3: fix for getting
 auto-negotiation state in hclge_get_autoneg
Thread-Topic: [PATCH AUTOSEL for 4.14 13/97] net: hns3: fix for getting
 auto-negotiation state in hclge_get_autoneg
Thread-Index: AQHTv5qUhSxFm0wZ8UizI56pC5w6EQ==
Date: Mon, 19 Mar 2018 15:54:36 +0000
Message-ID: <20180319155411.12348-13-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:bqxY1NQzHwTogH7RoACT2l9cJEfNozUdILIbu3A56ZLTBRKEdz0sRjHwZvhBG83JCt85HMiFzK4END6Tw7nmQgS95FRHC0vlKLSxOUdE6y2O269yiaF8bJFj+BG1bdfNTZVYONF/0ijXISXYgkOaCmIlycZxoUi6koZknDLcptYmCeL43LcBxnnao0aYBI00pO/AVrSoUWsLKPFvCKpzViWgF85eKLJkBmGTYO4PULc+dLgk+HdHj/FqoAgHheP9;20:NEd0AOf9yPN/JkSQZco3d/Utb3z/jexNSTinzB3uOkvkQk8JURBADRyXXCn9vouFKhzqQkjHFBrHmRBPq6azjdfZ82uBF9luJ3zZi5uYppHDjKrVXJDhjP/Ri7sW0LdgBfamR7+/YviQvoW5gOy8XZxY/kOpX9gRy7o3H5wlVz0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 464ce700-c2fa-4afa-6f67-08d58db1b76a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0903C6B9F57875BC0CB955A6FBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(8936002)(68736007)(6506007)(76176011)(14454004)(4326008)(2900100001)(3280700002)(25786009)(575784001)(86362001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: snO3AloCNtIFN0AYTWnMDNYdTcHBSQF7iacptcCXAkYqG9Exw8FzEDUgdbZz+uWcaG15bz6IomIdUoB5/71fUqgAff8EWO9T/PCqx1GWUnzxGFACd6M+755+e0b9M1Tjg+wfkzzXjH65RbwIjiHPfUedwT9bvrXLNDXX/sxNE07Ee7rQ7ovJxEIisiQySna/j38CgqTMpha7tUe9avi5ZZ3tuZrdDN+Y/5lcQQaTqLzlQUJ1QxwZlx/FooAlyyTDf7fDB4jkSX12Pt4str+rCHwxeNg0hRiQmC/QEwkOwqUkGqAPQHySWSyWNBDFZ+2UuQUCEhL1EZxTx51fja2BtA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464ce700-c2fa-4afa-6f67-08d58db1b76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:36.7215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
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
index a0ef97e7f3c9..ff7a70ffafc6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2092,6 +2092,10 @@ static int hclge_get_autoneg(struct hnae3_handle *ha=
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
