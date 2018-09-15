Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C9ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1538A208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dir2nS99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1538A208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeIOGrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:17 -0400
Received: from mail-sn1nam01on0101.outbound.protection.outlook.com ([104.47.32.101]:52800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728330AbeIOGrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y65WCxWvNpwBDOdFR3cvEQFtmV1kC8nitmY3ay4uSs=;
 b=dir2nS99LY1XJKmEed5LyiVOwLFPJMFnBgvYkPfYOF0IotLs7b4gK9jqCBBiAp1xrKo6N2Vnvvcatksg9OwAwocxFMqWfzQxGhpNt0A8SNGMQLi+RyxG4pm1ho+MYcO0IFooY5yOF3AAkJNYrwYC8eP2nkchkzIWRfT1m9px2fg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 26/92] net: hns3: Fix for reset_level default
 assignment probelm
Thread-Topic: [PATCH AUTOSEL 4.18 26/92] net: hns3: Fix for reset_level
 default assignment probelm
Thread-Index: AQHUTJOj1HEbDu2pQE+QUvgoJuztDA==
Date:   Sat, 15 Sep 2018 01:30:08 +0000
Message-ID: <20180915012944.179481-26-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:/y0r67Gpdcab0g2kidEFpmhW9+6aRBeVOim2AZhJEZs9pYkI5/TKQujtjTN0sQTKnzBjVStmhcjnMzlcEaG3/W0RjLIRMZJz3BN9tIBFdNolnfLTkShdJmu+rOwJDDXui/qnOhOPxiwfysCb/SRM2OlsUqsljOYImKULdp9x6g+DV0HesXYjSnQbeOUO2EOsLXK2BSbrCdI1OwnsZUXXhp/59FNCn4AsHGdSyFEe34FkRtpmzRQWf3yfRPQ7YMoynyQi4O0wWOmetInZfnnr72qeehKO2/Of6v2PsgwPiVla93Uvb3H2LiMvo853hf/gBd8KyZKadC2qpNsX7AbW+Rm3RRr8fpMnr0SbTQg5hVjw362XxjOq8QizjbBjXTXMAOLJPJlNg+7lxfcytm+WMHlt6Xe0bx6VwZhyBg0B81hijq2C3XJtgLOA3s/mLpnASIkJz7Hd9dtMcQs5oyWJRw==;5:zu/KdLBawYJzqYdMm/NciusZuJwiQtgS+knKA8bVQzvnAKqGftZbHPtwbNT4Jumgxy5f7ConxDcGlkTfv69tI54CeH0WhNOyh2TwSEupvVNMqqFrBEMBpUPTVyQNWGMPD/tdhKrhxnwM8xTcrxLwies94op67WQrTXKTE9zi19w=;7:DuTa5SNWxdxbglmYXwLgWrVfH8WCUuW1RyRNLjBdNuryViEZFTpytdmr8bBWwdfHcnL1oR2hFNl9REMMJdAOHrIy5/J6ArzEXFKchd4qrr9Bce1v+hEZihasMjRkSSMClPOByhvywGFkwV5dYyXxTys38s1ks+vL46AykepUJd333h8gWPc1z45lNrhqbSopxtT67gxsNk7aOtoVsb3G8qeU6dfCR2nJVUe2/UMTilkqHkZnphib9yAHHcTeT2PA
x-ms-office365-filtering-correlation-id: 4f2a1247-7a4c-468b-68dd-08d61aaac5dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824D18627006F18D1A9E150FB180@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(1076002)(66066001)(22452003)(99286004)(102836004)(76176011)(2501003)(5250100002)(97736004)(54906003)(6116002)(186003)(3846002)(107886003)(25786009)(11346002)(6346003)(446003)(486006)(476003)(26005)(2616005)(5660300001)(10090500001)(86612001)(86362001)(36756003)(4326008)(217873002)(316002)(68736007)(110136005)(8936002)(81156014)(8676002)(2906002)(6436002)(14444005)(256004)(72206003)(7736002)(53936002)(2900100001)(478600001)(6512007)(81166006)(10290500003)(105586002)(305945005)(106356001)(6486002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: O7AK54mRVHw8pDAYzRGMBvIoi1HbT15kbOm9CkdRl85ObzEB0Towxh14F1FDrm5e35ZyT/4XCYj3cUQ10bOPQ4sfbLin8dIuZp2GlhcR5q3789NLHasTFrKGJosG2BUdTlMCpp0oPNGK6lxOe/WZzmWJFmdEeVcuQKB3oowdNhvMMd3O7uqRIseapJCkhLukuh+E9FWGdVFDNOI7LtqYj5nQ/kuLrOnQdyiypEMFd01joUuirOwYA+sCktx50WpG5cTDBqRIiUWuhtvvxqD/JWZB23lpIwF1dZ7g5wBxVXKIUsDEDw34CwJRGgjxl7TVzC7Lr2CS5uUoNlhPq9F0yDEga+fTvpdHh0yxQEACQ6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2a1247-7a4c-468b-68dd-08d61aaac5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:08.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 82b5321460005ac5d34996e17f5a51a4004a1e14 ]

handle->reset_level is assigned to HNAE3_NONE_RESET when client is
initialized, if a tx timeout happens right after initialization,
then handle->reset_level is not resetted to HNAE3_FUNC_RESET in
hclge_reset_event, which will cause reset event not properly
handled problem.

This patch fixes it by setting handle->reset_level properly when
client is initialized.

Fixes: 6d4c3981a8d8 ("net: hns3: Changes to make enet watchdog timeout func=
 common for PF/VF")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/=
ethernet/hisilicon/hns3/hns3_enet.c
index 25a73bb2e642..bcec3a779407 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3081,7 +3081,6 @@ static int hns3_client_init(struct hnae3_handle *hand=
le)
 	priv->dev =3D &pdev->dev;
 	priv->netdev =3D netdev;
 	priv->ae_handle =3D handle;
-	priv->ae_handle->reset_level =3D HNAE3_NONE_RESET;
 	priv->ae_handle->last_reset_time =3D jiffies;
 	priv->tx_timeout_count =3D 0;
=20
@@ -3102,6 +3101,11 @@ static int hns3_client_init(struct hnae3_handle *han=
dle)
 	/* Carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
=20
+	if (handle->flags & HNAE3_SUPPORT_VF)
+		handle->reset_level =3D HNAE3_VF_RESET;
+	else
+		handle->reset_level =3D HNAE3_FUNC_RESET;
+
 	ret =3D hns3_get_ring_config(priv);
 	if (ret) {
 		ret =3D -ENOMEM;
--=20
2.17.1
