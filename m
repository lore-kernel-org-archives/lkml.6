Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeEKOeK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:34:10 -0400
Received: from mail-co1nam03on0081.outbound.protection.outlook.com ([104.47.40.81]:52554
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753091AbeEKOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:34:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v6 0/2] Base enablement of IOMMU debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Fri, 11 May 2018 09:34:03 -0500
Message-ID: <152604905217.106201.15533883255216330970.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:802:20::42) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1449;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;3:e4EpOnAwFjr4znDjqGcZb3aEWIe0oIs3Ojkb9YuwMBxf5enJp445GBT5235B84QvBjl49u5KD/+T7NDeA3bJ8iAs/p4dOYFGz+ySMVPtSCHKasQ4WGi5L2xJlgiu/5w9OszdklZ3B19XfGBQM8tdCff2EPjtNgAmjCZs/oyfcyz/HtNgWMD7sT0YocDIZm8sR/+ap8IiWlqy3k0E6ONeCOcaAJJWUREIdUUKihtnvruRpL1OAaIuoIuWRq5CYFBr;25:qIa6OdYNV47fkdsY5v0JyGRDJPcgW4wyC6hTV93ex+Y+sa9tniTmZUbh6grz00hMdIKSHK0tv/Gtain4UVnXe4po7A1qcPZULA7qrbqyo4ve4aqwR/nilBhjp7wyKkCiJ7IFc0GoRrMJTboFoZTr/mwzZ/nsoBohLcOaO68iDZfmplEk/P9Q9URqBFAK6uwZfyrpAaXqhkXU3euQNYCemuGNTnoqU/i9dL/bsO1n77UmPk42CigXe/KpE44g/AqwHxTg4CB/FWukk86I2XF7jEFnfnzH6Q6jjGfi/8cHvwAK24t3iw88BEXIccXBYKrwgm+rXqja2lmE4K4w1wmHtQ==;31:yx96UKkbsm/BcGkQz4kdwRObhimzNYyJolWVX+cWh9b48/OO+fsQ1nZ074gQ6oVKqWBBQzs4y+MTuym2E2WF6JPpbj87MwPTI+4ZaQb+RzhRc1wWcxeUMFjmEwLdDdwLl6LArVjhA8IIQ9U6Mr+8ag+ddapQGgqxEEU5yLsWzPZHy94ZLNuPCdsz97zCPi5ctZzEdqsQlongHgKCHNl/vu1VEK76KCd7TMZHmHy71Cg=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;20:/SNXEOp0nME2C6mzsuMO/g/pL8Y190urC4BDXOtGX2vRh7C0/Ju0/AFsdBZPU47iFriYT5/d17nXcaZXfRIt5zjZGYEhA7jsGOX0UoDX2ZVqxRILS7sw1q6o5aSC58wIE0Vu6KFscotbu8CKDWz9vojb6r/of6iEKt/v7fHmzArj3GFPE9RLUst9i5eEqj4RKWa8DcoiB/92oMT0XDQYmArwPDZABeXTWbnoDVggFypsEXzPvg1Yh8q3dUFa6Xqrr1+d+QK/xxBvHK0bR6PHjzmJVxPMJd364cZdM7AZpew7GPt6q9NGJN8udYOuUYMsUz/JTNa11fJ09Ok9W7/H5ocier6OmIeWfYItxbBGq6T+Xnp+Lz8140OSqzxgxA5pFCZovsX1J5H54gGAdS3E4XeLtRSevatUIjUnAcQobzN1AUpImw+iViF60Hzse1yHHCAY1TUUYl2duZTf3Ht16JWZkomLy2nuV8TWU7XRyn+chk7Va2SZ/NymsuCI4/J3;4:7Z7OMT17XmsjXElQQkdGVsYM34+EBKM5Bs4Z3nNyJlP38qSPKs/ff1/J3pm8bFpUqRnUwmQF1akE3YZL3sMRE48qMWeEd4yRqVQkSN+rQFsYl6jJHH44EYA6uydIHbX7HPNkDv0tHBRrKtydxYvYHEbHY4Mc5fi/4RwIL1l1nBl98LjU8hAtdMABajFeSZEa9fOOJi8pcJhHThC7W2B3aIrFGvEk0jC64sqnt4Umqd4L1CuGG/x/8vZvVvPOo2fvCmKwtVsaP2h97uHEsKT0TQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB144904CC2C763FD927FB0F57FD9F0@DM5PR12MB1449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1449;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1449;
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(39380400002)(199004)(189003)(81156014)(2906002)(8676002)(956004)(16526019)(5660300001)(476003)(7696005)(186003)(66066001)(47776003)(53936002)(7736002)(305945005)(50466002)(316002)(386003)(8936002)(55016002)(81166006)(486006)(58126008)(59450400001)(23676004)(86362001)(26005)(52116002)(478600001)(4326008)(2361001)(25786009)(3846002)(6116002)(2351001)(103116003)(68736007)(106356001)(105586002)(6916009)(230700001)(97736004)(53416004)(2486003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1449;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDQ5OzIzOjZyWk5nUjlRZndxSGpqb2JhQTlRNllGVTEv?=
 =?utf-8?B?QWRDZmx6UGxRdGdNMjUyWDBGM0UzcWFUWWZmRXRIZFRua1FlVVVhMWY0b1kx?=
 =?utf-8?B?eDFvYmdobzh6WVhXMXZlengvMWlCWHMxUFQzMnNaZm1pZDZESnQ4WFFFbzZN?=
 =?utf-8?B?SXA1ZG5XVjVDQnczcWRKRkw3ZlVjbjFwUll0ZTVOYVFnVUJzK0N0d05XdjFl?=
 =?utf-8?B?TzlCYjhOQ01NejV1MDNCeEU5WFNreDI1TmcwVW5OMk0wYzNpSVMzVkgrZ00x?=
 =?utf-8?B?Q0dlVXZqZ2tDd1AyV0xYOE9QVk1QWC9KNHpnSHpYd244dkE0aHV6ZnNTVjRk?=
 =?utf-8?B?UEFBL1BsVEY2Uk5LT3Y3M3VpNnlRSko5ZXlIWCtjWHNiSHhVdTN3cXlCSXQ3?=
 =?utf-8?B?STB3QTV2SHZnSGtseDN0N01qeHVlT0syRkF1TzliOG1ETDhBWkdLU1VsUFR5?=
 =?utf-8?B?dHFCejl0YmhtNmJWa0ROdEtBOUMrYUhOUzNudTRtZEUzTjVvUTEyOGdrallt?=
 =?utf-8?B?dTBOTnQ2K2JubkFOSk90c2tSd0dxcW1hUXE0cjlGSlROS1d0K2pKeEZDUnM0?=
 =?utf-8?B?UFo1bFlxWmZGSWNrdnFTOW1SQ0xiM1hQTURKVmVxQS93bFlBYldJaW5IWkgx?=
 =?utf-8?B?cHY4d2l6QmJzcERqVm5tL3d6Vit6SHdyM2x4V2FuRmN4NjY2L1NobDVIVEo1?=
 =?utf-8?B?VS94SkQ3ZWtGUEZNOVduZ0htNzd0VHFUdlgxeUlTblMwdXJZcFNVbmlCME54?=
 =?utf-8?B?aEN0WVZKTm4wVlV5SFB1cmtHRU55dHZ6TXlyYnlFeFJ0dU9NN0FOMyt1QktP?=
 =?utf-8?B?RldQQmo2SGhsRUtlT09vVXBUNzBDSkZSV0V6OG9VN0l6NVZFWG43ZjEvalI4?=
 =?utf-8?B?WWJwbUpMdEtNZFJ0REJXekF3RitLSXZEZE5LSVZ6a3Z5RWVKREo2cWhTVE81?=
 =?utf-8?B?djE5YzZrNVl0QkFSd29jUldRMk9vbXdLdDhVOXVuQkd5T0VoVDJ0eTBnNlJz?=
 =?utf-8?B?bkdoWkVCeXZVVEZRNkN0cStOM3R0eHZoc3F4OUNoZFhzbWFhSmJsMGhXVW0x?=
 =?utf-8?B?anF0aERCbEo3a1MwdlRma2UxSFNOTmE1V3dYSkNlOXYyY2toRUEvTkhhQ0tL?=
 =?utf-8?B?aldCa0k0SWNxVFlTaHY4TG9nWno4SG5QTStrb1c5Sm1MOG52UHRpcTE3S1BE?=
 =?utf-8?B?MExSeDBPQm0xd1FPZUlqdVEwV1NMdkI3dDdWREh2K0dxL1cweFJQYWtBMXRo?=
 =?utf-8?B?aWJzckc1UVpLZ2tNNFlOZHczYlFhTjl2R1U1NXFoS0dOVXpHYjZZTEhncm1w?=
 =?utf-8?B?dXRwOUFzUUxCMjZGZzBDRmxKYThENUtSUEhocmpad2ozTkQxaFAzTFBZK21r?=
 =?utf-8?B?Z2FaN3MwbjFPS2tFWjNnM3hCbVl5T3RXc1F6Z1dGUTlHVllFRWRtaWhGOXQy?=
 =?utf-8?B?VGZtbXlKZUlOQXp4ODY1QWcwaVI4WVpCcFExWlNHV200ejNmMndCQVFGR1k3?=
 =?utf-8?B?MzQyQ0dvd2dyb01BN3dPTUVpZEdmZ3RDcHhVNmRyNldlSzJSV3BtMExUbzlP?=
 =?utf-8?Q?fe8io/1nZsEOSdbFOm9/UNxi8HugPbp290z55sCyLtPs=3D?=
X-Microsoft-Antispam-Message-Info: Lt0Rnc4cn5qndkprUV1MelFJdhBKechE+AIwAAJDPvnVl8bGQ65hmOx1NNYH8d52fYG9J1Up+iTrU5Vi/Ddo/f7YMYQJ/JlDKcy0pyG7p4vZl8kfMHwLGZi8GOq6I7RfAEXG6dKp7Xe5tJzklx35qchY5in0pxJOyOeDmTnURpnVrIWiQl8A7ESWZR7uRn5Y
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;6:3x9loxRthJhyBG1v6+3vvo3ZaG6ScScDWf0fPV6Li0vs59ggZmzsdG15gsMbBZ3ABpl3IIpvIFE5StHyqhffZl9Y8kx3Livxtj56nxAS4+JBmQqF/Ii0s6iyBFb8a0NoTjWgmMqAn7khKpyPX7JxQFF9e0ElNL8inLru/6WziLgoCWY59TgOnPNTAJyDgH+ZoZnQZVbf37ZhRNJmXkF09tyXezbXBf2tnFltCCmQwJPoePF/pTWrWRLmsSXBb9ngxzCjE7LXSsnGGxIQP0oj9/6jeYwu5XNHm0zaIM0QlPyTZej4UOEbuy629/PCnDcOZLVV8roz2SrG+SM+KttxTKV3Pvw1RECAyfBsZXaJI3fJZJyLH7KkoAh2X921NDxLckFkB6BXQgj9t+qJjCu8ZY7wAyvNiCJsoT8mml8Q8wn0T/yhJZlR68VqGUAEKVYf6xV1osUTOO9lDh6D0o78Yg==;5:VQDtJ3PVKcTx1Fa+p2eS6CUCCQI/oK6qg0SJNE3jx9zsRAXFqBWBapwYmKoy2g1HHOrG8bkdbYtAg8ElXDVYC7pYCpYYD2u9lpH44nZitsbIkQDaWtgvZX1jQbogf7AyyNYuPNEQrKJEb9EFR0TPHdXyCcYeDhXvskWu7YW6SiI=;24:AnmBZBzTfzCoG5W7/TJ6vQg6jVI0J7RJMpSm13hKiiDJ7uVmtuu9qwIQENw/6xeWF6lL1yKcfTSRhBB5LWbfuGZE9rKHqm+QbEUTqOBxWD0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;7:Px98fe+hev9GhUeLDUEi2KiGkIthx5h3nBro74lx8XKwLpxxlxsHZpGv/103CbxkBLIYZNJ26VgQ9uV5pkinYwZz5eDODYLl2WUrYrRAvImb6Ruun7k4RCaK0ZSls2cgnW8OLJJb52rYoBbnHs1L3IKUuqUxI/fxxAweTRFxCjIxDqZ/S3S33KnIx4b8or8/uJYj00F7Ar67UNpZhnUsdwN1dekCW3JI8IbvD1fH2LTjUio/26XQy517/QVVhu0W;20:+YCO3SrOO+bJIf7Mwh3PzqwJKAvnKOyhCi72iqsP3ieo0R8sx7k+YDrYeIGjpfUjxac47SuF5E0swFFCbd6JRTBSzHXG2u68RQqRZxFAXmbGWyEP4K/B+MJNsQ7qXSMvyH/7nOKIV5/KtwRGmgGQnqO0On6PX9L8sGR6ZY0MfEygA0136O1Owd4wEfLiwiGqRqgXxzhB+ys/Y8Niir/05Q15NC56neGfSESDUCK1oMVb4vD1Rfn/7a+SHih5yluP
X-MS-Office365-Filtering-Correlation-Id: 2a60d716-3f01-4416-f9cd-08d5b74c400c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 14:34:05.9501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a60d716-3f01-4416-f9cd-08d5b74c400c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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


 drivers/iommu/Kconfig             |   11 ++++++
 drivers/iommu/Makefile            |    6 +++
 drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++-
 drivers/iommu/amd_iommu_proto.h   |    6 +++
 drivers/iommu/amd_iommu_types.h   |    3 ++
 drivers/iommu/iommu-debugfs.c     |   70 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c             |    2 +
 include/linux/iommu.h             |   10 +++++
 9 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
Signature
