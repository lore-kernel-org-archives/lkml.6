Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C15C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388BC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kQBphMzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388BC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbeIGFTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:30 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:20941
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730864AbeIGFT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFL4sOdNkukowlBhouIuCvwtqUUOGcrFjTbjs+Fp3QM=;
 b=kQBphMzF9KOrKNyLx9mbidixlyf0hpAeuPfs6L69WOb0j9NiKceXdhXTnSeqO0rkIAUOmbvpSN8s6lJQnqdbzBBXoYXarEYaUEzlIKP+6+LsVFKLu23LkVktqxr6q+Of5YRaf6UDJqmjewtKqjEo7rm6WEdCNpwj2GsIhP/4Oic=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 31/43] wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to
 check return value of qe_muram_alloc
Thread-Topic: [PATCH AUTOSEL 4.9 31/43] wan/fsl_ucc_hdlc: use IS_ERR_VALUE()
 to check return value of qe_muram_alloc
Thread-Index: AQHURkMf0r8Wo25E/keM5nlvSF8Zeg==
Date:   Fri, 7 Sep 2018 00:38:40 +0000
Message-ID: <20180907003816.57852-31-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:U/C25x2LGOKiwsRtZcomLgzvIJdJfb94c2T6qNZIHgsrbhBDlr6qdT3wD7ZE8N4qKFxbPfpd4mdWSypdeaGuWsdtx8sDMzcSH9RgsfsJyDqVncPyO5n2dKbCPiNRc7CbXq2iszmXuGQ3leGjXoCDkNZk9F8jfaHbPQ1NWlraZCNjZ/Q+O3IA62xg7jK2rOED/aHC66gP7ast9DsqUqjIuhIsK0Js40yYzegU+FcAKNxM6cMOrAtrUMGuT5+YdU1HUfkPcPEBTAv8sMOHLNCDEpS15Kdzgxjh7lm9m3iVkfP2tjHxfwtTUSX1NolNa9TjnxM4ClHb+KB3FSBAWgYWI6Rp/KA5EvZA4i9OYYVYcfci7nAvcHfAlVlWdnVL88ZLkYEB/kZ29Y/4/gcxtABodedL/mPvyLCjOCng/+CoQSwkut8rDquw63mgDRJT6nZDOHJPnzy1LSpkY2xcuqEHsQ==;5:gnuH2TmhvhbY5rzY4AiYSg5zQcZoK/BNyYcLs4nYStHWvAN3gu9ptxUbG76Xvkt9NJxCJGNUhQwSKQLYuHeAdiWSitCq3ZmAFJkgIvDbeCwVFFHy2HZmJ+z++S90H7Je6UA8fFbZpx7v90B37gAkHzmc635zUwSvv3A2ym+6vW0=;7:FB5VSOju2s8825LvnQvX6j5NMSggmFcZZDDhGQeck2T92xipj/JUqrGMXD407G6I9h+4U32a9bogxTSlkeTWRogedPA+cfixzfDpJVJNSbRBACNHaMKXX5G3eTisndh1bQwMCOKDId+oazjd4e9kJ/sGgpeCVwogKTHvUgXxm9Wgr320P7xm3fG2EF63YkIIUS/iyfVrr93EDpNd4O8pPGQQ81WBAV1ttcANyZ9KNm4mhanXKq1JpiLqt8xB6KoH
x-ms-office365-filtering-correlation-id: 169bca57-60c3-4f32-4bf4-08d6145aa089
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB0694FB78D03ECA3E28FC3332FB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(575784001)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: GF3c91ZdjFQsK96rS8oiANBRle5lp4lYgcyLmAgOI1EQBposQ7E+dBNTad6e5yciqYYkP2vdnMsMt5YuBsLJU5mZBOsaf7eVxg/TyGhpMwWJi8PoJdIYbtoEyX9ulKtxVTGdaL9yODdIa4/Zdnny+FG7+v23ym6GR2BNdAzPG0Il3AZ5xMm3xSpmojuREoiPRq5Px6pOPyFJV+F5z+4hA1yYXtOLuPIHSNJCVlCkPpuHj0iSRh8SRnVx63dHmrkj3C6jy50LhTevVk/qyn8fSVrHpFbJSdNqCzu8PXH61RJMjSdllBNRQyNOXim7bDzRDrWU6yFUJFj3JkaCLzQnDl1+Wg2qE8uvImbmzQ2gUbs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169bca57-60c3-4f32-4bf4-08d6145aa089
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:40.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit fd800f646402c0f85547166b59ca065175928b7b ]

qe_muram_alloc return a unsigned long integer,which should not
compared with zero. check it using IS_ERR_VALUE() to fix this.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.=
c
index a8bd68f252e9..7a62316c570d 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -161,7 +161,7 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	priv->ucc_pram_offset =3D qe_muram_alloc(sizeof(struct ucc_hdlc_param),
 				ALIGNMENT_OF_UCC_HDLC_PRAM);
=20
-	if (priv->ucc_pram_offset < 0) {
+	if (IS_ERR_VALUE(priv->ucc_pram_offset)) {
 		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
 		ret =3D -ENOMEM;
 		goto free_tx_bd;
@@ -197,14 +197,14 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
=20
 	/* Alloc riptr, tiptr */
 	riptr =3D qe_muram_alloc(32, 32);
-	if (riptr < 0) {
+	if (IS_ERR_VALUE(riptr)) {
 		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp =
data pointer\n");
 		ret =3D -ENOMEM;
 		goto free_tx_skbuff;
 	}
=20
 	tiptr =3D qe_muram_alloc(32, 32);
-	if (tiptr < 0) {
+	if (IS_ERR_VALUE(tiptr)) {
 		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp=
 data pointer\n");
 		ret =3D -ENOMEM;
 		goto free_riptr;
--=20
2.17.1
