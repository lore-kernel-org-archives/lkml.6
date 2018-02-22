Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeBVXHb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:07:31 -0500
Received: from mail-bn3nam01on0072.outbound.protection.outlook.com ([104.47.33.72]:42656
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751432AbeBVXH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:07:29 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc: linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v8 0/4] Prerequisites for Cavium OCTEON-III network driver.
Date: Thu, 22 Feb 2018 15:07:12 -0800
Message-Id: <20180222230716.21442-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:100::32)
 To DM5PR07MB3180.namprd07.prod.outlook.com (2603:10b6:3:df::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 906adecf-95ad-4137-2e82-08d57a4909d4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3180;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;3:SYZ1/96u0gA1JRlKlP1smtZkKw5QfnjQ/iIwdLIIxHjryfb8yPtw3lQTT08rY5Vvjt6J+P5niBtZ96LjmvkICUJHYjJQVx2NCaQuIwb61UYhv2LZyf2aaSLErJAWY00WlJFmI7sANA8HY1JIEiEk4XTBUpT4R9+nb3WdfT0WBIib7c+ObpYiw/cKsUUsAy4x95hgdjGeQXidmJ0pF8BsWqq7rzSRoMsxxMK0/J6QRQ8l+uKzydGNtnAImKxa4242;25:ZMkuvmO8t25NOQ2a4VsYP1NCEHkk0FG7EJ9OBNeniz+/qc6nkFlQQokby8tF91/bvlACMJbQEogLr5o9dvXET1l6KYVCwTjbk9NRZGrIeZ0S3iQRI6DLRCysK9E5p7GmqKLAuV/MPB0Rm8cwIxQn79uUnBcjF7S5srAN8F8W41bAfJC3TzsruxeiGl6A1lmGj/TuOqQnyeWyViO5TshBFLSIQgulslFmgZJPhaHbT0s8i1jkORxUZl7HYQ+cSq3hRDtcIfa9cCk+88YdaaSQnNmxxcB4QAKuoMVVCRfqa19g7zq0hbRryGuPDYxIi+EhyMc1kQW86nweTpPtEPSNLA==;31:I6kf4w5/dUgwlkcwDdmZjqDVKgLGIL41hq/K8KsfeUcI5N3KGQT4MxmMTvGvuEtCHJCY1pJtMCJhGAoo9slmjp755jnX4YKLR7IeToVYnkkHwUywSsOs/GWnOMeHx04n8iMNAikNZJ8kULfr1OxjMpDiHgh+CWQFnT5p3D3DnXpFfZMJUAW4RRs64i6N6TJb6MgyHCvo++LHo4x/qqGt2SMLaxOs4298ktTrG6QPkyM=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3180:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;20:Jm+GkE7PaYvF39pROizZIhArn2b/tIAtEdY273e2WymKBGuGHn9VGgQ3uuLW5X9Zs51XW2AV7troWaUZoEXEzvIMIUfa80nDXilh4bZyeZsbtenb30EmhGsR1X2qSYl8msGPIBWWM4GMGojA2vkZIjLOAqjR5xatDOz2myOmUUipOKQMluVCFpTdRW8RGgYPHV9glDLYrKckbWVjOKRSlogV2puW4ztigYDJiLhEXa7+CWPFEkEpiMtb/svVuXRcvk124UFmDwjFCzxmNBIj35vYeZCLnwODqav1DRkH3QQBLQ5CEO7yF7LJDTBtD3/DjksoHv5bhLId86bEbELe4DkBR4dweEXgbZP/DzxM1Qan7pnojsKTzsnpdX9xnW7DtFAfrjXZ7sX4QNl8hYAKTWVFMYsxUFdiP5znjP70nthjwumBx/SGc2a5/DI7Uyyk1Sv+5v1SH4XKUAZYil/2mA+8F0JEsgqSWbi/NolDG+vOe/kZ14b/jQJUMtnE62+v;4:cb/bd1C98tw1oEF71hxGMEXCjPLxxORRSpROjXjagfSYPvoomGdzVn2lC/Tm/2hWPRxH1+i01DEaqxb28JAowSQLSey3C8jOpb8fA/wWJopmDULVF6HUap2qBL4gkgioO005EzTdDzg3mDReVFdAHYzhCSLHJDUY66ebqDpwVDAi8P+gMpFI0tG58rruLFp09063KLf20wT94bpTEGTXUcAZSzBHAG+nUldRz8BNd604i+Xyj6xiZ095L3ywFAZB7/YeJn38A1yYPIGUGRVXnQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3180A94A1E154E829735CFC497CD0@DM5PR07MB3180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3180;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3180;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(39380400002)(346002)(366004)(189003)(199004)(53936002)(305945005)(53416004)(66066001)(107886003)(6486002)(69596002)(47776003)(6512007)(386003)(59450400001)(6506007)(26005)(5660300001)(50466002)(8676002)(81166006)(16526019)(81156014)(478600001)(316002)(16586007)(54906003)(8936002)(72206003)(48376002)(25786009)(4326008)(105586002)(50226002)(186003)(68736007)(3846002)(6116002)(1076002)(6916009)(6666003)(36756003)(2906002)(7736002)(52116002)(86362001)(106356001)(97736004)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3180;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3180;23:2ZJqHDzd6pdACHg6QeqARm6tKsfNd/O1ohPayGYrN?=
 =?us-ascii?Q?rvcmQ5CxP7lyeQYEclW7tMn0W14uPX1/5cVV/i1yeKr+kvBD10Twt+L79Wgj?=
 =?us-ascii?Q?hVmKgwOvAvJOOFWIElNgY4D1dNIGxkoY8tVnBh+ghf4izIwuhu+FkxV9/sE0?=
 =?us-ascii?Q?uJXQr+UDAkKvDfL6L9TBU+kldbi7zoNsloGilOTALmTmtg5ML/FewRXZxLdC?=
 =?us-ascii?Q?WmCNNPAvqqWTQLCMBgtRnKYL2dwgg/Tjf1UH68xsB5rNybKwcXFtm7PhGCjZ?=
 =?us-ascii?Q?7oHaIMhRG+qb2oUzr0vvhrlhF+7BOiD2rNDIg4Z+D1qNhG1ywOfIYdFIMcmW?=
 =?us-ascii?Q?6eFor74cBOLZNPurouBHtjQJeTdLfAf9eRNZ4PZw+UT5/jl03M3OHPDRwj+I?=
 =?us-ascii?Q?9nmTjRbrxolZm4gY0eMuFCUS18E0UzBxsKj8pRXAC4mkEEoed7WhjwUT4+Cv?=
 =?us-ascii?Q?LN9/dzxioxkqZymLkWPssS0eHN1Q43BaujV5YG7B/LSrze3LTr9hRNfwYBEw?=
 =?us-ascii?Q?AWmWWX93XQtW1AMqx/ZEjCOe6Ozkd6JzBB4vJw7lKFOAoDdU21bRdSMu4tmi?=
 =?us-ascii?Q?o4oTXaxz1FqXufcu61TZkaC/5NS8/KuiZorZX9L8oeg0xeczVpK/7QoQddG+?=
 =?us-ascii?Q?5LYFc/bkQtHtscBBBumWQq/xTlq++1eG3g/sv04YdIBxa1/Jnr8+aP6bT8Zl?=
 =?us-ascii?Q?bqht+Gjr5slNvOz8gJ+Ig1nymWEfANnj1reJWM7YblYWce8+3HdFXYH/gnGl?=
 =?us-ascii?Q?8OLcsZ/bRyLtyrE21Gz/dd5esnIsQM7AgRBmUHuhbcQAjTJAmAtUurTffuOF?=
 =?us-ascii?Q?1Fu3KCO4xuCyRRVFdrTP3T6A4iN3i2BRYX1+N1piqXtwRquCImLPWAsppDwI?=
 =?us-ascii?Q?Xj1jjVxeTrrfNrAVY2hQ/DqSrqap0ksfJ5N/APtRFIaXsGwjHL/ar9OVYp2b?=
 =?us-ascii?Q?EOOBgIkYo0IJjl2i904FcTPp1th9h3lRKR+mfby9Dr4Bdnq5uYENFmHEnC7C?=
 =?us-ascii?Q?ITOgD6xerVqmTMUHgW7W8ozJnbNyCWCKWW3i4Us8v/nHNbvj5xQHTYlH/1Ln?=
 =?us-ascii?Q?X/WFofva1MJas8Ycmf8rJtNSTIYgcHtlNKD13UyTsJ19uWpDsGI2W+CqG3RT?=
 =?us-ascii?Q?t5+0/tYF7TcJunyhIJQ+xLx1G2QSMKfPin3JgImDuWRf6kDBzjwTwzVjidE+?=
 =?us-ascii?Q?oQriinZQWRkrLfHffN+Wsqw5ttp1vpiqTcO?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;6:8s1UAadqnf7h9X7jbw/JbYfTqXDQwH9dEbcz71Avd9HVy04t7Ytbf7Pk32lCanPm9q4ydw8dnaYXOsb6jC4yxcEaNC0ayBpM1ljn8U9PJf+l/J5QYU8L1wOV1fuoTkR5+0Sa/D/uQr4sN5P32nPDTI+tYYwhXNyYXIS6Qx0q9zZUW8086xLGXmBuo1QVynPwlS7jt2dVHWy6l1nVyGMCk86vSdNJylsphSOfJ15j7hukXHD6z0+C3FKa4MYR+vm8DOSxEXabzd+ojgx9LDWQXhE/dB5oSVM5ppwFUnEccoOcgXXM3IJHXzK4utdchPq5ccSc9NAJgwNgbOLs+9KIKNpoADY02OQjIIbqntoyr0A=;5:fsC944JjTvNGzskqCzZiSaa+ujv3Pe9tlveufxGJtJBVKeoY1RDhQDKHtxzo5JKZyg8P1Hnn1cHagLa2m2x7fzUppbBeMJmhCoxXt6sQ+/WkOnW4xGk75cgHfBC/tgWFBiZtVtnFl1Law1GTXWLrlLdCVL1BYmHvMzyUdZDb1lY=;24:9ZQU9AJPs3FH0Kt8FwbBpTwo1X2nKb2eRtwJRbCBkhU1HBwtyZBgS9I0Dnf+dNy/6oEf4K5LYoZTQxzFc34BgguJi24amFx2uN5mrpjWn1c=;7:uLViIEZ59/RPLus6CPs2Wf+ozOkxM8TIbJh8HJ6ysHTS6sj85L75QTAZZvuLNOblWSud4M/DnQElJ5xJb+Q9ZPPCckQW7gFHMpP9nlBGegrosBUKrt81V8b7g417H/B32ZJ21Eta4TlvxTgaZzJFLYDvr06AUeHE0PO3+90CoVUsJP57o4LL35F4oT53oCJZrHnZ1hlGngRuBpeZFvS7CDcgLJCSbaNOI7Kfjdec4lENE8X4zEtCeas++ULdIDh6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 23:07:25.2801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906adecf-95ad-4137-2e82-08d57a4909d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to add the Cavium OCTEON-III network driver.  But since
interacting with the input and output queues is done via special CPU
local memory, we also need to add support to the MIPS/Octeon
architecture code.  Aren't SoCs nice in this way?  These are the
prerequisite patches that are needed before the network driver can be
merged.

Changes in v8:

o Rebased to v4.16-rc2

Changes in v7:

o Splitting of the patch set only.  These 4 mips patches are unchanged
  from the previous posting.

Changes in v6:

o Added back cleanup patch for previous generation SoC "staging"
  driver, as Greg K-H acked it.

o Moved FPA driver to drivers/net/ethernet/cavium/octeon as it is
  currently only used by the octeon3-ethernet driver.

o Many code formatting fixes as noted by davem.

Changes in v5:

o Removed cleanup patch for previous generation SoC "staging" driver,
  as it will be sent as a follow-on.

o Fixed kernel doc formatting in all patches.

o Removed redundant licensing text boilerplate.

o Reviewed-by: header added to 2/7.

o Rewrote locking code in 3/7 to eliminate inline asm.

Changes in v4:

o Use phy_print_status() instead of open coding the equivalent.

o Print warning on phy mode mismatch.

o Improve dt-bindings and add Acked-by.

Changes in v3:

o Fix PKI (RX path) initialization to work with little endian kernel.

Changes in v2:

o Cleanup and use of standard bindings in the device tree bindings
  document.

o Added (hopefully) clarifying comments about several OCTEON
  architectural peculiarities.

o Removed unused testing code from the driver.

o Removed some module parameters that already default to the proper
  values.

o KConfig cleanup, including testing on x86_64, arm64 and mips.

o Fixed breakage to the driver for previous generation of OCTEON SoCs
  (in the staging directory still).

o Verified bisectability of the patch set.

Carlos Munoz (2):
  MIPS: Octeon: Enable LMTDMA/LMTST operations.
  MIPS: Octeon: Add a global resource manager.

David Daney (2):
  MIPS: Octeon: Automatically provision CVMSEG space.
  staging: octeon: Remove USE_ASYNC_IOBDMA macro.

 arch/mips/cavium-octeon/Kconfig                    |  27 +-
 arch/mips/cavium-octeon/Makefile                   |   1 +
 arch/mips/cavium-octeon/resource-mgr.c             | 351 +++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c                    |  22 +-
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  20 +-
 arch/mips/include/asm/mipsregs.h                   |   2 +
 arch/mips/include/asm/octeon/octeon.h              |  32 +-
 arch/mips/include/asm/processor.h                  |   2 +-
 arch/mips/kernel/octeon_switch.S                   |   2 -
 arch/mips/mm/tlbex.c                               |  29 +-
 drivers/staging/octeon/ethernet-defines.h          |   6 -
 drivers/staging/octeon/ethernet-rx.c               |  25 +-
 drivers/staging/octeon/ethernet-tx.c               |  85 ++---
 13 files changed, 472 insertions(+), 132 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/resource-mgr.c

-- 
2.14.3
