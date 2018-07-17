Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3254CECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11102075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sA/KGgoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11102075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbeGQMoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:44:13 -0400
Received: from mail-he1eur01on0057.outbound.protection.outlook.com ([104.47.0.57]:39680
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729659AbeGQMoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyvSXY7jG8wb0HtIVRcM8xUAsHdFiAGb75qMwQ1/beg=;
 b=sA/KGgoiYLY00S0FT9V2gzNdTRTJS3K+GLnnLdspkRxPqChFlQO3ZVsujhqKWTTA7Tu4kmqxlRRbWAAgLd0Kk9kmoImP7L9BkVSy9CqQy7uM3trf+NLtPvfr6VgnMdaFMiH+aXFSPz8LG6Hd7uzQo+csxfqxf9sVDoSOn4GzSys=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Tue, 17 Jul 2018 12:11:44 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Liu Ying <gnuiyl@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx: Remove unused field imx_drm_device.pipes
Date:   Tue, 17 Jul 2018 15:11:28 +0300
Message-Id: <69a927983d003e7ebfbd19cbc940c5e2a13b9473.1531828221.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR08CA0098.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::24) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 075c095c-7c70-412f-39ad-08d5ebde7704
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:4v9HSQhUdN62IKD+UEI1YZo0vAI/8VK6RiXLNHSSzMonFnZ7Nmgy3Ok/LjmrqTk/Q4lJGITBvl2rCaSWe2XSAGrwBml+NbpYsIdxuqffmHQi3w26Zf86YOoFAtOCrsr65n+va69HkJemqCBZp/V3KxrJL/SDY/b8YRejgpfVWNwPQ1Z3G5MMgH9/u5MUMzE/R3+nKUBOp92oMXL7TEaWc7MqFzMjUhS0ea3FrBC5I6W20dnIkIl5MtwB3OwB6Lpz;25:V5Btbg0h6AO1ArkN4RQse3kPA38tNWuy2bHXrl9Q/S/D6uUKrt9rbAlFjuZPIWH3tMYhegJO8z23k3Y9sSuHuAi6Mx+k3MibEnwubomMPMAnyaqJtIvs5qclV/GQaEIcG16HrtExdcntFmA9TvyLSH5qUeki+X9lz6CNVgcQfGW7OzpPmRgwJvBOj1V2v6y/4lsajI/4j5N1u8/nPs6sUlgEEofgvIX2nXVnj9uH095cp50r10aS/8DsyYGjuKJbW89bq82olQCWc7pNPPolCUMKDFdDnaTWkqCvcSbB0tmabqfNQ7XqJ9PxXM1jr6rZmxzbpbaAKCUpLoGz2DWA2g==;31:pEoNUyTz6s8hNQycQB2dzcuqDfbbzhWaF3qq45bt+maz0ujBw6Vr7CAeoSWEm1+R+9kxUgDtvjPVy22EOiwLXEgVq9TuUXRLIQTazOw6q0nSveWT/tKRkyX4eNTZnwP6PMlMepSb6eyZGJrUATxZEJNl/KxI+nisX1Mvgk4nzDf7VCVKcD7ZXsWipQ5oMbWfDdNNt0IWElT7ZjH7OXXKP2cuub3nLjmqR/WmwcAYNQ4=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:Xm2ZTpqrz98MVrdLOmkXsvRH8boQKtTpecKOXXoBVDMpWvN8JdtNE6txPXr+Z1CU0M+Rd/MuOKwnqar4NfmT7LGQANDzZOOnyQagrZJkpMTy1+qc0ACQVYDEI2EeQOZ86VzylEHvbya6MbBWIlDGX8W3l5XISSR7LcwhXYtF5/g8nZcAQI5B4fQKdWBGbgzwUCHebt2D4VG4X1BByAWuQeISlv6QTgTMJVtjTrvLz8ScXNPpG85zCfGeNj+SEDpYINXF9lEFQoqS0yG6D946UAcPv7W1OKNgzHm6FEkPz3c2Xi6IuJ30UAm3yCiLY2tSm4t8+GD8f/Ef+0amMysmhlXHz7i7ZM4nBtvBwA78nl4FaHpHZfsf4UkeB5/66K09H5HdkpS1nopJNsstaViszDoS3ew3mICxlYLHaECghAo6f8vxl+6fVQEFlWp3lQICUrTfmtOj5FciBiisma3C+QpJzE4uqWmAOkogSyTrbaPJSc/kTHSChNrnWkf9kVc+;4:h/Ez5O9IW71c+ZSLNvArf6KIYH3Qtmfzxdrcw6wPBXPugDIpETykN1+WpwVZ0nna2TFoDxYH/w2f9NQp6pzJJXfZHN1006rac9OWNzHpSUkRFjdFkztCuT/zJ1/wwKD/VzGIh3bqWiMc1dAoEZxXepc7ttzE9AWQx1UOjssyMx8w5j+uxUYiXSOFDOGj9tZZDG+blVE0DFpPkZawmkAkXeFxQcCJfP57hbasUiWwyVPgfD7YULjK4bEy1bpLHesYAkfT1IJG28vYK/DJySUD8YaDCqoAu18BcT+8owi3LyTonNcH/M/eIeIHaTvN/lpr
X-Microsoft-Antispam-PRVS: <AM0PR04MB42902E24967C7A16C053DC9EEE5C0@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(52116002)(6506007)(26005)(186003)(14444005)(7736002)(1857600001)(16526019)(86362001)(6512007)(478600001)(51416003)(8936002)(53936002)(386003)(2906002)(81166006)(81156014)(476003)(956004)(2616005)(6666003)(44832011)(8676002)(5660300001)(305945005)(486006)(39060400002)(110136005)(6116002)(54906003)(316002)(105586002)(97736004)(6486002)(3846002)(118296001)(68736007)(25786009)(16586007)(4326008)(47776003)(36756003)(50226002)(50466002)(48376002)(66066001)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:MZzaRMUMzLWeiAEiT2lEPts8kJb4YE7sUZw+D2L58?=
 =?us-ascii?Q?aInoiNdi+Mgp0sS2msOF5MAW3uH2RgJ84BKrX2guStfMb9EkxfD+igTthYCT?=
 =?us-ascii?Q?oYQaJYuO2deiQ9k/kZMh8UzNZ4H5FS0gDz249Rlx2MqHQn47qfyZwbsnKoQD?=
 =?us-ascii?Q?+gJH1Nm6q4Kof70tufVZ2L4DISrSMlCXZgwQsJHAs25L+aiaMM4hgfzN4HY+?=
 =?us-ascii?Q?N+n70X6jb7RxqlewMrJBDdPEKg0t3YDo+4nWZRYpZJVz+aKtN1MbCrDJ/Omy?=
 =?us-ascii?Q?tFtSpeUuykslLeI2hUnYG6ugZKrysKoTWXIGZgxac5RYrlhZcns038+/Q5/T?=
 =?us-ascii?Q?F0UNa1r9O5IbWmkOv15knkYawQ5uHZ27xgAtwvykzuRz2jK3jfg3K5x7Sma2?=
 =?us-ascii?Q?RyJNrbhp95owZSfDpRk5pigCWeglh+d+UcRYQZG9QQxqDgr3DZo+yhRZAviz?=
 =?us-ascii?Q?zyOkSyHuj2Kc4rIBufD6FZzyu4b5Qbmxj8PvUpR7mEXgHU5R7VgfUvtvFUFV?=
 =?us-ascii?Q?QwCcrzvdnj4w/yhCW9zR0ACqePkTsepAetRhbGG/2bSRFy4vbLeCbFqSFCKd?=
 =?us-ascii?Q?hnC5vzYy8EtUmUgnIcMmzi68bE9q5WYzsmcF5zUvZ5Mon9fLTqPHKuvIsUNv?=
 =?us-ascii?Q?7pMwhHf1ARC1xegtUUzm6n9N0LLxt/vPZke72XwzEnfILkbkl0tGXQ6SlRDy?=
 =?us-ascii?Q?r4r37GF+6KQ9oaoBjpv3AmZQm3/p1AjxC85ls97uuL7g3H/Y+IANyT5xFReg?=
 =?us-ascii?Q?Tgx9VLcd2+hsw5gCNz6r36iDn8LuiRBn92hPPg25X03eJ3muePX1rdSm97pv?=
 =?us-ascii?Q?8QACpeNJsTkn0ILrybMZHdgxY3RzAVJP9FRTzAeP6e7QVT7pMoon9Pde7l3y?=
 =?us-ascii?Q?25D6u+rj1ZTGGcasQCH4hBALso9GW2SPnyUN833HmXHOwQKTELKAx65gMG+o?=
 =?us-ascii?Q?/CyKLWXIR093Yh705RKzmxqpRn3bXAr1aBsKEb27Q/+cHNLf/eU4Nl6QD4MC?=
 =?us-ascii?Q?8vILR1J31+/7dMWXw8ovUR7LwddKMcTGQ3J6UNhX8CDDflsvl2boGm/28bAg?=
 =?us-ascii?Q?R/akGfyMUg/sCQYFibfyAzksdymxyT4NSQ/fdBHr/uuARWhTevopgObNhtpq?=
 =?us-ascii?Q?KJK7/GiOm92ufbRpzq855SEBrQPsdU5Ry7bC9T+qmGCGAduRC8gbOoc5575S?=
 =?us-ascii?Q?uK1B7UABwzVQykk+RBETwTwcMEJTyM1+yObh7Il93RAsj5QgQ1TW9Tu6CXSy?=
 =?us-ascii?Q?N9ktBY3RaH6esUT/vbd70aFEr6O5RCA8xhITLyl?=
