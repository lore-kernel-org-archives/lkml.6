Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731FDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2253B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f9ntJooq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2253B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeIGFPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:45 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:3440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727799AbeIGFPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7QOV9LQq9In2/7nuSEyVfqjHhSEjHuRcd//JFQg8Ww=;
 b=f9ntJooq+vLDFf0oDysX3HS6V2Q0v5SizOWu/CcdUV6dg6ZlTiy5QsnDFoXVL5GXRvsSvXuIUG+A6wpK2FfsvUqwhnYpx7J0kerH1gspxS40nyV3IKtTw6OIA6kcLnLE81WGpdzO0yM0jamGi9ATkVZAeJOurs9O/pmHpYGXYbo=
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
CC:     Loic Poulain <loic.poulain@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 70/88] arm64: dts: qcom: db410c: Fix Bluetooth
 LED trigger
Thread-Topic: [PATCH AUTOSEL 4.18 70/88] arm64: dts: qcom: db410c: Fix
 Bluetooth LED trigger
Thread-Index: AQHURkLYpZxotgksUkOdJpokS7gG2A==
Date:   Fri, 7 Sep 2018 00:36:41 +0000
Message-ID: <20180907003547.57567-70-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:KEjZGw3kppFWnygkheylcEmh2pLm4JK8ICt7gL+5xvwjORTcnWUVyH+69SvmY91xKxq41VjZNz85MJsipUgs92iy0eTpdp41aFEsO2+JtwuAXOmXM5Ezc11eHvHy5lYNGGe7IyotDaYC7ANqVz1SWSjUNyo9+7wbdWT5enleAsLlbx1K2SQRMSnK/t98L7ditXpPrHnJFNOSDp7J6q750FzxLCuxJbcqrOleWop5M/2OcSqIdRQFLzx24ZwmYqiwpCzXA8wS/oDx7zFj/ZfbbpvBo0EbY/XL+cwzNPjkGi7VYzdPyNAycmDjEb46N+sBMvsPG/SXBziuqW6JSlLJRVr0JQKTzRMjVEY6JiTMGt9t18+9ADOHbuLh7lzMyK2UgSOjnon/Mhsi6j0ouEt10yxSLn/iUY8pnd4Hj4FEnrHakQdmVKzmaQlxFhd8I1krfLaThHywBjIfyqdnMJkshw==;5:TrhB7cpzPAvIcvhFglqCNo7J5LQaACBHozSyoT65BoegbHMTF/NQoA2uGqKKnjhITMFBq/y6yGh4fB3zpYco0/Bn3Y7GPv4cUqf28jnppsSI5T2Zjp/DV3hxtLX9OOxfmi2xgTnpmgMGU3kDQglisDBm66lakCUsNLYIO5QqSd8=;7:tLCwnzkqt573v8gI0tOLUIpJ73tGdgovtTmZh/ZeWXfAAG2dU0amkVmaC3keO/tr3RBQftkZIZ7v/Xk7+DATEAOFrW8YEA14ra8Wv0mpWOElT9clfnra9VRnhcK9a3nReCfpEgR22t1z65T03ATMs/gND7zMvVpGTr1JBQ86TOeGRihfDB2wrRPzuotL2C3vvtajYwDxkDCUsgbYvnsgNoph7K4Jf5oOd0bc0YbNKnmzvum7HBVMejUhEa8Gm/iE
x-ms-office365-filtering-correlation-id: b7ecc266-1f45-4501-aa51-08d6145a1a59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0118D191BB08A66C370329EFFB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JmQKoR4qNBuxVFbh2Cx1Y8UiLMt8rhfA2y1kxGQuIJZrkbGFlCSdFQ+j5n8YTL3hBWs46aSGdwWq92iSxZPQWEURhzrPc6+xZB70tm0+ftf2Qbh4rB8w9LOmyroONEQWsViojDJokr6rGBjPQfNqmWNA3AimMXbdNUBcr74SUTKUxPy9Ca2SKNkt47d5ThNLV/twnOYbTp6dDE0tB1RgrnNhEpBRf/pH+ZfQAt5iiFjTnHU02s1Ql6xqzY3+0LXNN54wvJrv7J5ToliCnUmlw7PhzIy9ov8OuyO7SXqNMIWOV4g3kfSsU3eXHcC/9iFTE7i67POBgskflIKFkO5X9sF7EKjP7Y5IL0j/2TguVsM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ecc266-1f45-4501-aa51-08d6145a1a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:41.8418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index 9ff848792712..78ce3979ef09 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -338,7 +338,7 @@
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
