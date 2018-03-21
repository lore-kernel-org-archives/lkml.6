Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeCUTOS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:14:18 -0400
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:23344
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752831AbeCUTNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:13:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de
Subject: [PATCH 3/3] EDAC/amd64: Add DIMM device type for Fam17h
Date: Wed, 21 Mar 2018 14:13:35 -0500
Message-Id: <20180321191335.7832-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
References: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:405:39::39) To DM5PR12MB1913.namprd12.prod.outlook.com
 (2603:10b6:3:10d::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f30aa080-8606-4a13-f355-08d58f5fe1f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1913;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;3:i6hm0C7HK1vFY4c+SBHkSmTcNOmt3UWrN9cYgeJnr9NgqlxoPX+L9bwEaoJXfvbL1bPF0ENyp5w9GYSvj8QIEiO+aHVd6N1XLgt4JXKtGE3pvebcGqSjron/JHe4FMyPevwrCMCOTD5tGz2pxGx+vQT6d+tDNcswMOJxicUmtqajpbKqqXcp3rXhmjlw33btNeDp4EfHa4qeGNucVHr7aV7P+Z+0yIbUw7FatlVEaqY0By1nlZf5ihmXZRUl1g27;25:jRrFj83wNVhnb4a4yBcyeggDa5jM1SGGybos6QcEegZ+n07jC5w5KAQr8Im3QV862wzHHFzIsMWGkn1cjk/FSRJrGDko0HCb+VprRtMpxRTbjfule8r93Dq6Om09eelxE0jDDB9JbYNn7SbyqYfz8LUId9h4g2p/ntydEGsT8OwDUhRdxpU/dWI+QSlQe+g+wuUEw5vEZd/Se+2wRgh/8gba5a8dz0s1UogMYIKLgY4c76xm6kOXJ8iuPfPFA1QK9XzLNa/pfdIzM+Pr8qrXgMzfaarnI7tT40J9HfRzIA9TlY98ze2d/heTT9zgLiKYOe0aIcA4kQ+zRWgA64TLNQ==;31:n87MFu3jhyjd7Hce5gwK9P8ySQjedKN+qNyTjQNYfG3Fo1Oe8s0ScMSYmX07A/4TKm2nxK6i0dh/30D33OBdJZDvsWsG/H1qcI2GNm3k4MFxtl9eC5nlERp26+46v9Q1S8HyN8jyVBIZ2XX4Cj8e7O/JHLm7uF+Lhh+XiXVMsrKUWeIV97h1DTe2iHuIMA1IdEl4okUpgCIgkNpPzTJ5dTMWCLTx/kufSagLCLU1ouM=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1913:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;20:+shAF9slcWOdDDgCpxWkrC0JOIONPNUBrO6YD6OdaOPrrVS7jcFVMzlU+5Mn2a5az6smOsiPx/BXMyudX82lnvsUUFrgF/HHQKdoOe8FPJ6Gu5dfVPqSoVLWIURS5pFD1MVCuzU3PbqarXMUHdos229HKWgPPEH6ON8J2EtaZZEgcFAShqH3EoGjepTXJRcf8w2tBSq663OVL5mATJhqU3RVo8XEy87zf+9NFagImH4PfdX1l7OhIAyA2VYW6kPIPwe4x7sHKD5YR5D2reX9LaarAPRBZ0BhrzFOvDFu2m0L3m6xDMEqh3RFRpeW6C2nBs494RpD7k063uoUM4UjkzLvsEL0tXy+a5AoOnzESHxYWhElvYKbGToBJ99MEOibUqrr+n2hKzi+gKm/cbVaV1+XVMMmimWwvsYbj0NqlcczDhdhb/ItfYSYA78zOrHNSiIG027L2XA6x2fsHQfzewNcwjXZQD1Uc/StVTDhoqJFwb2JA3mlwILX7LS6crm8;4:GByNbSvSmFOOTTrDPc6HETUrsYLYb3FpehoccycYH8pHL7LS9FxaIo1omGihMDgiX2SR2URltRis/IUjVUBBNZURS4xjWJhvQvqTq5p9AVMXjRS8aRaYQ61wXJfl0cs6DIxSVyQhY6CJLMgwvCjXVPM/NYUrkUc9Et6W+x/mvPzPfWaCpdEwtkIKSp1P7PzzJtHAEkXTWGyRmjVzzVgUeDzCbXZPH5Atm3D2EoBqwEc7lTFUHygUXqMdhO4703/qIwwzamxUp14s3wzSXhkkUzYNT3q5VfVq6wNj8i7LuaQ8fUS2W2ylnZN/oRy+b0QMy1MeZO4M3IV8Oy14KWmbUg==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1913FC4817DFA8D04E66070EF8AA0@DM5PR12MB1913.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501326)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1913;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1913;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(396003)(366004)(39860400002)(199004)(189003)(186003)(305945005)(8936002)(53936002)(50466002)(7736002)(2906002)(36756003)(5660300001)(105586002)(386003)(50226002)(25786009)(53416004)(97736004)(48376002)(72206003)(1076002)(2361001)(6486002)(3846002)(6116002)(86362001)(16586007)(316002)(26005)(478600001)(8676002)(6916009)(47776003)(106356001)(51416003)(2950100002)(16526019)(6666003)(66066001)(2351001)(76176011)(68736007)(4326008)(81166006)(81156014)(7696005)(52116002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1913;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1913;23:vmNVvYY8glnN857dwI9gGJpyPePhpIs3VnBjnpTFr?=
 =?us-ascii?Q?1E6wFxL8D1rP5WabOCfsFg9Pi5Jx7PZwodoWemianMdYMgM78jzuCSC3ckJk?=
 =?us-ascii?Q?dlP0uQSl1VHASG2d96ApGs4sZPmg21dBRtBlUBavhDPNmMuOUGubcC4yGxRC?=
 =?us-ascii?Q?FyMKLSjDBq+pM2/ea1AH3H/PHcH+JEw07LZ9hNvVWA+PtxUgFK4P7XShNcNP?=
 =?us-ascii?Q?fnefRqTF5BEuidD/CbX8DDkDIPXkQz3qaR6cL0H2HvdN8xYEo+BWZzyqw0Er?=
 =?us-ascii?Q?r/B6ibU2x7z+YSzKhQmKpZxt2vlR3dqcwFdQCi7gu/jQzzVWERq0zsiufmAj?=
 =?us-ascii?Q?JoROJ/Yoi5jFicR37MeReFCY7WOai/UtWRRKBPFgxvhANMg0UPuU3f6A5hAJ?=
 =?us-ascii?Q?V7vnLVZfPZgUiuaaaWAH+jZSfuETvmIvcVwYjgj3u7BwATp5xl0UX9QD/QPt?=
 =?us-ascii?Q?PBxKrLyX1axkI+llv6QFQQj4FCiQ2S/w1ZQZx3tgZXKzGkwaO2XtlQCNsEU2?=
 =?us-ascii?Q?zSvnxH/rouIvmYIeq+ewNCEs8iHvDa8yG8KR2oO7GTWddJti/xT1R58S+RPG?=
 =?us-ascii?Q?aqVODZOEul5Mdp4d03qrugta9r6gfZz2GH8dj9HkcEfalzNUWVk0yvPI0waC?=
 =?us-ascii?Q?74zbgLxxGeLNXXeYiQNwnsnuBZ8Y1TwGhqyvxMyfeRokKVdnX1PaPMSgwzty?=
 =?us-ascii?Q?WTxri0LsUuqVAsbFD6ZY5pr8Lz9xLxtRDQXoHL3vMsRCbaORFf6HIhHd1Hin?=
 =?us-ascii?Q?W5w7XRbLhRU7ZhsLY33v0MPvIbHkJIk13f6hfhGDtvHkEBfCXMtXt42uPirg?=
 =?us-ascii?Q?zPEU7XFjtiRREJAyaSECGwdBlbm0zgQimpE9DD1mVAZnSThQKNX1f4qwAqRU?=
 =?us-ascii?Q?/q87tX9E5V5keJplEzDTNSLXJBqBtK8EAisQ23ZQclItRSIo5Tp/7ayhoNaS?=
 =?us-ascii?Q?Mzskdw9HNU0n93+jiZB4opMqy/qeVURztiUXqSEzeJYQXvxDD3XfASOXI1SN?=
 =?us-ascii?Q?ocIZnMnAIAIy6AZ3Ei42BK1zlCJIW7q/c9NzdofS1ev9Lp+4wdkezDI2Sqby?=
 =?us-ascii?Q?RGqKuf2DvtC9HJ+oG2DuyfVhrOl8efK6w4fDW5v6OU1f4KNQ5SJDFEXA3S1L?=
 =?us-ascii?Q?ZRL43AP8TfUABff++jmwO2d82XvVcgzda1SYjM/0y5RtChwlPIiS5n84nwI2?=
 =?us-ascii?Q?v8HTZYvdswpUEkFsJGpxzWl0grud2WnJzKf?=
X-Microsoft-Antispam-Message-Info: 7xvAROJzbiXebhxGWFx770XCxTTOnu7IYL0+ardGCgFwuDba2FYbsZoOvFm/pxFt12cJAbcklcpIEHW7q+SjTImSqxLCSaimFZEGLPFfHP7ONNvHfgDlsWujcmihjLbe8fnovAERI4Gn5RNsImghJ40p3k5LWqW4FdazFCvrzoyMcTtQmkFTVqoIFHl5G5c7
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;6:KUaR6yXbOaAp32Oc8kXLaThSGIn4mmWsdzj+F6xsQOipkzhBu6K2dKVtI1gUcFjd+7aN9zq76BQ4g+Zlb9gXPqHLTe5pX7BQ34r+7X00Ze5yrEMxx1fNjf48ZC3BlzWFgzY7S2LrcVQxi3MSgyIrfe1lvLDd49sczJWSOo444XymhDmBQS2mtEYyyIPBA++WoBMn/jIT6GbOFPZxrRDbrWHqr9MrcUT4SzkiEQGoLGMrd+KF8rsNWXUx7KYfZYEWVdbG/CJ5iDg6UY7oYsVIF9rZJVYjlNCoFmQrHOijnkrpRH/a6sRqc72fUvu6eMhuEo3lKKzvuxqc1dmgwOZ5u4DIJMDbJAgMjcwRloNIhS8=;5:2jMBA8qLGvxoj+8M5bCpF2TGH67VWdRp4Yb5WFKxChL5oxFH0Bc44F0HbODPnQqwCx6cFVI/ICGH5iw/p8HxOef3Dn883JoSd36CU0JMEe5wt8kjmLb1x/H67exP9HStcNfxEH9/IQY+Q4bCe7E+0pdxhu0F7lrljoFo3Xv85eA=;24:H1RG2w/5Uj3nfHlB1LIhhLEAERFK2p3PpifvmbK15wNkdl2dGJPGuT5mg1cotOq9W5ijC3UR9hVybYsMsootZk6//YBd30KE6q9enSSkEmY=;7:VGODkWFZHuO0ZGYXYkwJL+f/JXEcVcXaZDSMbD7EQb96nlFV8iqfjE+ijBOhrKCYeNVjWVUwGruvaiRrIpgJGZ+o0UMozW52BQbosZFkOxH52WYQT2nRQ3k0U9LmvuEUq+C67MKiapXe0ZegZdWMzwt85RgpvXaQSMqcCacJTpa1tCrkcJk6Cc9+A6F38/9RkLJDxRUcT4CTqjiqYG2wmq7lg67vHDD3f3QcKdreAGNxX5fRq8iX1QSgSYyZD9dh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;20:SiAjHQxfMwmgeQHX0VLINWnOlgg9DOixhHgpNZpHM0lu1hkQ00K0AuJMXcIdNKqbvHijePTRHsGmgC37pdtuN6ouRZGRVbsO00IUBC0x/i65fyrXZUCJ5nJGBcMSF85XcP7uVFU+BwkTIDsugo2a1Wi7zxQSVU32vo0EISwsMfErJpxstOck0JSdJmK/yPdKNePsz9x076HGdWNA6xSsQjQf4GDtWTH7QGwEs9qZiEn8IM5BOQEv0eFC8wFDDQiw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 19:13:51.3203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30aa080-8606-4a13-f355-08d58f5fe1f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1913
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Set the DIMM device type for Fam17h.

Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 17 ++++++++++++++---
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 054086b19c6c..59d0085e4ffa 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -998,7 +998,7 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 
 static void determine_memory_type(struct amd64_pvt *pvt)
 {
-	u32 dram_ctrl, dcsm;
+	u32 dram_ctrl, dcsm, dimm_cfg;
 
 	switch (pvt->fam) {
 	case 0xf:
@@ -1046,12 +1046,22 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 		goto ddr3;
 
 	case 0x17:
-		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
+		dimm_cfg = pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg;
+
+		if (dimm_cfg & BIT(5))
 			pvt->dram_type = MEM_LRDDR4;
-		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
+		else if (dimm_cfg & BIT(4))
 			pvt->dram_type = MEM_RDDR4;
 		else
 			pvt->dram_type = MEM_DDR4;
+
+		if (dimm_cfg & BIT(7))
+			pvt->dev_type = DEV_X16;
+		else if (dimm_cfg & BIT(6))
+			pvt->dev_type = DEV_X4;
+		else
+			pvt->dev_type = DEV_UNKNOWN;
+
 		return;
 
 	default:
@@ -2855,6 +2865,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < pvt->channel_count; j++) {
 			dimm = csrow->channels[j]->dimm;
 			dimm->mtype = pvt->dram_type;
+			dimm->dtype = pvt->dev_type;
 			dimm->edac_mode = edac_mode;
 		}
 	}
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1d4b74e9a037..47696d3ce487 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -368,6 +368,7 @@ struct amd64_pvt {
 
 	/* cache the dram_type */
 	enum mem_type dram_type;
+	enum dev_type dev_type;
 
 	struct amd64_umc *umc;	/* UMC registers */
 };
-- 
2.14.1
