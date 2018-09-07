Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F09C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A862083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i6aIhYXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A862083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbeIGFRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:23 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:33184
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729275AbeIGFRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfeU64utFURAg7znkVdwluCSUkjT4qVLq6HNDfKkQHU=;
 b=i6aIhYXTXzLK5kG5bAxpqQo1Lq7iKeGIe/2LKRJuvPuJqlUhOWHNXDuecNC1Fo8xipNbEJRPo7XJVf5/CMf0v8GirD63VF8sAI788uGmd0fzECopAvspdip6J0u06NCPFV3BJL1DcdemYSejhK9sus3yo7tEkltMs4qBaI/5EH4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Loic Poulain <loic.poulain@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 55/67] arm64: dts: qcom: db410c: Fix Bluetooth
 LED trigger
Thread-Topic: [PATCH AUTOSEL 4.14 55/67] arm64: dts: qcom: db410c: Fix
 Bluetooth LED trigger
Thread-Index: AQHURkMIgieTIq36AUa8l6CmXKiP3g==
Date:   Fri, 7 Sep 2018 00:38:01 +0000
Message-ID: <20180907003716.57737-55-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:VN1fgCxH6h+qTdy6pL8Cm27OZR/AlISGbUMkbqgN3jcp+t7mbU5tR+nPtyTLiIN1evrkI/p+H4upi1anM4xt+IQjnMnUOsrIax58aKGMf2PPMyi9TV6yu8bOm7D7ps6u8JK0osV8/Y07kDsJdkXPdIPUOmwKrfWJCoZI9USl/KpIsvBUGQmy8safLJpI4Gsztv75sBmxqcR/Uv/5y2btEsi5WV2N7H6wY39ey+Q7hO7o+jQlsfZ959XFpZRrzBju7WoWdYs0Z7UBeMV8NDXvQXL/w0gKxGwoBQK/gAZvOEoyuAYXle3HU6/XcLhnjo7szgmmzgHwlAQLhJWzbrmZJrL1oP+Ru1B4qPQVIvxr2sSyd9F1eiF4UfGjtDUbFHJfoLGhcP0jVeaU4Uv7zRQmNOirfURdIrOtO7PVEAnJLHP9C3Gq9zpiHUxda6K+wHFG13dKFN8QMucuz+nof8wBdQ==;5:pvNDtgv6/3WpHkyN6hk33R3FaJy7eT2LHhdEfMH/YGs6DZAtaUluv5YV6p67NKmGovPPo2L1X90/zWYhCdbbJ8eobnnSgT1EAYH2xsuVJM7SKsfecWwj7ARCN4ObuoY6qiHYPPTjyPhvGM4ggGA2VMXiD2ardxBKlMBvdn0Mz3g=;7:1CUoD/rj6kqeYLCNvKIDxjbn1FJiMn53VnC3xUmc/GXLP2ZkVxH2CzSNrPNyLg47iTMhc0aVLdd35mPgZ7FKqtSNikukOd+bYHfMFNx3dQR2kOhLs3HKOgUqTpojXVYsZ+iQWhnTdEX493m5Nm1zoPw7jQQ9+Z8qH1ZGk8+m1yoclXUuy6Yzn2W7+bbr0mDl7hBv69trW1VF8RIo2sJRaJ3xZrlmlceaRgSPUxZ6xbLS1ZMFw3i/w3S21FTl1yKi
x-ms-office365-filtering-correlation-id: 2ede9f2c-c7f5-4f2a-a3bb-08d6145a5158
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07574762BBF2171303551B1DFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pzbHlIHXeT9qsnXO+Eam8HT4JZdsJyGyk42hQXTnkIPSEZQmWfyaVhcHh1fhvWPwIvqK50rRa32umqF3tZXCH/sqgBLkA1vA7wOXhZ383IqDEB/kFNn9h3eNhpGYHqPD5uHUSNZmp7J8GrpNX6/1wyueueEKxgGb4VfbzQ8NcQf/FigFT66TS5AWmGCwn5OJaqbgOTG+a0ldUts0P9DQA1zDaROBv68GL3ZT41Q9/9pjGBCP177pooUYE+AMWP5rSvKK99JhiEfmQk2avRwQeQfD3dBTU71e2z41BvcYe3+NKp35MXE0/3IqJUfI+PnuyfrZT+sQFnOqaBGrlRr2HD33KCU482MSO9XwRqdbn4k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ede9f2c-c7f5-4f2a-a3bb-08d6145a5158
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:01.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 1d63e6b879de..b6b44fdf7fac 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -187,7 +187,7 @@
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
