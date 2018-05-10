Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966533AbeEJQhu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:37:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54526 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965017AbeEJQhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:37:46 -0400
From: Roman Gushchin <guro@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, <kernel-team@fb.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] selftests/cgroup: memory controller self-tests
Date: Thu, 10 May 2018 17:37:01 +0100
Message-ID: <20180510163701.28936-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:5477]
X-ClientProxiedBy: AM6P193CA0016.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::29) To DM3PR15MB1082.namprd15.prod.outlook.com
 (2603:10b6:0:12::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1082;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;3:aN0zLbIFhemtwTJd9oJ5zTZkmUyZCTPdz3vNRhJDd5uF4chzRlGLnc+j2lzc8JqhUg/F6MG0W4b5JhEBk1TA/6D34Wd9A+FOY/8s/5MLogDsgCk9S46fYSTGU6/GrhEhtRQLDEx9RfLmGsrvOtAuEoswpXy3ym2GsjZMD8NpIaCaku9zh80wcnZnfJFCjPgkilIB4g1zBaP+QfsPmhVNZ6Sarz3PI4AwmLBZlQX076esekt6JdgYsCJCJ+hGi8NC;25:M5mZUiH9dik8IEBLSSROSyLRkAO2eCVYRTV9TIGw2RSeE1yGCnERAZHNsqGd5QHkoWtgHDKC5yhkth9cvspwDDfrlLbjYKp6PWx9t/5GtDsRDBlQJyyklqfZxlT7JFypgdo3lbxSkFVJK1WEjAr8TDqUOA+Y0ChZKlGftzFij8KAPx7K8kSZZNKCUNbu5uP2sec9MCTXxUF6tvTR+4+DBtBc4+buAxXj2Qe8nL+T4WWrjKy6adJcUXhhFs+yD4GnWly0VP1lWSm8GF4kQNu5yRJ0pudm7Q2fS9B5KJsGOv/f22Hrg0l8XZ3fvdyf1MyrOz5eYuFCIg7USTVNi7oqRA==;31:Z0t/huQMb9TxQDn9yq8utSmAq4gFx/DzaDzUAbtTN31rNwc+gaaGMEuUpFZ+KLZx/Sd9Has7wnJi4LQ+ICLewrYrWStx3DfUjzH5H3DTEEwTgd/7fHOnN5OUr4fOi8oaf9R+hTpYdIA+30kXxE7yfnrJI0u98QtiU3rdHi8OUHRdKcdV0w6ondo2bRr67c6uLo5dJ9m5xsvsiwMiSQ0HM0aceO1bRODc360SuT/MGIc=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1082:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;20:UA0q9t7rFwV6KdnWmSmgpYBnGLbTJuLirzx3/IT/0qms27/R/7ijvXi822s4y+K/Tm1PAlM6z8sHt9rJoR5a7T+Ft0cWeQoxh/UmFNsv0CIwxL2h0Xg9lfOxpF6lgTuExde3K8a/MhbMl3FNaLxjr2DbLs5FagUmGgv7cbJLawlDYgcH4/u71m18hRaemqk1Elo+u7P/uslTSYhTnADFBURZM6jDviTJ5EBxBOa+dkD62vOAtxJUgiRezLClgjud2Cxjucas1Wy8sQL64ImGU/2ewM8ot94k1C7TNMbVsjKiRXyajZVh1TPGFsSLmfzVnjld6O7Is9CKIbSIsD9ZUesK9TM0JVMngU69GLBT3LwzRGphMhz54K6r3NT6StH3HRkNdSCJDON5h39b1d5LD5XoLT5iY6cuaQpap7BrOolEgpBmcLw0m25F8gL/lbPUBHcc++aL935byQfohddtXXrFEhimq2Z5LlEqac0sV4YG1qwtXdXa4n5hMzlGv2cs;4:ZfeQtg7p2GJQMD5pIsVS8sh28BWJz6Yed3wNhU7iDEwTkysbCjDtvznlaVhPs34z+d4zaUDhGjMTHtH2oyb50sNlo9KyoeRd6tZN926bISckaKd8aNKneSvQlbEz9iVblfXMxb/9CBfTRj+tJ0NhQrZy5El9i//9OByytN+U+azbJq2QvwrXg4eMvWugxXLm5FlwPawLzMXm97VytSE5RmgXp+c7yM0lElMDv6FCIPGrMVlJsjqgueTkzgmIPqd+NDbPGfSkb5GjuLQiWHqVUoaKWu6GI0RZSm7oDtLMpCbM4JSG2y3xcZLSge34OA8JICpy+pCjh06OHPR17OVHTJihreneclmXBKFrT+KcGY4y3cCXhiFLC9rkDUkFwVed
X-Microsoft-Antispam-PRVS: <DM3PR15MB1082691F223F99265A7EAB32BE980@DM3PR15MB1082.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484)(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM3PR15MB1082;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1082;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(189003)(199004)(305945005)(8676002)(25786009)(50226002)(6116002)(7736002)(186003)(47776003)(68736007)(81156014)(8936002)(16526019)(81166006)(386003)(52396003)(2906002)(6486002)(478600001)(52116002)(1076002)(6506007)(51416003)(316002)(16586007)(53936002)(48376002)(6916009)(476003)(2616005)(97736004)(50466002)(86362001)(54906003)(486006)(105586002)(106356001)(6666003)(5660300001)(69596002)(59450400001)(4326008)(46003)(53416004)(6512007)(36756003)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1082;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1082;23:4krBoWByujLCA96p0oOMOuVZ6pXoH3hkkvKAXUGAd?=
 =?us-ascii?Q?ykCZ6O5SAUzk4Q2Aq087PyR7NgJNqDqbQJzaf3MpRYbKhDEuoQ9Ms+8bvKRy?=
 =?us-ascii?Q?cbzMfjZwmwDfkmgVfP+UZfStYZHYeErR+L+X2BAsjc+WG54i2JGtETSZ3kw1?=
 =?us-ascii?Q?b5v4fnaNXPZk5u9ZHoC5fyfvSxJWp5o4zShQ4fRibtTuFgRXzI+YGG/RbZld?=
 =?us-ascii?Q?w6dOOiUkcJtD3JaCfpcvFGOznaCqx+hY3J8hd+o6kbQMfNFkElIoRIVPZNtz?=
 =?us-ascii?Q?q/pvhzo3gFb0bvjioeGDjXtLlnA4ZcBS/rtkbZRwArX6G0jnZBLw3T8xJ0+8?=
 =?us-ascii?Q?+x/3cKnTwmdllTgalCy9ckpaLX1ONC/nuYOc+QEg0vJ7jeAOeH/JoqziiD89?=
 =?us-ascii?Q?ncjS+l3fjXZ0o+AxV/HzHohvN520jcDJc7ib9QqSa/NFhjyRcu1MtMrMa3/D?=
 =?us-ascii?Q?gYXFT/fk5abKDoSM5QFqUg5lcRS9zjTLpUfzMHC2M1yzqPmy9oltmk4/mYAS?=
 =?us-ascii?Q?Dsi9XRTL3zSdFKEFcBeBW/2KP6BPHIRSqRd5mAkaJcZbOq8GS/lB4EmUcyaa?=
 =?us-ascii?Q?MpJLGRWsX4MerDKorNgxVWtO7H9amo+00QbdaPaM/Z8njK3WLEg3JAM4yHJ/?=
 =?us-ascii?Q?ykhyVg2T8T97Gh42DcujaAzyfhjDoRexkp1A+gJ2CFpNf+7x+1IvdxaUWSYg?=
 =?us-ascii?Q?MHSZ6NuHYZTt4WoTrhWI0EffFxhGsGJeEQvJ/AW/KvPQ5eB1O/azg+gzoutA?=
 =?us-ascii?Q?SI9Z0i/CWfknSKCfOAcJ1Li1b3n3aWjz8+lgtzEvj+g+weLlFz4eHxFBylkm?=
 =?us-ascii?Q?ZM2RHI8DbZ1Zs7q92igC9669o0kRJMc9sN6hCyjlIEgWTrWvDBdEbSYvL8L7?=
 =?us-ascii?Q?2ncMGeTl76djIpTQFLxKOjowadfbUX9wpgPIFzHeIIMGcPnQpJY0sSr+4+Pv?=
 =?us-ascii?Q?5niuJBh8pRHSt/tV4Y0n/8Fs8SOz72TxsvSY6deYB5NSdeNkHdEQWvqq2y3V?=
 =?us-ascii?Q?ZneyiYL2BetCmxJ7jULLJICfVywWRnorvWtGsYDX/K3ZWssLqlRbrLhMwKWF?=
 =?us-ascii?Q?X/RSynIdA7KFvfufGpeQkirimMHfIb+NJesPMjpPC8FXtuK+tsHbRacG33Ep?=
 =?us-ascii?Q?iDqM7wkptZUMFnVeFKTD9jolv4xcIz36NbRdGTmLjGsWNvGzULzfmoyakMLD?=
 =?us-ascii?Q?WbhXqAeWwYWCWE9qE9QU5tUfhArafIujVTP33e9DMbkEPRoecsd5hDiW+o7e?=
 =?us-ascii?Q?fv/12cUXw5H3hWwWOwDdpdWwdHa7+516yCXQrUpCJ60sSmv6RJjESwHl+Ri0?=
 =?us-ascii?Q?kYozIpeWgQg/8x91EO0z4U=3D?=
X-Microsoft-Antispam-Message-Info: LrAVuqh4OXKQwhJcWLpMqoS4fWXcXwZrL1AaVx2DofoYJ8L4uOO40ChJAzEzRSi4IKQfuwhSAk/BX6ppWJrQa0KzN/uiDFhj6FdCD7uQ0TWxlgeTYtf21pHC8YosRPLHzQ0ETWmzatyq5zcdajRmEg+do2vNijQKDBYpeN9BygS24pIGWCg0Hg8IQtx0rA/c
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;6:aVe1RuhGSLUEPpKdtNGA7Q21+f1cqraAHZsIpRTfD0+wRcnUYqWSo9/3ecj3e5awsmmHI7pENpAz2Bl9BMtofB/3MDBcxXA7k7rW/1Cz5wMEPD1xzdJT4i6ucWXtDoNHQFA4+lOBKUNprATGZqdyl6lsFqjSzxXC4+dCbAVs4U0FlQ0ckSP7EEhxMmLpi2iaD6dSqY4yhHqDsdZTW0KdZL+EaSVN9xISHCmcxpY9F7uZRarc2unuUcaBn/Lvk0YxWaOHt4jpgSGE7LKSsFc827FPkIsorRc/ufzHMcyXjUR7/TdMTBFQqaxffX2d5Rdmw6n/3gF7MG/Afk3ujZ4ZbEivmC3ACb9YPNXWScU2WEhvB+53PpLPKZ9GDpc6kVaRQQHVCD2mPjNQpiG7O/mpMyTshBhVhFtbrAMBru5jepQlmThrWOKSKW2frpk/ygSfm+7+op6cx+qcqDTdrdByMw==;5:Ld+C0l/mHycOCC8jzZra1FehuGC+d3clF/3AZrD7jrAig9ycz2Twh7KDUfAg5m7hZAJhbE7W6IdZWZSsyAOOPTdJa5pDoyK0zn6SrNFam5GSJF2v0j05NmsSXKrEntZGKpM7A8fqJ6O21Cd7w0Z2KXY7lzhFA6etHegd9DIfszg=;24:h3eMFZemBIfXji50AH7IRj3BJKJgcGHIsBs/CmE1l6GEH5LqEevWXImtUQNxl3qgciYTxx0R3NU+KruY13NeTZJUxnYTVgy29iHi+8AtGbQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1082;7:LsNx9aWNFaHxxKrhXzxywF6Lwj7m3q9n6wpbs+Q7drn8t3gShFODua4FJGcepsA3Fwa/JvABcTP4yMczgj/uhPDEwSc6FnLyJJYNtn8LQkfkUN99HUglOAbJQ/oyErgwV8QRkhKm71ndcZI6X5h5JSxzmUa78rescykxurLz4ZLBSieGROlfzB83goMY4Agk6/7IBcYbEvi2V6zO2MomCCQB2EZCRG4ChsX8Ownq9FmkCCiOMA3cyP69+gQxR9YA;20:zy5vqyDPHuxvn6dBk+Re5VJoXKU3xEA/vgJ+fvQa6SJIJrlN13vJg9PUsBXLxdnzJb+uOcOZHyQewZt2dgoBVpYhkhHordVYmLAGhVM89mbFAJetUW+jcTffGgpmrkhR7dZqxhQJQxcHGJxUtQwL5RIUBj8RVvKD0LieydGTdNQ=
X-MS-Office365-Filtering-Correlation-Id: f345265b-0680-4740-84ef-08d5b6945124
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 16:37:26.0711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f345265b-0680-4740-84ef-08d5b6945124
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1082
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_06:,,
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
 tools/testing/selftests/cgroup/test_memcontrol.c | 741 +++++++++++++++++++++++
 5 files changed, 1109 insertions(+)
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
index 000000000000..b6bbc4c1adc3
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -0,0 +1,741 @@
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
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+/*
+ * Can't use KSFT_ values,
+ * because there is no difference between SKIP and PASS values.
+ */
+enum test_result {
+	TEST_SKIP,
+	TEST_FAIL,
+	TEST_PASS,
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
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	/*
+	 * Check that memory controller is available:
+	 * memory is listed in cgroup.controllers
+	 */
+	if (cg_read_strstr(root, "cgroup.controllers", "memory"))
+		ksft_exit_skip("memory controller isn't available\n");
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case TEST_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case TEST_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ret = EXIT_FAILURE;
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	return ret;
+}
-- 
2.14.3
