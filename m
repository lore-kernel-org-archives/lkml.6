Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965950AbeE2SXP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:23:15 -0400
Received: from mail-by2nam01on0076.outbound.protection.outlook.com ([104.47.34.76]:3566
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936850AbeE2SXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:23:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v8 0/2] Base enablement of IOMMU debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 13:23:05 -0500
Message-ID: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0701CA0014.namprd07.prod.outlook.com
 (2603:10b6:803:28::24) To DM5PR12MB1451.namprd12.prod.outlook.com
 (2603:10b6:4:d::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1451;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;3:YPycUxn1MMRXSEeiLIMCIQhD3L7TQudoJQE28kHBEGM4O0gwtPw3m9FznwZxfSgx1czlDFs7XS7SZowxiFalSfP57DLGhmybF74OHFiA8rmw6VnZAy2gb15hFJaBhyXHQoVuBpF093tPqcu9lWxTL8+KBommUAf0JAJ2jB0ZPIL1IRNDeq6HBtM3wPfTxjKDNRPRiYkdqVkKGX2T8qL7+1v4x8nj/4YeVua/CJsfAjIRyWqi/LMxDDdoatGDj6kC;25:/SNEt8J2+P+mNM7wsu1T5hnKsMyARB1QdZcvGXjfdvF7YKbCgbdl66V+o1f0UQWETDD2ZzL9coNZikDTqcaxFZfw2JUo1o/i97zF7XhiawuOlwqqsAvRTTdX7GTnFgTYVV9neLryTp9pEvvrD5j2wLbeXCuEPTMBQX6jD9fVjdi8hlLGw/krMK56Ddy2QJybvxbL5gIHPObqXFjnjN4+n+5hQyOuDZCNu4psxJ6D1E5WfD32yxuopF7SJDK31/AFqyy6Re+ohYyCqyMjPDHrabMNUMsqCQNBsyBIy4Hrjx5K3ICSfCrHHKuV28YA3388jdEC9OG2tp5Nw72wXSECkQ==;31:/nuhGqJcXrNSUuYeJB+zBwjlG3g1QuyT8FN7yyHuq3ew1uggPgYMEUvi+WaXYHOp1El3I5SJQE12CTONa9RsbORW/fzuW1ttlxeDrwyISqUCpcpLeOjE04+5I4i2oCDI+i1ZNLGKkN8a+/zkj3lxjeMz5Rk30tTh9T40ySuyQ2LBwq+PNf6u1lXUofxUHbEIU3WQsGCJuF7aNwIpKqeD474mhVYlZ9qYC1tTwIAzsVo=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;20:iDmqhyf3GRxXsrsbb+QARYqDZcWB5peWKMBf9j1a95YoHGnIBsqRU6hZ7g5nUOG2KcEjyT6BRBmAbRKqgmaBL4L4NbdybZ897svkuQBOGbQqH121HglnxfkS+SxE0fZNz9MdDE4uIq0hx6YY83NenXblydJ0DNf3eatZzzzlDFPst1mYFEqDCDx7r7UKSmHIg0wZope2epq6f3lj4CSAuFgScTyU7qSJZYwfl7s6JkDS+K34nEPbX1/cCPg2m1T6oqVsTmOl22oZf385Hh6TSyLsOX14o7TdnHEjUn3esfd21e0aWo6lu/5g8z63YQsl2H+WfcRRtqM/Fgs+n5NLRzFi/YjiVR14p0KE4SXoIXTqWWhBD6ZjC8NERnSGsthtX0aS263oDddhbJxNpkbRe2xkFcQBG4SP5OSiJ6+5IzNvV4leWmeLuw9tOvz2K7t+bcsnXrvrOpPTttEJvW+vlpqRNmUnS18qhkegf91dIS2LFT8e27NygStwK+OcFnXm;4:zEHsl1BqpfaRPOFKae/mb8F/PNf1Z0HbaIzb9iyFZKC1oSJx4EjlWt6egCRVOgp5479Bgc+1BfGNtm3PDtmVAckVn4/HqiWV2qhA4ecN2lnHkf1quCbp0MuGZbPLRBfnKmC48PXzaPByS9T1EfuSYVfU7IVIotoyK/ibGkCJnkoNcdK7NLQov5zh0Zl9waqExOLvPApjCMAew2VHYZRRlkBjRF/XC7yY2EvsC+xtql4kNU8Gb2S6eJtZ6gRAEmypiPixiRA/MwHnoEDA/fI/9Q==
X-Microsoft-Antispam-PRVS: <DM5PR12MB14518974D0D03F9B8727D8C8FD6D0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1451;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1451;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(39380400002)(189003)(199004)(386003)(26005)(186003)(16526019)(5660300001)(105586002)(106356001)(52116002)(53416004)(3846002)(316002)(23676004)(97736004)(6666003)(86362001)(6916009)(7696005)(2486003)(58126008)(103116003)(230700001)(486006)(478600001)(2906002)(956004)(72206003)(476003)(7736002)(6116002)(47776003)(55016002)(59450400001)(53936002)(8676002)(81156014)(81166006)(25786009)(68736007)(66066001)(4326008)(305945005)(2351001)(2361001)(8936002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1451;H:sosgrh1.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUxOzIzOkNRMjB0Q1hYQ0VzSllKdTVRMThRSytycWRU?=
 =?utf-8?B?TXdpT3AxWk5BaFgwNERtcWFWaGt3dTRvdGVPRWxEeXdzSXBCS0thWU1BQitv?=
 =?utf-8?B?eUZoZy9Ic2RIenRzTDAxMm4zSUVvWTJjZHg5ejFsTDk0QWtoeEF5RmNpTmpP?=
 =?utf-8?B?QjJMaUdDaVdlZ1FQeEREN2g5bnlNcmwreWFpV1NzRVUxdTE2NUt2L2laRHdi?=
 =?utf-8?B?cmQ3Y0luTlExeUJMMWRlQ3d6Q0ZtR3d3R05GbU5uNHpkNVM2WVN3YnFmWFZy?=
 =?utf-8?B?U1FEdGJ6bEpqVXN0Q0sxaUVrS3g2NjVMblBXU2JqdjQ3TW9QaytIdmZDV1NK?=
 =?utf-8?B?M1hPVFNSTVg4WTkvTFBKemNIV1l3MXY5d2hwV1hhT212TmN1QnZnVkE2dkw3?=
 =?utf-8?B?cW5tMFBQREY5ZzlvVGFzeVJ3UWR4dEoyUUttcFNNSFJqbEJFTllnNXV3V1Fk?=
 =?utf-8?B?WjdPb3hwSWlDczR1bG1kMWFXZTBBQ2lRb2RLS0wxaUVZdVYwYUFoK2U5NVV4?=
 =?utf-8?B?aksvdHdORjVUUmlTUGdRbkoydXpuNEtORlM5NDdseE9Jd0pRdWtIWmRCbVJv?=
 =?utf-8?B?dmRxdmhDUGVXMitHRlU2Y2dQRm16SU1NMldoU2JzQ1BUdUZtY2doL3pmSTVn?=
 =?utf-8?B?R1ZRZHl2K01PR3QzM0RMcVBsdmh1S3h4ZDRuK09VUVVyc1d3eFQ5bUU2UDEz?=
 =?utf-8?B?cUoyWlRUY0xWT2RobUs2VzI0ckFIempPWXVwNG01cGwxb3Y5MWR2WTFXVWVO?=
 =?utf-8?B?T2tIaE9McTVWSVVmaTdhbDQ1Ym5laWxQMHFGSmZZSjh6YjhzcU5qTXVuN2ls?=
 =?utf-8?B?OGdHaEFMSmF3KzVzQ0pVUEZjeFJucmJ2L2JlNlk5V3F3dlliVkZUcno4KzdK?=
 =?utf-8?B?dkFqdEhkeHFaT0NHQndOeDJDazBuc2N3YnhTZmt2SHF3SEgwZmtQb2NWZzRX?=
 =?utf-8?B?YlF0TEZxaG1sM09LL0QxVmxoWFJuOWZQNElxaVBJZjVPTmxUcVpYRld6MHND?=
 =?utf-8?B?MEFYU3NzT1YwWUxHZjBqZ0FBZ0lDbWFJWW00TzV5bGg0WHJpM3dMalZHSStC?=
 =?utf-8?B?eGlVK0c5c0JidjB1NTNUZWFaQ1lub0xCVjRDUFJ3YzlXUnF1R2kwUTRUT3hD?=
 =?utf-8?B?eXljVmN2UjRvY3dsZ2RiZFBZbXhkVE5Lc2lWNW43aWgzNnBUZi83WmZTcVNk?=
 =?utf-8?B?SStUOUI1dGNoc1J6Rm9adDFQM3E2YlhoWXpad3VKaUJ4ZFFNRnlNVlBxTFF0?=
 =?utf-8?B?YTl5SlFsc3ArREtkUGRUTVpqZXFUeEM2SEUzb1IzR1FJNGs5MnFTcFp1NXh6?=
 =?utf-8?B?OExlOEI5UFp4eHJNQVlIQTc2dnpDQk1wMHI3UEpQM0lCS1pZSEM2OFphQlJh?=
 =?utf-8?B?VWFrSFU1cUFJb2YrUDYvVVo4SHVYbUNlT1l1ZCtWYnNRdlUzRWZySGMrcDdy?=
 =?utf-8?B?OVc4dmlVMHIxejJZLzYwcVVHcUhNTE02dHVpZXF2Ny94dkJmQys4WFp4TG5u?=
 =?utf-8?B?NCtzTDRlOE1EcDNSZ1ZGNG5pbllwaFlIQ3BZbEVOa3Q4MFZIYmVNZGQrOCtM?=
 =?utf-8?Q?7sT5ZLMeYqghcC8DeH2zjUdNFNyStn6anNQ3dBDyKfJk=3D?=
X-Microsoft-Antispam-Message-Info: kc4gHz/kX4cjCWQr8Dd7LoYXe7MLLpCrP19anXQpeX1f2KAg8jF0ty79hEaLTZtKTKjBpuUhYWfkx85fDLTWbyg392uCKDs4HboiCrgQoADBdGgueagmno5n4pnagSKQI7wycK/0XzdYJ2bXcs53nZ8SXnW1PUV+Yv0Rsu66wx027HkW6TRIsKdtQbCnx5LM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;6:qHIxYge2GxEXXDhdM5+47yTRQs3OMjJYvq9Kt7v7m2k6nwR30AMjK8nBHVTHItsLgfI/XO6+tRflObd4LlpZZGTC8Uf4juDYI0SF0HshdslK8Kv5zlPhbiFZuIPSWV3YpOVuW0UewFSC4gqbhxKwT6hds82P686AHj+4e/WW+qyisTV2cJNQ/kSEsadGKmCXjdpb0ZakEhAqQKCeuyJ/Fo3qhc7qavhLWEqsdF64DhObXfoc5EACZYoPp1b5LRPME3K4NHz5VkVEIIHZw8jqZjGuuEda0VO7Q3jgl2lGCVBAafPHS1d2/ocSAApYBurXAsUeyWD1PZEMLhIdUcNrVX5dvTsOEXv2AzPnUMfYNC+ZjuFmAhD0cYVoUTc5UxbL2gJ10N/6LoQWmhQI90hAIP8twS3VHnS8qhDqy6qWlDcUEXpuE1q/4zHqaVBVVKprirkeStTOttq1AnO2U+rMeQ==;5:N9YLW2aTIPkfwBJR+1p6MPdLk0S+7hZ0JfW6Xt1trGJzdr5qTDX1dxpHupQe6Thzv9gdZs+tM1zkcYhY+EZKS1uIjBD0UErMMJdCQMkgcw0sQCqdos5QJLw1//s0V9vozlIDUuchlHct7F9T+Ggh+I5ZUHk9UGLaxdy6992KmeY=;24:3BoitUL4pI+nUxS9VrAeQK+5WL+FQ69FCV+vpkEFZqx6oJb4u/vlbHS4wmX2ikoGunGOu6K1ONnjeOvz3ZzH5/ck8QP5CbxZOOzwUKIKReU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1451;7:Q/lE4t9kWFEypIVlLcSdmcgNqvo5UOoY8j6Us/k9IoWRlqcfTCbeCaL6fVK9rB2RPgTfk9QaO+yrUOBbLQNKB5NWTMEqQhGMefdL8nGjnwWD6D2UVaLayfH9zzaAS1l7FsOPml4PKx41gLIfYJsXxED+mxRcdIrXMCO5BG+g6/cqHVcaK9DpF/hAF9fnfLU7HbHkq9IeO4akfFK3EnI7Xy6RmSQLtwefvBLzFMoLLVjo61frUFSstUHfksTH1CyQ;20:FOTJzoK1O516RclIZCVSUlZbXuydZzyA+jM/fg6fl4IFgPXYuH2D00DDtGdUUuoiVw0e3S+DFjq7EyG8ZRI8NBAA/TVJircW+uk6WU6B4zr+amv6ZO6NHJRgBhdJR/+xVB2rUGAkXwy9CxXZBKodb0DKIvEtb4+WArCI8gGM24GtVGYRSAj7KvxMyrbfBIo9fwbApBSR5EEQ5vtnqzX4QhlZT70MsiaYs6EvDcYbyhiGcORt0P4CMsFFDS/j2mHz
X-MS-Office365-Filtering-Correlation-Id: faeafe21-b36b-4d06-1168-08d5c5913b17
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 18:23:09.2121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faeafe21-b36b-4d06-1168-08d5c5913b17
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches create a top-level function, called at IOMMU
initialization, to create a debugfs directory for the IOMMU. Under
this directory drivers may create and populate vendor-specific
directories for their device internals.

Patch 1: general IOMMU enablement
Patch 2: basic AMD enablement to demonstrate linkage with patch 1

Introduce a new Kconfig parameter IOMMU_DEBUGFS to globally
allow/disallow debugfs code to be built.

The Makefile structure is intended to allow the use of a single
switch for turning on DebugFS.

Changes since v7:
 - Change the Kconfig approach to use a hidden boolean for a
   specific device
 - Change some #ifdefs to reference the new boolean

Changes since v6:
 - Rely on default Kconfig value for a bool
 - comment/doc fixes
 - use const where appropriate
 - fix inline declaration

Changes since v5:
 - Added parameters names in declarations/definitions
 - Reformatted an inline definition

Changes since v4:
 - Guard vendor-specific debugfs files in the Makefile
 - Call top-level routine from iommu_init()
 - Add function for instantiating a driver-specific directory
 - Change AMD driver code to use this new format

Changes since v3:
 - Remove superfluous calls to debugfs_initialized()
 - Emit a warning exactly one time
 - Change the Kconfig name to IOMMU_DEBUGFS
 - Change the way debugfs modules are made

Changes since v2:
 - Move a declaration to outside an ifdef
 - Remove a spurious blank line

Changes since v1:
 - Remove debug cruft
 - Remove cruft produced by design change
 - Change the lock to a mutex
 - Coding style fixes
 - Add a comment to document the framework

---

Gary R Hook (2):
      iommu - Enable debugfs exposure of IOMMU driver internals
      iommu/amd: Add basic debugfs infrastructure for AMD IOMMU


 drivers/iommu/Kconfig             |   14 +++++++
 drivers/iommu/Makefile            |    2 +
 drivers/iommu/amd_iommu_debugfs.c |   39 ++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++-
 drivers/iommu/amd_iommu_proto.h   |    6 +++
 drivers/iommu/amd_iommu_types.h   |    5 +++
 drivers/iommu/iommu-debugfs.c     |   72 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c             |    2 +
 include/linux/iommu.h             |   11 ++++++
 9 files changed, 155 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
Signature
