Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474453-2-18010501104543552100
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
    t=1521474452; b=wBJqMZ4B2m6cWkqrSiMztzmwxNQ/NsAxgVPGzW3aZNq1S0R
    UIR50NJPeX0bSHBTXbzRKmpjqkdQG8zlNavN7pK6LXSG+vUQ8VY9MWJZqCPJggkX
    9P/MKSn2KJY3M7emcLS+c+5QIf4XhuP94Kl03hbktQCRLHljJ1KUMGRlgse6hxni
    adRlVZLkEPS605CaW4+dfubI2aF/pb8wq9hvkQxbu9rQmwGXNAig/riAVVgU9pDI
    aycFiuh1+S7FRTvk2fXIkOJW2lPe8Jdxn9QhorjGNJJg2alwkgIjBdlNsUFPvZAC
    GLCDmbfy0J4jxY3gEVDIJJjvsL7SxIk4D7N832g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474452; bh=jINyyN
    MM5NXNTuAwU93X9SjJWa/krbf0FYK1YAERdBU=; b=kxgM3BRTzzIg9pv4n6T5pf
    6Fd3/mJDOwsrlrq+sgGsum1DLP40pkXzVAXzufTtjjO32u/iHjkp8ivXz7IejaRs
    njIlAIZ/wzNeKA79ojHEt9LDcKs3lNWp7XmJJAVNA4AI9vUh7Y4wBMiC5lsOC16s
    1hxNW4H7hzYR7r3pxqpPAEjCdIqc+0m4kMo2MaJUtauaFKuC+nHdSGuc1vM61Odg
    THyyn2Zm/JQ0b2YaMQKQcUBQOSluSxX2/fCdrwfglo9yPge+VsUJjBvZfLjNLAWX
    M0WqHvlbREncghHbn9ngyh4bjAbsbtexf461cwmy3G4FjFhAlPHkdmimhoBqOyXA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O7SlWX4x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegleeinecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O7SlWX4x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegleeinecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933371AbeCSPr3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:29 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933034AbeCSPrU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 015/124] net: hns3: add Asym Pause support to
 phy default features
Thread-Topic: [PATCH AUTOSEL for 4.15 015/124] net: hns3: add Asym Pause
 support to phy default features
Thread-Index: AQHTv5mNK/W+dm1Z8Uaqo3X96jIcDg==
Date: Mon, 19 Mar 2018 15:47:14 +0000
Message-ID: <20180319154645.11350-15-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:AX8YhLMtAm17au/yDOSlAZs+1NPp0XkZA1nKlQGqvke6daax6H7Tp5h0wGdg1N664gKkGjRZ/gRA8PRCTr4HDQiSOusALiecvQ9/kXkgSOMdhJ8pNMiJQEJYPSQpalAfvU8qq2nU0HGVkGVZ6Jw3PrvFxV90ZzwOPAuwk481qMv9kuGZGR4oo40ir6wip6ouF0GGTHbSjDnse8UlzSbnSDjL+Ty4ECLQqgRn+Nj18PRDSUVCCf3SMkMbtDItcJg4;20:/84o0CBisT7DYv1FNPDa25fk7SMWfzpSObnoY4Wu9S9hWjUplqUds16yM8KDYzasWvgDbjbjFoII/pj+MPoSemS+kxPcWBdX5wdyRWqR39Sr3hJWA5p7BRErHCN71ud1lsF8kcv2aPunPaqdVIs08e3UjoUiE7dfHvzF0ZaPdQU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c77f921-97e0-4f11-d624-08d58db0afad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013C430D205D13F66F2ED4BFBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0+fM/Q+SgG9J5ki/kwnr9Vs7VTF7piEGhP5e9vPb6srOgSYHtmv0dV08nTLKkFvWt5kKQ+g5Zqv80kO7tDuDYStYcVnrHT2KUZ2IhQQgOPw82xhUbyMIhjRNiPX/sGeJn7SnXQhLEsEyFMdhVPHTfFmEB+s4s/df81miozNZ1HWffVdgXqzyQK95y+/EGe0oiJvJyycCjasj9z5VDsiPbY+13jsamiI0Q0U71CUsawCVpcKQW6AkEB35CUjSC5Whvrq3e47Cl9z59dRoPcQgfOPEC4fkO8ovjt+HO0VXkp7wEtsAe+5upY0EWZS3T1qrMelmmNKLs00jPit3MdLl/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c77f921-97e0-4f11-d624-08d58db0afad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:14.2488
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

[ Upstream commit f16121c80c8ee4dab3c41363cb8b24f8d8eaf45f ]

commit c4fb2cdf575d ("net: hns3: fix a bug for phy supported feature
initialization") adds default supported features for phy, but our hardware
also supports Asym Pause. This patch adds Asym Pause support to phy
default features to prevent Asym Pause can not be advertised when the phy
negotiates flow control.

Fixes: c4fb2cdf575d ("net: hns3: fix a bug for phy supported feature initia=
lization")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/driv=
ers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 7069e9408d7d..22be638be40f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -17,6 +17,7 @@
 #define HCLGE_PHY_SUPPORTED_FEATURES	(SUPPORTED_Autoneg | \
 					 SUPPORTED_TP | \
 					 SUPPORTED_Pause | \
+					 SUPPORTED_Asym_Pause | \
 					 PHY_10BT_FEATURES | \
 					 PHY_100BT_FEATURES | \
 					 PHY_1000BT_FEATURES)
--=20
2.14.1
