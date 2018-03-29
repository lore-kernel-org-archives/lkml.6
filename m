Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeC2Wyo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:54:44 -0400
Received: from mail-co1nam03on0046.outbound.protection.outlook.com ([104.47.40.46]:12430
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbeC2Wym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:54:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH 0/2] Base enablement of IOMMU debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, jacob.jun.pan@linux.intel.com,
        linux-kernel@vger.kernel.org
Date: Thu, 29 Mar 2018 17:54:33 -0500
Message-ID: <152236384612.3266.1451709369164076985.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:300:ef::25) To BY2PR12MB0696.namprd12.prod.outlook.com
 (2a01:111:e400:52df::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03a90b2f-72ac-4df6-aa52-08d595c80d3c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0696;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;3:+7cZAp9xAXBCaAYWhjhWPA9/lrQ6hg4O20MNg1/m5c1Gyu10Ulep7nW7PwPrFJLEFrNqNIy1n4QcEdZ5CKUo9wBGq5uFVdcRm9cDzofmyrYfaOXm24ozgrk8Fry7EMp8nUUhbFqyVNNq9gx3exyZLQ0NRQPGcASvfRqtcJ3kwmVQyV+1Xi30S7fDQq+d8lZWSh1J5qwe7i5WCvsnx3gz1F+6iAKdxmQlDuWs7s+AvXFt9HUpl1huwgjuz0m2UuFH;25:r5HZceC7fu23DXZz5/6WFKOkzUKopOkKztCafxKT+R4rUv+pWIziw1FnBOMaZ25z7iXuOx3NSnP1AopwBl0HpkDFPu3IwV7aTAogjk0XbK7SUZ+mp6oxM6NkLKJ5hdIgXhL819OWuab/7xC5KammpynRTJihvigJOQ83PuTbS6T07bFjLEfiuBzXZVhwQpqZKEO3hR/MW4TFpjTBCO+eVNOUwNHbrkkfs9Mmu9FkGn5kvt7mFd8KWvA5vzhGhTHvyLmhPrscYISxxTsjByQ5Rcqsq+AW2lNo0nCBrnbieUlTjz5+SkSLg24bDCMDjpJLEY5xkqO8Hty+NugvtyE1Sipqi4xV/Us/hNTSRxLs99Q=;31:85gPQP3NOuEZPcj9R6E8+5huPxV51OvzqjuI3M66nbAtJmOgUARTIvCs5rbc4g/h+eXb6OOxLs+6Jat4YX/43EAQB2ChNPCKs0uQf9DOE/RaU9PyYuobAFEsbkz3/B6sdvl15LgEmySbzmL8wh0nMNgc2EcX/xKDwGsY9Bgsx23D6IvtC2WTsfJpso8XMw8+h7LfX4WOEKH75ZX4DlfZxpxmnV+hrdhfh8B9lebCUMk=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0696:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;20:AHNM0MpQt2Serq4q+pBKGu156x8EApjcjU3mFZaeo52ZkxGWD+Zf7tOyoQmII8imXBCfEQX8GovG3hmSgVXapZEhx0hmPGxncKqUl886DB5TPGiOFUuOcDS2y21VGavO0L414TCvowZfuZXboASlltx6qKPUU1vs0MN0ud8T+WP/dk8ddQGuUD1BcVZBHisQRLENlxfQH5yUcVTqvdAEVt5BmOjnet8qiOoUSqDJX3G6a2WyQT/xdWmnPIKsgsXI8wRAxKW5jXhhvrSVGBxuU3RnyPjcTIDg41lYhuTzO5DxF9aUazS+Lwo5ZvxThAxBa4tkJLPknNcH9rTJteYDG0i53V8KXDUC+KqL8rAZAeVWnaVtN4T34DXsaUBY2ACUfKMt62METL85UajXJVpMP+79QRRXtiD4QwuwIXKPvBmohlOLlzK60tU5Wjer1J4ZA1ORBj+DvHz0R1ZubiUJ0xsO5pr8TOjFsI3/BumycaDEpkWziqUMAJZ+Rpzxn17O;4:h0rm5dbWBeKB3ER3RF0xU7WKAQBCxiRjZF7sK7C9eeNAGUhw3jMp4l+5uX7GqPkli3NllwZfDIV1qs4eh8OhDu6QbUKv7zTo9DljWGVQ74M77jD7yXLreoRHxz1ldy+9DmgnIbIh4ScBQtUSGgqsWTkdsoOxqe/c2buO9hzSHmI9uMH/33Z+twq+SYcuUaahh661IF86Xi0lTnmvjiF8VrjGGLta9hEPJQxeVh3942N5qvA++sSacH1CMQlEL8xUJ47OLD9CjkzCUVD9C0A7ng==
X-Microsoft-Antispam-PRVS: <BY2PR12MB06965C2760AC0808F9C97355FDA20@BY2PR12MB0696.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR12MB0696;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0696;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(199004)(189003)(6116002)(6916009)(52116002)(72206003)(47776003)(186003)(305945005)(478600001)(53936002)(86362001)(26005)(2486003)(16526019)(23676004)(956004)(68736007)(81166006)(3846002)(81156014)(230700001)(25786009)(386003)(50466002)(7736002)(97736004)(8936002)(486005)(8676002)(476003)(6666003)(58126008)(486005)(9686003)(2351001)(106356001)(103116003)(2906002)(6486002)(33896004)(33716001)(16576012)(5660300001)(66066001)(316002)(77096007)(4326008)(105586002)(2361001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0696;H:[127.0.1.1];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk2OzIzOmxoV0U3Q0pVdXNmZ0JEUkRFTElkR0k2ZE5P?=
 =?utf-8?B?Vml0ZDNNbW8yMGV3L2I0L2UvSlpNSTVqeFZ2VFM3SHpIaDJEbDZ2YWpuNWxC?=
 =?utf-8?B?YVd0dksxeFNVcFdvYlN1d1lXYmoyWnNaaEpGTWxBM21lQ1R0U1U1ZHpwMTJV?=
 =?utf-8?B?eTc4TDZYNXdER1JHcmx6ZExIQXVlWWtlMVBXb2I3RnhVczRlMlJIcDY5a3RM?=
 =?utf-8?B?aDJBY2N4Rnc0ZytvQ2xkZWhjd1ZkVkV0TVdNUTRyZkJnMW9SL25xdEtvRlor?=
 =?utf-8?B?ZWYzQ1d1dVcySkY0VHd3YW96anlRcHFNaWZUYW5rME5nQXQzUW9SVDVaaUQx?=
 =?utf-8?B?QnQvZXRWYVpEZHJCbGY4TzVQS3o0bmJlZFoyUTJMVnc2WEVGQ25DSUtqQytO?=
 =?utf-8?B?TnVTOHkwRnppVXVDZ2ZZNFBpMVAwamNGWUxmRGJDbysyYWROcmU1aFVEclZK?=
 =?utf-8?B?Umd5NU1lbHVXMm1BSUF4WE55MUJZanJkZFFMTm43dGtob0kzVFN4cXAwdnVM?=
 =?utf-8?B?QzFvMVRPMHRhUkJSVHhXU1IrSG1IZkpSRmhFWStkZVczTktxL3BoVFVOZHA5?=
 =?utf-8?B?VWpXcDdFNnVialN1bllFYlpuRStDVjRxVXFkVlBTWk05bzQ4YzBsNTlzemxT?=
 =?utf-8?B?cXVReGZscmxMa2tLM3diSkNadjgyZGNOallhR2c5aS92a2cxODIzMUlkTlhT?=
 =?utf-8?B?Q0t1eFhzS1dSVTF2aU1nQlIvaTBxS1lBY0tKb2RZTllERzM0VWI3eFlhREo4?=
 =?utf-8?B?UTg3NFhRcDZPekMxNWx6REtTQVRWeVRPMElUVFo3Q0RqRWZiU250b2t1N3U2?=
 =?utf-8?B?WmRkL2hIempYU3dzL3BWdkhObEVKT0NNSkxaZnV1WE9LdVFFSHQ5Zmt2Yy90?=
 =?utf-8?B?U25pRWNpbjcwUEQzM1R3NG9NOEMxR3IydjRnL1FVa09hT3pPWFlPb2tDMmRS?=
 =?utf-8?B?c3NNQ2xpMWl5bG5qeXlJbDlEbjcrSlVab1cyQmdwaTVleGkrSXI3TU1LT2lz?=
 =?utf-8?B?QWhGT0p0YzJLWHR3RnJmMUtWMEhDZ2RIdmdPbUFNMmFaMUI4VW1CZ0dRby9z?=
 =?utf-8?B?LzJsc09jaUNKRnlRTUJhcHc2VFV5SVE5TmdFTm5CL0doekREdjZUMTJmd2FM?=
 =?utf-8?B?THZjNFIxbE5HeG5KdDFCNC9OeFp3WGpCdkFwNnEvU082cW45OFhiejhLYmZq?=
 =?utf-8?B?Mm43bXMxSWlwbWM3WkdFaHBHNU8vQzJrUXY3WEVxN054Z2Y4MGx2czdOb3c2?=
 =?utf-8?B?cHpLR09WQWtSbm0rQk5aemVUUUNncHhnL2RSc3I4K2VUZHRkQ0RnWmNvQWFJ?=
 =?utf-8?B?S3JtekRoN2NPQUIyZWpjbk43dmQ5eWZKS29TYUJiS256Q0dSY3JaU3FDd1Rh?=
 =?utf-8?B?NzVSL2pnUlN3MUZwRkpySTRQTzdLR2pCSHdDd1F6V01haXlJdXFjOEZOMEN4?=
 =?utf-8?B?SmMxdmRDQ1l6aXFuWUIyZk5yTVhNYVVINGZvZnkyK2lCWnVxeU1hd1hzV2t1?=
 =?utf-8?B?ZHBaZklYOXh2aUFtZ0JSQ25vSDIwKzRnaU91aE5ud2lOY2dVdnBuS2pwbHg1?=
 =?utf-8?B?Um5iTnpXaE0yZmcwRkp5bU5DMG5QYVBjUzVtWlpsLzBWNU55RUJ2dmJGdExG?=
 =?utf-8?B?VXRqT3lhMFlTZi9tUDQvYmJDN2N1amdCdWZNMXY3QmdvSEFveUwrSnQ4TWJB?=
 =?utf-8?Q?P41gpzl4NRefYKSp6CDxchZ3ZF5yV0S30Ki5TE9?=
X-Microsoft-Antispam-Message-Info: 48FG7Z+nAfvqAJyBQRYPeq8SkdF9/lfERkypmPO8r0fD4dq4ZO9I1uHdkPOScPfiRUmdbhVo/0DF0WQLqpQOIDlVEBfeGBfBKzKZY7ijNMeSDHjcNxnCyMW5stei2LNcQlqEA4K/x3Qr8LqHVLWw7tuJjJVKPXEpls8dOJadIA17OfzvKjce3isqUVwKYzBD
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;6:wUaiB6Uczo/ZWUUqPECywKbqf+Hhg7E0NZwolgvYM1TQ5VOrVvkICR4hVKwleVCXyZe7HfUmp+MiHQCmXNNYZdrhkbV3ZPfHqig9oOa/IkcocJt/tpHP2uvjlX7e/xbrqL2r3KX2EJp7Uqa3BZQ3g+GAkmH7i2LuVWjz7XKRljLosF3gA2LrX0Uz4w7BASE6fAZITfoMk+Cb5r2TjCz2k/9MiW9BC0b/vUvHKJBbe7UxcSY8rhWGOiIaz4x9ty4B0KRLIYz5zCCVDL2g5r/WDeP8u141GGGheRsHakx3hGSxWlv7VeqUQ9KaNFFoK7mDCGTon5WU/CGf1exuZBPOPN0id8ONyzAeeEOqW+kAuFm1QT01fs5SC5dhr8I5/QQ7WuEdXpTGaUmBR5NHWh4YOO8Huf5lQDxaFK30DdaGqYULppkW+bka+gJGHmCqk4Bs+0+Ik9jjKQKxxi/e4lqzyA==;5:I7q71M1Ej4jILS+9FeeIXjR8e/f1MePqx01ce/ZND1eOfx2IwZpk2m/ykJU6ORq/YMRZVHhVXqWqQporMD65yysa+LUBIuIXTJQMFhP0kPh0F4RsWi958X/ZTKWfBwF9qJVMgiD9YZxsEk2QJ02pxqDtw6vY2cvIQjPj3gpWiKU=;24:KU44LczPAQCSUMQjXSKuxZCy7IuHcKFWACKdsIrLSwoVSyvZ31uUvZrYMS3AOYil+G8SpTA6TdUw8uSK70HU8lARgeHReHzn02BCLoVDJn4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;7:4+wxAvxtO+G/XU6AaSmkrTLL5gCkz1LxrW8NkPfDpebxuheghX3gqSZZFVet0EW57T7M0uoKvNTGwTqFIkb/FKET5/Dx7ZrE9aodxOnLRxxHYIjNfQb8OGes9WB1JlwhQfTdXtL2rpMQIvdszyigEm/Hl6ck+hGB9TE0aaq62aCcZfPtNoxgugRTD1jJuP3AlYCeXq/F7dGSgUFVLry/Tg7bDHs1A6ro77Qsl5i1LK+OU9gffNJeSX0jMATnA5kj;20:VlhaacQM/ttpvzZeNM5vxEamVI2c+89VcqrojpMoE4PBAhqFowqQsVXXrAe+I1ouLOGWSRoUb+Is4UorEdM/5KkbIfC01NuSw0O6LZDWFNGErRjj/M6CZGpn5bNy7ntvEZGRakWsosHSH9ql1COkHSSzYryJ/qz2+uzkEfs/Wrii9qO734Ub3pzSzDdjEA/+owybLHhCcFlRHcW6wmK7pwhpSqDYsKj+VTZti5/YpKSsy1ME8XgPb46R9R2hx1F4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 22:54:38.3682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a90b2f-72ac-4df6-aa52-08d595c80d3c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0696
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

---

Gary R Hook (2):
      iommu - Enable debugfs exposure of the IOMMU
      iommu/amd: Add basic debugfs infrastructure for AMD IOMMU


 drivers/iommu/Kconfig             |    9 +++++++
 drivers/iommu/Makefile            |    2 ++
 drivers/iommu/amd_iommu_debugfs.c |   47 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    7 ++++--
 drivers/iommu/amd_iommu_proto.h   |    6 +++++
 drivers/iommu/amd_iommu_types.h   |    3 ++
 drivers/iommu/iommu-debugfs.c     |   32 +++++++++++++++++++++++++
 include/linux/iommu.h             |    4 +++
 8 files changed, 108 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
