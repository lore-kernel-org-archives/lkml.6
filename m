Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752741AbeCXSuC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 14:50:02 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:57948
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752579AbeCXSt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 14:49:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, bp@suse.de,
        tony.luck@intel.com
Subject: [PATCH v3 0/8] Decode IA32/X64 CPER
Date: Sat, 24 Mar 2018 13:49:32 -0500
Message-Id: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:404:13f::22) To MWHPR12MB1919.namprd12.prod.outlook.com
 (2603:10b6:300:114::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14672db8-9736-4a74-4b48-08d591b809c5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1919;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;3:A2jz9F2p+GpYIyg25WLfEg6JzbquhpS9crI/huxyadRYYEpBP2UpROMggB8bTc+vgPNbZNP6J2lYwR9pFYoCZ0E9y0P/U/aGdeaKBojpuKjL/gHp4XwOlTimv0eYAKZpGeT6rQPEwlrPoGa1nKB+sUJb6dQpfAQpywHRSmw1qwBVDW/q/znwQ+7/o2W95Sw5PXRFHU8uzq5BVKfOiRENasqIYKBdxyhImyZ43CINO5OKQ01UnKfW75NDnROSTt09;25:JirKUagVGPpnLaALSFZEfIPJ18iFVjQjwYbUYduA8F2M4LEtRgj83Oqp7OgjdK82qNGn3Zq4iGGJenIsU1cMUQHAzFQVZ2Xb16CFe0lLEmkdcNtKNRUs602TNJrIR3KzuU8NssCZ2zRTxG8ggGqs1RoQ6/c1ZzEliNxfbi6OA37owHeXvWJCH9DwV6+9MVhNyUQU3Z2kTisSlYg7yIQQlrNSag8uMBLIMxx6uj1hsETWITCPow1rqlXLykwzqcQ+/mhj6UfhkYUCb6n93bYr10RqQWjqJALV0YizI2byMkAhYiJX7IbIXuvGtdT6B3QftTnvYQIxRM/3Ig6bIw4Ovw==;31:NZP6GLZNdgFy/ffP4K0QIOEoqDQ4j43ms23oSPP29pQ4wxuSxxIeq2D+Cup06wnJjzM4VNUQoBbFvHrHUW8QbyqcVpBHCm8KWT0Li6DHLv2AF8eoWrWNjvoRNHf74up5dFTc6V/CYo5AnZSwNWNPEmx5b88n9lwjaxEYK/bFbgX3h4WVyXKgWkBejN8PIc2xaNlf2ZZAEhA/bqvqIcfDkajMIvdixV97mEyFhCbvdr8=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1919:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;20:NZ3HoEZsX+wh5lIqCGno2wEoIvrr0tn7HdNeFpj0BGVfihu1tP9r7Wd+3eLNVcf+hSkQUt2Mh3XkJV1MS+dJjd6kDTkCl4aRCyjt9l2X7R1mjUNqGrwqULKLfZ1WJTgX6p7Rdt6XOMQscmqDmDu3UX6HMoKhZAD77X85ryIBOa1O5hf14PA6uT7YTDvYQUhaalAws621V30uYGi1rYxDteuPOkJjohp1X7kTW1Q1nO7kJLrPm2NSicwZkLxfCd1QhPpfS68K2ZLilLG6zx/w0yeyFOiYl/829/ejHN22NFPRaduRkaMm1FE3fsupws2wFDIo1cnZx4w8InthCI4UKEaGPMDk7vouPnxxRDq/LR+iGlYtaRMRKW8UQyhqpoHbZtSvHkE3g+NmgE1xrd5RYWM+9cgFEt6fgdOppTXxv6mB6/FI1a0WlDmwHiRVjC4g96OtBg6aF5EnRlifF9zQj1b7Ecc615SANspjgUbh4JKdIdwVgDfsvrzNJ+E07KDN;4:Mg5OmS2hu6WCW2o2MYsqqvZzn2INn/N50kRgP9ohCto8HppS5RgwkjbhIXj17bm5lpRM4RKA/fX+HBbIoVMV9Uml8RoWa1ST8tAXVEOwgJEHXKNZaCr17LF0j5SWOGcsl6yWdVTEy+T4Xs1aYNofQ7ssJCnOOfefpXyxzUPesCkwUgTdpSkFCsXrHRjFMIcGC2leLxNsdEGbXgKEHq/EcKWUginrPkNaDMCuu01apEgcCdjV0pb/AARpQYCUWjTByl7mi+zgDRlCfaDPOCU/MNDKaFbvE1WdEqI+yTJ/5XO/3IuC4DkrfObMyZnGIYXzwAhHoviQP1sHFub/TFnspQ==
X-Microsoft-Antispam-PRVS: <MWHPR12MB19192E467CEAE265B5BEFC34F8AF0@MWHPR12MB1919.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1919;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1919;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(2351001)(2906002)(66066001)(36756003)(52116002)(316002)(4326008)(51416003)(25786009)(7696005)(53416004)(97736004)(5660300001)(106356001)(16586007)(68736007)(59450400001)(2616005)(386003)(956004)(7736002)(86362001)(47776003)(305945005)(966005)(186003)(2361001)(48376002)(72206003)(53936002)(1076002)(6116002)(6306002)(3846002)(16526019)(26005)(6486002)(50466002)(105586002)(81156014)(6916009)(8676002)(478600001)(50226002)(8936002)(81166006)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1919;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1919;23:L36WJ1l5Hbell9bJxN3LI4SQlvLahXw5F/y9M91YS?=
 =?us-ascii?Q?jeqliMCzWKFDsDVUG17zbJTx3HDQYLPrZzLHQSkqBtMwvek1pSv9jXJPMCJW?=
 =?us-ascii?Q?MzbI43pSY63j+C4s29xxTRVDthNSx/U0OPi6IwZJN3kCNRu0C4CaULjbXTOv?=
 =?us-ascii?Q?g69uQHivcToZ89Y8B75tuMxfvWRm0Tmx+zXAaA2jdASnOMmfb5/3AXFPv0YL?=
 =?us-ascii?Q?u1HTY90/dGwSUdrM2T/Y5iH1CYW2+XG6KuCgIZZfmuOY5oTsvNhGSfJI3KpC?=
 =?us-ascii?Q?dGx5/X4Y1A8Vj6N4b1YHfF4WvJH7wQGq+Bx4EB2SOO8qghleLCOui4STN1h4?=
 =?us-ascii?Q?zUQaEoul1VQkUuxsqPfl4gWCyVfiRfX+brfWai1cKDjpKSlvJIsxvDqor3fy?=
 =?us-ascii?Q?ah8scxqvFtz0NEucofrEh/lFlEwHfXH5X3s4UIzAjIwfxJNbBReqZHaV4lq7?=
 =?us-ascii?Q?ugoES18Z6vJRStsap4sd6ZC+Ot8UeLlR0Do0aUr5YAZi9DiJRRlKOW5QBE68?=
 =?us-ascii?Q?p7AFSfpaXSseMgYXtZoJ2iBCWzgNtPNo2BiFMGd2b513TfwCBr1U+GA6rCwX?=
 =?us-ascii?Q?V6D/oflGR0DXwwyg0jNIKz3y5FvRTSOuuOrdoOhgSXL3ukr52Cy9qxoXq+SM?=
 =?us-ascii?Q?++6mFZ5x6NS91zMGx/CrnaFad2WRd3yjzLHdavtR6FcmbWlepnC9XgD9dD+J?=
 =?us-ascii?Q?mivzBOkSEUvr0RaORM5ajmGxe+z/QEe/zXmQNyHz68uKKX3OU2oHZWq9UJ5d?=
 =?us-ascii?Q?RdsCfnlkWjYGU2RxKaTcYopsqXaIsLDWPxXGlHgGtD8ZkDxRh8Sl9Oq3RbI0?=
 =?us-ascii?Q?S4iVvSUvRUFaxn7KS4SKFGbdRpJcub58TAfaSgCgA8g93+5MW8XklpO5mg/T?=
 =?us-ascii?Q?t1rGD1CDW7L4a2SyDNlwP9vm/iV3eRIAYtbzz23UVMtWZO86NRogxLvNBEYR?=
 =?us-ascii?Q?XtaAwm3lCVrExA5UvzmR7VK3br5jvQXj/zaGPoJHie5nRFUOp87klr5a+2P4?=
 =?us-ascii?Q?bbdJJ0i/r+tN3c4yiUzGh2aGmbOir32qxCgA2bp4w243Wyz4GAYAWFys4+vp?=
 =?us-ascii?Q?wQ3CtPcu0YIf/Sp/edrOJAphKRuZIH9bOVjYJiXpDNghjQjKp96VMcS1gYOT?=
 =?us-ascii?Q?x7jokUzqyYlZGVmaZ5h2hAi7hGqfihslLhtxmnXwe+Dt9Z4J3G6XglBfojUG?=
 =?us-ascii?Q?AONj8mhFp6fICkrcAYmYzby2Os9whlwg+W0oKPnY4/6fUHiLd6OBIPZVg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: busSNGMupixFoWxSWriV8SMeD1c+HJc1c7xVJjXNzBrpoXPXOh51M1YS/2eVRkiYpdcSGCWQbxIV8AorKNvSTYfxT3lipHWZA3rHRru5L1F13vgbxSjTAYeboY0nQD6clGgPazFyibSmEW9nSqzgGgEefrAw8x6EIbSnn/QlE81d02kRf8CGgESMDq9mav3d
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;6:Sj0lMSO/CNhKXo42n9NxVmDPPvBkIq040j5Y9KLAhee1KV+LRCUFLxM6aBmGAZCO2Bep+PJFTSqdZiSkMTEsbhHZPNFC1PDHPQx2oTBhJl8PkMfWfAM7VIsl0xZ8eyqH1pGwHvS/76xNihL/UZ9aYH55cjd2Q7gQiyO1W/+PYudgOleaS2EnCa9u8+jXTDSqNF3aEsjYKCov6q78LlrBi3PqHv0iW49dUP+jDTShg6fGXXWzHn/wlA+GAce4b+VQkIvY8zozHn1Otihjfsgyq1ZFBnyskvpFwUlTOXb7MpkUtX+W2cXXqWsew8XgrTJV9wTLkLy5Wi3VNvGnekQ9WBYG+ZiIZGjR6W6KiL71VV8qAj/oZymtQZGpC89zoLBvQi6pOKz3MwdDVpep+vFvZwx7Osp1zKcw4TzQYESSn9wfuRzgdPwJNR9wnqN3w6JzAuXoDCoOI7/yeRHZzuAQMw==;5:xm/z8z1CtSjBNVAw26vJpXFh07C7klQQlYA4gh1uzcr5l9IicZaO9MslsWX4BcpfKJ+E7pQspAUh8pcA5bRv6TiWNoD4/We0eB9X4yuMSTX7YLcRjxutwOt0znco7+z8UmbSxm4XK7wPJllxd93VgaRRwOPWoaznD6s6mTlNfjg=;24:a2ZzvSKYpbJAGKMCdyMhzqNehxfuTekBIgOa3Td8X9Yqob9IbXgdMIiR99YcdiNwmFDVavwQsKEZU5r25j8pud02cx0bVow0Zz8OD4hoe7o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;7:FCGz+zzfoTvBgHjNWe/7AHRg5a5SSWs638D+eN7i9VoD+aAIiVo6JAJA1RjguW+E+tySNN0T24WxTCGMq0NOqJMaX2lLYuD6u+UEOqAE8NudEKN8zr5uBclBQSzn4c1oNntaO7cyxqwHrP4A8hqJEJ7JbEbHehhi2R5PVJwm8zx+Ih9I2iLTk6zC+W4g2WAPC24smn5nMJkTED9cJBw1ub0j/Wh9oDJXnP1H/3jM/rP6xiQ/Ih6z5w8bhL2Eqj4g;20:XJ6iKTNAQ+OaGQ0KESLYNauWMuYxbDwkrrUtqvYAaxJYcmgma2TTRcjiKQkaq32Bf/FlDyVE7XuNsVCGx0pSuzwFr3E9+NiFUA2tWVVx049zDF7syF565vTOrJm+WMDoF82CZRLvtCDXTGeZ93hCZ5f0ARHPoFlr9PFp8YJT1ngJwzN5xCLIGA/CuRNboQjTASWuUNFW2Fy1FBKGs7W34ieqCcfj7mWbna0yI4A4Y1X7B0gtgA5C/yUBIxyluW5X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 18:49:55.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14672db8-9736-4a74-4b48-08d591b809c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1919
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This series adds decoding for the IA32/X64 Common Platform Error Record.

Patch 1 fixes the IA32/X64 Processor Error Section definition to match
the UEFI spec.

Patches 2-8 add the new decoding. The patches incrementally add the
decoding starting from the top-level "Error Section". Hopefully, this
will make reviewing a bit easier compared to one large patch.

The formatting of the field names and options is taken from the UEFI
spec. I tried to keep everything the same to make searching easier.

The patches were written to the UEFI 2.7 spec though the definition of
the IA32/X64 CPER seems to be the same as when it was introduced in
the UEFI 2.1 spec.

Link:
https://lkml.kernel.org/r/20180226193904.20532-1-Yazen.Ghannam@amd.com

Changes V2 to V3:
* Fix table numbers in commit messages.
* Don't print raw validation bits.
* Only print GUID for unknown error types.

Changes V1 to V2:
* Remove stable request for all patches.
* Address Ard's comments on formatting and other issues.
* In Patch 8, always print context info even if the type is not
  recognized.

Yazen Ghannam (8):
  efi: Fix IA32/X64 Processor Error Record definition
  efi: Decode IA32/X64 Processor Error Section
  efi: Decode IA32/X64 Processor Error Info Structure
  efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
  efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
  efi: Decode additional IA32/X64 Bus Check fields
  efi: Decode IA32/X64 MS Check structure
  efi: Decode IA32/X64 Context Info structure

 drivers/firmware/efi/Kconfig    |   5 +
 drivers/firmware/efi/Makefile   |   1 +
 drivers/firmware/efi/cper-x86.c | 358 ++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c     |  10 ++
 include/linux/cper.h            |   4 +-
 5 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/cper-x86.c

-- 
2.14.1
