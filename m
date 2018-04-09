Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240817-2-5759907963371000122
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240817; b=PApegIDgY6KtQOXkLAuz9g17nATnnb2mVksb2wXYZ9PDcZQoci
    H4exBOwpAd7RBB0Bhhtg2oC/mb8xyuYZjlo0guBE/Is2ONYJAmkc2fWy4cQaGISK
    sIYKyZdQWqS2fgrDfNFpR+83vszzSZoyHttKZdfO+Y+RtxOda5qaQ9Aiv/NtEtgC
    AanyB9Zd0UL8qkxcZ14kPwsut0m5vv8plFjWzkQBpLWJM0xo5Zlig3+LY+M/O/mJ
    Z/X3NWpQbpCDOu+gjC6F+/qIguhJupsmXq9o/InmLzwiFwPqv3eUuSOBvb4n4saw
    TgHcJAukSwvsliFvVsMvcvHgC1dp1Qv7XtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240817; bh=lMy1Rx8SR3
    C8GxJUxWOMR1BqgkHBF1BXY14XYTsrXeo=; b=TMEJjZ9trXaQVA2EA6WgEQFmJ4
    8NLaiPimxUwbfpcUb+nli5Abi4DqjjIJOwtgb+n3z8Sv0FQvmexw9VFRw5ezOAp+
    tJalGgbz2p86Fgr/1Kj6nzmBASpaaEkL1sdC69WqKVgkjRmODr9ZS+hS3NJC5ESX
    Qrx4Qi5Fgofr24XRVtOt6ykpNwvrTSMZCBYnUx5urtZKihcccZNI1YSEzJnHPf7k
    C27NErtytSQs8sCwfgQCBKR57m125D0IxjTl/MucCHrfbJkwFwjK3Tiw46BpF9v0
    atYmY1wGAGGrJoAWlryI5rceV9/JbpSLNv0KKzaK6VCbsb6WidoeX4nIiXQw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NbS2FBzv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NbS2FBzv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKeV2aYW/+Q/WuGhji32Nne5eA+POWl/UXTc8N9XwigiENwgtItONTUrHrbGU5+Nj1xuq7nK8KZT71Ryoa2qz2sNP1e5uX8A4Fx2BOcmf6ratLnEzsXD
    8pSS+YxSK87N21w8TD9FzjCqIZOeHxzKmFWEPEbtAgORSKUWorY/X2sRpkAF1S9QwCA23xI5Hil6k6LpmyNL/XsrkSAmx1V4vnsxdXzqtb2JplbOjWOcB7JZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=bp1g5Iz1D7c7guLF1_8A:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755954AbeDIC0l (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:26:41 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:61603
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753163AbeDIA3L (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lin Yun Sheng <linyunsheng@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 094/293] net/hns:bugfix of ethtool -t phy
 self_test
Thread-Topic: [PATCH AUTOSEL for 4.9 094/293] net/hns:bugfix of ethtool -t phy
 self_test
Thread-Index: AQHTz5kSmP4t9d1uLEe03Z80aaxvCw==
Date: Mon, 9 Apr 2018 00:24:07 +0000
Message-ID: <20180409002239.163177-94-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:yokSKvEl0vuk6xoOWnlRhUz8OOvFYw7cu3OJ2dqNmsVlf0Wr/QQ0Sz9/0OX/5TiJPl4bi1RhWTxVfQ5hm5z5lyw8Vuakm2kaB6E97LWggsj9KIPxi2mN0B2Fl/WTdOs2Gsw4R4mAz+XTh6i8iieth41b9g3uXcWKiXqIT3n+wPyybyTL6qejtK7OybH5k6u4VDD8V8IKNHZe8apH01VEHhqO2Lzae+EyXZAKCusp1njzjaehpIB4OJsRGEyLiqqn;20:960XV3Tv+6zoTWc09krxGFwjAp+87+fISSiWSHWsAwr4PGwKlWEwBFQbY0pcbQDHyMDNYxa3b7YQAUSrXToSJ9mjri4HlawYXF1cYP9LQyS27Tx7N73qqezHXaSRCenTDxOy97YEN2IgYNNUrigS6H5ZF7cFKwCPaNPm0DZAHOM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d4011b8-c0ac-41f9-e575-08d59db0e91d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967B6599182791C70F74492FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(5660300001)(478600001)(8676002)(6512007)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: C6YtgsWrJuIAAsutiRYh51KKRNZ1ktynzWaFv7KYF+32iabXb4nqp/exWPAOVXPQWoMZiTBYT1cuiMdLHvn0+NDuvN3/mnhXJiXbhDizJT1s939fp2bbnTKhvazoAz45etfaid6KwvjQRact77aHCKspPlIXUFfUPZM1E93C9Wd1emz2lH4jBALWgVBjCcUy3C0RwDmC+kzFF1/lrWPZ5Qp/OznRIOZUcU6qgwRpO8HBrRjm8gp+n8Y82YlbOxcNcmjh3rqXMmwjRTXGevLf4NUQwwBT92Wd1Gg3BIwQoY9Gcpiq7Gu6XPqN2nFDZzy6TfLJbPcsE5OsO3kBzfTxsXH2NO7mnSja7ggrmLIXR2XufZ0gdILp6pUbFLsjU2UuSqTvX2uYura8Xyp+55SvYPecEBkZi7W6m3QkLfofd18=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4011b8-c0ac-41f9-e575-08d59db0e91d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:07.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lin Yun Sheng <linyunsheng@huawei.com>

[ Upstream commit 7fe5b914313ff67d71cb2b5aa4b850e0884e75dd ]

This patch fixes the phy loopback self_test failed issue. when
Marvell Phy Module is loaded, it will powerdown fiber when doing
phy loopback self test, which cause phy loopback self_test fail.

Signed-off-by: Lin Yun Sheng <linyunsheng@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net=
/ethernet/hisilicon/hns/hns_ethtool.c
index 86a496d71995..ea5f7bd14b80 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -288,9 +288,15 @@ static int hns_nic_config_phy_loopback(struct phy_devi=
ce *phy_dev, u8 en)
=20
 		/* Force 1000M Link, Default is 0x0200 */
 		phy_write(phy_dev, 7, 0x20C);
-		phy_write(phy_dev, HNS_PHY_PAGE_REG, 0);
=20
-		/* Enable PHY loop-back */
+		/* Powerup Fiber */
+		phy_write(phy_dev, HNS_PHY_PAGE_REG, 1);
+		val =3D phy_read(phy_dev, COPPER_CONTROL_REG);
+		val &=3D ~PHY_POWER_DOWN;
+		phy_write(phy_dev, COPPER_CONTROL_REG, val);
+
+		/* Enable Phy Loopback */
+		phy_write(phy_dev, HNS_PHY_PAGE_REG, 0);
 		val =3D phy_read(phy_dev, COPPER_CONTROL_REG);
 		val |=3D PHY_LOOP_BACK;
 		val &=3D ~PHY_POWER_DOWN;
@@ -299,6 +305,12 @@ static int hns_nic_config_phy_loopback(struct phy_devi=
ce *phy_dev, u8 en)
 		phy_write(phy_dev, HNS_PHY_PAGE_REG, 0xFA);
 		phy_write(phy_dev, 1, 0x400);
 		phy_write(phy_dev, 7, 0x200);
+
+		phy_write(phy_dev, HNS_PHY_PAGE_REG, 1);
+		val =3D phy_read(phy_dev, COPPER_CONTROL_REG);
+		val |=3D PHY_POWER_DOWN;
+		phy_write(phy_dev, COPPER_CONTROL_REG, val);
+
 		phy_write(phy_dev, HNS_PHY_PAGE_REG, 0);
 		phy_write(phy_dev, 9, 0xF00);
=20
--=20
2.15.1
