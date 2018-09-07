Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE75C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF342083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ObGRxyV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF342083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeIGFO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:58 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeIGFO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIg/ZAdP2wkjE/OmZNEbvWPDSOi9yjatXlfQgGH2S2g=;
 b=ObGRxyV7JgytYsFN2dJF4F28rz2xNuz4x4blMprf+FVGikDCyIhNObRyXZtZHxtPMxn3x0ulZa6TICub94/JEa4K/k+yoCkiMIYX5I1o5z8KfEQ6uja1ug5AzWBfS+fuchzspoyO/B39oIpPfMg2KDFbu6Let657rY5ieoFE2lA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 35/88] ARM: exynos: Define EINT_WAKEUP_MASK
 registers for S5Pv210 and Exynos5433
Thread-Topic: [PATCH AUTOSEL 4.18 35/88] ARM: exynos: Define EINT_WAKEUP_MASK
 registers for S5Pv210 and Exynos5433
Thread-Index: AQHURkLKSN5WBYj99kaTw5nmQlQptw==
Date:   Fri, 7 Sep 2018 00:36:17 +0000
Message-ID: <20180907003547.57567-35-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:bbbY7wgwGjUiRlDJgeeKSgEtUXt9STlxp3AM11wyCmiVq8N5FO986J+Aay47UPJbpU6H3dl5s26GlkLqReBDYeDC+KvqMjDrXGiXXqaBHTRvkWYMcFRxjYRL+NMMlKzrONOiEV9QFXXY2QMRGeMA1NtstDexVg6/B2aTbJNTZzWkJiyN1ueOM0F1lPzGlC+tzy9+FG8RFKfHO1pH9fi6AZvXtqgYQbEfhvtsIXu+99oI07qRLH90y1j0pPVqSS8ArAUs+hdxLW0pMMAJr79s2CRQ2TZ1fipnWaly0YeDLXIzxRSqxZpbcI9joTtFUO6XUnF8XiRlP63poRVQjA3eJK87RtS5yihejqhCAgWSSraf38NIn6Vc13qS+kqNhis324a1hwzIboSlYLtnxDAIB1jXmVrvplU780Q2BuckZYCo+wwfCzEko1QU6zbHHa9pO0Zei83+xGQmZCwxUf2b3g==;5:8nJV/uM8PE5Y9bov0zNwCn0JlIc+Thb4NmloQsEyajEjnG9cRFVmKqRtKp8poVVm3OTnhTy7e9Dnc3tdHiR1LIYwMoCtoKnyzRxcmqg+gh6hdN3B+bxTNrnNBYwDBYOpPUceXQ/BLNhnNkHvehIp3vVcbae3eWxloxZHAbLwtOs=;7:5l1QU1a8pFZHrqIoONOp8Tyf7EgFzKhwDWhYnsHF4g99qsliY5LiuvN6cq3HjmtuYFuzH3fiHBscmdXaiG9NwbMBCmDAPFAqrS+os3rBr+c3GJcAhYfH0QIoR877I5mhUKtPZCYMrxicy0v7nOjz+0lSx+s0/GqaIDCADQpj4ad+uR5hyvr6rqAkQoET8PpFYadhW2L25ZovKtgqrUnQLJ9/UvOZ6CPnFqflW4b2x0b4KVCzTdduQqht0+7Y3IV5
x-ms-office365-filtering-correlation-id: 9d7951c6-bab4-443b-9380-08d61459fddd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046925D06C9C754F6FB9075EFB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(39060400002)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KUqrkTP23nc3R/OfjU4YCyviOMtsJA2VduvFo4dfj+mr0MgvYCLiaIM8XTeraiNO7ksgcPplCnH2ZRAFrTuwQwOlExlsKsXXu51ENTeVUh9d59xkT1ZXRZj/n613l/uNRKDkuVNwD+LBW4Zb+AbKL0iH51dGsTVpf7Eu1S/2kOpX/s5VbQNbiX5cuWLGWcs7Y5SNiX0HZe7A/syU1OmR1gWcXPb4m6o8tCxDKzfiRckWZv6W+Xm0YhNQzvk/y1ibl653uhsRvY8w6C2bhrdbbg59+t/an9l4d4u1ju/B/zcsCAZAVgdnMbVZoosz3HV+U9I+5JjVhFLn011lzli2UhXJZdFDzfljayEYwOjjD/o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7951c6-bab4-443b-9380-08d61459fddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:17.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit e5cda42c16d89720c29678f51d95a119490ef7d8 ]

S5Pv210 and Exynos5433/Exynos7 have different address of
EINT_WAKEUP_MASK register.  Rename existing S5P_EINT_WAKEUP_MASK to
avoid confusion and add new ones.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-exynos/suspend.c              | 2 +-
 include/linux/soc/samsung/exynos-regs-pmu.h | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.=
c
index d3db306a5a70..f3384e3a675d 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -272,7 +272,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 static void exynos_pm_set_wakeup_mask(void)
 {
 	/* Set wake-up mask registers */
-	pmu_raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
+	pmu_raw_writel(exynos_get_eint_wake_mask(), EXYNOS_EINT_WAKEUP_MASK);
 	pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
 }
=20
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/so=
c/samsung/exynos-regs-pmu.h
index 66dcb9ec273a..eb0d240df7a7 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -42,7 +42,7 @@
 #define EXYNOS_SWRESET				0x0400
=20
 #define S5P_WAKEUP_STAT				0x0600
-#define S5P_EINT_WAKEUP_MASK			0x0604
+#define EXYNOS_EINT_WAKEUP_MASK			0x0604
 #define S5P_WAKEUP_MASK				0x0608
 #define S5P_WAKEUP_MASK2				0x0614
=20
@@ -180,6 +180,9 @@
 #define S5P_CORE_WAKEUP_FROM_LOCAL_CFG		(0x3 << 8)
 #define S5P_CORE_AUTOWAKEUP_EN			(1 << 31)
=20
+/* Only for S5Pv210 */
+#define S5PV210_EINT_WAKEUP_MASK	0xC004
+
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	0x1154
 #define S5P_CMU_RESET_LCD1_LOWPWR	0x1174
@@ -641,6 +644,7 @@
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
=20
 /* For EXYNOS5433 */
+#define EXYNOS5433_EINT_WAKEUP_MASK				(0x060C)
 #define EXYNOS5433_USBHOST30_PHY_CONTROL			(0x0728)
 #define EXYNOS5433_PAD_RETENTION_AUD_OPTION			(0x3028)
 #define EXYNOS5433_PAD_RETENTION_MMC2_OPTION			(0x30C8)
--=20
2.17.1
