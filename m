Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261FCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCDC20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mRMV8Syl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCDC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeIGFZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:25:37 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:49926
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730902AbeIGFTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAed7ykxhruvljdNmGScbZfnEd9l2br332bl2TfNRCM=;
 b=mRMV8Syll1qbKislZyNviixSRmCEnC6nl9gbGQuuHIOePX5YLrB0CLmBSoOI9hlBz0pTBaf1dwciSur0GGNoB5sTyS8d+eO5IU3Vi5rbg+uE7u6U78u5z+s2iAfq6uBwF6xmdEhdCwJ5KTf2r7ntGxbpV50KaYYsKWO4cPuhzbE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Loic Poulain <loic.poulain@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 35/43] arm64: dts: qcom: db410c: Fix Bluetooth LED
 trigger
Thread-Topic: [PATCH AUTOSEL 4.9 35/43] arm64: dts: qcom: db410c: Fix
 Bluetooth LED trigger
Thread-Index: AQHURkMhk4bRLqBx/0+Wx9LHn9QkYg==
Date:   Fri, 7 Sep 2018 00:38:43 +0000
Message-ID: <20180907003816.57852-35-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:HcP06wkEBAeFHJYtTeo+8U6Utz2BhX2qcZhbDW2sR36KUKL5EsnNyqjXvG26zm6mfQ6hYCz+gY6g5FPQzl0gWfB9xbtPydhHysZpKWKBKHqB6lTGBzwTgr2OT+FwdZ65adxyEm/IX98/GjLLO2Sb6byYf0PqN4CWhuJcrlY1XVeQPM97c2zsn21oDXFlY1iZ0XpTsnrC6l1w33lUuEjIbsRm+FlLjBDIuPVzleETg4F5OaFsNFynaEKSlw9eoCOAk/fj6PJPKn2Y8RP6rfs+vzL/BW0aI68hAYXj5LHyiPLdPcQBq1jYVweGOAe/2GiL/3L+0eLmDBCzAuL5wWz8BNZa3rEhTYML6m61omebTRCbwKUmUMtbiQ2VR2+w7XoaOUhonYXuTIO3TLCuc4/xXvYbQ8IYJJ/9aKTLiVl+wUAyeGR+mTM5fPdJOwzBtsVvMgkk60tz7mTHjUa5j2syNA==;5:dP36qAzvFXRgg6hK7JYpYw5f7tqhXPzSQ/ywpsfZ6V81CInQ9MmgTYoUavpGvP3GSdsBLKg8dRtQDE91AIjDMInkYB5piSb55+z/148nyyv/y5vqsMednpS6fPgjJB1lG9r2v/AYBKfzrM5srizWOxzqH7ge2vCUiozqeCx8MRY=;7:N0/EE/V9w9Raiq8wcNPtg4AG4v9H60X6OANI6NcU9mW6fcePVakG+BlkbnqRAv2oNzFxKX0/rySxitl3NwiSm4UTfJfBapXhLaFbpt5DHQm91KaDtzQ8Z3FsQqViDviRNnDgCNuzHlD1abxnjKzAHG3W1jxLi5m+N6eMTxALdDkD+2PgCJcPUCITQBqCGq30s+NST98Tk2fT6RJ+dTwX5A/l6cr3U5TzLj8VCpxFrxcVK5lkerL9JjuYRFJCBcjD
x-ms-office365-filtering-correlation-id: bd25d794-f5f1-4d63-a474-08d6145aa191
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB06940B1A4E6F6F7524550E3BFB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xMm+mII34Rf3e02HETc0KoYpYNRYlGQrx/WA52E30q5tuDiwRKe3OVNMQdALWiCI3v8/wLKZGTnIHV4eo9DkKYEYS51WB7hwtBy7Q1Kj1vY+TUvsw/mX/ey8ZuPUN/0bTXrDxH8lPlgQDy49OYR1u+DlIFCBOmCBFXZbIA6f/sa0tm/cFHkBISI3ycejKJ2hZQpg3vJLTrDucWlZNe4doQIYs2G/Yzbyosc9D8iv8N7vNLccxdFdOL0/5kbcrH0MHX7qrGdYAmoAJbxDUdXoXvTzjWtLwFOW1xRmUnYA4xoQyvz+pkeSckb6oypLhl3tMi9OLWpF9Nj6Z1OVg3mikrj2uTZ3ixLeY253itaIlRY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd25d794-f5f1-4d63-a474-08d6145aa191
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:43.3328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit e53db018315b7660bb7000a29e79faff2496c2c2 ]

Current LED trigger, 'bt', is not known/used by any existing driver.
Fix this by renaming it to 'bluetooth-power' trigger which is
controlled by the Bluetooth subsystem.

Fixes: 9943230c8860 ("arm64: dts: qcom: Add apq8016-sbc board LED's related=
 device nodes")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dt=
s/qcom/apq8016-sbc.dtsi
index bb062b547110..601be6127628 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -170,7 +170,7 @@
 			led@6 {
 				label =3D "apq8016-sbc:blue:bt";
 				gpios =3D <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger =3D "bt";
+				linux,default-trigger =3D "bluetooth-power";
 				default-state =3D "off";
 			};
 		};
--=20
2.17.1