X-Microsoft-Antispam-Message-Info: LJJKuChv2rsd3c78zto6uDOrQZYbZZ0ZUrG2jc9q6h5Hvb5zvn8WVxdlt8/Q0EAofEfU9Wjwsh5Y+72+v3i8bo8eY1FzfMzrD/Un6/vWLR/KPkbSmgAoDPHywRwiVAEQhz2Fh3cbOcljA4ArfyQm5wQMuEV4WiDhCarSPVLJAFSpSGmv4uOJCVwvQ2Syl99h2yDw7MPS5pV8YK6wG2s/kpEqxBaj4yYPuJSS/KRxBT8tdpI/SEI6RC5Nl4QT70X6E216/BRsHyZBUsUfWSc1ZfaguKPwPH/7fNAyxR8lt1ctaKNv+v+Ishxq3FdHBn4mBKkvT+cvi05pG1FPyhWl8KD1fhk+il5QbM93MSe2EoY=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:9k3ijFyu+yiHoP2v2HWWK6ycUuXSDCHEeBPidzOVfz4VArbStz3sYY+ZrnkjkXs18zXAclZdJ3eKAiz2MH80k5Y6b/hE7vaOd7nj/1BYAG7vO/GYyrkwQrE9aekhJvY7CnhWwmYFr8BGq2selmP1f6wwfpvCSi0Pt+y6msALSULyxJ6vec22mXbw2n0IDJ+EKHsXA1oFmDD2TGBLD3lC7WYuO+Qtw0Ljulkgtg+bZe/oFIe9Eq3QKK8OtAIlAG0/eN/MJF8Bb7VFulXtvbh0Flo4CS74w0rp+NIi7Ata+01cVOfwGrIoQrM1X9a3G5oTsgoy2I9qNl/+9PJU1UKYd72Ks4xBqt3/8MqQXoI8l+Bac+k7BHeL9cOXc5IWwshUZEuBh0hHECqz6yEkB/xeHwAYYGGEE77z0nMBE5w6P5NXAH0bgriTbJDY3V1/qoQ1HmVc1UQGiiqHMaRb8iNfPA==;5:tVE0flG8jBmam6QoWxFNnDF5FOKhvYJrnIYNPH6zXXOO1wqG4Ctqnm2SlF/LV04MHp51MkTfhfag2aWOYkWcYrWX7TKFhqmybKEjFYyZQ/Jy+E5PaInhCPOX/L0KoxPtJnewsw4tzx4nrEUa+pUanvtO3NNKrVcLBPiwfdUteKU=;24:MmWuQVtOgd/V9nXSBhSfAtroNhQfcT0PZojyOjHVQHVLXW7PGGdIY86yN9a7qVCgKc5TAX54H2FftZVPkWUUejSycr1v9WeM6ZBhInkOMRs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;7:7QvjtYo7aAzVMpDmgxq44MI3B/pa9bDJ3eNZzmQ6yssHgdd0ONzmwpOxmRgHgJGTAflWfzsPmVSDOFMuPivEulgmgdAyDjXiZ0RHW/Jzje09/b16asIkhDSAP6hKl5fN9oVGulHppgMInCTS6GkKxskF7oqMHH6UhGehSGK5CN6bmEod9gC1Nk7EUaa3q4exsrPNkASBNhvzh03i7qWqOA8aqORHYlPbEVS8+JYEks+HoKxaic0xY/1TZAF25Htt
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 12:11:44.8419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075c095c-7c70-412f-39ad-08d5ebde7704
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been unused since commit 44b460cfe554 ("drm: imx: remove struct
imx_drm_crtc and imx_drm_crtc_helper_funcs")

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 1 -
 1 file changed, 1 deletion(-)

Looking at the imx_drm_device struct it is only used to save the
drm_atomic_helper_suspend state. It seems like this could be replaced
with drm_mode_config_helper_suspend/resume and the entire struct
removed.

The only difference between imx_drm_suspend/resume and
drm_mode_config_helper_suspend/resume is that the latter also suspends
the fb_helper. This would be an improvement, right?

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 1d053bbefc02..7744e10f15b0 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -35,11 +35,10 @@
 
 #define MAX_CRTC	4
 
 struct imx_drm_device {
 	struct drm_device			*drm;
-	unsigned int				pipes;
 	struct drm_atomic_state			*state;
 };
 
 #if IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION)
 static int legacyfb_depth = 16;
-- 
2.17.1

