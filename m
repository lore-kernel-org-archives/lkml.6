Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeENRV2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:21:28 -0400
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com ([104.47.36.55]:42255
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752118AbeENRUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:20:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v7 0/2] Base enablement of IOMMU debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 12:20:10 -0500
Message-ID: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:805:3e::39) To MWHPR12MB1455.namprd12.prod.outlook.com
 (2603:10b6:301:f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1455;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;3:+tdwdbvG7/YozzsXfaNQ46hvnJ6k1NGmqZJvYw7T3M452COo3m3x6ufbwJXy1+fWBDthho9Gfae8WuhgJuObl4f+a0E1Gpi0Kv64LqmIo/c8SpKpHT9J48pWILrRMfKYIOM+fefLpwad/Og3wCNIv7s6KAfbDDLOR6tVJz3K2TE2OXpbjBXcY1ga5D1yQDtsNNi0Fpzkk86aJ9X47x96Ggqw+NuB7AcMWJhA1cpDLvQsQ8soeIzIy40O/cyiDy54;25:nRVz6DLvoxmWhGHMxvfqN5PzDm+jvPQsjtGyldsHFOmC8WhQMXEfKTx+tiuiFTmgHKBwUtcvHsCI7uehA9YbaEqPm/Apo1I7uLkN6e9193B4DfkME5xKiCVGb8Ekk3caIZM69t7nuUoHdcdiHQlUeWf4HR9nY3xdAevop0K6GeDwUuhzjp+lj+4ISUNTShKHSxGte6QqWzsBhcRNHLGMW64MuPgRJrrzdrBav+uYAv61EaqVv9e3HJH09GNRZnbfTX3alkfJ/04AJTNC28Q0uxTC/FTj+Bk99wnH6UU4/X6BYZ3qcehBhmL2gn0tGwlzRlv6XVyJCflQyagR44NAaw==;31:ai3LjZ5lc4e1Tquf6Z8BEPqxrp6+ffzYQDpD5qxj2uobDx3/990jWCH8OXgGq7BW153+p+xM5Ci6ajn86fs/ZS8uczCHhNOlJgaDCWL44yIqfs3ImsWqHoDPWmHR4IymDWjWn+HWYvPdfsEqHzLTZ9uI8SdS7ch9SAwrsghi3wagpMLSYchKLFrBGNSZqyROPTGDIqGlhAwpPXlw1pcViGNyLj5pWF+o/U2hNam3AmY=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1455:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;20:RKTP3JrK3bj8scDCk07pMdLDdfEPYYDlt2x2laQR1y+EZjQrnLAjm3EB/zmpyBBMfFwHIu08oXDJopKwBFWOuT+uAgDEaqMGjmfmir8f1A9/BDIsyekq1dC8uihPdOPS6TGMmpm/ftqDnYln9BP8o0Sjw8ozx9H9XhDoEzO+BJiS7qw/6rRdrYpU2qAlnHdEPPgWxSQwSZlh7/BpNEdIdc9nib6ei1otZf7wXaoSj+zG2iwkdur+40xGxANP9uPNp1HHWEbDNt1jI6tKX68RxHKOoJjuFLI9gdJI0kXaG+F5xjxY2MA4AByQSSNISTtR9Rd0OWCWS4OocsCBG8cHEW8U1KWbF6OxNBv0Nm7EkVempRsrA+shNBQbh7slzDlM+GTFtcJW+VFG5NDIeN3Ch/bHLxrTIyCVfEPe8gEWLzZRAE+S3Wk+/rplci5o7H1ApZy1TK+HFg9e7JfEWbhQ0jwfHKUKccbl68aw+zXmQDPI+592TZvEWwzCSD1lfW9E;4:AOrkNcRaBkL34g/NKRgmOD4Lk6PBRXhrJXiaydsmnxFjhGc/BqLu5wEGjB9qyJST2n3qgDkY3KwnSucjlj1kpEZI+wMsoZjRxLbqaTVlA7n0XKtDWjAyf33mmJIVR2VhaD4LP2E8r+Ad13BFJd5i3dZ99M/LVdvU9zTH87GUB4rtpqca0lYe2Mg77LfNEu03gjeF83xV+mx7uAiFUSmVQv3aG7vkQvuhPnpkptCrQHfyw/4XgiZ+hxpO4/Pfi1gipf8Odf7s/XrlShv6Tb5nmw==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1455D9D7777FE27DE9EED5E3FD9C0@MWHPR12MB1455.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1455;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1455;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(52116002)(53416004)(6916009)(105586002)(956004)(7736002)(106356001)(26005)(8676002)(476003)(4326008)(2486003)(23676004)(25786009)(103116003)(6666003)(7696005)(316002)(486006)(59450400001)(68736007)(386003)(2906002)(305945005)(66066001)(3846002)(230700001)(47776003)(55016002)(53936002)(50466002)(2351001)(478600001)(81166006)(2361001)(16526019)(97736004)(81156014)(186003)(86362001)(5660300001)(8936002)(6116002)(58126008)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1455;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNDU1OzIzOnJpQUYrYmQ2bEFrL1Y4ektFQmduQ0JlaGRp?=
 =?utf-8?B?VG0vK1hjcmw5aDVGSFkwRnBsTHdpeHZHREhlNjBQTFhkWm1tYUkrWG9RM3NH?=
 =?utf-8?B?QjVpcmRmRXRGWGVjQUdXV0V1RTlsR0grd3UyVGwyRWdvcWs2dXRZSzhpS1I0?=
 =?utf-8?B?ZTZ3QXZQTm1DbzYwVG5kbkJwZ3hwMTkxWUlPQ0VkMy85Mzd3aXhVYzJtWnFt?=
 =?utf-8?B?Q3lEaDcrQ2phNGh2aWVwQ0U2cDc2WVVkVmd6dzk0WWU4aVpyUUw5V3FDUTFv?=
 =?utf-8?B?VlJRT3AwMEJZdXN3SzFhMXFUQzhpRm9HMzJRK1YxVVBSTEgwWHZUMmNXYU1W?=
 =?utf-8?B?OHprbndKc3FuZGR2MXRLNmlsMW5lYjIrcWQ4UFpxRlhvaFZ2bHpiNVBKRWZV?=
 =?utf-8?B?bzhxS2NMZVJ3Wk1GNmFob1RrU2lpWVN5M1pNelA1NVl1Y1RFeVcrc2xqRGlZ?=
 =?utf-8?B?S3JvazVIUWwrNzFodGkrTW9zUmUxM2d2WFhWRzJka2dQQXg5OURSdUJTdllh?=
 =?utf-8?B?Si8zbU9KVzhORFd2bzIvVjJiWFFzNERhTkxCOFU4SUZWLzI4TGxrZGg4UnFU?=
 =?utf-8?B?dncrR3huemt5VjVvOFVXcHdDSDFpUWhSS2J2eWtHRXBaZFY0bXJFQ3pLLzZZ?=
 =?utf-8?B?ZE4wSXQvOWQ4YVh4Rk1UdEplQWUwTnVtdHBpRXl6VEd6OXBHekd2TWF0Z3lv?=
 =?utf-8?B?RmVCaE1Pb1czdlgzUnB5c2pOeTluM2NLWEhRTTN6QXVZbWhERFlUS2syQSt2?=
 =?utf-8?B?ZloxSXNXUThXYWJjcGo0aXpSR1VvNzU3NjdGd1Vudm9kb05SUzZjTmFsYUNW?=
 =?utf-8?B?b2xEVnVrZCt3Q1AxeFZYNS8rbTA5SE5La0NsY2lQelFhbjVXa1BMNHBwcW5r?=
 =?utf-8?B?cldNSGViQlMweHE3M1RlZlp6QVl0OThVakMzcmNPU3E5SWZjWG9lM0RLWC9h?=
 =?utf-8?B?VzArS295NW94UXhTbGgrN2R6S3JrOHE3VzF1dEIvdWJ1WjhUMW5sSjI3Zjkv?=
 =?utf-8?B?YkxJNFVUTTRESXRJV0kvN1ZjaUV0Ukk2Y29xNFZrZW9hejl4SUErNWxibWNz?=
 =?utf-8?B?a3RESngxWHdXQkptNG5XS1dHL1loeVZkT3ZqUGZqZ3IwSW5Ma3paSzczK0Rr?=
 =?utf-8?B?OHRTSjRkQjh6cTJqMnZlYjVZa04xWWhzaHZqaU5Xcmpjb3E3aFJpZDBFNmNH?=
 =?utf-8?B?eGJlYldUbWFyZmMrUWlWYVZnMVFka0hNYW1rd1ljd0kwNUdDWEVtazBEeU5I?=
 =?utf-8?B?Vk1Id0NnYXFmVGU2SUw1cXhaN0w3WnJIUkF6SUNIRGpNMWl6cTdhQkYwRUQ4?=
 =?utf-8?B?c05TMnhrVFYrRllYY3dwaWRYSnVZYjdzNm4xekh4ZGg1dm9hdTl0d1BIOWFJ?=
 =?utf-8?B?TmhJVTYxdFJDdlRuaU8xUElMZ2ZocXpJUEdEWnN1aDNNYzNTMXBhWGhVNkhX?=
 =?utf-8?B?NS9rNlJNQ2E4UEd6aWwxa0gyc0kyWlJxbWlhZ256bGxuTk9jNFBqRU4wYVhU?=
 =?utf-8?B?TjVrRnMvYUhxM2xDOURnUGZDeVh2cjU3K1psdWgzRVRJZGtMTlNhb2hUMzJw?=
 =?utf-8?Q?FXHehOYRjqfmo8mMpFXBQlNQgijeEp7KggOpIMjE9cjI=3D?=
X-Microsoft-Antispam-Message-Info: e75O1Uyy8/Nj3NSIlE2mpJCOzoa7Scaj60nmznzyHaT1VcvqjGxNM5/zlzmHrqaGAU2b/z7xGX6rkfVYR0mGqv8DR/Rv95TpMWkIBSRyYxPG8ad7AsYDIdko8IpofWO+Wf518EggpyEGRja95ZSU/P2xkqDpja8BRsmRyP1IPoZPu+YdtVATDebzXrRFkA8B
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;6:AXb1ldxSpGc1ROYpzqXDeqoYfdHL1e0CUb5ao/li/XGk03NsxQCdwjBhQwlxvMYSEyzHTxTLo9jQNxGfiUSlcdOOc4+ZgPuaJeR1ZXMZh3+gHzJIp0Ua6khEPHChJh9GaOkSFNK+YrbWfgzzSS+qdo6UOwcAEWUJ/oEth8kkTqWh/l5G5m/t9/5l7vy9e5RS/CjJgwVpHvoDMgAUHzUINoDEMrcd/IFoE7okXK8tq7ZM90L6Iqm5f4OUYThpRa7kLxzFakzuXMDw3MS0hGFk/mfLITvYTy7hsBzH3AScyIJ3d5yea0/18XZq0Ynnm0kawdiCwn7TdclfRRSC7+2pC6ss2niHaL9W9HMEsAfHRYyiHZfRsBMF6rAUjD84o2frIpVayNZ0IZDjEZkyMs+5x6CKyatR5y2sgrz+DoGOVFPrhkuoMTzWg6G+C3L2+3gdJCez6VUAS3RNNL4uOEt0wg==;5:B1t2SzGLQWejCSiR1UaAsCnhnrLHGgaBOUAutjlI9sz+JIwDKiS/6rbsEEM3XXwXZPezzkLzigNiCsWbsMJoH1o1SroZS9QPeR1dwnghXxC4qSrFdRFXo6LEo2lmCKB2HhX6sKs4F/Hg5bIRTS5GBeevtSYrP9XYZrbxecxUqaA=;24:G1dcha1GGYj89VBMTlQdd9zm7RAhSXxh2/6X2IB5+Z25J8/N7xSvkcEGqKBk5zpHlDxlXU6VWH+aRZl4yc6wUAMfYp5vKOCt1gETaE2/2I0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;7:LdY6ogX8K2LEON4DY5fGQif3PgxFwEhQGYpSi1MueSabyh72x0oTpmS+XS2brOrZChvikkNo7drQKjm2fz02IgGOLpCMR/RbaJ6n7UXDHzifLaDbMBBtqBfDonWU4FZ0N6btD9u/iSXq+Y5t72c1swbCGf4SccuVKpqGmuoo7FGzvhggnmHN3FgoHHo/cPkEwm/gQndEOvJHUX4+ya13q+Qsb6xNWSdxHxdPQcmWJkUUOwhGtiRpi1yIgnTeUoV5;20:0iYRNX+NW3rQ9KrOHxfpUNtpqKaF7zHoLYj+KtyozLnDA/fO/5R3juhEX1Hu2OTqhIKTg7A+mwm1wfpLggpk1KMAmQnQqWAKWSTLrCUZ8qEmZNSbOaBphnC5ExiY0byHvoA58JssNgxIUECdgXt35+J3mUvZ0RpsQPf5uncmg+UBvIjYPOfyrERdJOpZaWG/GHlFWmZkm/fjr9I5YiUnqBpbJOzgrjoMqqNmTUq/mvWQO229fXuR3dMspieUMtES
X-MS-Office365-Filtering-Correlation-Id: b9452059-809f-4336-7fa3-08d5b9bef51e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 17:20:14.5759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9452059-809f-4336-7fa3-08d5b9bef51e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches create a top-level function, called at IOMMU
initialization, to create a debugfs directory for the IOMMU. Under
this directory drivers may create and populate-specific directories
for their device internals.

Patch 1: general IOMMU enablement
Patch 2: basic AMD enablement to demonstrate linkage with patch 1

Introduce a new Kconfig parameter IOMMU_DEBUGFS to globally
allow/disallow debugfs code to be built.

The Makefile structure is intended to allow the use of a single
switch for turning on DebugFS.

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


 drivers/iommu/Kconfig             |   10 +++++
 drivers/iommu/Makefile            |    6 +++
 drivers/iommu/amd_iommu_debugfs.c |   39 ++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++-
 drivers/iommu/amd_iommu_proto.h   |    6 +++
 drivers/iommu/amd_iommu_types.h   |    3 ++
 drivers/iommu/iommu-debugfs.c     |   72 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c             |    2 +
 include/linux/iommu.h             |   11 ++++++
 9 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
