Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5EBECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95C020866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GAtCJ5AM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95C020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeIOHC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:02:29 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:19456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728320AbeIOGta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlS8LnDML+2+fNahijfTEWVkByo9n+WcrhJ3VDmjUAE=;
 b=GAtCJ5AMWxjCA/6up0KTe3kd6Rf4xY3/D/J4jYpQr2LFDHTClom+AUwVPFY93mxke8JRG1VmqHaAcAx7ylSAuuf24e56Nbo7Lpx4RPimVmmZ7YxaHbOHD1mfTtImZ32reIN87WQvI1+BIOVCy0eB6YPgF8PpBuofKbi6P3Fei9I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 03/57] arm64: dts: uniphier: Add missing cooling
 device properties for CPUs
Thread-Topic: [PATCH AUTOSEL 4.14 03/57] arm64: dts: uniphier: Add missing
 cooling device properties for CPUs
Thread-Index: AQHUTJP2zKIw6mH1IE2rNdzqRCGssw==
Date:   Sat, 15 Sep 2018 01:32:28 +0000
Message-ID: <20180915013223.179909-3-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:n4ZToTsh9+FeMr6uDvivqctsq+ScHu7ssNJ0lgLfRosUtcAJ6MyeM9q7kCGWZEhrMYemgz+8x24F1PC7tkH/zP0nrsWEnQDaWEZwlkbKlzdSrx8cA+7hD9TtmWbf+GxpkoSKismmAXZQ3HuDL85rtID9lH8+//BBiE9ZESbj4qaQhqG7YpXy1Dnlot41B7gpo5JCMltgRdS7SXKnVGov5uwtmEyf5pjjKEOGuUBEurCmVM7Z9sxPQCtC+3rZ7B0NoEyOsnOT+o8HV0/vor9rqBLLg/28N27UQWuMONvzcHmEqSmMzqJ1wPV8WE5KQPR3RpyELN+TPVcxC8HZTzxKFk/Xs8Bep19vrPs3d+dXgROeyeDDigGjLa3j2x/j6Eb0tCyBIeedYRY4XDucI8Gfzb6GaNoOjNQFMPHHJ6O0ZszkitCuoQtr0U9FPSQ0BNoe0c5vOnrVpp/3rJVpgstz8Q==;5:DVZB8yJxQXmzVifYQiikXT55fN73ZYfUa3tYE6A1B9qxM1NCoF3IRgT0G7il4Y/aZ+npnPIUh+4VClj2KJT3CybU6FNzdBbVMRpMduTRtUeq4FeIvQSywZ8ZWm+y14u/j8stMIiGkVxFjp58/LNVxA///j2L7ufkK3zr6ffyKzk=;7:1pwHgtqcialFUw27CqVBSYvQXWRkvZdGNap4rMR1nJUaDBQDzh5J6eJCURqqVEmyuxVDCXhE4oTsG3ofD+bb6LPLa17vvr8QqN686tfx1TrFCd/cNVyrbTdoLRhU3TlBexF2zJSjGeo/f5R7OCP6vFtVdr7S5cJlQnDRvEotPwHPsRHF0AEywfTUNnMfXa2r7yzDlbn+VUWaFyLXcTuIC1ThmIat52N7RmQQigCJHFKvl1SC+mkvxFdB+TebnTt0
x-ms-office365-filtering-correlation-id: bd22a9a5-3a2c-4f88-53ca-08d61aab1935
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011761D0C88442D1CE12529CFB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(575784001)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y7rgor75pFEC22zKGD8Zkd4/pd3G1hyytcmUZl5pTNGfr5LCFAo17SlKVMrLsjB9cUvjCsy0+tDq/CaTpv1aQEmx5gsv7l9Z3AnH2lSvQiDtRLbf1nFykHD9qDC2F+V9bv61kl1g9/BYom0pR7JKG6asnRGILLYWms/DkRdJKWvGQieU7V8I9FiC6YvnDNVPY9B+2JMtGMEFSfxwnFNIKLPCzJ0wPk7tcnlqLFMrapyE4YKa8LVTGFsM9SCzRFM8+7LyJjnPICA7HsG3u3vG9M4FcPkSBd+jl1ZWkiaAbQ98T41p8FFMIqJhMxDJlaxXrm3HU3uOQxdO8QxojUKgU2BWPCz9krd5yuTokL49N0Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd22a9a5-3a2c-4f88-53ca-08d61aab1935
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:28.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit af0e09d0c6762e486b0eb5cc4737396964c34fad ]

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/=
boot/dts/socionext/uniphier-ld20.dtsi
index a29c279b6e8e..dba6f0ff8106 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -55,6 +55,7 @@
 			clocks =3D <&sys_clk 32>;
 			enable-method =3D "psci";
 			operating-points-v2 =3D <&cluster0_opp>;
+			#cooling-cells =3D <2>;
 		};
=20
 		cpu2: cpu@100 {
@@ -73,6 +74,7 @@
 			clocks =3D <&sys_clk 33>;
 			enable-method =3D "psci";
 			operating-points-v2 =3D <&cluster1_opp>;
+			#cooling-cells =3D <2>;
 		};
 	};
=20
--=20
2.17.1
