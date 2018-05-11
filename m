Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeEKSEY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 14:04:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53120 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751052AbeEKSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 14:04:21 -0400
Date: Fri, 11 May 2018 19:03:49 +0100
From: Roman Gushchin <guro@fb.com>
To: Shuah Khan <shuah@kernel.org>
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, <kernel-team@fb.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests/cgroup: memory controller self-tests
Message-ID: <20180511180342.GA20683@castle>
References: <20180510163701.28936-1-guro@fb.com>
 <20180510183224.GP2368884@devbig577.frc2.facebook.com>
 <a652ce44-07f9-d229-70d4-4376bfbafa40@kernel.org>
 <20180511143228.GU2368884@devbig577.frc2.facebook.com>
 <ae4dc3f9-baa6-b492-7c43-0359734440b3@kernel.org>
 <20180511162920.GV2368884@devbig577.frc2.facebook.com>
 <957d089f-7a88-9ff4-733a-8e082339720c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <957d089f-7a88-9ff4-733a-8e082339720c@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:2755]
X-ClientProxiedBy: AM5PR06CA0035.eurprd06.prod.outlook.com
 (2603:10a6:206:2::48) To SN2PR15MB1087.namprd15.prod.outlook.com
 (2603:10b6:804:22::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1087;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;3:t6tUUiislbyeNCiDa8T3J6fA/UQR9VzVgzsO1/e5Iwynh+IIsOrcWUmxInsdKAucGCqLwHW7fjoKvMMAPBcpD2S7GhDkf6MtpEke3dIS4ZX/8gfiKIxdaudK7tnsacZBn6xjHT2GXinpxGy8WWqXooaPyU2388k/umi2ZK/dzIXoqCDDu/qFD3SMrdxRJGLtFHByiqShL+1eCyiswP4Z1sfuenT69zwmx/SO4umXvP2JemFdat52FiJrCAtUIs7m;25:04D4IpDU1fg8zpD+2Lr2Clagdcmu47BVjEz3mRg4M6Z/Knzn8g5xcC2w9GIItSMi5ka5KPd0TEbtdrG8GDJ9zMkFGSL/N5ts73OllW5C7wNqnn/d4rtpqGFv8LrA5ib/tVBvxzwexd1YYhwNyO35kJT8+zHO4B+3qS9OdRxnK1z1N/g8zfWf/E0jRcF9ZzehzWK+QT8or7puIMks8QoNk9gnSH3uyzeYp0oE8BbFvEhR8oUt14L2jcxuM0iwInuvGvBh8kbgxjTihCEGnMME5G4Kkyj9gGRAQI+XY4LuG/1cCprjCiwSjGS2URjAw3Yb0Dmsm/PtYn1X/s3nnGrdXw==;31:gW3MD3H28dxfoGee8KsH2qfEY/FWVoXHqGsv6hgjaeVMFrl/XEAh4WANaGPpIBP+6A+830t8wK1flRk+wWcLT8BOhxPGCgedWlNbWA5GdwTTdvCNDRcJw1ns71J00Q+r2D+djGEFSV5EPXszOBZfb/ZuKksihRAUlZPtud/h4EPSHRojyT5PbuGAv0dLGDJ9V38yBipbCbWANSpvLspWRRDfFNZYjIBFfqu/p6BcEmc=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1087:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:nkg6UglW57XOawqECVnQ7O7pHhS+CYRhKnS3Yd75+w1fahGH87JEYMA2TUO3yfa0Av0QLI0jjBZyxjhTunoZCnGiY58e60zYfTwKEWmnTXlMaSnCtvXsQww+vVyRWlEB5K3K1JJmpn4zYG3lZ6Q6tJirVKhXfHhZgajFFNFEQKYSnAHHGmwU7kMLIUArFdMA08MF5bQ0Vwae7sqA0WR59IJcLuMy7qNDcpsVgcd4ux0wt/SjY/cS3qqlTitfO1XWXSyiIb3IAXGIaMKi71Y6zgacT5kItzn9oiRHgG8pKGhrH8rB8W4iNWmWxUIYAjy8W2T7w9HMBZpCTt4//Gf8BvCcCxQjSSImFcqF7sx/W51lMXtFZOcKUGvKYvGytsaIFcb7znio4QwJVHDv2av28GnZHxnFTJ4pWrvoj6eP6jtDdK3L5zX/qwB9nPvzCm70rM25Si9fwFPT9VFC4qby8JTWBZ/hKX+sY5fFtK0/ELb1TO1oVf7DM6f6xlMNJZgM;4:ngrtPPD3/fgt5htqK4uhChf9AZ4yiwLGcN+fpgXCDF3YyuNMhOq2rkT/2wlC9+KCp5T2BNhwPbdNHmVYXjZiagRUOKbHvnFnmfz6LtnYZKaVrW+MkW0nEthAdh6zflQJdCNxzpK6YWdWfxNS4aqpDrza0zpDQ/pG5fKmCF5eVnm39Rz7QIrZbz6Fz+MIIgehKXw9YnEMMBa1ZFKJCnrfAi1J4EwL6Zlbv4Sf8W/SbVlfO1VcMisEVWqtueanDIFg4LW8XODXZeP/Kx4jWi4SOQLGlOCtGzG4ZSQhP5z3yooEysIZrabx5/xqZ/We1JBx3ZxqOGEglslsC0WTK/VF3r63eFh38W9F0aAAuQ7IUyaLM7rlXp+/eauwdNGwZtku
X-Microsoft-Antispam-PRVS: <SN2PR15MB10876707A3E4DFF396FCF339BE9F0@SN2PR15MB1087.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484)(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR15MB1087;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1087;
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(366004)(346002)(39860400002)(396003)(52314003)(189003)(199004)(81166006)(476003)(6666003)(23726003)(8676002)(229853002)(486006)(50466002)(105586002)(11346002)(33716001)(46003)(81156014)(1076002)(7736002)(25786009)(446003)(52116002)(6916009)(386003)(2906002)(97736004)(5660300001)(305945005)(106356001)(47776003)(6246003)(93886005)(478600001)(58126008)(53936002)(68736007)(6496006)(16526019)(52396003)(186003)(316002)(55016002)(33896004)(54906003)(9686003)(8936002)(86362001)(53546011)(16586007)(4326008)(76176011)(59450400001)(6116002)(33656002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1087;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1087;23:g5i2lvj/+RitYvSxmqg+k0v5FZjOoh128W0ET5fF2?=
 =?us-ascii?Q?8bx4zjxkBLQxtWRbUY+wetzhNA0PGecUWsk6t9SXHZ/CNISrCz+RdTuSb5qn?=
 =?us-ascii?Q?fVc+RtpTJYiBci7j+beqPBMonJOzk/DfPp9hC84sNNCFKH/kmaZO76nXe3Xj?=
 =?us-ascii?Q?ycHHDODkigs2Ho9Xap74VCV+7EZp//S0EZuj9sisvbmFnVD7THcsTQuf5fQJ?=
 =?us-ascii?Q?2IPF43Z468hWnFSbHDVw4wT7Fshb3DRIVreQam1kyJAr5g/Q30L6u26Pk5Xv?=
 =?us-ascii?Q?JUdZ0kr0ceFj0+lorVWw8Nv0c4e+khsJRR2hDQXmYchoK2k8MI4Ck7zhm0mM?=
 =?us-ascii?Q?Bx6Dlp1xAfnO9Qjb0s0k0iTqCUIzXbdJZx6Sv4LEad8Ip5q6ItQFf+RQPACJ?=
 =?us-ascii?Q?2eU0vaxeft3TU003K1RbvnF6tQdibAmL7r5FdyaYsf9TMhKl69BfmJOnSdHu?=
 =?us-ascii?Q?3ANosGYTFgngR1kssinXViIh4Be+hmGC5L3k8om0x0CSi7BYqEtCQx748awW?=
 =?us-ascii?Q?t2eRgveBozPq299afGBfG3s/if1cUHt7d5dBThnOx2bGkBzsaUYyOhdV7PwT?=
 =?us-ascii?Q?7WEFmjL9DMWvBKbXuEy1g5d0n5jZqz3ZQg653gpRumCpMK/1iYM3DMJWRH3w?=
 =?us-ascii?Q?nVsuD8mtAFwNl1Ruc9pYyR3u1qMAypqIurT+XmNFwdWfVDxCUDeaYl8OOpKj?=
 =?us-ascii?Q?vXoXsAp8YcnlX4MvCypU6HytA20PeSYHm06ocKSGxFtYnRWIAXyf4lrMd29d?=
 =?us-ascii?Q?23RItSpFmE1N9iqxWOkX1avOdWKEtPfDyZLNDzT4I8KN1mYJJOZ8t0FMNnEP?=
 =?us-ascii?Q?rsuY3boOhlbqWDhj5pWPHQDE6ybggDMVVzkNv6s22yPa+GZzYLoEcdUNzcgE?=
 =?us-ascii?Q?LD2xYGyqn5bpmxr17/l/3s+tnyrvXQNaWkPKG9Snao4FxwoFcG3FOPbBWJz8?=
 =?us-ascii?Q?wqIA3LUQ1DPnAFyZWjHFidUSLT6apUbvLbJMHHFGxbCjX5wkYnmoC9jL3Xyr?=
 =?us-ascii?Q?gbPxvzkMb/hYx+fkrz3H9O4jK6xAgvX7QYDBAWdNgu/RVAElyK9zaXxq0L3W?=
 =?us-ascii?Q?NhMUl2z/4bVIbN0shwfUgsFXDZdptmxqDlsKeyFUxkVWjURX8YgKENigC1gl?=
 =?us-ascii?Q?pHGAR5HgdMSiOx9A6301CdpjFXNLg+iJhl8nvJAyyo+nj6GSWahHOD1Job6l?=
 =?us-ascii?Q?qRCg6ttG79HUs9BfydvNtUfe5rNnnBwYyyl4oZWwc+iQFaJ7cKwE+xppmAqh?=
 =?us-ascii?Q?XVTVmcCAtC5+RhkhcyDV8LXmn4569CIWsbYtftyxHjM3+bmjsp4NemAj2peC?=
 =?us-ascii?Q?FAHabzGYhUisLGar0MF0bgUg3V854DB+R28pDy13vrZat7JlqKLeir+jYElH?=
 =?us-ascii?Q?ZH3YFGV28b8+TbHMwy/QkiUZRE=3D?=
X-Microsoft-Antispam-Message-Info: iD4I3deS/GJrPj52ORT4ANgtNxTBf9pcwEksVRMeWywpNTtM+3U3JzR0LpLtbO9L/rkwUfNytzNVhz4WdT1lovZc820fw6lt0gEhL0QAtogH024T/b0TBu53Ns1y6vWAEGh0MqhtKMG74uhdnqhINAVVzabjWD3Cblt9f/krBr9VbuFnzGIoHaLewzyDUlPx
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;6:swh3PSkhAHjbYcJlQCubYg7bB8siGaVYGTqydwwpEyrdQcD3mLIembVYFjZj8fVrcXAdxz+dJAfhRJrqsmUm+zfDjYWG98MThps/kOwmgQnIVyo2caQgwyphPgdISDiowrYQOCB98B7JS0f//eOLRin+jNL4ewJrNrKNJJT8iAAVfrcECumXan27aNZf2AIuywB2BUL1tLTbKfg3XJ8GaH7cHSZ1wsCevubaBdyWLS7inGEWokWqpMJSzjf5F2hjMKrAkN7aaJmMWFqDKFQ4RjuKHWNKxKnyUqqfMDDFX8oEt7RGnlFWXoSHLfZA5lZQCOylEOZubHctZgb496Zwi9t5hF5ODwr4OCLxNcRvuIE0Rd1BSbEIOXhqCJZd3wVCIzSWeUraqxhOH+Z9hsTc7l2GImcUioewIYI3x1+EatSpwpm5TIYqTNR4KN3/dNCOsxAVBK8XtGCpogaZTx2QXg==;5:EMDshIeDx2Fkw295xSfh2yVBuFKlGy6aAnqz6XbogqpX1Xh33BxU1E2wwHhyQgGnLC7ZucxWcr0FsirhDGikY+fC3HZk6EYriOEFt5vBIwjJ5AwLDdseaR751RHRif9+RzORycqaBTIexVxMLgJQugCKmtxNeqLPfc85wksk83o=;24:M1h6NVra2xxNgVr0Tp5UNBamDPmEzweEk0JKcGb1bDqUd7EsB7SYlHkcrlhZQYbFrTYZLSaibX/OJEPoAITkQE9z7+CTTYJt0w3sHPIfQv4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;7:WdkZuUh7s4GHZjGbWWquClBV794OWlJazaATPjet/Hxdfda8lUEUd+abkm4U/LhW509Xki2wKhnnP4unB5DG+SPBXlJF88kkTpGb0UY3Uhtosv2cHU4N4f0oE1TNo+0CT9ydLA4X3bY3oUZvA8gN9KcK20Jh+lNUtXtVJox6iIicyt4BUvTLLIMOQwwYcTIXSMUVitDmvFOFVWO0A1YB7JOvJLANu8Uy0B6WGhPllTrj9+eemg508cf0UE+kZjhw;20:tMC/vU0cHmZIDurGtau+mVaPZ9t8hV+uCuIkaGPWqsy9SsGjreIGA12A0r2SALwXrbp+eAedNyRNdTXQd62q5Fbokn/eiTpvTvR4MRoEfprsvxf/qVtTwbZx9yuBXzXk/WYUBw+Y0BaVJrxSTU4yhTlWJOQmEhSbQ0bpQCHkTh8=
X-MS-Office365-Filtering-Correlation-Id: 1894411e-2c8c-479a-b0ed-08d5b769932b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 18:03:59.5574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1894411e-2c8c-479a-b0ed-08d5b769932b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1087
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 10:58:53AM -0600, Shuah Khan wrote:
> On 05/11/2018 10:29 AM, Tejun Heo wrote:
> > Hello, Shuah.
> > 
> > On Fri, May 11, 2018 at 08:55:28AM -0600, Shuah Khan wrote:
> >> I think we don't need to create a special branch and all. The following
> >> should work:
> >>
> >> linux-next already has the skip work. What we can do is:
> >>
> >> Do the cleanup and test it against linux-next. In linux-next SKIP isn't PASS. If test is
> >> compiled on linux-next, you will see that SKIP is SKIP. If it is compiled on the mainline,
> >> it will be reported PASS, which will be a temporary state.
> > 
> > Hah, why not just create a branch and make sure what we see in the
> > topic branch is what we'll push?  That's how these things are done
> > usually.
> > 
> 
> It probably doesn't need to be complex.
> 
> Unless there is a dependency with the cgroup tree and the cgroup test,
> the test can go through kselftest tree with you. That is usually how
> I handle kselftests.
> 
> If you think there is a dependency and it has to go through cgroup tree
> then, I can give you the Ack once this TEST_* gets cleaned up.
> 
> thanks,
> -- Shuah
> 


Hello, Shuah!

A minor problem here is a version with KSFT_ constants won't even compile
without your patch, which redefines KSFT_SKIP into a separate value,
due to duplicate cases in the switch statement at the end of the file.

Anyway, not a big deal, we can handle it either way.
An updated version below.

Thanks!

----

>From 0cfd4f1ce368fd240575f1a087f93b743690bda3 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 10 May 2018 17:37:01 +0100
Subject: [PATCH v3] selftests/cgroup: memory controller self-tests

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
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/cgroup/Makefile          |  10 +
 tools/testing/selftests/cgroup/cgroup_util.c     | 317 ++++++++++
 tools/testing/selftests/cgroup/cgroup_util.h     |  40 ++
 tools/testing/selftests/cgroup/test_memcontrol.c | 731 +++++++++++++++++++++++
 5 files changed, 1099 insertions(+)
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
index 000000000000..c92a21f3c806
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -0,0 +1,731 @@
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
+ * This test creates two nested cgroups with and without enabling
+ * the memory controller.
+ */
+static int test_memcg_subtree_control(const char *root)
+{
+	char *parent, *child, *parent2, *child2;
+	int ret = KSFT_FAIL;
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
+	ret = KSFT_PASS;
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
+	int ret = KSFT_FAIL;
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
+	ret = KSFT_PASS;
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
+	int ret = KSFT_FAIL;
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
+		ret = KSFT_SKIP;
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
+	ret = KSFT_PASS;
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
+	int ret = KSFT_FAIL;
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
+	ret = KSFT_PASS;
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
+	int ret = KSFT_FAIL;
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
+	ret = KSFT_PASS;
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
+	int ret = KSFT_FAIL;
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
+	ret = KSFT_PASS;
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
+	int ret = KSFT_FAIL;
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
+	ret = KSFT_PASS;
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
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
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
