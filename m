Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeCZGgP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:36:15 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:48357
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750981AbeCZGfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:35:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/4] x86/CPU: Rename intel_cacheinfo.c to cacheinfo.c
Date: Mon, 26 Mar 2018 01:35:15 -0500
Message-Id: <1522046116-22578-4-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) To DM2PR12MB0139.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03c3cbbc-433b-4358-c678-08d592e3cae9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:WK229qF83JXgmop4Q5MUCPKqUvrcEX66NUHHvtja3vdYzVorMuqZdn1VZot7IkNyGi1iI7PoOxvthubNPK0HvEO6DlLAPMa/KwH5oHi0G+0yFYLJRd1OORCj2flSHFeo3LMSOil4NKZbk2caJ8t9eaZ2Q5zEoXygUzqgTbSEjbb8tQnFCUyjUa2o+W6AaaLW43o/1tdGOFDzEASRYdzTbIAdZMcnab6dzWAylNnKTAFX1dYmz+EDoF4vi+AVibl8;25:+6Nu55kD5e0a0I8Kod6hm6rN1ZfwUezRNGwizulq8OASptkkjLQUwlidkv51OvU5/WpoQt+jfsibLTzMM4KWY6lDIPXEddUuyh6s9t6eX8PAMclaakaVhz6lZhXYlpxRhuVth2QsgLx8R/f41R7BIKAGDoTwUy4MLK5HsJJ8zfSQ9wirI9f2KQ9SHKZ+x5rCSVmM5R/Im22250vTebNZU4VLgEz+vcfUm1/4GWoYvaBeZTp2QUMb962UJZuxi1YQVCgzv8fX/pon44uEPNb85dJsHramdeCzyT9Wghk3A4NCMB+/R/BjDkIJ4DAXF0PIUHJYvdVSkQCnezksC0RIfA==;31:S6fuOF4U9XwhOS4+BNY6Pk4+A8CCnziU2k+GAyTkSl6P8TvF9xbVar/TPL6dz/NJ8WaGTkW2vhj5hGB0htODwm/wjY087+rofbEzng+IdIxvyD3/YlS4VuUJSO22YFDQqetYgu6zSmzHL8oZpm7mg/h6sczzC0eLmsZM093ISthIStjI7eZgITBQnJm3gJyq8knXNjIzz+/MGFPD+H6bEjSWJNJE3JlKhSF/oMqtdwc=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:WhPiXOQB+gAOLJWwaWOJMyqRwe4Fvb1ZynNpf3jWcvWX7cKtsFT3NflQk6cyMrUjeznNOblDlHj9g8yCqqfJMPWxIj6Pt7zO0xYQJ7LZhXMddPxEZxY05pIZSTviN4jLfiuIXBO/aSxgeviYgWRUrNqu6kuyYDcMKCquQ/KgAy8ww5ewwPcx2QIQ6C50B/qRm086Xyx/aALxlqHr1/RRWRvtY0ZQrEMsGYYJ7Qg/F/9S4h4bgP5SDNrmBzNoqFojAeA+BajJBDnwAbZMxFVpnrWzo6w0W44Q+UAhO+D8RPxUhh0KIvL9RQVJ+zXitUi0z48PCVIvM/bwKQgjv6k3wSMrBPQVICwVP8yjaZHG55YmcQpYELPvmGIdqbRgBCe3pIyN6JO0UmIeN+mK4CX/dj2yT8+OGF0vDqXmxh+1CWa4dxOHKoQG9s4izQ8xhEiIamQ+xOz+N+xsa/JDnYjTz6AYMaZC5ycqeUkogcBDqricublCEyMLBsnerM6Pp30H;4:is4WqMHijV5TnDf1qfw248HaHJHHvlHBWScqqyyT0A21XDZq3eXpJmWKOQxoTTFTOYfOfVRD0H2APIWzzpgYloe57Y4SEcNDM8HV/es7tQplVk3RT3BSjKCXuGsc245i1DjMmvHbLDfGXS6I40zS4Hjk33A+HMnvxH/xKgSTWY/CcDaTnI5r+yi/aAGu4y/mMkGhdMXCTZSClZ6BKhCf62V67rKRUAqLkcXJuNteKDzltZvpvPPUrKSNFqoQXG9msGKeL2ohe3qJeXnRHTLFj79rGWGozqkeTH1cjKodaIL5ZZndMYtLmjdAkEewZovM
X-Microsoft-Antispam-PRVS: <DM2PR12MB01391B28A9D034EB87DD9A84F3AD0@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(48376002)(76176011)(16526019)(6486002)(52116002)(316002)(186003)(47776003)(86362001)(3846002)(6116002)(106356001)(105586002)(53936002)(53416004)(68736007)(81156014)(81166006)(11346002)(478600001)(97736004)(8936002)(446003)(72206003)(8676002)(16586007)(956004)(6666003)(25786009)(7736002)(305945005)(50226002)(50466002)(386003)(4326008)(26005)(7696005)(51416003)(36756003)(59450400001)(66066001)(2906002)(5660300001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0139;23:2IoH4g1zt5t7n+dqxb9Ni/O6aeUlniBoepL7ZNNj7?=
 =?us-ascii?Q?VQH5P91IVuEnoF5NZ1j3xuT8oFrsxU2CPqqahTLuCcXKCa9IANqBWsc8GOHh?=
 =?us-ascii?Q?cBuA7aDLMXAGIe5FpjTaSTaiK/dbu4P5WS2bX90JZ70Iul9pruWi6nfQjvAY?=
 =?us-ascii?Q?AqbnLnpN4pLRQYEBXXmK/HqtmWJpLWpxgZEX960kiJ/PsbAkk9b1ykSnzgDQ?=
 =?us-ascii?Q?3QBTdPGkC1galDy8ANMxKhzCmoz12RoEV7nqZ/dwc8oqXb4zdHgU5Awdxwno?=
 =?us-ascii?Q?pMwI0MU8KQUu1heXcDFeUa7fovEbTKD+d82WPr6HLRRSVSSGdMAIkC7un07b?=
 =?us-ascii?Q?s3DUJKGGQW3gqfzyokAaGtVe3vSUABAvjCM6qDIYVucRHLdIrOAljIjDl5lX?=
 =?us-ascii?Q?fjm/GawoD347Lqx62wVCnstxTScYrp6qNym77ime2QCes/P8SxC6IpvaCAvt?=
 =?us-ascii?Q?5T0dZDeBuzsCD1wRStlmYcUhizg3SgER4CCNBsA/EfjqlkcKhiccu2QvYci2?=
 =?us-ascii?Q?coJMNa97LJsqy30za5s1ReYhM1iw/X6vhVro3VcfDS0pOimE90RhZv8dBP8f?=
 =?us-ascii?Q?PwxAdcHYQAWzyOtR71NBxPDbt4Nh7CtyXSo8sO+bT6Ptnftvfz6zecAWvrwc?=
 =?us-ascii?Q?7DHlbNgl1MDB0xJsjrcuAnBuk2OXCQw6D2sX9rF0S7BvlwEGovObXAdp1tiU?=
 =?us-ascii?Q?4QFhclz67CwE+vF2JZgvX2jQe3nIdf8/eZtFBVvinVRoPs6L9RJqoO1iUGi+?=
 =?us-ascii?Q?KIDYvELtE7zshJivNAXN9aMavl3FukIAGnYzRHNyt01+Ago3yfY7QOhEtH9R?=
 =?us-ascii?Q?3emIrmsL082sVGPIDkQuXn1vQxUl0aW3ASeiWzl5U469+X5yeDf1X9kUgDCx?=
 =?us-ascii?Q?qbm80npWgspwRD0LeCv4IGPonE/gMSUPJ2249mbpjss40bYZ6OGdu69inAo1?=
 =?us-ascii?Q?1GAZWtusZtwlqRmSS91QEtuOZAwaOKYt7KyXCwymJZtZWmV2GrA+HZfETyDz?=
 =?us-ascii?Q?3Z0X/IZN52OyYhqWhQRCeUDG/KOHoGuOOvuYVybJuz+HvPVUMn8LWyXk650g?=
 =?us-ascii?Q?ElKyGM0CqDD91L89ci6RFOMMFRPpSu/1QdQhUpE+o5RUwBibhl3Su5F3bjA1?=
 =?us-ascii?Q?gZvKV/wNtIewCNKAjoOd3cT4kyxWpoDaj8s93WeVMkN9uas8S7ujqaGIWx2Q?=
 =?us-ascii?Q?DmOVKWLLsQ8z0c=3D?=
X-Microsoft-Antispam-Message-Info: 2xI7jiP/mNV1Y0HGkGKMT1xM721lfqQq/y4FtG2V+ijNbNR5Wc02lsV0Jmqec1wd/lxM9U1KHHIvu727IxrDHb87osagkwtKKEtlhLCWyFcSijIAAaTcVPyhgpdbeSxrmYtzqqowExpR5qBHebNh+fh+Dj025NcyK/CcpFU0IFOeLfUQjSPlfeCXcFxGAFNu
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:NkRb+4rl8vAGh5kL9GN65LfJYwRoft/qC5qgcM3mfXkUCZjnsDh84ZykiXMP8klLbOuNgX1dmfsFKGItyAmp9AAJJxy0P/yNlGFQ5zAcV32M2NATKA6gGyJC6L9feM6kMYMYRb4TOJdybhpyVqnncLV1krvh0pgixOtZ3rzxlLiWYq/2gVRCI+4DkaR2j7Sj9TxeQY3m6pwgSI89VJWRbqiY7WexXJmEy/GOkx3qMSXH4y3Hfx/bYK8FCGv8zRNOKFftxThaz39hSbWN9cw/wvPr2ib9US0+EH/V4oiIEawv5DKn2bEkR/ZXfSpT00kOxNKGl9jjJIXKMWH7XCc3Kz2SM6L6HNBl3x+2A3FlPZY=;5:/d4d/a9E2VMO7fMOhY//JuPj2OMv6M790apfaXxewueYVejMyZpUdbQh3CAhqsuU2f6UwQqPIQsGQWrzM0Q8g4V6YVdgp+OjLtzgt3Epuabf8tUh/vFkprE00yzWmxg8i9eT3WvUq7s+uK88OqtB3rRBXgj6TlBAdp66cv26qtE=;24:qkjiIeCMKncYCwKRJfaK1s3GhXitDYnZRqDZH+BZEZ/iRbx35FNSHwZKHvOEsEniUknwUNwOkHOYPDshf5gy8IFBqZgnA/x+RbekCfPI+oI=;7:roSNbBHIqNUdke8afrDg2phrOls7ZrQNhZDSG3CZq/4/b/Jr3dYjn2sziXuNbLvUvyWTJ4NcTRofSHnDqu51sF6BGWb6X0g64gVhxKuvaAkhzEgK2kMdrZvIHwqQ0XZHyh5RT3Xb97VABD9bW3E+hUYLmeS2pMVLS5I7nVgjJlhzDFAKgFrPcNn0908Or69DmBCxLFrbt1Fh++Q/KGXgdkk8BVB4PWD8X8kiCPEkA8tNX+SiqQB0VpcuJlPCML4u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:cz+tch3Vgh16NlExDjyx3U8RwkIvIi+7pUN2sqCyD2vcYRIc02P3jL+XkMY/vFb9D4UauMnBumVvN5VVXRxl/LXL5af2adA04I+KDNjmWGumEnTo/8MXrMi5O+cQFWCOCjPkZ6haT96tdwBIbsajZS+VVRCXm19ATZ1vtXXFDl4WBtdDWiJJcvyIg8Nr1/xZWy269e6J12GQDp/zYXmpWiG1IsigV4eMjA5jZ4Z6D4Am0cRdfVHUDfkYmZD0/4xy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 06:35:39.4374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c3cbbc-433b-4358-c678-08d592e3cae9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Since this file contains general cache-related information for x86,
rename the file to a more appropriate name.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kernel/cpu/Makefile                           | 2 +-
 arch/x86/kernel/cpu/{intel_cacheinfo.c => cacheinfo.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/x86/kernel/cpu/{intel_cacheinfo.c => cacheinfo.c} (100%)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 570e8bb..32591f2 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -17,7 +17,7 @@ KCOV_INSTRUMENT_perf_event.o := n
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_common.o		:= $(nostackp)
 
-obj-y			:= intel_cacheinfo.o scattered.o topology.o
+obj-y			:= cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
diff --git a/arch/x86/kernel/cpu/intel_cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
similarity index 100%
rename from arch/x86/kernel/cpu/intel_cacheinfo.c
rename to arch/x86/kernel/cpu/cacheinfo.c
-- 
2.7.4
