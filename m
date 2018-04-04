Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeDDSyz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:54:55 -0400
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:16044
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751231AbeDDSyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:54:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2 0/2] Base enablement of IOMMU debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Apr 2018 13:54:44 -0500
Message-ID: <152286703837.3286.11286329185822795742.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:301:14::30) To BY2PR12MB0694.namprd12.prod.outlook.com
 (2a01:111:e400:52df::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2945e051-e01e-4a17-4232-08d59a5d8b23
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0694;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;3:U6x9B+ZQ6V6xfWmyTYBltN6AF4av7pjx9jaUqD4IUuh57G8GTqjhk7Gqlei4ePgS5VPkkCcCH53ZQRrLP8HS0qBDo4ePdi4H9col4i89g+mBnPudi+WzEC/VfrH31wWPRD6YaL9tehIKlWPLrqUCf9Yqryo3XPyKiGMEDUZYdIEuVWouAvRZdE8Ow2CleL8GOIFT2AOj9VTQSecLQZgBKV0wIXrg6dELa5wUyoqnGDhv4PvLRz0BKTJWlUDVukXZ;25:l9Whe6FNwOXyIGTdCXPLITblWnYvN02+qMmhwYqqVXmhLw/FS3wh/b6XZiJMA3z7BVX6VwCTVBRw8Bl8hz64lew9n0p9agpho10GJuAlezL9Pg90s3tEeP9KQnv0gbHZu4nfMOWMyPU8lMrAK5Xum5Qyb6ncfTxSUYODmy1gsQeSKPA17TXlG2y6tmC9WLkRrTVKVSJ4AYbeQy+isfhm8gmjlMFT3yZRMMweWZU2S+Kjz7D0l/AlXV+JcR6Y2+AQoPg99u8oZDQXdEsyk69+d0ABVtRlRJfLRBkQK0JpF7l6P/mqmfLhZ5FHDHxkPa1va9yCvz5o/nIMMHn1SQYHpA==;31:UybXtyGPn068hxYvG+7xPxVoKg07BRD+VjVXa7JX415JPzar8XFBUkHQWY5GXZYuXZmQUj/DMitFZq8ggN4Wr1BeTn5Zx3Qgl9Wc+eO7xD1Uq/0XZ0X+ivb8h8A/lm/RP9Ry5fZtMvMf0OWcoFDi+i9Le47GstrDCKU9F5KQ6b18WEDoS7VwHH/sCrioRn3gaAkFQ0FrOwJWDPxGoKa339Ip27hmjyw7S2OXfC624Ys=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0694:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:CwruBYIPMNW3eVqXT87LA/0c656MOGU9oKDZ95D+c9RX1H9xS1oNWsrczrc6b2svbeuvyJ5op9U9WWr27KuS0dbdxVXH7NDvyCgcI91oLlbzRDl9ta+Dzmvq1cNEL5dLtRAdp3PUIJYu38H9AZSRa2gf9zeIbjnqTqSVb+rrdoD/3M2VleofKnjYnR1czOGOZPhoSBc4izgsbIApqg8BQkvY+yV97WrKt9S0pbimUz69RRSOub16yDuWUkiYrTjByWmnTlGNTboIFl+Z/oFxpk3/xZ8ZppcvCra4MV7PM0Jf8RNxGn0/PhzO07dEYc/Q5sdWTrNNEgLY6Fbl/uvY732tlSFQU76lkeZUEX1dT9EynJTQ8E8q+Gn4SEB+tiBMpVowfVosOS6JdeSgSBNe0lPU2YSddtAtitz17RCQTZ2XioT/jUGSRuUa9Gkf3r4wFZzG7nZXCrat5gm1dDktDzbj1HyLcfEzM7JnD/jIRbCD6TF/wydI1MPNx+wiLvIH;4:syuxyrGpEh+glvt5sp74vvNQpXGlw1PXxHHi3HmjE8RHiHDpSd6ocAWI4Czq7KMPudePUMz3GfFKHFb98LLr2zHwiZZctCXWP/cFT+kdxptCEK6H4amH//FU5F80NDekB0SdzmTLST6AQz23L8MsF2UzA0bQ4c9XyCe0UhWXPx4etlesKR3HEnGVwLaojznnr5TgM7YKjWRLBsmlW1ER9X6xh47OWI0qFmwUinB5Ozk4MOioIh94l8jnMRvsJiQykTuFW3tjKhPpspIXxQ8xGA==
X-Microsoft-Antispam-PRVS: <BY2PR12MB0694B0A3A5488E2B0E1D75F3FDA40@BY2PR12MB0694.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0694;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0694;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(66066001)(105586002)(956004)(50466002)(186003)(97736004)(72206003)(26005)(77096007)(6116002)(7736002)(3846002)(476003)(16526019)(4326008)(25786009)(478600001)(230700001)(305945005)(33716001)(47776003)(86362001)(8936002)(106356001)(2906002)(2486003)(6916009)(316002)(52116002)(58126008)(386003)(103116003)(2361001)(59450400001)(68736007)(6666003)(33896004)(23676004)(53936002)(8676002)(9686003)(2351001)(6486002)(81156014)(16576012)(5660300001)(486006)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0694;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk0OzIzOkJ2TURPZVhuRG1aZnJzOTR0SUpKSnVnOGJk?=
 =?utf-8?B?L2NhSUdmdmNZZHJGaGN0ZHJ0TDhPMFR1TlBneE5YWlVWS29QVmRSUjFtQWND?=
 =?utf-8?B?QVBYaWpsRno1NnFDV1RlNGZDRjQ5Um1DMmNXWkNuRGRybjNDcU9UL01tbDll?=
 =?utf-8?B?RlpuS240SzJsdmN4KzJTcjBQL0xyN3NVY0s3TVBORWsyRFZOYlZNMm5iL1kv?=
 =?utf-8?B?OGhCRjVna0tiOTNDQmFDYldmZlVXQk0wMEpVTnhJeXkwVjNuMEQ2VmpjbnRk?=
 =?utf-8?B?ajYweTlHbkV0UzUyTTNOMGRWbzFnSUprZkFUT1NBaEV5Z1JJbDc5QzhyVmtu?=
 =?utf-8?B?b3o5eGNLbmhqcVFZYk1NcnEwYWl1b1kreHJGZjNwWCtBMkw1aWFlRm9Za0VU?=
 =?utf-8?B?ODRtTENsU3JNUm5PTUxhS0REK0ZVY2tMcFB4aEpUcDNxOE82bW4zWUtjdWNJ?=
 =?utf-8?B?R3dwYlRjN1V2dko5dGFZS3VkTlJvYlNjM3Rjc05QTTJqRFAwdEF5Nms3Zmwv?=
 =?utf-8?B?L1Q0SDNtTy9UU0dsaldoRWR5V25Hd0JxSmlZaU1vYTRodUR1elNoL3FQUWx6?=
 =?utf-8?B?a1NBZVdVVmdDOFlpb3ZObjlKN3NTb25sODFWTkFyaWtCOXZHTGF0SmlBZWpa?=
 =?utf-8?B?anJtRVhJLzZ1WEFNa0czTWhyWWlneVZMMXU2dTdsdStTc1psOVYrUDRvSHVh?=
 =?utf-8?B?OHdSS2VKWWNGU3dvQU1VRzRseUQxWDFpS1lNbEpML1FtUy9ERU1oR3hMQ2VJ?=
 =?utf-8?B?TmM0THlGZEFQYnNzQlZOcE1hMHZWZFZDdThIb0pRaFIrYTlQNDdyM1NBRUlo?=
 =?utf-8?B?ajJMTHk1L3Y0RW1ucFAzeFVZb2JFQlVwV05Zd0RVWDB0M0xZQVJRWFZ1OHlB?=
 =?utf-8?B?dUZteno0Wnpuc3F0VVl5ZmRmSENONlNzTEpzUnVvd2NlQ0dzWFJyUkdjQWdo?=
 =?utf-8?B?Nkx6dUprTmJPS2xrSUI2bUVLNFI4UTN3ZTNLY0N2Q0lLek00UVZNaStpU3Q1?=
 =?utf-8?B?NHVQakxhRDlTM0JhOE5pTXJWdXBwK0NTVEdWek01NVpKRHNaZG9XbEtsSTAw?=
 =?utf-8?B?Sk1GTlBINk90M1ZmNE5IZmc3MmljR002WjF4VWUrZnNIZisxVm85Zyttd3lp?=
 =?utf-8?B?N2hSV1VzZFV2TjVHV1oxeTE2aE9lMVpXUWQ4bjJmNzNRYXJFRGkva1Fvc1dL?=
 =?utf-8?B?NFVUenMxN0M3OEhOaDh6dHlMVFFBQy91czU5eWorUUFnaFJCaEhzcVRXcHhl?=
 =?utf-8?B?Q0tqRVJSS1ArZ0k5cVlsck1ZQ2F0dXd3cGdMTnF6S2NWeTUvSno2cnNOTG1H?=
 =?utf-8?B?Q2dvY1B2bENVbHRCLzZMVXZTaU9wdGhQRzdVcll3MTF1aUllWVZaVkw4bS9T?=
 =?utf-8?B?ZnJDYzBMZmF4VU1UcmtGaGRHYkJQWlRERDZkQ2VpUnhIbjRibzhFTjB0SmxX?=
 =?utf-8?B?cnRWSzJOalY2VWwwTEdlT2VHK0dpekxmOXF4UEtQcjl6VFA5THAyNlYybm9Y?=
 =?utf-8?B?d1Vyb1RGYUVSaklZUElRNnV0RDNkZGZwb0xFaklnaG1BVHdwRytkTE1KMDh4?=
 =?utf-8?B?Yzg1bFI0MThwN3hROWdKVmFSem9kUnNRV2o5cGhGUUduY2wwMm1ybmthTlhJ?=
 =?utf-8?B?SUd0NG40eWZzanBiWnE0SFBBRWFxWmlZVy96blMwdTF2RTNVK2FxckwzTXBC?=
 =?utf-8?B?UW5DZE9Cd0lMdlp3clpMSkZrYlFyZVZXcG9mMnVYVnpibHIrOTRlUE9LYnor?=
 =?utf-8?B?RTU1NnYwZ3Zrb2o5OEpidz09?=
X-Microsoft-Antispam-Message-Info: ioWnDvnnYWieaM+/G+Hx0Xe956TDolBhm3TCHMLom3Rmuj0PgYEUbbCSNS11s4ZQh3YKlSrWmS8cv0V25x8X3rqouv9uo9egg/ovf5Ltub0b3DOgQ7lYQa2TS9G5MqlqCD8tKfyEGpvQ4pF60MBUhlS/K55NqjZeh+UYfqA9DqJED+KENhN167UYAmfAgO+s
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;6:LFeNMxqoPpNz2jzCbwapVoZNlWaw2r3aITFNs1llyjDteWbFSDm/Y+liFoacKky4kOoVRDfnFfLMG5TX5C2Xe2b7Cmpv/CNkCUcdKWXvDdj7BtWZ70NY4K9lGtMppl01iB83ssLQuSkkcQ6bzkkqxMq1ED7T5snWJ3hjdgO8Z2wEJSXoK049Cr28U0YaxYekhYnTrDmMseGbBi+a+svjdlX/bf9oNop3yCO1U2WhtF6xIDI/nCQTrE7FqUcxe0X3h9MRJyqtMgncmsbuxN8SAEmo0Db+uIlA7wKSaAn4zLqTaOqiMefT+ddIAgNE3nx8nHSiYpgrO79ks3/FGkntyZGafGhS5D6Nh6dZ/P/4k+hNX1J7pAK+ciktMo/IfSXt/TZkAFX+6Wl8ntZNbU4ofZpeMYWwd4o6lgpR35UvoY9SjvYvH1yvubgHoEnnBGXdcD5otv/Zb4dBM1fvIUgy9w==;5:ehNGHscp2hNCS41uDBSn0IoXENFyKvt5lAP7OYaNo6Tn87oRwjn2Qe8Q7BhOi+GdzB/ewCzBs7HRmv1LsLziVdBI7wF/vElZPBDAgkVFFjszDdg7m1mmw17NMx93+tju8ArSVwWfE8IqM3Hm+4RdZlYojI9JGw0ETraq4/096No=;24:Q81aYj9tYKDSiN7lxOwFbauv5N/wJdwexAi9uOcffvc/BAk9F3CIGOCN2R+UZAfoE0Uy0r0WsH23Ckq2OB8CbUjBMHm5iHrlUOzjy+LQ3PI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;7:uQtx8lFcio8M3QJ6mt50BzhN4+vzrUYXY5ZwFnRmwzr0x09YAzceOJlu4bkDYnPqwTGhcBcMdezPKLhBQipxHLTriSuI04ONGwl8WeMSRvbFOLuebXdyp4X8JxnJG0iQsfKfAZYCEZj7lMqNK5GSuqBz14Urzg3IPK2rRLEUx3qemCLDB1kwqHQbf38i+R1F2gDt1bMKf7QE6T0oB7XDwxJqzymq99wKgfmMjLb9LG5VCCP8Iq84cMSMAmdSuQCj;20:qFff/T5EUqGLHkMdFopOLccqcUrZmO+DRJ7A72/cowSdLIOs6L6YOwPTxaWwpeNJ/CicY6XOEXjum9+qFpC7fdphxC4KbHfjGd60eTtMVG8WCzXfMjlpalQHKvGpd5qqvRJBVmaXT+V/XfMag7xfws4HnGCI1oeo06eBrZkjVLP0HYiRzqSDNlN6Hb/BT556JC+XF7bn4gQ2ZJulaEFSQTAvde2YicX9MQizV6VwXNlym3iW1AR8M+UJ4DqzPwAE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 18:54:49.3365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2945e051-e01e-4a17-4232-08d59a5d8b23
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0694
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches create a top-level function to create a debugfs directory
for the IOMMU, under which drivers may create and populate-specific
directories for their device internals.

Patch 1: general IOMMU enablement
Patch 2: basic AMD enablement to demonstrate linkage with patch 1

Introduce a new Kconfig parameter IOMMU_DEBUG to globally allow or
disallow debugfs code to be built.

Changes since v1:
 - Remove debug cruft
 - Remove cruft produced by design change
 - Change the lock to a mutex
 - Coding style fixes
 - Add a comment to document the framework

---

Gary R Hook (2):
      iommu - Enable debugfs exposure of the IOMMU
      iommu/amd: Add basic debugfs infrastructure for AMD IOMMU


 drivers/iommu/Kconfig             |   11 +++++++
 drivers/iommu/Makefile            |    2 +
 drivers/iommu/amd_iommu_debugfs.c |   45 +++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    7 +++-
 drivers/iommu/amd_iommu_proto.h   |    8 ++++-
 drivers/iommu/amd_iommu_types.h   |    3 ++
 drivers/iommu/iommu-debugfs.c     |   58 +++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h             |    4 +++
 8 files changed, 135 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
Signature
