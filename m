Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC38C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD4A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NkVljp6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD4A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbeIGFPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:50 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:48060
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729381AbeIGFPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjWMGmOCWI0H50YofUzIIjeemSp1DxVORryk5G8GCAE=;
 b=NkVljp6XQUStF+8OW4BkMPHi3GtYi9K94apnvDxrqpePr5dMF1R9MJmu5FrDHMEKEfDSBUbTKmFvc/RHlYV01piF6SwCmfQ9cSqijmGCsE2LIut5GwQEcwFp9X/ZAysjWXrfoaByZh73DvYNvsSezsJI0BujbZuyDLByM3O9StQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:37:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 80/88] regulator: qcom_spmi: Use correct regmap
 when checking for error
Thread-Topic: [PATCH AUTOSEL 4.18 80/88] regulator: qcom_spmi: Use correct
 regmap when checking for error
Thread-Index: AQHURkLcK6vHpdBEXE6dIMEZt5PebQ==
Date:   Fri, 7 Sep 2018 00:36:48 +0000
Message-ID: <20180907003547.57567-80-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:IfhqkcdTvgle9zPdReNt2djP4FmdRj/xauOdFbOSEOb0x5MvoKa9rh0mOHZqViVMucglckATPRAflnPk/WtK/6l2gghS2+DZE2mdOxX5zoRt96mPLpo6NNcChgtbH5+X3M9U7g+CcmHd0IE0um5BZU226buLkGYsC/W5EnTqkF45x+Jg02Lc6epb4MQeVKHoOhtY+ADcG4/ucs7Wel3OKiEVEUiY/tIKkC/qL68/C9+5C3PPUO5nvusNN3HrKET2HfjTR1bRe8i9v3sGPANXk1W1+isFgRMwO7DgXVGuRCE8CvlAPOiTwfMrknLkisgNIfo4GXn4hX3E3u/dK2Wj7kmpq/DHTxnuUg7O8+i28jqL+sWx3zTcepY+Lb3ZeE59fjIw6eTciLDKOJpCNfMbYHnd/rIPXczkVzWH8tAxag9fjYbqJBa9TH0+xQ98/oVyw24dpNaVq+pZzeEfItM5DQ==;5:aBXDoSY6OKtpr6J4JC+bCd52Pz4GZ9nkCtvT8L+pgxvXKgNQs4OVQwTjXG0Zmy5R8/YZYkghngAwYGX2RrEUkob6hYZxX21wNzixyHNkwRUkCQg3ckztg3QaWHaOdJu9UXZ9RvRS3wbIxrdBX4FUTo5p7t8QC+jHaKX6n/ZFJog=;7:NGXIQN0tPvy69IRIQrqB9NhB5T/jtbiFI7ZxLe6ea1zEboUuAnHk3kYBMOkdGpfD2Bw90K9+UwXG9Ieyw+Fv6jgigVY5/SqTiwRPCYr8ZYr5eB1J5l1sFrAZzfLzONpfhP9/CmiS76fKcnau+Xwd6Be3OyD8R5cDHg5TwTsMA4yYjoAHNEGT85nVewORzPzvzr3YU8lf4xBLUAnFTXDjNkMpjZ5pHO164kzLKn7Ff4PC9b1R0WTmhiHtSz46C8WB
x-ms-office365-filtering-correlation-id: 23a0bd78-df7d-4fe1-2b54-08d6145a1c9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839D9FF9EB05930F508FDFDFB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: IuBZVj0PirLziWqT8hFXRoMmkyHuWXdkRK3t4y5XREx071wFgh9LXcTW7XzisaUNwVfIVopMb5n/IUAz7wuzKZCbxZ/xbE0M1jH2mkCkgpw064Xkp8Qur1gYMC381EKdTCXemgooxZGA1gvxt6D5XeKUKvKZCprYiQd8jin844ydWWNPHXTaSHE3u/z8F1Bxw8PRQefgJ0NLxRevKQFThuF2FkQdYN3hgLlNO29jHND/sFoleLrVVnwDdvKhhwr53S1wHEIagsVyjTJo7zWovbLwmPAWeTJgWsN8D+7X9+dA2JPyzQDVXhM6B+fr6LqRGk7cJBphs8ePXQ7WqLzZgiEeCXh7XFdKskG3GxGnF9M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a0bd78-df7d-4fe1-2b54-08d6145a1c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:48.3402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit 85046a15529606466bc778e1205f4cab8e3724d1 ]

Since we have just assigned saw_regmap, and since the error message
refers to saw_regmap, it feels safe to assume that it is saw_regmap,
and not regmap, that should be checked for errors.

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qc=
om_spmi-regulator.c
index 9817f1a75342..8d5cd624b4b8 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1774,7 +1774,7 @@ static int qcom_spmi_regulator_probe(struct platform_=
device *pdev)
 		syscon =3D of_parse_phandle(node, "qcom,saw-reg", 0);
 		saw_regmap =3D syscon_node_to_regmap(syscon);
 		of_node_put(syscon);
-		if (IS_ERR(regmap))
+		if (IS_ERR(saw_regmap))
 			dev_err(dev, "ERROR reading SAW regmap\n");
 	}
=20
--=20
2.17.1
