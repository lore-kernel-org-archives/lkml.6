Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCABC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF072083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XBXD8B/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF072083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbeIGFRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:17 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:33184
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730287AbeIGFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGcDzkYdxm42vJK3WhGWvJqcb7k4xrok5YCxVDFW46k=;
 b=XBXD8B/HSvUQknn7N+pF+IQLiXfAnmKDOIYEsFFARTBbMFObX3dHsrNoeENqCfL2fC6LSNLha+PgPUxwr/CNUqKx7LnTJ7hSW4WAkVrbGH0qlemGv3zYb+w8QQqEdhgpytgl+/WfSq3pFnfRIPr9rSS89iOIhWk8U8yLwpKl7IA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 49/67] wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to
 check return value of qe_muram_alloc
Thread-Topic: [PATCH AUTOSEL 4.14 49/67] wan/fsl_ucc_hdlc: use IS_ERR_VALUE()
 to check return value of qe_muram_alloc
Thread-Index: AQHURkMFGMal/SfGoEO3PuDQyNzMpw==
Date:   Fri, 7 Sep 2018 00:37:57 +0000
Message-ID: <20180907003716.57737-49-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:3QPc3h7yDkdSSyBJMTHmCckXwcIyTl2+xqomOX4UI40nMUiJ017f5nASv2eTEfsiv93/YeR+Fj/bJM0PQxl1Oae1QM75ZC0OyUoZkD7ZUerxv9By+RD8TFN/eWClFVLWsrVIL3r8stmDOZgoVhNx0qKop4SVQ0HFr6sMFmEwleMtE5jbsSq+u1kUz75X7EO4QqWgiyhaIXD3tJWEiqV2q/GB6GvzOAvjOkWHvxoyy1vRjsVFPqIopqYDj1nU178yepsPQz1rIiNcWLq69mWPEj3VVe5LcgdE5jjoQwlEkI487WxTQnybf7TA1QmUJCW5Iw7wpjpGsv2alEw1k2qGrkscgihm/uoHEgxPGAFwzcMuHGRKtve1lqV+a0g5RThpo474G9OaNjFfA5c+7EFLtBBJEvdt5+7oV4zEMGJrbADZHQPkuVEdvlZyZRNo/mztTunTTAoOxPdrw6SjvgyUew==;5:Fd4xEiG8qesuHsnt19HDkPvL9q+geTlYsFXcQTPU3LndrofLa2RV0bBvGa5dxnX1yY1Sqy7IQX92OHQH9t8b8Lrtqmm7m3gLRag7LI/YjsZR1COvtetfV2L0fuB3ogblm5SSZXuK7/X+Co/i4J1/CmkTShGdd3TG0vWbvqSLerc=;7:CyiZ3brOecnCDheXM1o0zZba3Dd7IonpI92rov88NxQRMti63rKgoNWHxa0d8117LX0XMafaL+HMOfadbxgxB0uTKG6tQ9gkjjT5CyILgWovbbPkhmH0FvxOQy11s7nVv1ibUEIHlY6bc+0C3NtjmuTTvtdlqzASe0JycKiS9hYI8EIHySBJtJWHyHVU6Q+kxq6o8UXteTEFx+O3kCwLK86JCRO77GrL21PufQgIznxGbZISWCD4dwTQ5yoCBSXz
x-ms-office365-filtering-correlation-id: 7c05ba33-8cdf-462c-13c0-08d6145a4fbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757D25ABEF05345E5E1684BFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: K5+ZY90OhnNbW7B7ID1rHPqhFXvblebZd6id44ui0zyyGHY8KqYfqAot2Au7fEh2XmcBJd1wlHZx8Ngue8uLMpLC2ABGtRNkGNhP1dIY8hasf5BT5MaeOSZNgQvvt44BkMFTCdL/ce9N60ZTNPQdZouCLUuSasgflu5Khe+Rw9Ohdloq1mK9z+6FvdcAW/ypz2HvOo3shhHOHzhcCvSzj37JT38U+ULZSIIIXM1xdQo4JswcAo+tr7lFlpG0r3uK3XjXwS1v1VR9dQvPER4Z00HdP/kKWY/5FiOuq18RUNnoPGpm+RYSEgF3GTkRxO4aXbiulod9B5/CmO/rzB0QqA+EzmQqYdUh/QRhqvdzivQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c05ba33-8cdf-462c-13c0-08d6145a4fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:57.6997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 33df76405b86..18b648648adb 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -192,7 +192,7 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	priv->ucc_pram_offset =3D qe_muram_alloc(sizeof(struct ucc_hdlc_param),
 				ALIGNMENT_OF_UCC_HDLC_PRAM);
=20
-	if (priv->ucc_pram_offset < 0) {
+	if (IS_ERR_VALUE(priv->ucc_pram_offset)) {
 		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
 		ret =3D -ENOMEM;
 		goto free_tx_bd;
@@ -228,14 +228,14 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
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
