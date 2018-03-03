Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120809-2-5564427060233850689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120808; b=NVVuCTtctsovAO/rrW9KVp1ii4iml3aw5PUILW96SbrF0MU
    GpKpWyamnBAYKq9E/iTi+2p2YpddeLsuPSP2oSvURScrBLrj8/J4vYJ99dkNAtNN
    VtsHuaao0Zy/wJdxx9rSZFR0esOyUEJmXLdHaKPMjl/ihzfGCALMCgziUQ1BNIEB
    mvCWPqIciUVXDtjy6BHoajqtjfq+14MLJh9FODcgMclmHNxA07UICre1puoedWts
    /JE50ouZkoYn+B0/RrOTHVQmVI7aVVv17AIq2n5d+cSqxg4q8yPJKn7mdge+dLQD
    g6JtV5cm9vt+SEUfNUstIt/cgZKxRT2JVfwykCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120808; bh=XTeqwZ
    zqw1C9YjiKYqrbqYZnKyBeG6utEqaE1pmCkJY=; b=qTCIaGs688mV3qjjpJX7F2
    lyu3eBqffWRAHuMwmXHCFOmRMpJ5hZohSe50t1l+HPFWCjLhMWjUJwFDKhQsF1/i
    y4s9vSxO9vGgbmnW2Ly61YU8giRqc0+GPK09EaH5/f+SV68GrHvUj7rDwlHgUSW1
    4hyUTn7Wj8q+RtOLojyoEviWbLGH/xLYNWG5izakiW7Ient4jWydxz4Aps4onH0s
    dW6tv13u6obpPhQypUqi7hC3YfI6XfT+yf4zXv0/DrWkRpgqzig0WM/hZCXpv5W2
    TMR2Ixh9huvgsdp/QDEfiMpIYWwn+bHtgJQgnMhtQbmIuGktKQ5HzLWcVv7A39Kg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gPr+f8XL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gPr+f8XL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934211AbeCCXqO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:46:14 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:36491
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933745AbeCCWeI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 106/219] soc/tegra: Fix link errors with PMC
 disabled
Thread-Topic: [PATCH AUTOSEL for 4.9 106/219] soc/tegra: Fix link errors with
 PMC disabled
Thread-Index: AQHTsz8FzZ/0mX98MEapFnYkA+7s9Q==
Date: Sat, 3 Mar 2018 22:28:57 +0000
Message-ID: <20180303222716.26640-106-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:ZQcDyr0tKDAu30vjoRrGXwdXCdzRC0PEHwa1iKhd8bgI+hEKsmdEmMTbXpjk79b9Ue/wmIDY+YqZ0ybepooNpwCl3ZFHFD68EYzsLOhBfdPFx3gyAEdzMkSqXmUHmZx5DZ4X4zSkMQzEleMBwOHmYmxb9pCq5FtYoW6+o2nnF2Wtf7TPKd3QVFOvQ+Ds9SVDm7HsZMtBUu+me+KncktsAltACqmbxpTZe8wCGVnw0J8OLSzqQLX7EVvY4KP+9vq/
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d55e945-35ea-4acf-1d3a-08d58156de2b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065AC749DBE1A9DB403147DFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: vgLAMzLH2IBOKmFAs3vx1t+PHzAo3NFLGaLsFvIjK0QratAlN03rjgXTQirlXyExJDH697M9Uuh5ldvx6Z3IZtixugeZsAlOwsPW5bTJsEgCVso/MK3p/dU7KTy3hREIVPvz2JsXBurGKKfcFQAvb1j/8WQ1T5rRu7ZmeE8P5Ok=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d55e945-35ea-4acf-1d3a-08d58156de2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:57.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit bd737038d555468198495230f4233b9ba92e774c ]

With the new Tegra186 PMC driver merged, anything that relies on the previo=
us
PMC driver fails to link when that is disabled:

arch/arm/mach-tegra/pm.o: In function `tegra_pm_set':
pm.c:(.text.tegra_pm_set+0x3c): undefined reference to `tegra_pmc_enter_sus=
pend_mode'
arch/arm/mach-tegra/pm.o: In function `tegra_suspend_enter':
pm.c:(.text.tegra_suspend_enter+0x4): undefined reference to `tegra_pmc_get=
_suspend_mode'
arch/arm/mach-tegra/pm.o: In function `tegra_init_suspend':
pm.c:(.init.text+0x1c): undefined reference to `tegra_pmc_get_suspend_mode'
pm.c:(.init.text+0x74): undefined reference to `tegra_pmc_set_suspend_mode'

ERROR: tegra_powergate_sequence_power_up [drivers/ata/ahci_tegra.ko] undefi=
ned!
ERROR: tegra_powergate_power_off [drivers/ata/ahci_tegra.ko] undefined!

Making the definition depend on the presence of the driver makes it build
again, though that might not be the correct fix.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 854014236290 ("soc/tegra: Implement Tegra186 PMC support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/soc/tegra/pmc.h | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index e9e53473a63e..6d2fe5045b13 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -26,12 +26,6 @@
 struct clk;
 struct reset_control;
=20
-#ifdef CONFIG_PM_SLEEP
-enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
-void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
-void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
-#endif /* CONFIG_PM_SLEEP */
-
 #ifdef CONFIG_SMP
 bool tegra_pmc_cpu_is_powered(unsigned int cpuid);
 int tegra_pmc_cpu_power_on(unsigned int cpuid);
@@ -108,7 +102,7 @@ int tegra_pmc_cpu_remove_clamping(unsigned int cpuid);
 #define TEGRA_IO_RAIL_LVDS	57
 #define TEGRA_IO_RAIL_SYS_DDC	58
=20
-#ifdef CONFIG_ARCH_TEGRA
+#ifdef CONFIG_SOC_TEGRA_PMC
 int tegra_powergate_is_powered(unsigned int id);
 int tegra_powergate_power_on(unsigned int id);
 int tegra_powergate_power_off(unsigned int id);
@@ -120,6 +114,11 @@ int tegra_powergate_sequence_power_up(unsigned int id,=
 struct clk *clk,
=20
 int tegra_io_rail_power_on(unsigned int id);
 int tegra_io_rail_power_off(unsigned int id);
+
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
+void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
+
 #else
 static inline int tegra_powergate_is_powered(unsigned int id)
 {
@@ -157,6 +156,20 @@ static inline int tegra_io_rail_power_off(unsigned int=
 id)
 {
 	return -ENOSYS;
 }
-#endif /* CONFIG_ARCH_TEGRA */
+
+static inline enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
+{
+	return TEGRA_SUSPEND_NONE;
+}
+
+static inline void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode=
)
+{
+}
+
+static inline void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mo=
de)
+{
+}
+
+#endif /* CONFIG_SOC_TEGRA_PMC */
=20
 #endif /* __SOC_TEGRA_PMC_H__ */
--=20
2.14.1
