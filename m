Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08474C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594922147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v4N00ssa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594922147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeHPWsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:48:47 -0400
Received: from mail-eopbgr720065.outbound.protection.outlook.com ([40.107.72.65]:54957
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbeHPWsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq2Aamcxv7P5E434g1D+leuriqwhrTjYZbqaa7nHP0o=;
 b=v4N00ssaM8dNMjA09hHPk6p4ZygCvG3g1uH759VjyxkrorGJJpsPOjPCv68NsvhoW/Pbqr/19ZaeGkTpQVvNK2wrPTOZeN8RqrDdOHxybOyBInlMTy8nlR+0TtlZuzG3gqlbO3VLVxcGFLWvZX0w9cd6nPH/PH2179C23wRNX1A=
Received: from BN6PR12CA0044.namprd12.prod.outlook.com (2603:10b6:405:70::30)
 by MWHPR1201MB2508.namprd12.prod.outlook.com (2603:10b6:300:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 19:45:12 +0000
Received: from DM3NAM03FT049.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by BN6PR12CA0044.outlook.office365.com
 (2603:10b6:405:70::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 19:45:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 DM3NAM03FT049.mail.protection.outlook.com (10.152.83.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1059.14 via Frontend Transport; Thu, 16 Aug 2018 19:45:11 +0000
Received: from SATLEXDAG01.amd.com (10.181.40.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 16 Aug
 2018 14:45:11 -0500
Received: from leodev.amd.com (10.180.168.240) by SATLEXDAG01.amd.com
 (10.181.40.3) with Microsoft SMTP Server id 14.3.389.1; Thu, 16 Aug 2018
 15:45:10 -0400
From:   <sunpeng.li@amd.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <arnd@arndb.de>, <michel.daenzer@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <airlied@linux.ie>, <Jordan.Lazare@amd.com>,
        <harry.wentland@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86"
Date:   Thu, 16 Aug 2018 15:44:38 -0400
Message-ID: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(428003)(189003)(199004)(15760500003)(7696005)(186003)(356003)(51416003)(86152003)(316002)(16586007)(36756003)(110136005)(54906003)(4326008)(53936002)(305945005)(50226002)(26005)(77096007)(8936002)(575784001)(47776003)(2906002)(86362001)(486006)(476003)(2616005)(478600001)(8676002)(126002)(72206003)(14444005)(5660300001)(106466001)(6666003)(6636002)(105586002)(50466002)(2201001)(68736007)(81156014)(2876002)(81166006)(97736004)(48376002)(53416004)(426003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2508;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT049;1:H/9ivJc2lGPR3T0DOK5vs50FDu01Oj1S0g7+jHxcho8MSz/a1dGVYt4N9oHwLlSAA4FSn3fzXiSosOVnxfykRcg2B1HOp8qK8Lz/ctgQtKOK6YDH5CcMgi0UCTIflNvY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b65bb3af-19e2-436b-2833-08d603b0c7ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:MWHPR1201MB2508;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2508;3:TPDjhXMCNyBPZejl8q08AGCIs1wSwGEEXUvAfR69nsaHa1eu6Mhf2ho5C9y2sRHF+6EJqVzi7W7LHFgsNNTYcDCkIQYM5m0EvnqMVQqQ41GUJ+DMr6JIy0p4dXAS5xQLY10+8j7KWJ64D+v8ONYed7QtJOH7euhsxxvKCIleCm5U5DGkUUa4IE93GOPZtCy0NzsVTGNbT2WpNFtIERv1YnaI7sXu7JyNhb/EjDBkgzynRY9YHKych/YZPAUjiRCnZrkzBdpoFJgRmtBQ9y2QMmNfKZ7SLUddw+fVaU3cqh/EMJCnpdwjf7Z8CpJzUw6gSedn0LwyKAUWRdR2BnOBhT0+Gr2uSV3R7A8OTkcSE7A=;25:Lna3E4vftM0qNqL53w8k/yxhGuBwD4VKpSVbXRxMxkW9Lt01xWssegDj5BFA+ZuEUhBdToyy0Hq9EXYqIQjhsc0q50scfUwByzhvdPp3TDq+WiLJGTAxf87kC31FPBsK5XUlY3JTIUnlMFw2jGjkqMyQBQ1mABWOVs2/DQy/77yS7NH278RfClFxk1z/YDVONXYxdpt47K9kN/g8JjHSlxYBlU7HFM6aFDoeL6YQ5YscdjO8pFPz17v5XbgpS3e3jfV7Z3ApKP9roiSkhrBAtdIMS4s/zDpD4fcdD0eAPHIuPH7oVL3jqzPevurwKkto3s+yAwQliqma3+//OvjRsQ==
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2508:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2508;31:kY5DaTfR3nfQcSJkLtuEztFNZR4aeWvPeR2TC3SN1HsyrhiOYzGu4+DZYYN5cJMga3IJqUln4HWHBJYfYcK5l6phgynNRSIHOT7BWrGnFPxb5uRvCJwMQYsQyq3ggBEn2ZI++wNzTnFWsKXke0zfPLz85NRPG08aYtLAFL29JjCb32bUqRvpi7khZH7iZ4kFiCu1i4+GtGtF2CJiCAtDZckLg8Ob6+zLZgd0c/Tp3fw=;20:w4YcBo1GmeNqFu347MG4o0CH6QPQ996X6jQkvZhe59nF+FsxcqUX9cA/JGzRXZSVqkszJOZohT6uPrVPPxzNrw+oJsKCy/+Fbl2REG0qNnZzSOW243wJ93wuIrrZTn9w63U+u78fhS9VACUoFHPaBcnR2E8TZEAD6m0a1r26Wgasx3vi4uY2kQM6g1By+4DS1euiqSLr0szQ92aizqF+RdO0oV5blz0Gl5oVtRirRRWrpntuZr3QMWARBCBy1UJwZkdThVnuNqaVcLCgssvfWXg80MUdiEjiIPNxEMf6F2fewY/5CKvrWZbhRE1LaKE4dYWVUbT12JX5lpXr5Cq0obGTtJyheLVmWVzt27m+DiGN9xfJFif9Gf8pQp06TsfVTisD9TKiaOcwyGIpUOqbA7DoCqSRUh1lj3Eewy6c+MCyKIT9xqCSie7iO3a7xDoHaPvBDba5XhfF/qOMfeX251F3oNLj1xbi82TFNYa3zhoi3lRhFGOOD81RNuiIm6oT
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2508A00B38A696A414D6B963823E0@MWHPR1201MB2508.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93003095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR1201MB2508;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2508;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2508;4:yUidf6ZM2OwXsjysd8IE6pIR6EcQP+epIcAy3MT3zni56esvMoLnrsy/fCzK9tMHshMiNzjFx5Qwmo1SnbjdGjBbzdGs+Ydqsws88Q8aBWqoR8A9a7bdidLCKjrhH6LnrO+NcOrlesOt28E5oPEKgXIt+J0IDMFDrHVViduArs7Espx+ozJHwIvf+8jOmHQ2TCjFPGT0SF6vt7Uwf1cY9qiGLn5wzhiXS4U+6x56XAlOZAmM9O4RpCC6OkcnhwieNGmeL2xGpn9IPOgyadj0NuLI0nNsheE/f4xLG57fWSqxmGc6GtJ2hOLS+yXd9H3/6K6Xn8+gI+h35PHa34wtjg==
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR1201MB2508;23:oQcPNVwkllXpnp0/Ytd0UL2gf2FJuIzUlhfYL1I?=
 =?us-ascii?Q?h9WoXrCiQbitYWjhZaBFStJakPqE5te0pyqpKiV2c7Fer6L2dcZHdOD01eSn?=
 =?us-ascii?Q?8/UCJhk3yNBNefMlZ4uLJGV27CbKXcOPCgWY7VyumoXvfSpnuQp56fYAAYDr?=
 =?us-ascii?Q?eamxQ37p7Di4DrQN6Fq8DpPjob+0Aoe2gTIVhUSv6Ms4YuHf4J8uwaXpdX/L?=
 =?us-ascii?Q?Sb1xwEkJNzEqr1C5qUh4NRdiE5MNv2we8KHsrp1dLzQPPY1h4hEcZQZga0sf?=
 =?us-ascii?Q?5B6JLSvGyFOGamCzKPI3QZBkiq3h5a8nResRmE5rE0k4zMmrTY4jJj0vH0NW?=
 =?us-ascii?Q?DjniIEWaLsbV3qKhQxYn6v9Hhu6U+Hze5DCdrOEYisqv+p8m8SU1utl19Noe?=
 =?us-ascii?Q?9pm4Zo4V3Dh+aa3M1I5ZPaWOW7vWFKm3RKINkdtg/9wO0Ovzlh/2lJC5WBB4?=
 =?us-ascii?Q?lb5P0rua1g5LuD9mBXm8JA0CEL1+tv9l9MTxU7eQn65BV36blab7magDMC/h?=
 =?us-ascii?Q?9ru3R0KJOcjcnoV2BiVMbTI9JmTLD/r2y+SzRdaZi8FeUnApct8HoPbt1iYt?=
 =?us-ascii?Q?nlV1pRJ069fVVW+xwV+tvOVhPy44UfuIa7Rg78qXWYfzQ0Zs+lk2hPMMJxAb?=
 =?us-ascii?Q?/5fWue+rjbl07TGeijIAEJMm/RWD+6R0bfYQkYWBU1k56G78cS01s6T02Q8a?=
 =?us-ascii?Q?DS25wLeSXj4Qc96vlurP6JdOT2DwYjiEBEbTeV09x07F6PXpT9gtsGimJIQX?=
 =?us-ascii?Q?sOe5lJwGhOz0U0M+FQEddD4opstes2cSBSpY2MC1eFDBN/lbTtZjD5REROdj?=
 =?us-ascii?Q?zyNYSaYK4gvDg60vNlVC2RwZPVZhQLP2jCfqJaBHmotQ/dY6Q0zB9JuBEDNH?=
 =?us-ascii?Q?SJtOPM9JCwBUBABigMfvvHRrcb/5dH/elo6eK64ZPxJwCwM/aC2ADh0/REAm?=
 =?us-ascii?Q?ztTLPZm4xKloNkHzbRRvCRDB6vlNbk6hGHLrntxJzgn7edQjp8//wh8WKrOp?=
 =?us-ascii?Q?dOFMT1Sx3OHtNi2ZG5QnU8+JG+IXR2BzqzCRo4Jxq1uMBYVr4ZYLyiJ7Hn76?=
 =?us-ascii?Q?oF2JF6BzFiDUhHTBHYgq0THDY9ZJMF8gGSBnHmfN+FIQP1+vAiE/r+Ewwiz1?=
 =?us-ascii?Q?btkHYXfok0upUEhdEVMUJ30pdGsIOCPXEaGDgU8rk1MpMVcEQVyZjScruNT3?=
 =?us-ascii?Q?V2NLb/YgNy1nmdJy4NIL8IQfx1XN+96aZ7pmm6a2GMP/lKhRneLg88UIGHQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: ip6B0Wky24SYqU1m3oFoqZ2vSTbZLtvLyqX96o2ra7gmk85e4floNs6P6Okxt7HHzYY+TwVoF1DPkQb3bncAX875dfWmDhtFqZKqs+QTZCXpQGv7wa7zievbClM79dc69YHpHl6lB0tkucZeViWsBbScdiAkNymJEhNW18WE8ZKFyeN6xARVWa7BH0WcJuEZpAKU/hM/2UlNFaLFNbp/YZDRQUxmsWdxRlxleMDmVuFDAL62XMRibt1tSdZJwySBJHEX04kG9LoqOiLhZzFKYS4aY90jzhwXVm2ye7N+4+dKNCa6AFZGfn55Wi84TMupBbe418HDe7D09x9bJ7PTn43/UkVwouOLyaFIV4IZg10=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2508;6:rfv59eBDWS5LS0vCigaCEbTwur1CeLHjJ+BNy5//3Rap6IO/nDxQn1piD6TzqEH4UkZRfsEmadVJm7W5M/meT76Lce+fNEfVpuGn/ZmLiowwZH91J1NWnRAMeQ8MosOs3KJBNoKhCBrRmVquwAIs3vrmcfbrGToMhyFhKfehErDQnekw01lEkOJw8h2qGaQYoVDw0kjBTBeZ8lY4QI/00pNiE8RjpsNGItdfQyzDxcdcEBXRNT6WARQjMJTO2WU3wl5wfxC2ghhKo8o/30EwkBJqMTJOgtlDV6e00S3dNJHDQqNMbANxV4IlcuySP6rRZL7SQCDhrOTWm7/UmXqmtUQK9pFAIdRzAA6Gs9+piKdpIgj++erf8u6nVTL7KTGL9A7uUq2DAmmUVGsWW+041V7t1L9ApQMLMtaEU7K0NJSA2ccydufwECdSw3eEMD/qjPdetLhvw5VfGYJGn9bTQw==;5:ZpL87Xm9BCKzDoIKBYQ0zGoUQU90slDEQnNPh/HnXoLnj8OrcCqgQVAzbtZbPMBm8BkmujSoBVttm0+MRVnkvsq7yyiwND/Uu3WSKsyVczAuW0V8W0JV+c60Cceyt2FnHtFR20qa+voQ7jWiwOiX1ue8qEYY70YEb65ZN+AR1K4=;7:qkxcCKcYSZWfnGK7ERHFPsTZyipYBrtP6x0lwTLTBFwZR2kmN5q2Ny8veF+z8YejKs73XHYFufq20BN+7Mc0nsNyGePwxONjyrWq4esSKreVqXwyazkFsPzAF/HjTVsTo+n10MpBQW8XyUJ9TitDrXLNCCl/vx7ziqctUBeuVTmq2Ez+yvMWqIvczfrifGA1PzJjxX+x+lAzSeVVR7Joq2LKbwTmLTiETf5NvPIrz9hm99A7amHRqXm5jEivfuTF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2508;20:IH1pqfzAO25W6nXKWhbeYR5b+ERMrI9plk0UF9/qRv6hfA2ob1zuLXUsWpN+PiXoBYA1sSLZE/3tK8Lob3pRziDkIurtXILo+zjU6l5T0I0CQUw1NWaU1dF2dcICXF5mj3eyb/GKHPHlDd20QwtHQGTxzBmSbxzaYY6L83GGzAHKjVfkhEuDDyO6zI9aGjTQRruLxJrqSBCl8hRKY/8XL/8KjGbBDyHnbyMXSPxI6tPN5pKZoFPb/v1HZhsZzKkJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:45:11.8776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65bb3af-19e2-436b-2833-08d603b0c7ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>

This reverts commit 8624c3c4dbfe24fc6740687236a2e196f5f4bfb0.

We need CONFIG_DRM_AMD_DC_DCN1_0 to guard code that is using fp math.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  2 +-
 drivers/gpu/drm/amd/display/Kconfig                  |  8 ++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  8 ++++----
 drivers/gpu/drm/amd/display/dc/Makefile              |  2 +-
 .../drm/amd/display/dc/bios/command_table_helper2.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile        |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c             |  6 +++---
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c       |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c    | 12 ++++++------
 drivers/gpu/drm/amd/display/dc/dc.h                  |  2 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c    |  6 +++---
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h    |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c      |  8 ++++----
 drivers/gpu/drm/amd/display/dc/dce/dce_clocks.h      |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c        |  6 +++---
 .../gpu/drm/amd/display/dc/dce/dce_stream_encoder.c  | 20 ++++++++++----------
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/gpio/Makefile         |  2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c     |  4 ++--
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c   |  4 ++--
 drivers/gpu/drm/amd/display/dc/i2caux/Makefile       |  2 +-
 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c       |  4 ++--
 drivers/gpu/drm/amd/display/dc/inc/core_types.h      |  6 +++---
 drivers/gpu/drm/amd/display/dc/irq/Makefile          |  2 +-
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c     |  2 +-
 drivers/gpu/drm/amd/display/dc/os_types.h            |  2 +-
 26 files changed, 64 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 313d7d1..18c9e05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2287,7 +2287,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case CHIP_RAVEN:
 #endif
 		return amdgpu_dc != 0;
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 325083b..4c35625 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -9,6 +9,14 @@ config DRM_AMD_DC
 	  support for AMDGPU. This adds required support for Vega and
 	  Raven ASICs.
 
+config DRM_AMD_DC_DCN1_0
+	bool "DCN 1.0 Raven family"
+	depends on DRM_AMD_DC && X86
+	default y
+	help
+	  Choose this option if you want to have
+	  RV family for display engine
+
 config DEBUG_KERNEL_DC
 	bool "Enable kgdb break in DC"
 	depends on DRM_AMD_DC
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 568a041..f1016d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -58,7 +58,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_edid.h>
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 #include "ivsrcid/irqsrcs_dcn_1_0.h"
 
 #include "dcn/dcn_1_0_offset.h"
@@ -1188,7 +1188,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	return 0;
 }
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 /* Register IRQ sources and initialize IRQ callbacks */
 static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 {
@@ -1528,7 +1528,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 		break;
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case CHIP_RAVEN:
 		if (dcn10_register_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
@@ -1758,7 +1758,7 @@ static int dm_early_init(void *handle)
 		adev->mode_info.num_dig = 6;
 		adev->mode_info.plane_type = dm_plane_type_default;
 		break;
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case CHIP_RAVEN:
 		adev->mode_info.num_crtc = 4;
 		adev->mode_info.num_hpd = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 532a515..aed538a 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -25,7 +25,7 @@
 
 DC_LIBS = basics bios calcs dce gpio i2caux irq virtual
 
-ifdef CONFIG_X86
+ifdef CONFIG_DRM_AMD_DC_DCN1_0
 DC_LIBS += dcn10 dml
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 770ff89..bbbcef5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -55,7 +55,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCE_VERSION_11_22:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case DCN_VERSION_1_0:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 416500e..95f332e 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -38,7 +38,7 @@ CFLAGS_dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
 
 BW_CALCS = dce_calcs.o bw_fixed.o custom_float.o
 
-ifdef CONFIG_X86
+ifdef CONFIG_DRM_AMD_DC_DCN1_0
 BW_CALCS += dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cce743c..bf63774 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -491,7 +491,7 @@ static void destruct(struct dc *dc)
 	kfree(dc->bw_dceip);
 	dc->bw_dceip = NULL;
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 	kfree(dc->dcn_soc);
 	dc->dcn_soc = NULL;
 
@@ -507,7 +507,7 @@ static bool construct(struct dc *dc,
 	struct dc_context *dc_ctx;
 	struct bw_calcs_dceip *dc_dceip;
 	struct bw_calcs_vbios *dc_vbios;
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 	struct dcn_soc_bounding_box *dcn_soc;
 	struct dcn_ip_params *dcn_ip;
 #endif
@@ -529,7 +529,7 @@ static bool construct(struct dc *dc,
 	}
 
 	dc->bw_vbios = dc_vbios;
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 	dcn_soc = kzalloc(sizeof(*dcn_soc), GFP_KERNEL);
 	if (!dcn_soc) {
 		dm_error("%s: failed to create dcn_soc\n", __func__);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index caece7c1..e1ebdf7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -348,7 +348,7 @@ void context_clock_trace(
 		struct dc *dc,
 		struct dc_state *context)
 {
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	DC_LOGGER_INIT(dc->ctx->logger);
 	CLOCK_TRACE("Current: dispclk_khz:%d  max_dppclk_khz:%d  dcfclk_khz:%d\n"
 			"dcfclk_deep_sleep_khz:%d  fclk_khz:%d  socclk_khz:%d\n",
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2fe8967..07a1dd4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -41,7 +41,7 @@
 #include "dce100/dce100_resource.h"
 #include "dce110/dce110_resource.h"
 #include "dce112/dce112_resource.h"
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 #include "dcn10/dcn10_resource.h"
 #endif
 #include "dce120/dce120_resource.h"
@@ -85,7 +85,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 	case FAMILY_AI:
 		dc_version = DCE_VERSION_12_0;
 		break;
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case FAMILY_RV:
 		dc_version = DCN_VERSION_1_0;
 		break;
@@ -136,7 +136,7 @@ struct resource_pool *dc_create_resource_pool(
 			num_virtual_links, dc);
 		break;
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case DCN_VERSION_1_0:
 		res_pool = dcn10_create_resource_pool(
 				num_virtual_links, dc);
@@ -1303,7 +1303,7 @@ static struct pipe_ctx *acquire_free_pipe_for_stream(
 
 }
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 static int acquire_first_split_pipe(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
@@ -1374,7 +1374,7 @@ bool dc_add_plane_to_context(
 
 	free_pipe = acquire_free_pipe_for_stream(context, pool, stream);
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	if (!free_pipe) {
 		int pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
 		if (pipe_idx >= 0)
@@ -1992,7 +1992,7 @@ enum dc_status resource_map_pool_resources(
 	/* acquire new resources */
 	pipe_idx = acquire_first_free_pipe(&context->res_ctx, pool, stream);
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 	if (pipe_idx < 0)
 		pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fa1efb3..1cf4ec6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -294,7 +294,7 @@ struct dc {
 	/* Inputs into BW and WM calculations. */
 	struct bw_calcs_dceip *bw_dceip;
 	struct bw_calcs_vbios *bw_vbios;
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 	struct dcn_soc_bounding_box *dcn_soc;
 	struct dcn_ip_params *dcn_ip;
 	struct display_mode_lib dml;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 439dcf3..ca13775 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -592,7 +592,7 @@ static uint32_t dce110_get_pix_clk_dividers(
 	case DCE_VERSION_11_2:
 	case DCE_VERSION_11_22:
 	case DCE_VERSION_12_0:
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case DCN_VERSION_1_0:
 #endif
 
@@ -909,7 +909,7 @@ static bool dce110_program_pix_clk(
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
 		unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
 		unsigned dp_dto_ref_kHz = 700000;
@@ -982,7 +982,7 @@ static bool dce110_program_pix_clk(
 	case DCE_VERSION_11_2:
 	case DCE_VERSION_11_22:
 	case DCE_VERSION_12_0:
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case DCN_VERSION_1_0:
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
index 801bb65..c45e2f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
@@ -55,7 +55,7 @@
 	CS_SF(PHYPLLA_PIXCLK_RESYNC_CNTL, PHYPLLA_DCCG_DEEP_COLOR_CNTL, mask_sh),\
 	CS_SF(PHYPLLA_PIXCLK_RESYNC_CNTL, PHYPLLA_PIXCLK_DOUBLE_RATE_ENABLE, mask_sh)
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 
 #define CS_COMMON_REG_LIST_DCN1_0(index, pllid) \
 		SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
index d52dead..9c3e6a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
@@ -30,7 +30,7 @@
 #include "bios_parser_interface.h"
 #include "dc.h"
 #include "dmcu.h"
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 #include "dcn_calcs.h"
 #endif
 #include "core_types.h"
@@ -480,7 +480,7 @@ static void dce12_update_clocks(struct dccg *dccg,
 	}
 }
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 static int dcn1_determine_dppclk_threshold(struct dccg *dccg, struct dc_clocks *new_clocks)
 {
 	bool request_dpp_div = new_clocks->dispclk_khz > new_clocks->dppclk_khz;
@@ -725,7 +725,7 @@ static bool dce_update_dfs_bypass(
        return false;
 }
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 static const struct display_clock_funcs dcn1_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.set_dispclk = dce112_set_clock,
@@ -882,7 +882,7 @@ struct dccg *dce120_dccg_create(struct dc_context *ctx)
 	return &clk_dce->base;
 }
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 struct dccg *dcn1_dccg_create(struct dc_context *ctx)
 {
 	struct dc_debug_options *debug = &ctx->dc->debug;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.h b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.h
index 9179173..34fdb38 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.h
@@ -114,7 +114,7 @@ struct dccg *dce112_dccg_create(
 
 struct dccg *dce120_dccg_create(struct dc_context *ctx);
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 struct dccg *dcn1_dccg_create(struct dc_context *ctx);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index ca7989e..dea40b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -316,7 +316,7 @@ static void dce_get_psr_wait_loop(
 	return;
 }
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 static void dcn10_get_dmcu_state(struct dmcu *dmcu)
 {
 	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
@@ -743,7 +743,7 @@ static const struct dmcu_funcs dce_funcs = {
 	.is_dmcu_initialized = dce_is_dmcu_initialized
 };
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 static const struct dmcu_funcs dcn10_funcs = {
 	.dmcu_init = dcn10_dmcu_init,
 	.load_iram = dcn10_dmcu_load_iram,
@@ -795,7 +795,7 @@ struct dmcu *dce_dmcu_create(
 	return &dmcu_dce->base;
 }
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 struct dmcu *dcn10_dmcu_create(
 	struct dc_context *ctx,
 	const struct dce_dmcu_registers *regs,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index b139b40..91642e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -135,7 +135,7 @@ static void dce110_update_generic_info_packet(
 			AFMT_GENERIC0_UPDATE, (packet_index == 0),
 			AFMT_GENERIC2_UPDATE, (packet_index == 2));
 	}
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	if (REG(AFMT_VBI_PACKET_CONTROL1)) {
 		switch (packet_index) {
 		case 0:
@@ -229,7 +229,7 @@ static void dce110_update_hdmi_info_packet(
 				HDMI_GENERIC1_SEND, send,
 				HDMI_GENERIC1_LINE, line);
 		break;
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case 4:
 		if (REG(HDMI_GENERIC_PACKET_CONTROL2))
 			REG_UPDATE_3(HDMI_GENERIC_PACKET_CONTROL2,
@@ -274,7 +274,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 	struct dc_crtc_timing *crtc_timing,
 	enum dc_color_space output_color_space)
 {
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	uint32_t h_active_start;
 	uint32_t v_active_start;
 	uint32_t misc0 = 0;
@@ -317,7 +317,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 		if (enc110->se_mask->DP_VID_M_DOUBLE_VALUE_EN)
 			REG_UPDATE(DP_VID_TIMING, DP_VID_M_DOUBLE_VALUE_EN, 1);
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 		if (enc110->se_mask->DP_VID_N_MUL)
 			REG_UPDATE(DP_VID_TIMING, DP_VID_N_MUL, 1);
 #endif
@@ -328,7 +328,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 		break;
 	}
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	if (REG(DP_MSA_MISC))
 		misc1 = REG_READ(DP_MSA_MISC);
 #endif
@@ -362,7 +362,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 	/* set dynamic range and YCbCr range */
 
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	switch (crtc_timing->display_color_depth) {
 	case COLOR_DEPTH_666:
 		colorimetry_bpc = 0;
@@ -441,7 +441,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 				DP_DYN_RANGE, dynamic_range_rgb,
 				DP_YCBCR_RANGE, dynamic_range_ycbcr);
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 		if (REG(DP_MSA_COLORIMETRY))
 			REG_SET(DP_MSA_COLORIMETRY, 0, DP_MSA_MISC0, misc0);
 
@@ -476,7 +476,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 				crtc_timing->v_front_porch;
 
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 		/* start at begining of left border */
 		if (REG(DP_MSA_TIMING_PARAM2))
 			REG_SET_2(DP_MSA_TIMING_PARAM2, 0,
@@ -751,7 +751,7 @@ static void dce110_stream_encoder_update_hdmi_info_packets(
 		dce110_update_hdmi_info_packet(enc110, 3, &info_frame->hdrsmd);
 	}
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	if (enc110->se_mask->HDMI_DB_DISABLE) {
 		/* for bring up, disable dp double  TODO */
 		if (REG(HDMI_DB_CONTROL))
@@ -789,7 +789,7 @@ static void dce110_stream_encoder_stop_hdmi_info_packets(
 		HDMI_GENERIC1_LINE, 0,
 		HDMI_GENERIC1_SEND, 0);
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	/* stop generic packets 2 & 3 on HDMI */
 	if (REG(HDMI_GENERIC_PACKET_CONTROL2))
 		REG_SET_6(HDMI_GENERIC_PACKET_CONTROL2, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 350ee3e..bf3789d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1250,7 +1250,7 @@ static void program_scaler(const struct dc *dc,
 {
 	struct tg_color color = {0};
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	/* TOFPGA */
 	if (pipe_ctx->plane_res.xfm->funcs->transform_set_pixel_storage_depth == NULL)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index b9d9930..562ee18 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -61,7 +61,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCE120)
 ###############################################################################
 # DCN 1x
 ###############################################################################
-ifdef CONFIG_X86
+ifdef CONFIG_DRM_AMD_DC_DCN1_0
 GPIO_DCN10 = hw_translate_dcn10.o hw_factory_dcn10.o
 
 AMD_DAL_GPIO_DCN10 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn10/,$(GPIO_DCN10))
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 83df779..0caee35 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -43,7 +43,7 @@
 #include "dce80/hw_factory_dce80.h"
 #include "dce110/hw_factory_dce110.h"
 #include "dce120/hw_factory_dce120.h"
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 #include "dcn10/hw_factory_dcn10.h"
 #endif
 
@@ -81,7 +81,7 @@ bool dal_hw_factory_init(
 	case DCE_VERSION_12_0:
 		dal_hw_factory_dce120_init(factory);
 		return true;
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case DCN_VERSION_1_0:
 		dal_hw_factory_dcn10_init(factory);
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index e754131..55c7074 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -43,7 +43,7 @@
 #include "dce80/hw_translate_dce80.h"
 #include "dce110/hw_translate_dce110.h"
 #include "dce120/hw_translate_dce120.h"
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 #include "dcn10/hw_translate_dcn10.h"
 #endif
 
@@ -78,7 +78,7 @@ bool dal_hw_translate_init(
 	case DCE_VERSION_12_0:
 		dal_hw_translate_dce120_init(translate);
 		return true;
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case DCN_VERSION_1_0:
 		dal_hw_translate_dcn10_init(translate);
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/Makefile b/drivers/gpu/drm/amd/display/dc/i2caux/Makefile
index a851d07..352885c 100644
--- a/drivers/gpu/drm/amd/display/dc/i2caux/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/i2caux/Makefile
@@ -71,7 +71,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_I2CAUX_DCE112)
 ###############################################################################
 # DCN 1.0 family
 ###############################################################################
-ifdef CONFIG_X86
+ifdef CONFIG_DRM_AMD_DC_DCN1_0
 I2CAUX_DCN1 = i2caux_dcn10.o
 
 AMD_DAL_I2CAUX_DCN1 = $(addprefix $(AMDDALPATH)/dc/i2caux/dcn10/,$(I2CAUX_DCN1))
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c b/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c
index f7ed355..9b0bcc6 100644
--- a/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c
+++ b/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c
@@ -59,7 +59,7 @@
 
 #include "dce120/i2caux_dce120.h"
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 #include "dcn10/i2caux_dcn10.h"
 #endif
 
@@ -91,7 +91,7 @@ struct i2caux *dal_i2caux_create(
 		return dal_i2caux_dce100_create(ctx);
 	case DCE_VERSION_12_0:
 		return dal_i2caux_dce120_create(ctx);
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 	case DCN_VERSION_1_0:
 		return dal_i2caux_dcn10_create(ctx);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 9f33306..bb8af05 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -33,7 +33,7 @@
 #include "dc_bios_types.h"
 #include "mem_input.h"
 #include "hubp.h"
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 #include "mpc.h"
 #endif
 
@@ -221,7 +221,7 @@ struct pipe_ctx {
 	struct pipe_ctx *top_pipe;
 	struct pipe_ctx *bottom_pipe;
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 	struct _vcs_dpi_display_dlg_regs_st dlg_regs;
 	struct _vcs_dpi_display_ttu_regs_st ttu_regs;
 	struct _vcs_dpi_display_rq_regs_st rq_regs;
@@ -276,7 +276,7 @@ struct dc_state {
 
 	/* Note: these are big structures, do *not* put on stack! */
 	struct dm_pp_display_configuration pp_display_cfg;
-#ifdef CONFIG_X86
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
 	struct dcn_bw_internal_vars dcn_bw_vars;
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index a76ee60..498515a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -60,7 +60,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCE12)
 ###############################################################################
 # DCN 1x
 ###############################################################################
-ifdef CONFIG_X86
+ifdef CONFIG_DRM_AMD_DC_DCN1_0
 IRQ_DCN1 = irq_service_dcn10.o
 
 AMD_DAL_IRQ_DCN1 = $(addprefix $(AMDDALPATH)/dc/irq/dcn10/,$(IRQ_DCN1))
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index ae3fd0a..604bea0 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -36,7 +36,7 @@
 #include "dce120/irq_service_dce120.h"
 
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 #include "dcn10/irq_service_dcn10.h"
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index c9fce90..a407892 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -48,7 +48,7 @@
 
 #define dm_error(fmt, ...) DRM_ERROR(fmt, ##__VA_ARGS__)
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
 #include <asm/fpu/api.h>
 #endif
 
-- 
2.7.4

