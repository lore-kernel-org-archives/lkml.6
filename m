Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756038AbeDFOkY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:40:24 -0400
Received: from mail-he1eur01on0125.outbound.protection.outlook.com ([104.47.0.125]:45074
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755271AbeDFOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:40:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 1/3] ARM: PLT: Move struct plt_entries definition to header
Date: Fri,  6 Apr 2018 16:39:37 +0200
Message-Id: <20180406143939.14642-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180406143939.14642-1-alexander.sverdlin@nokia.com>
References: <20180406143939.14642-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: MAXPR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::28) To HE1PR0701MB2473.eurprd07.prod.outlook.com
 (2603:10a6:3:71::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d77253fb-6b4c-4bf1-ff43-08d59bcc50f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:HE1PR0701MB2473;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;3:Ld2X5PK4o1lPGL4WW3qc3WstONpmWDig0YItL//iiCZMtvh4PAPTp9KTspDFUIzQFOTu8w2cJWGWf3RPgdZkQtgPzkh805bg35h3sPcAekByO+ezU48bslhAVGaa9k7f3CLxatEl8oECjWOfpQn5jENU6VBST3YlE4QaGsvbK+ac31DkxkZ7yZKVyIJswLZF0jXnvRApreRxOfx2CPWVKb+iWxCTLp43e2eehEeDHD3Q5ks4S/hSkFmk/1rtGnjN;25:E3b8yrF+phZnlc5wJ5noSR8EYdoGIb4N3o/otCZRe4cHsA5uDlFrXk7Yn4K4SENHPhvbY/UciwnZC55jY86V/E5FWU/lvqucrh96QuK5JXJZi99kQG2vkzvto3y11CFSRO2b0OU1vj3D2q58hPNIfGx2fF/gLEp6puP7uDog3Q+/jl/zobQY4bXiw1HZBIq7Cb/oggtZgwlbBRMMJtvjDMUkKCG7luNjrde3oSDr0zmKUip2n8b6RQuR+jhqsf4L/2ZJwecQigNIwTz9IoMT0ucBtaf6O6S0bhKCZKeYEAVg1ASNGO4AeK4FbtoPl1L9+5lWwKjtjCMAu32/AH+muA==;31:0gLdrGXQk+uHSpTzkyiqme1GEDNkJ2cPGldpCxML9D+sz+LQVnjYe6qKvXHgEN+by8aJLhwOqgORxJYiiQSfa2zF2RcJvrT8sQtLwvF9Y5gtlU7YTfVpzFqUmZvUfEVbeJoyWkhM1b+xBBgsl339j1dbh8A82x0wSY9MxRmakbiERJduKajvvNSXGnSpbByquUOwXuvTDBlmmjONm9A6g8ex8lVUMIHkiT9JS82I8No=
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2473:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;20:Fvnm9kIWmXKWS08xx6cOZNaBhYZahzvLklVUvprRFLS1alaRKVj4bMk7v7SI6H8eeSOqflUubX+4KHu//hVs3L1cYcE8qa1JwxJ7679rJ3skRvnx0ZFhDcf9ITBzQ0JnQt5l36fz6+7KeHPeND5FLGM0U9RhKW4r0mb6Gr6BR6KaC+gpA2EKXe0ST5s44isMyZQMWVtbk0dVEY5U60nJdENpbxY1wuLJfkGyQtrS6ifdjR48JGszpkYMZ/NRyH6/scvdBgBWNy4pxdTc3/87MfH+x1CQAOFhxTlrlD9cQNy5J+OdMnkh8ZILkXEegpIuu1k7f8FOHyBgzudbQF06AwqziDrvIWT6LSUOZ7URg1U7O1XhDudQFh4xiQhKbDkU1OQfYdgcU4Jrbq3V0n0aprD2QmMwEU1lrxHacW2LN/2Fi6f/Pt1wFGZ4ZqSxl4Vl0KnbcFlOK2ACR52LzoT3eL03iLerf3mB9q4rftCiMfo7SqMs6A3TQkf2fRpq7xa/ODW+jQbu4F5guACsyEon7VNUVAjX+z82jZF0RQykqdT3XjHhSRTH1EaAESTvwdTRgUFzjwTgfebLZeNIDdj+ynixNV7tT2f/qsNvY/O9Koo=;4:rNLGH9sz31DfOrRJ/kb/qDammbUk6NeWGYU/65hw8n8RfrqBLq1Y8uf3MTAWhohxEZYBWKtRBMZ8W3BrDteDFlR/9EPZx2oTHvluXbUg9PR43JuHWcZ0+eCekGzBZKqdq/UriXH/L52gKotyjllbeeCHwDCPMJIFBZZj49Qjoy/TKSE+/UQMbKS87Fw09f3+EZIgOJQbwHci8jtAACFDXJZxjeeoBoYOnBd5zXEw/f+GVNsMb5y/yfRC3odcpIzYmJTQXu49MyUaldHGuKYDXmF73xTWkQRQGv/tkiNKVYujALEfOu01Q7XTCPg9SjcF
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2473A0F5A0EA9A791257604088BA0@HE1PR0701MB2473.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(11241501184)(806099)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0701MB2473;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2473;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(376002)(39380400002)(189003)(199004)(25786009)(446003)(4326008)(11346002)(956004)(97736004)(2616005)(476003)(26005)(186003)(16526019)(6666003)(47776003)(6916009)(2361001)(66066001)(7736002)(305945005)(5660300001)(486006)(8936002)(50226002)(81166006)(53936002)(3846002)(6116002)(8676002)(81156014)(106356001)(6512007)(105586002)(16586007)(316002)(6486002)(52116002)(51416003)(76176011)(2906002)(36756003)(68736007)(1076002)(575784001)(86362001)(54906003)(2351001)(48376002)(6506007)(50466002)(386003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2473;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0701MB2473;23:LN5e2H8RxE9cpppFL9b13eDdCv+IlJux2z9b8kW?=
 =?us-ascii?Q?2eQIgDffo2jJs7G5WXKqUhqyfAqjdlsleE6aWCkxyuLzS2CWJ9f5wUsx0Hmj?=
 =?us-ascii?Q?3TYVatRILJ+sMF1tDKqShP17Wu0k/U0S6WBX0KDfSUKMAzBv6mOvB9sVJx3m?=
 =?us-ascii?Q?9cGus3WMMQn0IsSEDL6kVQd7Je5tecojmbglOMEf2pn26/aPfLVSbQRuUNcz?=
 =?us-ascii?Q?24DBghpV5v2skZQXnLMuyf4VrW9Zt+ylsTZ05G+QmpFDu3ORQfn5EOsHhDBT?=
 =?us-ascii?Q?lVeAuv8/LSyafuZJhqpqJJ0y4PInZ59OX32ygRgCZaYc0mpNTfcp6WLxuntP?=
 =?us-ascii?Q?zDJdB3ABSxWpF5pFl7zdikLqep5g4oWPwQ/exHfc2SSaPFALV16JT4x0xxzF?=
 =?us-ascii?Q?ePMMl9ZUY+3wkP6e379st5Sv1EmCoR7wah2QuHH3EO8U5Z86oYJP24vKstVN?=
 =?us-ascii?Q?z6BqKHcamY1acNHZmlOjRv/NqbuNJHW53VIenyf+HU3+wB2SB1PyVBxBGjRv?=
 =?us-ascii?Q?HUJvn8PIoPDOH2ojxjhKkKN/67PKPxeocHtWhV0nEgHPIyj6M52npQP/dE8C?=
 =?us-ascii?Q?FRhvt5zKPgTIjYsWdotrH8BGq9qW2B71Pe3JnNRu5kYHaTQjTZzuKC40EaXI?=
 =?us-ascii?Q?Je6imA+qPKA+Lz8ZBHbMCF6NjuRw50EQtcZK7tcxzFHchO/HkUXNF2S/46Wv?=
 =?us-ascii?Q?f2beJZdWVps/KUpdkzmo591kkaIODOex7FZk+fXwzoIKB0bvqkdD/jbKRXkb?=
 =?us-ascii?Q?ZQv2OgwFNxQApTNfmmmKkWd5/CV/Un+p6SV9Py0SCzCS8FlxalAOd7eblrQ3?=
 =?us-ascii?Q?DgGWzXm5N+gkcshi74t1BW+OnbzUt7+VUPI1vbi/PVXPUP/cTK3LVh9Yzwi6?=
 =?us-ascii?Q?iul5gmTf4PXlvLjbigUlowtNQEicOQ3iJSdLgAAhFChevJUUuPorROm/fT/5?=
 =?us-ascii?Q?gfTyddHsKVS9WoPxC0/35R+9ne7EVv4PA51Z/UwvrfLkB2A6FWpiYzLdwYWs?=
 =?us-ascii?Q?DoUKg1+HidaO57zEo17m/FzvdST+uwSWT8uJKwNUG5DZI6xOaAheWY/D8bDX?=
 =?us-ascii?Q?hfgRaDWMEtBIQwtat3rVUvUgiSRQ0Wwy/LprisKGRkRHk8nEqwdCD0f+dqWd?=
 =?us-ascii?Q?xrUlAqD0M11Er1pkazDTjYcf2339Q/Xh5G5qiFeyx4f+cpLD6BKek54BYP80?=
 =?us-ascii?Q?CCoOTliKwFbKX76NroDw28ATJIRxjRoPmyPPo9XFP77lvEXXYoSLeWMF3YPs?=
 =?us-ascii?Q?h2o/rn5Anh/saZ77KX5sIKM7BFmXdZxePbuGBH/NB?=
X-Microsoft-Antispam-Message-Info: A6Zk1TiWvykxJkZPXv7UwdIsJr5SZiR/DhWi3RHPyMfDItmz8J4oLdzQg+H65m4cHx5K9yHZAiK4WEyJKOFRt3FNRna76cZpZf7x0AQ7eE99oxC+c6WJ9nNNMjKhlQ0BbGMAsx3AMxWT5Bha45xAzz/Kn4My8oqPPza2UAuBpYZl3xe2uzTvBl/IYnfKt2FXhAFdWY3Pm2zb7HrBqzK3nq8jZQzEHiyhAZxrNUefkDU=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;6:05saIQ5lGkDwEw9Yd4fNhJ6ZKiZl55wgdURfItDXoaGLqrjn9fxUwjgL+jkNEftnAXLXT1QfsvL7VcpzCCX1UOWFcrHHWerS7hZSxH8g177eT9Wth1ohEarYzXgjz5lqeZ8errMt7XXk2t8dJzuLWru+Cxi+O1BVR9j1pMAfH/mPCFJ47vecbNwfVFmkD5wZjnEtMSn0w3FUq/jm9FAiIq7uqt3rsOsKjipY9EuH2PJ90aTY4srtL2e3an/sVt3Yg9D2Km03Qk742/xoAbAAsTvR5xb7d/ZlT7RkC8jJlA9gctVjmY9I5Uu/uywqIVykAZSuNGl+Mt9nioSJXCiDLqcldwV1XrHAO4XbmHsNbfpPB9LAgkyTqKXqOIoacd/uHaPrX8gAyLa57SIKjAnH78iJ2FVSsr5UA4fNLIaHQB/v6wFQHDklm+gCzNxddm3AGATgW5TCO/YY8JB4aosaow==;5:htHVrI8UOJF1akTI0jx+L+JP4TSkHBTrjzLPEySDicXciT3oyqzVUP+XE5cHdDsDf3EBV6y0Ew2nOcfuy6mAC4c5BVedMuXKl6lXHO2OI16btR0ov91O0ojTd9JtBOuFyPaa40J8XTgxofw/jWHALAFqJRg7skwIKIGPjS4j3qc=;24:ZGq2LEMIxX8/45uZbHoWwrl4F9Lt2UhXHAiNMHSHH8nc5ytbZX3hyIXVCxtINXsvioz2ZI07wS821a8OYVyY3nYTRNa73kD7wM2Jnq66ZFM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;7:rv+eyC4Q5l+f803bTzhTXlkWDO7rnDH8Q/jr61QeyMVyT4xfHM1ti+Mbt9z/omTvLKVLI6NeKVQV6dwb91qS2wMHT/ZdQST5HbOKEcVBxKFurIwlnz4BtwsOm/frTxtUrJcRww7kpBo/MpFEzbIPpcrcBAnbINNZDvX6hgC9URbfvpM+r25BofEmsoWMUU7OFbs77WNdx1HIChMiICQDY6jASxjgz0jbz+EWuFOYtFzwvY3PlfOZ+k+TWN17CLjk
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 14:40:14.4741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77253fb-6b4c-4bf1-ff43-08d59bcc50f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2473
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, later it will be re-used in several files.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/module.h | 9 +++++++++
 arch/arm/kernel/module-plts.c | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 89ad059..6996405 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -19,6 +19,15 @@ enum {
 };
 #endif
 
+#define PLT_ENT_STRIDE		L1_CACHE_BYTES
+#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
+#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
+
+struct plt_entries {
+	u32	ldr[PLT_ENT_COUNT];
+	u32	lit[PLT_ENT_COUNT];
+};
+
 struct mod_plt_sec {
 	struct elf32_shdr	*plt;
 	int			plt_count;
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 3d0c2e4..f272711 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -14,10 +14,6 @@
 #include <asm/cache.h>
 #include <asm/opcodes.h>
 
-#define PLT_ENT_STRIDE		L1_CACHE_BYTES
-#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
-#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
-
 #ifdef CONFIG_THUMB2_KERNEL
 #define PLT_ENT_LDR		__opcode_to_mem_thumb32(0xf8dff000 | \
 							(PLT_ENT_STRIDE - 4))
@@ -26,11 +22,6 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
-struct plt_entries {
-	u32	ldr[PLT_ENT_COUNT];
-	u32	lit[PLT_ENT_COUNT];
-};
-
 static bool in_init(const struct module *mod, unsigned long loc)
 {
 	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
-- 
2.4.6
