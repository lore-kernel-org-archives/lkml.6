Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965372AbeEITVE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:21:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33456 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965218AbeEITVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:21:01 -0400
From: Roman Gushchin <guro@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, <kernel-team@fb.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests/cgroup: memory controller self-tests
Date: Wed, 9 May 2018 20:20:16 +0100
Message-ID: <20180509192016.24944-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:7962]
X-ClientProxiedBy: AM5PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::28) To BL2PR15MB1074.namprd15.prod.outlook.com
 (2603:10b6:201:17::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1074;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;3:ixWgPIk2mPsY1fBzOC8TAHK6M4SCRpqYekbLLR6IASybIm/Y79U5+nMGAhqDL8fsxLFScHJxb/rFxH6makVAtUEtHCFqehfFMIUSLiESWwLXRBIB+ETVFTgoAa4bhvNjAdYXdFvSgmDJDQSSopdjcje/0WQzLZMmoT/4KA3YLnSEYwaJgV8ZbhCtB7rcs/LIRfpQqW3t/mkmf+A89IuHbcQOmNOzSU1NSZyLrRAFl/0pPJUUeoxOzqJPFQik5W4u;25:Rj8NN/YtJQejTgh9urBcuBffWeYcpGpkF9KTMFgC47j6wem0Y+WI4y1JzGRvmR6mTfXqU1LkE9AHDXL8SbZ6dPK/zy++vfFDyiMdLCrBT6nlMfw8YXZPZbfVt3yCl+3L6TInkIq/NZsoH1GEcDfMZOcnK8FJGdhYcj6Ri6dOFvnOpVbIuvjNS9lfRhtjDWgFEySmw+rEEAw/AlUHiQOnTMxJgpuh63WShzaGfUzEoFc8BkwivYSLzlqmpUOfCPR6EY919ujwkgOn2SgsrKp8QBXc2I3vVinz15Oa05chi1c9c6i0UMJuMtm8hsxaBCHeZ89W44bugCMXfIIpWz9G4g==;31:Vr6ua6nqn0jwjDdeTEpQh9XqPstfr+tGYzMpAGVUDwAWvaMHqOWbKetwC8WIjltJA9yTNa4+BSKaszKEQDJ0rJwJv2C6HKJT0nxsDjl6nUfT3LUMvkb8KrnnCKgjpPztyVH+7d03/lEx3yKuqxLCMcsof8nCWNtFYHK8cF1n81Q0rKpieF7El1mYjpydQ0ymMZ9HZRWFVp05Z5lQNBynbfX+1G9ztQkEXHxRDtP7XcA=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1074:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;20:YpcqHcG4VnyEv0pUChDv2iTL6mBhzUt/obWowTXD3MpRJdz61BWA6BVxSSfGI6eh2uoWk0l3siSJAm0jxZ8BHCGTbxy/FKHcs3pu/BcZaE623m7K9mCP7f27LSFzoTU+Sa5LYmeSGCNIVJwfEdtVPvmAv/ZVBf9YYaBI8UlMUf2XjOH+lWnsZZhWlBtRBtysSHOqCWk+AI668dQAqRU1ikQgWKE15k7fjZzXBe75Gg7CGN68sdfPi5/L50Cr7VPnBlXLa/oC25XVY7BBEkxX+Kyz17oq0IFGiSrIP50ytwfTC8a224Ir1QOlxTBTEKT8Y1SK81tWwRdypHDb68XBCp+DIz0GmESoBFsfxyb9qLeMgH5s3Rwy8cbGCplMl8HvgOavWFjqUbnD+QC8OZYwVOEmvfNNalARyS6WtX8yKaJ1rNhglfHhkn4IBFfQ+M9avUe2jPEttDnQs/AlTv2rtM3eSX5Pef/wBG3Gqtvamx2RkEfSpEAvwIYLv1aSIR+O;4:19L8fQTCS7PKXII+R5KLdraUCuXVXtC+S6gzrbwCi0xR9RvslPVQLx0JE9fLckitAtP8ICxRDxSvzkoq8A556gNXZTlUP/Sqc0jXb5ox994/y1IoUVseXms3qS+v4PFRH6vJ+7s88wN2A9AKZq+AL1oSv30hWOzch9v0yejBdgl4Agwu1nOuDha0/8Wf3ViojQAgtMEk+rK1tByefwCixEk8P7HK6fYJpmDib4kRIjCI4p4YrLa3PRaw0xrAVMwR3vJNh7j3Qk8uBcZUrlqcYfgS+yHF5pa6MCn0f1RelC1x8lp5P8AOPHtqwoYhXr+wW0NYRpdfckdoC+ldWpoIREB3gx/7dUxhdcuD1zWdwLKpnNrIr4IS3qL2/bceiUhq
X-Microsoft-Antispam-PRVS: <BL2PR15MB1074587DA02025644BF0ACF5BE990@BL2PR15MB1074.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484)(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR15MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1074;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(189003)(199004)(486006)(81166006)(52396003)(2616005)(52116002)(6506007)(51416003)(50466002)(48376002)(59450400001)(186003)(476003)(386003)(50226002)(16526019)(8936002)(1857600001)(6916009)(69596002)(7736002)(305945005)(6486002)(6666003)(97736004)(25786009)(47776003)(5660300001)(54906003)(316002)(16586007)(53936002)(478600001)(6512007)(106356001)(105586002)(36756003)(46003)(86362001)(53416004)(8676002)(1076002)(4326008)(2906002)(68736007)(81156014)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1074;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1074;23:tTbpCn0HaHra8T5S9HwSCQus9IrKKXBcxmiz3DmON?=
 =?us-ascii?Q?30smQYCLUwufHf6glhWXSnZOn4uZT0ZUTHgsIyizvpreQY6TGqDOCpiEjVAT?=
 =?us-ascii?Q?Gx+l2bV1TUBov2xnB2kwrqyE9d+hUguTuEkNL6fi4dQN6R0HWqzN1OxaEEK3?=
 =?us-ascii?Q?D11dERX7o+uSD68CSebI2oTiiDnFYNyzPlajizijVtGh6UWG8TMOpygn88Ho?=
 =?us-ascii?Q?mvnCP0e+pJe8sW6OGxsVV+jmuv8qjPux7LQCPafQOWXJxgC9Ew0nYE+QIPk6?=
 =?us-ascii?Q?ObFRyJVacHZhMN6MJfqJQbQOCiqxttrphrj8BQpIKZn8OusIF7jImYfxpkUM?=
 =?us-ascii?Q?xlo3i5amYpiaIfzZRRmUusiXovE98j9a3Vo14/H6x6GFzPoYYEsJpFU4txAY?=
 =?us-ascii?Q?wFmJ7JhqvcDLOJWzCTsnUiOr3OaXCsZCdcHRZCPcJ81uEZgGZb1Qau6kISvQ?=
 =?us-ascii?Q?YA74taVyPn1Y+L1ZjifQXXxmCvNhwYoSGyio9MyPfjpWFO3vO27gEiEdOqjR?=
 =?us-ascii?Q?vnBB3SEjpuGp4s2obaTY5UvfKE/hBSUMIdompd+KAysJ3pJuqA6+qurZeAmc?=
 =?us-ascii?Q?qNK28RX9BZ6kH2k9bKS6DO+A1e7kTV+ICHMMAYxU6U2c1wwfQvbjo5oY5yJ0?=
 =?us-ascii?Q?yNTZDpkwVGSBFQ5gSCZNYV/0b4wt4iNbcavPQzKpSygIedG21abpHLlOiwEY?=
 =?us-ascii?Q?FMiNwEJ5J5IjpOep3UdfaHlCvfy0XpqWxyTMHu6SJeR6nrwkZhTCA6OTiWOw?=
 =?us-ascii?Q?r+jrxFt8XnEE7vqFycWPewmQGLi8QNZKJ5GPf9lBCb9IjKMck+O+yrPLpehf?=
 =?us-ascii?Q?hW4nSpyP8C2r0m9ObVxJbefUrpW1sdAlOd9kQRNjdWO3nHT+yKclpMOrh/WC?=
 =?us-ascii?Q?pfh7n9Ht21jVaoe8Y4lY9odn4T4/Vx6Kg4o76bL2pfGPz644qZTYTw6SyP+j?=
 =?us-ascii?Q?y2DFJddtGL1FsJqC1tLeoD9bRG7ZbLtYrhv9x0KDSlCI8tSaItd3EnWVHdPq?=
 =?us-ascii?Q?1IicXvwgIjzxyp5POYxf233uUArJQ3/xRSIEEqV/MDbgVi7VT0xpHDU4n0X6?=
 =?us-ascii?Q?F+CWF+sHLiGgQ667hN1vFC36Q0dgT5jLf3LFIHqmeP6sEXP6ANw78fIdCi1Q?=
 =?us-ascii?Q?u3k82llJDlLxz54nJTimqTRnBA2DzfRgGDcpmUe3s3Tu1brXYqnmypALN6ED?=
 =?us-ascii?Q?MEsmmh8NXV5RPfzbIJUK59m6RT0/G5sJWhlhlptdYOnJXgHFnYF8HJQB+2Lf?=
 =?us-ascii?Q?8EBKxlokbWhnVbrLtg=3D?=
X-Microsoft-Antispam-Message-Info: F5weEYE6WL8XrgSBPDTK/LCt0MwANk5fSvCWKeF57SpM2E7YVfQp4LyNh+l/awbfFa5iW6FaBFDaBPx4qCQBBG0TccDSyicTJ7bDT23cn3V/cnGNXdEfNK2BRcRLqsdL0Zp/v8JWH3I3ss+9G1yFnZrCX6UVOXwTjqrW9TSxiNjWPFmeTEfrH0IqLQ4NzhuK
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;6:QHdOonpn31DqDp3RWqK1beP28e0iTsI9efoOdqXarVn4X+HhGzpLE6cfWHlf+jIEsHaNVmI9/k05N+8tdUk2G9vDwAVeSk7dMMBeKqar2GtDkpYF0y0sM/wO3obwqGch102YcS+pFqjwJNwGY24tlTn9N+pHDwUkIQjxv+PR/QD9bCxEMOr7EUwA1SWMz+WnmT+rIC8A8FOd7WY1DlixXtiU4yRqC8gXsQyYhte2DZ33zJ3/ZNpduiWTrqULpop5GKNkbNvpOZkSZuvC3l7zMPcjqgrVhLNLPdoZaCf0xktxru3fcUFKuXVNjXXS+kuu/gwYm11XdMJTZbE2+L8QAxX3YZTrFQNOhE19+CGUR/CPJ6qVpixC7vUW1C0RmxKENG9o/Ggo6Si1R4ZSn95NTwv7SPWBB4yjI9Lp7EI1Bk8aJhLk5hMXPUlmkFvaWPAmzMqmasfFYx6yiwu9Ka646w==;5:aM1eAIqirwO+54u0ijritv+Q918uvF/BDlUt71Bky4uUYav5XnPFFOXOE8uKPb7L0Dqexb+cAn+lRp3Tj3QMf6/vhbXUF3Uzh9ypgOJa3kFawsmAILLviwAqT4lkIDf1D0S2ymusnKzDhxnrp7rHH452MZ9ySq3dGfXPf/6638Q=;24:MKfosLLrjwwFMwT2eDZ360PyZpEq+ByQy+6ERgjYDfNB4zc8wDOW+CD+NUxk6R2rzxQ5iJ6+4D0NB91RGc2yHrYVYkbJtFXkb+xuVMQvZso=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;7:wKiIdoWa0DFctVrAjgigsGMoAuH5PSSW6E2cixBL0SIQTCPj2/T2qHLtvRVp9bBGjD4uvE2M9UFrn29hNcqBFDiPJ20S62SVQQEDO6IqMtC7b0nbBijO8zLb78041iVVuJJBAMjud9TALe2YTtM9+nJGRa4NqFj9iANOdcH3jX7zLPQ62ahij7HpUgedt2FGgO31zrD7Rb/8skI2BWPgN+cKaYondjiPIgAzaKF5oZS/ouNQNB52yUaoDH6Ml/zI;20:9UvMb4ARoyR/Eq3671mx1aDycx+rfKKAL7LmCTSzbPGCtvQaX4D2GXCJoQmGvQj2mBsnPv/vxeJ+BtlUdSnI1LbgEIF3DGh8bNz40ko6prgcjKkEQUnJh/wGDWb///4LP2F19mYR+I6r8gwl7TkNLbENcbythsvR6co0cAcAxDY=
X-MS-Office365-Filtering-Correlation-Id: 9744ca85-eff1-469a-8ae7-08d5b5e1f654
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:20:43.6234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9744ca85-eff1-469a-8ae7-08d5b5e1f654
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1074
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgroups are used for controlling the physical resource distribution
(memory, CPU, io, etc) and often are used as basic building blocks
for large distributed computing systems. Even small differences
in the actual behavior may lead to significant incidents.

The codebase is under the active development, which will unlikely
stop at any time soon. Also it's scattered over different
kernel subsystems, which makes regressions more probable.

Given that, the lack of any tests is crying.

This patch implements some basic tests for the memory controller,
as well as a minimal required framework.
It doesn't pretend for a very good coverage, but pretends
to be a starting point.

Hopefully, any following significant changes will
include corresponding tests.

Tests for CPU and io controllers, as well as cgroup core
are next in the todo list.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: kernel-team@fb.com
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/cgroup/Makefile          |  10 +
 tools/testing/selftests/cgroup/cgroup_util.c     | 317 ++++++++++
 tools/testing/selftests/cgroup/cgroup_util.h     |  40 ++
 tools/testing/selftests/cgroup/test_memcontrol.c | 742 +++++++++++++++++++++++
 5 files changed, 1110 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/Makefile
 create mode 100644 tools/testing/selftests/cgroup/cgroup_util.c
 create mode 100644 tools/testing/selftests/cgroup/cgroup_util.h
 create mode 100644 tools/testing/selftests/cgroup/test_memcontrol.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 32aafa92074c..24d0331d6c11 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -3,6 +3,7 @@ TARGETS = android
 TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += capabilities
+TARGETS += cgroup
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += efivarfs
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
new file mode 100644
index 000000000000..f7a31392eb2f
--- /dev/null
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wall
+
+all:
+
+TEST_GEN_PROGS = test_memcontrol
+
+include ../lib.mk
+
+$(OUTPUT)/test_memcontrol: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
new file mode 100644
index 000000000000..a938b6c8b55a
--- /dev/null
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -0,0 +1,317 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/limits.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "cgroup_util.h"
+
+static ssize_t read_text(const char *path, char *buf, size_t max_len)
+{
+	ssize_t len;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	len = read(fd, buf, max_len - 1);
+	if (len < 0)
+		goto out;
+
+	buf[len] = 0;
+out:
+	close(fd);
+	return len;
+}
+
+static ssize_t write_text(const char *path, char *buf, size_t len)
+{
+	int fd;
+
+	fd = open(path, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		return fd;
+
+	len = write(fd, buf, len);
+	if (len < 0) {
+		close(fd);
+		return len;
+	}
+
+	close(fd);
+
+	return len;
+}
+
+char *cg_name(const char *root, const char *name)
+{
+	size_t len = strlen(root) + strlen(name) + 2;
+	char *ret = malloc(len);
+
+	if (name)
+		snprintf(ret, len, "%s/%s", root, name);
+
+	return ret;
+}
+
+char *cg_name_indexed(const char *root, const char *name, int index)
+{
+	size_t len = strlen(root) + strlen(name) + 10;
+	char *ret = malloc(len);
+
+	if (name)
+		snprintf(ret, len, "%s/%s_%d", root, name, index);
+
+	return ret;
+}
+
+int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
+
+	if (read_text(path, buf, len) >= 0)
+		return 0;
+
+	return -1;
+}
+
+int cg_read_strcmp(const char *cgroup, const char *control,
+		   const char *expected)
+{
+	size_t size = strlen(expected) + 1;
+	char *buf;
+
+	buf = malloc(size);
+	if (!buf)
+		return -1;
+
+	if (cg_read(cgroup, control, buf, size))
+		return -1;
+
+	return strcmp(expected, buf);
+}
+
+int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
+{
+	char buf[PAGE_SIZE];
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	return strstr(buf, needle) ? 0 : -1;
+}
+
+long cg_read_long(const char *cgroup, const char *control)
+{
+	char buf[128];
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	return atol(buf);
+}
+
+long cg_read_key_long(const char *cgroup, const char *control, const char *key)
+{
+	char buf[PAGE_SIZE];
+	char *ptr;
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	ptr = strstr(buf, key);
+	if (!ptr)
+		return -1;
+
+	return atol(ptr + strlen(key));
+}
+
+int cg_write(const char *cgroup, const char *control, char *buf)
+{
+	char path[PATH_MAX];
+	size_t len = strlen(buf);
+
+	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
+
+	if (write_text(path, buf, len) == len)
+		return 0;
+
+	return -1;
+}
+
+int cg_find_unified_root(char *root, size_t len)
+{
+	char buf[10 * PAGE_SIZE];
+	char *fs, *mount, *type;
+	const char delim[] = "\n\t ";
+
+	if (read_text("/proc/self/mounts", buf, sizeof(buf)) <= 0)
+		return -1;
+
+	/*
+	 * Example:
+	 * cgroup /sys/fs/cgroup cgroup2 rw,seclabel,noexec,relatime 0 0
+	 */
+	for (fs = strtok(buf, delim); fs; fs = strtok(NULL, delim)) {
+		mount = strtok(NULL, delim);
+		type = strtok(NULL, delim);
+		strtok(NULL, delim);
+		strtok(NULL, delim);
+		strtok(NULL, delim);
+
+		if (strcmp(fs, "cgroup") == 0 &&
+		    strcmp(type, "cgroup2") == 0) {
+			strncpy(root, mount, len);
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+int cg_create(const char *cgroup)
+{
+	return mkdir(cgroup, 0644);
+}
+
+static int cg_killall(const char *cgroup)
+{
+	char buf[PAGE_SIZE];
+	char *ptr = buf;
+
+	if (cg_read(cgroup, "cgroup.procs", buf, sizeof(buf)))
+		return -1;
+
+	while (ptr < buf + sizeof(buf)) {
+		int pid = strtol(ptr, &ptr, 10);
+
+		if (pid == 0)
+			break;
+		if (*ptr)
+			ptr++;
+		else
+			break;
+		if (kill(pid, SIGKILL))
+			return -1;
+	}
+
+	return 0;
+}
+
+int cg_destroy(const char *cgroup)
+{
+	int ret;
+
+retry:
+	ret = rmdir(cgroup);
+	if (ret && errno == EBUSY) {
+		ret = cg_killall(cgroup);
+		if (ret)
+			return ret;
+		usleep(100);
+		goto retry;
+	}
+
+	if (ret && errno == ENOENT)
+		ret = 0;
+
+	return ret;
+}
+
+int cg_run(const char *cgroup,
+	   int (*fn)(const char *cgroup, void *arg),
+	   void *arg)
+{
+	int pid, retcode;
+
+	pid = fork();
+	if (pid < 0) {
+		return pid;
+	} else if (pid == 0) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (cg_write(cgroup, "cgroup.procs", buf))
+			exit(EXIT_FAILURE);
+		exit(fn(cgroup, arg));
+	} else {
+		waitpid(pid, &retcode, 0);
+		if (WIFEXITED(retcode))
+			return WEXITSTATUS(retcode);
+		else
+			return -1;
+	}
+}
+
+int cg_run_nowait(const char *cgroup,
+		  int (*fn)(const char *cgroup, void *arg),
+		  void *arg)
+{
+	int pid;
+
+	pid = fork();
+	if (pid == 0) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (cg_write(cgroup, "cgroup.procs", buf))
+			exit(EXIT_FAILURE);
+		exit(fn(cgroup, arg));
+	}
+
+	return pid;
+}
+
+int get_temp_fd(void)
+{
+	return open(".", O_TMPFILE | O_RDWR | O_EXCL);
+}
+
+int alloc_pagecache(int fd, size_t size)
+{
+	char buf[PAGE_SIZE];
+	struct stat st;
+	int i;
+
+	if (fstat(fd, &st))
+		goto cleanup;
+
+	size += st.st_size;
+
+	if (ftruncate(fd, size))
+		goto cleanup;
+
+	for (i = 0; i < size; i += sizeof(buf))
+		read(fd, buf, sizeof(buf));
+
+	return 0;
+
+cleanup:
+	return -1;
+}
+
+int alloc_anon(const char *cgroup, void *arg)
+{
+	size_t size = (unsigned long)arg;
+	char *buf, *ptr;
+
+	buf = malloc(size);
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 0;
+
+	free(buf);
+	return 0;
+}
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
new file mode 100644
index 000000000000..000de075d3d8
--- /dev/null
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
+
+#define PAGE_SIZE 4096
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+#define MB(x) (x << 20)
+
+/*
+ * Checks if two given values differ by less than err% of their sum.
+ */
+static inline int values_close(long a, long b, int err)
+{
+	return abs(a - b) <= (a + b) / 100 * err;
+}
+
+extern int cg_find_unified_root(char *root, size_t len);
+extern char *cg_name(const char *root, const char *name);
+extern char *cg_name_indexed(const char *root, const char *name, int index);
+extern int cg_create(const char *cgroup);
+extern int cg_destroy(const char *cgroup);
+extern int cg_read(const char *cgroup, const char *control,
+		   char *buf, size_t len);
+extern int cg_read_strcmp(const char *cgroup, const char *control,
+			  const char *expected);
+extern int cg_read_strstr(const char *cgroup, const char *control,
+			  const char *needle);
+extern long cg_read_long(const char *cgroup, const char *control);
+long cg_read_key_long(const char *cgroup, const char *control, const char *key);
+extern int cg_write(const char *cgroup, const char *control, char *buf);
+extern int cg_run(const char *cgroup,
+		  int (*fn)(const char *cgroup, void *arg),
+		  void *arg);
+extern int cg_run_nowait(const char *cgroup,
+			 int (*fn)(const char *cgroup, void *arg),
+			 void *arg);
+extern int get_temp_fd(void);
+extern int alloc_pagecache(int fd, size_t size);
+extern int alloc_anon(const char *cgroup, void *arg);
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
new file mode 100644
index 000000000000..7bf2a30e857c
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -0,0 +1,742 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define _GNU_SOURCE
+
+#include <linux/limits.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "cgroup_util.h"
+
+enum test_result {
+	TEST_SKIP,
+	TEST_FAIL,
+	TEST_PASS,
+};
+
+const char *test_result_texts[] = {
+	[TEST_SKIP] = "SKIP",
+	[TEST_FAIL] = "FAIL",
+	[TEST_PASS] = "PASS",
+};
+
+/*
+ * This test creates two nested cgroups with and without enabling
+ * the memory controller.
+ */
+static int test_memcg_subtree_control(const char *root)
+{
+	char *parent, *child, *parent2, *child2;
+	int ret = TEST_FAIL;
+	char buf[PAGE_SIZE];
+
+	/* Create two nested cgroups with the memory controller enabled */
+	parent = cg_name(root, "memcg_test_0");
+	child = cg_name(root, "memcg_test_0/memcg_test_1");
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_read_strstr(child, "cgroup.controllers", "memory"))
+		goto cleanup;
+
+	/* Create two nested cgroups without enabling memory controller */
+	parent2 = cg_name(root, "memcg_test_1");
+	child2 = cg_name(root, "memcg_test_1/memcg_test_1");
+	if (!parent2 || !child2)
+		goto cleanup;
+
+	if (cg_create(parent2))
+		goto cleanup;
+
+	if (cg_create(child2))
+		goto cleanup;
+
+	if (cg_read(child2, "cgroup.controllers", buf, sizeof(buf)))
+		goto cleanup;
+
+	if (!cg_read_strstr(child2, "cgroup.controllers", "memory"))
+		goto cleanup;
+
+	ret = TEST_PASS;
+
+cleanup:
+	cg_destroy(child);
+	cg_destroy(parent);
+	free(parent);
+	free(child);
+
+	cg_destroy(child2);
+	cg_destroy(parent2);
+	free(parent2);
+	free(child2);
+
+	return ret;
+}
+
+static int alloc_anon_50M_check(const char *cgroup, void *arg)
+{
+	size_t size = MB(50);
+	char *buf, *ptr;
+	long anon, current;
+	int ret = -1;
+
+	buf = malloc(size);
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 0;
+
+	current = cg_read_long(cgroup, "memory.current");
+	if (current < size)
+		goto cleanup;
+
+	if (!values_close(size, current, 3))
+		goto cleanup;
+
+	anon = cg_read_key_long(cgroup, "memory.stat", "anon ");
+	if (anon < 0)
+		goto cleanup;
+
+	if (!values_close(anon, current, 3))
+		goto cleanup;
+
+	ret = 0;
+cleanup:
+	free(buf);
+	return ret;
+}
+
+static int alloc_pagecache_50M_check(const char *cgroup, void *arg)
+{
+	size_t size = MB(50);
+	int ret = -1;
+	long current, file;
+	int fd;
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		return -1;
+
+	if (alloc_pagecache(fd, size))
+		goto cleanup;
+
+	current = cg_read_long(cgroup, "memory.current");
+	if (current < size)
+		goto cleanup;
+
+	file = cg_read_key_long(cgroup, "memory.stat", "file ");
+	if (file < 0)
+		goto cleanup;
+
+	if (!values_close(file, current, 10))
+		goto cleanup;
+
+	ret = 0;
+
+cleanup:
+	close(fd);
+	return ret;
+}
+
+/*
+ * This test create a memory cgroup, allocates
+ * some anonymous memory and some pagecache
+ * and check memory.current and some memory.stat values.
+ */
+static int test_memcg_current(const char *root)
+{
+	int ret = TEST_FAIL;
+	long current;
+	char *memcg;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	current = cg_read_long(memcg, "memory.current");
+	if (current != 0)
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_anon_50M_check, NULL))
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_pagecache_50M_check, NULL))
+		goto cleanup;
+
+	ret = TEST_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+static int alloc_pagecache_50M(const char *cgroup, void *arg)
+{
+	int fd = (long)arg;
+
+	return alloc_pagecache(fd, MB(50));
+}
+
+static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
+{
+	int fd = (long)arg;
+	int ppid = getppid();
+
+	if (alloc_pagecache(fd, MB(50)))
+		return -1;
+
+	while (getppid() == ppid)
+		sleep(1);
+
+	return 0;
+}
+
+/*
+ * First, this test creates the following hierarchy:
+ * A       memory.min = 50M,  memory.max = 200M
+ * A/B     memory.min = 50M,  memory.current = 50M
+ * A/B/C   memory.min = 75M,  memory.current = 50M
+ * A/B/D   memory.min = 25M,  memory.current = 50M
+ * A/B/E   memory.min = 500M, memory.current = 0
+ * A/B/F   memory.min = 0,    memory.current = 50M
+ *
+ * Usages are pagecache, but the test keeps a running
+ * process in every leaf cgroup.
+ * Then it creates A/G and creates a significant
+ * memory pressure in it.
+ *
+ * A/B    memory.current ~= 50M
+ * A/B/C  memory.current ~= 33M
+ * A/B/D  memory.current ~= 17M
+ * A/B/E  memory.current ~= 0
+ *
+ * After that it tries to allocate more than there is
+ * unprotected memory in A available, and checks
+ * checks that memory.min protects pagecache even
+ * in this case.
+ */
+static int test_memcg_min(const char *root)
+{
+	int ret = TEST_FAIL;
+	char *parent[3] = {NULL};
+	char *children[4] = {NULL};
+	long c[4];
+	int i, attempts;
+	int fd;
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		goto cleanup;
+
+	parent[0] = cg_name(root, "memcg_test_0");
+	if (!parent[0])
+		goto cleanup;
+
+	parent[1] = cg_name(parent[0], "memcg_test_1");
+	if (!parent[1])
+		goto cleanup;
+
+	parent[2] = cg_name(parent[0], "memcg_test_2");
+	if (!parent[2])
+		goto cleanup;
+
+	if (cg_create(parent[0]))
+		goto cleanup;
+
+	if (cg_read_long(parent[0], "memory.min")) {
+		ret = TEST_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_write(parent[0], "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "memory.max", "200M"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_create(parent[1]))
+		goto cleanup;
+
+	if (cg_write(parent[1], "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_create(parent[2]))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		children[i] = cg_name_indexed(parent[1], "child_memcg", i);
+		if (!children[i])
+			goto cleanup;
+
+		if (cg_create(children[i]))
+			goto cleanup;
+
+		if (i == 2)
+			continue;
+
+		cg_run_nowait(children[i], alloc_pagecache_50M_noexit,
+			      (void *)(long)fd);
+	}
+
+	if (cg_write(parent[0], "memory.min", "50M"))
+		goto cleanup;
+	if (cg_write(parent[1], "memory.min", "50M"))
+		goto cleanup;
+	if (cg_write(children[0], "memory.min", "75M"))
+		goto cleanup;
+	if (cg_write(children[1], "memory.min", "25M"))
+		goto cleanup;
+	if (cg_write(children[2], "memory.min", "500M"))
+		goto cleanup;
+	if (cg_write(children[3], "memory.min", "0"))
+		goto cleanup;
+
+	attempts = 0;
+	while (!values_close(cg_read_long(parent[1], "memory.current"),
+			     MB(150), 3)) {
+		if (attempts++ > 5)
+			break;
+		sleep(1);
+	}
+
+	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
+		goto cleanup;
+
+	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(children); i++)
+		c[i] = cg_read_long(children[i], "memory.current");
+
+	if (!values_close(c[0], MB(33), 10))
+		goto cleanup;
+
+	if (!values_close(c[1], MB(17), 10))
+		goto cleanup;
+
+	if (!values_close(c[2], 0, 1))
+		goto cleanup;
+
+	if (!cg_run(parent[2], alloc_anon, (void *)MB(170)))
+		goto cleanup;
+
+	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+		goto cleanup;
+
+	ret = TEST_PASS;
+
+cleanup:
+	for (i = ARRAY_SIZE(children) - 1; i >= 0; i--) {
+		if (!children[i])
+			continue;
+
+		cg_destroy(children[i]);
+		free(children[i]);
+	}
+
+	for (i = ARRAY_SIZE(parent) - 1; i >= 0; i--) {
+		if (!parent[i])
+			continue;
+
+		cg_destroy(parent[i]);
+		free(parent[i]);
+	}
+	close(fd);
+	return ret;
+}
+
+/*
+ * First, this test creates the following hierarchy:
+ * A       memory.low = 50M,  memory.max = 200M
+ * A/B     memory.low = 50M,  memory.current = 50M
+ * A/B/C   memory.low = 75M,  memory.current = 50M
+ * A/B/D   memory.low = 25M,  memory.current = 50M
+ * A/B/E   memory.low = 500M, memory.current = 0
+ * A/B/F   memory.low = 0,    memory.current = 50M
+ *
+ * Usages are pagecache.
+ * Then it creates A/G an creates a significant
+ * memory pressure in it.
+ *
+ * Then it checks actual memory usages and expects that:
+ * A/B    memory.current ~= 50M
+ * A/B/   memory.current ~= 33M
+ * A/B/D  memory.current ~= 17M
+ * A/B/E  memory.current ~= 0
+ *
+ * After that it tries to allocate more than there is
+ * unprotected memory in A available,
+ * and checks low and oom events in memory.events.
+ */
+static int test_memcg_low(const char *root)
+{
+	int ret = TEST_FAIL;
+	char *parent[3] = {NULL};
+	char *children[4] = {NULL};
+	long low, oom;
+	long c[4];
+	int i;
+	int fd;
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		goto cleanup;
+
+	parent[0] = cg_name(root, "memcg_test_0");
+	if (!parent[0])
+		goto cleanup;
+
+	parent[1] = cg_name(parent[0], "memcg_test_1");
+	if (!parent[1])
+		goto cleanup;
+
+	parent[2] = cg_name(parent[0], "memcg_test_2");
+	if (!parent[2])
+		goto cleanup;
+
+	if (cg_create(parent[0]))
+		goto cleanup;
+
+	if (cg_read_long(parent[0], "memory.low"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "memory.max", "200M"))
+		goto cleanup;
+
+	if (cg_write(parent[0], "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_create(parent[1]))
+		goto cleanup;
+
+	if (cg_write(parent[1], "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_create(parent[2]))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		children[i] = cg_name_indexed(parent[1], "child_memcg", i);
+		if (!children[i])
+			goto cleanup;
+
+		if (cg_create(children[i]))
+			goto cleanup;
+
+		if (i == 2)
+			continue;
+
+		if (cg_run(children[i], alloc_pagecache_50M, (void *)(long)fd))
+			goto cleanup;
+	}
+
+	if (cg_write(parent[0], "memory.low", "50M"))
+		goto cleanup;
+	if (cg_write(parent[1], "memory.low", "50M"))
+		goto cleanup;
+	if (cg_write(children[0], "memory.low", "75M"))
+		goto cleanup;
+	if (cg_write(children[1], "memory.low", "25M"))
+		goto cleanup;
+	if (cg_write(children[2], "memory.low", "500M"))
+		goto cleanup;
+	if (cg_write(children[3], "memory.low", "0"))
+		goto cleanup;
+
+	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
+		goto cleanup;
+
+	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(children); i++)
+		c[i] = cg_read_long(children[i], "memory.current");
+
+	if (!values_close(c[0], MB(33), 10))
+		goto cleanup;
+
+	if (!values_close(c[1], MB(17), 10))
+		goto cleanup;
+
+	if (!values_close(c[2], 0, 1))
+		goto cleanup;
+
+	if (cg_run(parent[2], alloc_anon, (void *)MB(166))) {
+		fprintf(stderr,
+			"memory.low prevents from allocating anon memory\n");
+		goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		oom = cg_read_key_long(children[i], "memory.events", "oom ");
+		low = cg_read_key_long(children[i], "memory.events", "low ");
+
+		if (oom)
+			goto cleanup;
+		if (i < 2 && low <= 0)
+			goto cleanup;
+		if (i >= 2 && low)
+			goto cleanup;
+	}
+
+	ret = TEST_PASS;
+
+cleanup:
+	for (i = ARRAY_SIZE(children) - 1; i >= 0; i--) {
+		if (!children[i])
+			continue;
+
+		cg_destroy(children[i]);
+		free(children[i]);
+	}
+
+	for (i = ARRAY_SIZE(parent) - 1; i >= 0; i--) {
+		if (!parent[i])
+			continue;
+
+		cg_destroy(parent[i]);
+		free(parent[i]);
+	}
+	close(fd);
+	return ret;
+}
+
+static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
+{
+	size_t size = MB(50);
+	int ret = -1;
+	long current;
+	int fd;
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		return -1;
+
+	if (alloc_pagecache(fd, size))
+		goto cleanup;
+
+	current = cg_read_long(cgroup, "memory.current");
+	if (current <= MB(29) || current > MB(30))
+		goto cleanup;
+
+	ret = 0;
+
+cleanup:
+	close(fd);
+	return ret;
+
+}
+
+/*
+ * This test checks that memory.high limits the amount of
+ * memory which can be consumed by either anonymous memory
+ * or pagecache.
+ */
+static int test_memcg_high(const char *root)
+{
+	int ret = TEST_FAIL;
+	char *memcg;
+	long high;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_read_strcmp(memcg, "memory.high", "max\n"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.high", "30M"))
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (!cg_run(memcg, alloc_pagecache_50M_check, NULL))
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_pagecache_max_30M, NULL))
+		goto cleanup;
+
+	high = cg_read_key_long(memcg, "memory.events", "high ");
+	if (high <= 0)
+		goto cleanup;
+
+	ret = TEST_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+/*
+ * This test checks that memory.max limits the amount of
+ * memory which can be consumed by either anonymous memory
+ * or pagecache.
+ */
+static int test_memcg_max(const char *root)
+{
+	int ret = TEST_FAIL;
+	char *memcg;
+	long current, max;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_read_strcmp(memcg, "memory.max", "max\n"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.max", "30M"))
+		goto cleanup;
+
+	/* Should be killed by OOM killer */
+	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_run(memcg, alloc_pagecache_max_30M, NULL))
+		goto cleanup;
+
+	current = cg_read_long(memcg, "memory.current");
+	if (current > MB(30) || !current)
+		goto cleanup;
+
+	max = cg_read_key_long(memcg, "memory.events", "max ");
+	if (max <= 0)
+		goto cleanup;
+
+	ret = TEST_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM. Then it checks for oom and oom_kill events in
+ * memory.events.
+ */
+static int test_memcg_oom_events(const char *root)
+{
+	int ret = TEST_FAIL;
+	char *memcg;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.max", "30M"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_read_strcmp(memcg, "cgroup.procs", ""))
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.events", "oom ") != 1)
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 1)
+		goto cleanup;
+
+	ret = TEST_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct memcg_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_memcg_subtree_control),
+	T(test_memcg_current),
+	T(test_memcg_min),
+	T(test_memcg_low),
+	T(test_memcg_high),
+	T(test_memcg_max),
+	T(test_memcg_oom_events),
+};
+#undef T
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+	int i, ret = EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root))) {
+		printf("test_memcontrol:SKIP (cgroup v2 isn't mounted)\n");
+		return ret;
+	}
+
+	/*
+	 * Check that memory controller is available:
+	 * memory is listed in cgroup.controllers
+	 */
+	if (cg_read_strstr(root, "cgroup.controllers", "memory")) {
+		printf("test_memcontrol:SKIP "
+		       "(memory controller is not available)\n");
+		return ret;
+	}
+
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		int r = tests[i].fn(root);
+
+		printf("%s:%s\n", tests[i].name, test_result_texts[r]);
+
+		if (r == TEST_FAIL)
+			ret = EXIT_FAILURE;
+	}
+
+	return ret;
+}
-- 
2.14.3
