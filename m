Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30947C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AAD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XJ6Gecu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AAD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeIGFbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:31:44 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729848AbeIGFQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAjnW04jgH2BqmLKpxG2+OBMk9A2nv0artSXlZq9nS8=;
 b=XJ6Gecu+A4kGHhIRLT+qwJJXVmyNEZGqZkQWRrPlu8LoJqt4Uv7N9BGRDmYNVdQgAwprC9SUZVaAHAlwHs+F4el0S2adJEouG38WCB09y7JE+p+Owuean3R4MzFyeRqYMjMslaifMX7Qm/QEKo2mIW1seR/Vj/yl8ReZUXjgQKE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 27/67] ARM: exynos: Define EINT_WAKEUP_MASK
 registers for S5Pv210 and Exynos5433
Thread-Topic: [PATCH AUTOSEL 4.14 27/67] ARM: exynos: Define EINT_WAKEUP_MASK
 registers for S5Pv210 and Exynos5433
Thread-Index: AQHURkL6d2X1HVqgFkCEjeg9MUI49g==
Date:   Fri, 7 Sep 2018 00:37:38 +0000
Message-ID: <20180907003716.57737-27-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:E9dkSlM2+1cCFRYJjVJVi/72Ypn9Tlq7onOL+udsEiT392yoK+T6IzarsVOBkIYN7+VfLD+CyaES7UaeHmoJ7V6ktrxp2nYHndb73ElNVmtoWa3O1ajlq3H/fohmuA3YaJ6Ho5lVt+aQzTd5li8eXhLI6gkfaaDDVnPAFZPRSl8v8YYudXOn2ZlNnIdQ3E64l3R1XZ95SBRcXgTG00NIkbtACEqAGGgi3+wCtgy2ux+iapPJeQRMSlhyYb/njQWkhyXKBMDFtLIt7QiuV6c3oM5EkUqBjfRgYDI+UcktZDYj0lv/efmTsztdBEkJruhQ1p0L3ts21+0WNkz4xxO4xQHzmDtVSmk1nV0m0r7iNNalTkK87VclpsNlMbf7WyycCID8ttPz49RX2QhIUBM8/b+vC0QAS1IMayKKNPYrEzxwrJiRBW1rmvDtETSRyIQqPNQT1S+g543yu3SaorN2xA==;5:ql06kxRhWeG8ICPMTcRUQZG8LXccIp3yDpTAXYnUtMOSXHd1xQuKw1pEqCrR/+swp30VarM3isiATPe+2gwEB3vJnTb8xin49VktSr6tGhH8ZaagzvL85xNfV/pMdKYHclmdV53JI37wQIp7anPkJRum2qzSQeZgAvapXNfjVWk=;7:Wc9dpwr7J2EwahSZd385ZhjzeOP2uKfc/OtDQRXpLsCx01hJY07IObFbC4H6ln0lrRRYl+186R5nlLMOU5vRd4jaXAzYBO8mKzJh2c93G8Flmg5AVZZDQqUJ+DKsubhar60g9LUz3PxUmE1pZPst0EXw6IMLjyzGN/F5WUY0B5zeNPDyYe5ZPkHsGCFn42fNbmaKuFDJbqD0sk+57A605TmmXZ4Ug5nGNFBLwIriY7DrrYuTiTxRINLpQkLQbpcl
x-ms-office365-filtering-correlation-id: e868cda9-20fb-48ed-33a3-08d6145a3783
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840FC5ADC6840B534050131FB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(575784001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(39060400002)(256004)(14444005)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZK2BosKs0lakuLLfq2cw749Be9iELZpIwB8b2bzRTUn0uv0X5lsjWXSmsSHd3SP4hqwl6MEwDlYpfBpjxYjpdfMmhkM3KfF1BIoWxhSXq9Cyu9T0/NyFI6z60QE4OGFZgTrnWPyvnhpUUpHscGYczc8Vp7J88cAgfK50PeZFzxINqXwdgnlj4vVxPsHQ28GtcOqXFVq5Qpn3/G36UAeexcKGdY8PvQt5rAmh/At5r7OLErHRcR9tW2qhraeHKwdqDZf5grUl5R5rLBNAirRXeRqrexQXHcWZrBNWJfa20oH12waPjvVOrSzxctj9v8CLHpY8DzTr8+mJr9M3LkwxfqUWWg1BK1Q6TexuM08TUO4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e868cda9-20fb-48ed-33a3-08d6145a3783
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:38.7304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
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
index b529ba04ed16..a6a4ba334147 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -279,7 +279,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
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
index bebdde5dccd6..f248e7e079b7 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -46,7 +46,7 @@
 #define EXYNOS_SWRESET				0x0400
=20
 #define S5P_WAKEUP_STAT				0x0600
-#define S5P_EINT_WAKEUP_MASK			0x0604
+#define EXYNOS_EINT_WAKEUP_MASK			0x0604
 #define S5P_WAKEUP_MASK				0x0608
 #define S5P_WAKEUP_MASK2				0x0614
=20
@@ -184,6 +184,9 @@
 #define S5P_CORE_WAKEUP_FROM_LOCAL_CFG		(0x3 << 8)
 #define S5P_CORE_AUTOWAKEUP_EN			(1 << 31)
=20
+/* Only for S5Pv210 */
+#define S5PV210_EINT_WAKEUP_MASK	0xC004
+
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	0x1154
 #define S5P_CMU_RESET_LCD1_LOWPWR	0x1174
@@ -645,6 +648,7 @@
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
=20
 /* For EXYNOS5433 */
+#define EXYNOS5433_EINT_WAKEUP_MASK				(0x060C)
 #define EXYNOS5433_USBHOST30_PHY_CONTROL			(0x0728)
 #define EXYNOS5433_PAD_RETENTION_AUD_OPTION			(0x3028)
 #define EXYNOS5433_PAD_RETENTION_MMC2_OPTION			(0x30C8)
--=20
2.17.1
