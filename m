Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CA8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2945A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="K/5qRN7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2945A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeIGFfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:35:22 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:3440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729344AbeIGFPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJp4mouTM+pNfvf7dZNf1Tie7v1G5lz/PLKUwEcKmVI=;
 b=K/5qRN7fdRv2LlmD32uYKb49fyTR3w4cm6YLRFcGP22DtnLMQl+9puYsbSfyP6LLWxpPX0qmkeOW2Hd5jDORxh4OiaWzdaKcQvIsXdPkP3sQpxclcGgDZfTagCFU1f90joCP/gt+ncf9c+yB6NHahC20G2UtL2eiRAwP2Q8atdg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 72/88] soc: qcom: smem: Correct check for global
 partition
Thread-Topic: [PATCH AUTOSEL 4.18 72/88] soc: qcom: smem: Correct check for
 global partition
Thread-Index: AQHURkLZXnfe7FAjfkiL3z6DtmZB/Q==
Date:   Fri, 7 Sep 2018 00:36:43 +0000
Message-ID: <20180907003547.57567-72-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:BsBR+9ZH4hwKq3kJxC5ytNTDeQn9DsuUuyTMKuACEp7bCXL3o2I7vmh4uVfmOIQr1ABZN141gte3Xl8jjDLScg2tN2vsTd/PVXj/skE4RLbtaP6xkshJdLQ7pDQufXUL59B5SR8ld2q5og9nlSrC6/4oIeVsVnGHSKs4OvmO8JIe4WTbR+/g/greyMRbNs6f1GTH0qzaWhmgG+xq+NbGEXHswX2WgHnVBvNRoCrFzbYMLdChgEv4UBmWke+ucp76X6FYTUEao5hkWjR084sB3NftCRs8UXmf40S2XzMA2hIFFEgBz3WmCSl8tLxBcrqarCElJnXDCxojpu2KGarxFdv2956HhURbBHGUR1Bl3qSDtFIrtUUibTVXodYBYB9D/VaPcw3Q8Yc52tyr5Z4H67PwqhRbJuzkW8fPVLCigbgSsR+YMTXo4FcKCzMsH77oySxlBv/6KdCj9RiaRUT1DQ==;5:NRsu63E+y2j7iDZ/v48eLYE6TwUW3FHt7HBZYAaSV/OzV9/yYGAgM8lJWKccz6BeIjHMD3eZh0t7YfDt7bxHI0mOiqFyh+T2VUn9fOzDJfHlVeDPeKMkgGZ9iIKeihNl+KIHsFGhLmAnSWvTLEkCQDC5ZlmMPswtxBtV8tRb5/Q=;7:kX4tO4V1DRb4Hn3nlzlTs43wn4LttWvBwvsNqBfDTMq2lm2XYu6cPKGHqBmnJ/JfYTR6WQv9s6xTRBcbmkbbCRJShZ+SrcTgv4VnvsUzwFJTMPmoD/NcXO03KgArU+to44g57yTJwDQuNpZbT7kMwO7y6/P590zrWW8IaYX/7ysjfeh62NtyespEan61VAGEIcamnLdbSTPxFdLxW296NgYJpz6XgO/r9oNTiprmtQY3XUttBKsDS7JVbublEIh6
x-ms-office365-filtering-correlation-id: 1ca80d88-064c-4eb0-374f-08d6145a1ad3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01189764B95D2881CBA05AD9FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5qxtiOBrYRULJ/Td4MTb6qd7NapKEL7/KTkAd/g8UTs+iQjwA7rJ8k6Bh4Ibu6gksBwSKuL/4xgj3un8Uz1cs7d2JlyGWOzt31FJM2pBEiAO4qSv7wH73itvqwGsQbAhJIvFCK6V77pw+vjDePmckx4rXE28IuJ4gA1aChUxDc9vMqzkuqVacA+cT2FFdb/y9bA0u9TKsDV37+RcFQ/xYSocDIJvC2LACJTcOpeYDqBE4l/PThu0+qlcjOjK6+RPsWrLxGRHSDqMuW+UutMxCE0lbVDlIaDe02kjQu8Qwf8qmoKzYrmBny3RWZPSmS8toTHjMHMpHOc9hmTh/yk/0KTJORhLVMjIx90WvRRZw6w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca80d88-064c-4eb0-374f-08d6145a1ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:43.0938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 0b65c59e3a5475895c93ea5f130597db16b8abf6 ]

The moved check for the global partition ended up in the wrong place and I
failed to spot this in my review. This moves it to the correct place.

Fixes: 11d2e7edac6a ("soc: qcom: smem: check sooner in qcom_smem_set_global=
_partition()")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/soc/qcom/smem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 70b2ee80d6bd..bf4bd71ab53f 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -364,11 +364,6 @@ static int qcom_smem_alloc_private(struct qcom_smem *s=
mem,
 	end =3D phdr_to_last_uncached_entry(phdr);
 	cached =3D phdr_to_last_cached_entry(phdr);
=20
-	if (smem->global_partition) {
-		dev_err(smem->dev, "Already found the global partition\n");
-		return -EINVAL;
-	}
-
 	while (hdr < end) {
 		if (hdr->canary !=3D SMEM_PRIVATE_CANARY)
 			goto bad_canary;
@@ -736,6 +731,11 @@ static int qcom_smem_set_global_partition(struct qcom_=
smem *smem)
 	bool found =3D false;
 	int i;
=20
+	if (smem->global_partition) {
+		dev_err(smem->dev, "Already found the global partition\n");
+		return -EINVAL;
+	}
+
 	ptable =3D qcom_smem_get_ptable(smem);
 	if (IS_ERR(ptable))
 		return PTR_ERR(ptable);
--=20
2.17.1
