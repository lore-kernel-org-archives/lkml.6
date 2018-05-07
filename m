Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeEGUCC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:02:02 -0400
Received: from mail-sn1nam01on0089.outbound.protection.outlook.com ([104.47.32.89]:54912
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752386AbeEGUCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:02:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v5 0/2] Base enablement of IOMMU debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 07 May 2018 15:01:52 -0500
Message-ID: <152572281179.3235.11484188869064303333.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:404:23::13) To CY4PR12MB1446.namprd12.prod.outlook.com
 (2603:10b6:910:f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1446;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;3:I0Rcb0l3Jx66cgn8okq/VOgQzvYo4Rk0v/NGpOESQyJ9dJkvLhudFRW33OgqPBI3a9yHzM9L74KFpMXjem5gm+cKVB81bceYtKftr6tKhbOxJ6W5bKySNNZncYP3k6UW3sCJBRT1C5cK5xoTsTdXJioGIwSLP7AVztJKhfdJq0jK6MVT0a7eSpqI4ZQbwIEUN62sED3oqfrtvFyfc1QA825DxfhYxON1YwrTNCpnV/q9zF8uqPuTjcBD55ndh/bn;25:Yot2Td41e5LkkzHpv1mEq21Bx/C3VMw6D99E0/QZpWtxNCHgSkTJFIGvFF3kEvZyrKDuBACS0/evcOmnwlCia/7L4Je58MPErqCGrCIVS7flRYQj66WvkyygDD63wRejuTE1CbViEsQedSHETHUEDmx76EMvRWNXFhH+Yj29aSxpyFTMrfWK6RoN5l1FUK3VaHjuhgCbqd8XhQz7+KtEekq5qkhQ9qrWls/S+ugDfk+uLXhiZNRiP8COmQAsqmiCtM0cD6HSJLnUBPILVpqSTejGnilzESm9/qacKtk6eo7aNJZzAVsk9cT+FzEDMke8GGeeIvn76+MZu/1LcuiILg==;31:m4MGr+3fB/BuhiA0lCh1HUCoJKp94w6JSVcakJPz3sX/rocwY5A4uz8pqbaZU9NMt/XkPk7Iu8uxnDJalPGSO83tuXpnzKcx3L/h1kDEn1WeXf7v+zxuvhMpi2OeOT4qM1XVFHn0dOqE5N0BadD1M4nuaiovsgzGTjl7py8Wp7wY7yz1cl/6fIOM38FzjQflwpqxG1LzASJzMLu4U72Gsa+KJTkmH9vzdxzHUy0ybl4=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1446:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;20:Hqhv5mPP368EC0V/vb3fxwJEMJhuj4KLVHXudptXxlkvddi7d5JqrVnf48VyKUSc0MMNMvQonVq6uTn+IsFv/5UWM5A7d6n1IsvdFjYcwOyUDsyk4y7K9zZbRGpUjP39i5Zomuk896TKzQhrbby86IqUo7nkPutsaVkpVwjzz1fUIPHuPaAyTjfpZdZxZUIDtxGJYIIUytBqwBxrOVLbKDEf5KOJbbl+ed62PXqlj3JZ7HGZYAfjBV77fgTRBW1OkRxXaaqbkSprxYUUgHJj37bwIvHLN2m+zQDH6JB4VQOZnpoOIxb8v8Xw64QEUIggmY6Sz0R6C0PcRLMov1rxqZ0Ej8ah4tERjbuAs39OQexn88SOb5vq9ow0uPCvd9MHz7uKXaxLrEZ7T3sdg4qv3GVDlhfkkVWO+uNc8vzCjMBWHHYGEaN7Hf4cLplcGHMBhLbCUPH89BY2jAbCVFe8wzPT8UZk+v1ldUSzNOGrd+G097XXJTXvyEnk/J2KMUxV;4:+3wprzWVFk44SBlKUWwVmPkkkYKc5pk/NDHaT02LhHGvYJPp7rMMsBRBKOab9fG7av+U9AGLynGj7Q5i2UZJUKiIZ6N1bFokBG0jVb60NdwiPmBm9u4YCgrAi3w0UO6mKBxqKQgdQpO96BwxApfged/i5d0qVCKnGF+xNTQy67aVmm9wOtFsAp+W3i0gx16BMZ0ElfCpaxQ9ukEYV9D1d67GAxTk1UDykRTG56MsltF80HE5RnHxh2ZGEQ/EYsZcc8O8IkTZV5FSLYcGAX5LBw==
X-Microsoft-Antispam-PRVS: <CY4PR12MB14465E30A7B1451123E778E6FD9B0@CY4PR12MB1446.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1446;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1446;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(25786009)(7696005)(386003)(2906002)(97736004)(6116002)(3846002)(2351001)(8676002)(2361001)(86362001)(59450400001)(68736007)(81166006)(50466002)(476003)(81156014)(4326008)(956004)(5660300001)(486006)(230700001)(6666003)(6916009)(478600001)(72206003)(55016002)(53416004)(53936002)(26005)(105586002)(106356001)(7736002)(103116003)(8936002)(305945005)(2486003)(23676004)(316002)(186003)(16526019)(58126008)(66066001)(47776003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1446;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ2OzIzOkdRWTgrWmo0WG5TaENJRjB5SjVUTStmcFRH?=
 =?utf-8?B?ZldxTFh0OWRqM3dWNlpBTWVZYlJSQ2lnbm9IamVnb3JNNURpU01pOXFtaFkx?=
 =?utf-8?B?VjVvSldnaFdOeWdNRHFKOWtYdHhWNXE3UXVtVThNVWdhYUFTUFlaVEdURFBz?=
 =?utf-8?B?SmcvVHVLTmRBcjhySENLLzFGbUN0RTRyRDB2SUdEQkRtbWhaRWpkcU9GR0Ux?=
 =?utf-8?B?K3ZSL2J4YWtNNFJ5ZThVd1FrbFlkK1JGV2o1WjB1a05zYy9mTVQ1T0EzN1hM?=
 =?utf-8?B?OWN5L05jaytxbTgwOE5SVTdxYVBaOHlUMG4vazIwWVVnbTNXZWdQNXdkZXZP?=
 =?utf-8?B?L3NnWk82OTMyZUVoMVZFR0Q4QWlsL1NkRUlMSWlHaEc1ZWw4dHZSS2QwK0xx?=
 =?utf-8?B?MTlNOTJ1UUQ0V3h5cTRXeE5yM292cGMzR0dxV3lZMFBodHdjUXBlalJaMGpC?=
 =?utf-8?B?azk3SmtONzhwdEMrZWF6TzMxdjBlYXVMZHlVU3dJZXUvRUVaWXUzbFdGUC9z?=
 =?utf-8?B?ai9Ibm5MRTAxRnB0TWppOUY4MzJKTlB4ek50cVAweWRGNzZ3UFYxMDV1MWVx?=
 =?utf-8?B?MUVTbEo4bXBJQm0ycnVGKys1SnY5TUZ3bDZGUXBPekVUSW8yZk1wdENHL3VW?=
 =?utf-8?B?MU85aEN5VjVLQjJvWCt0cnc1Nm9yU3BCRjdaU21rOGd6T2ZtbkpoamZBTitz?=
 =?utf-8?B?QUx6YmxRTGRQOFl3azFmaGdlYTlnVE1UeDNnOWNYU2RVUC9zaWtUYmEveGhP?=
 =?utf-8?B?WTk4bGFId1g2Q05lVkNRTFV0dDF4RUJCb3FzbExKUGYzaXBMQzZLMGNadzBm?=
 =?utf-8?B?bDBRZ3ZtZzZid3pCcEh4Y2V5RjB0azg3SXNOUFdJVUprbVlObzNSWFpkRjk0?=
 =?utf-8?B?YWdFZHU4eVgyNnRyRWFqVHR2dDBMS1k2aTJQRnVDN0dJSzRqZWo5S1c3dCtq?=
 =?utf-8?B?R3NxMllwQkdnbTVFOGsyTkZmRGM1Q0x3a2lsYmFMektzY2o3MVpSSkw1QUk1?=
 =?utf-8?B?Zi80a1VtcDNnbG94QlJiOUhJK0I0RFAyeWxENlNpY3g3QTl3eUdqV3Nib0VM?=
 =?utf-8?B?RzVSRncwRVVNeHdSTTBjWGxKNFR5WEtHK21xbndiaUpRd0Y3WmtZYTZoTVg5?=
 =?utf-8?B?clIzdFBwOFcreERPRDVlWE4wUWxIWUdvNkV6Nm9CNjkxQnd4blQ3endSdnJo?=
 =?utf-8?B?QmQ3WUZQZHF5TFBjSmIrV0l4VENqV0VoRWlwdWJiYVNOd3IyRDBmZlFTNVZm?=
 =?utf-8?B?ZUVPSnlpTU5vN2srSTJKclhKdHEyUmhwQm9oRHF1Tno0NEl5RzBLZVYvVDVl?=
 =?utf-8?B?ZklRTGhlQzN6d3VZMkxDQzUrR2IzbGtrTUdaMWtHU0QxYlJqOGN0SWlTbnFr?=
 =?utf-8?B?a1RXZi9SMnQzckVNTEp4N2s1NHhEMWVOOGluZmo3YnRpVkF5NjZyRmZubzFt?=
 =?utf-8?B?bFRjR2hEelBvY2kvUi9yK0JDTXZwSkhTVk9Ba1pMa1NoaGRDTGswdnZWY3NL?=
 =?utf-8?B?b25mVFhIVVROZTFaZlhoSm9lTkJlLzJsSDUrekh2S0xQbE5iYTl4QnhlOGIz?=
 =?utf-8?Q?yFIQuir0XEBtQUjZMyXJ9NtdOg7ZAP5MRUrGlLnyakF8=3D?=
X-Microsoft-Antispam-Message-Info: XzN0NlaM4xsKWmsddVwlLLSfJ/4ECO1ZP5vKDkNauvsxhZ5tQLxjjcwK1zevPEEAhG6rUoGs9sRMltw4o3Et1TtOrRi64x7ZC+ZjuXNj3U2Rn0+/uIn84F6LppmoDEgg/i0lGOFxnm4eT0azVNLhqB0uTTDSEZoTglX1QFUMIxi9T4lp366xeEbbXbpILO+v
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;6:trsUJm7Mdw6DqIriiOd95o7gn9guIB4sGNxXlWom35AlCzq9C4RCsJw0z6oGVEIQ4z29dngwVcZlSxDam8BbuGu/kVr3XyKur4EpRQmGZIxCL0xjENZh5+LlD4nX4Kpy0/WjVXn9IkhpUvJk0g2iCOJc2LR4JsCim/DC93k75kk5O8npHAdVb+fw75DsP4/WUAslN2ruS9px/Age7lnuTzxIJdqJpUSvt6bO8nE0R3r3eL0WkJykkzEc+EayN9Ye//Hps6m5Oc5W7Zf/Fa5RQReXU8D9RPzbfBg1OudlAScI2cJPNN0kx8JsiDWx1VtRRJibORG5dUXtI4dc6KNseTm+JgnUzz2u/6xoqh6OeNuIqKhXMSCirOTcSlsthbctCxdm56gH764aLsqFKNQSs4E2FIvTNus98C0Q1QtYvGLNXYQcgIWdKnBXTEbGGjrSBD95+eG/dM9F1UFR4ZBm5A==;5:8fJCt+7ndxV4NvDmiln8L1MoNg0HmWULNFNR2nETb+VpPXKa0piNK7qf+9fm+x5q40Mwc0AHb19U2ySYjfj7eunE7fL4q/69wERiWzSU/DyEE0zS5p66XNjJ6tFpAfUedoHqNG4MxFNYRGR8DW14MdcJwSqh6HVFZXzNPIrybVI=;24:tapCQgcmiNK0l4PbRO5Os38cCf3p0oKT6F9DPH6ricYG2oLJOX0tg8riiD40eEli4SC9CXsXvnMnRxXzvnqTPdcBkP9ERYRnohVtMb/sae0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1446;7:aqHaKF9ACiT71jGa417c5ZX+FPRPA2BHDlkbXA3co0Yx0pdVs96/WYmosbDL5Pe2pYZnO/Mm2x5n+ilUDw+oGlP7ZoxQMARDUYErjwsTNQVO2S23PZaCqh6/tKLxaK/uViB+zs8oHC3ZIEgszpJlV0IvBq5bCZs1ZujywjXa6/SF5Zmw1EQgM+ePxTIUx4gf3DggnyInX1dlPrYNuJM4Z3v5fDScWiom4BhSx6YMNWzKsIMyKDslZZShOBuX6gaq;20:s0C4JU50JaJTkYfztjo5nS/CH2NzmHdC+WSKzd6LXpz6g6J20KokaCwjtE/1Fs4bbiryQOnVzZlICvkobFCO1JdbWM+QEoAA9DbNlc3C8WVkKIEobwbUD+dX2ClwhALztqXT5jq1aUjoI8irzoh4xrDIfrHGiRTGvMEoaPs1isxXAA8Bb4BKP+oLWnEAqNewOzkb8lv3LiPCD7VxXgr2omhjdW9Uj0LnxYBiTaF3qRUZFATkLxwTVcYPheplhstK
X-MS-Office365-Filtering-Correlation-Id: 117d4470-3f68-43dd-627e-08d5b45563dd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 20:01:57.7215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117d4470-3f68-43dd-627e-08d5b45563dd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1446
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches create a top-level function, called at IOMMU initialization,
to create a debugfs directory for the IOMMU. Under this directory drivers
may create and populate-specific directories for their device internals.

Patch 1: general IOMMU enablement
Patch 2: basic AMD enablement to demonstrate linkage with patch 1

Introduce a new Kconfig parameter IOMMU_DEBUGFS to globally allow/disallow
debugfs code to be built.

The Makefile structure is intended to allow the use of a single switch for
turning on DebugFS.

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


 drivers/iommu/Kconfig             |   11 ++++++
 drivers/iommu/Makefile            |    6 +++
 drivers/iommu/amd_iommu_debugfs.c |   41 ++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++-
 drivers/iommu/amd_iommu_proto.h   |    6 +++
 drivers/iommu/amd_iommu_types.h   |    3 ++
 drivers/iommu/iommu-debugfs.c     |   64 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c             |    2 +
 include/linux/iommu.h             |    8 +++++
 9 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
