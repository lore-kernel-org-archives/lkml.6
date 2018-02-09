Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeBIOYU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:24:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750970AbeBIOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:22:03 -0500
Date: Fri, 9 Feb 2018 06:18:32 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH RFC tools/lkmm] Miscellaneous fixes
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020914-2213-0000-0000-0000026A4430
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008504; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000250; SDB=6.00987227; UDB=6.00501083; IPR=6.00766586;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019457; XFM=3.00000015;
 UTC=2018-02-09 14:22:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020914-2214-0000-0000-0000590E2962
Message-Id: <20180209141832.GA17505@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802090184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This RFC series adds some miscellaneous updates to the Linux kernel
memory model:

1.	Clarify the origin and scope of the tool name to avoid confusion
	between "memory model" and "memory management", courtesy of
	Andrea Parri.

2.	Move the maintainer list for LKMM to the main MAINTAINERS file,
	courtesy of Andrea Parri.

3.	Add memory-barriers.txt to the LKMM MAINTAINERS entry, courtesy
	of Andrea Parri.

4.	Add comments explaining the purpose of the various litmus tests.

5.	Fix puntuation errors in litmus-tests/README.

6.	Add LKMM acronym to MAINTAINERS entry.  If there are no objections,
	this will be squashed with #3 above.

7.	Add Akira Yokosawa as an LKMM reviewer.

8-10.	Replace underscores with hyphens for smp_mb__*() workings.  Note that
	this patch leaves rb_dep alone because the underscore is set by herd7.
	If there are no objections, these will be squashed together.

							Thanx, Paul

------------------------------------------------------------------------

 /tools/memory-model/MAINTAINERS                                                            |   15 -------
 b/MAINTAINERS                                                                              |   20 +++++++++-
 b/tools/memory-model/MAINTAINERS                                                           |    2 -
 b/tools/memory-model/README                                                                |   14 +++----
 b/tools/memory-model/linux-kernel.bell                                                     |    8 ++--
 b/tools/memory-model/linux-kernel.cat                                                      |    8 ++--
 b/tools/memory-model/linux-kernel.def                                                      |    6 +--
 b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus                              |    7 +++
 b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus                              |    7 +++
 b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus                              |    7 +++
 b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus                                   |    7 +++
 b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus                         |   10 +++++
 b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus                         |   10 +++++
 b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus                                  |    9 ++++
 b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus |   11 +++++
 b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus                        |   11 +++++
 b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus                    |    8 ++++
 b/tools/memory-model/litmus-tests/LB+poonceonces.litmus                                    |    7 +++
 b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus                           |   11 +++++
 b/tools/memory-model/litmus-tests/MP+polocks.litmus                                        |   11 +++++
 b/tools/memory-model/litmus-tests/MP+poonceonces.litmus                                    |    7 +++
 b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus                    |    8 ++++
 b/tools/memory-model/litmus-tests/MP+porevlocks.litmus                                     |   11 +++++
 b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus                        |    8 ++++
 b/tools/memory-model/litmus-tests/R+mbonceonces.litmus                                     |    9 ++++
 b/tools/memory-model/litmus-tests/R+poonceonces.litmus                                     |    8 ++++
 b/tools/memory-model/litmus-tests/README                                                   |    4 +-
 b/tools/memory-model/litmus-tests/S+poonceonces.litmus                                     |    9 ++++
 b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus                       |    7 +++
 b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus                                    |    9 ++++
 b/tools/memory-model/litmus-tests/SB+poonceonces.litmus                                    |    8 ++++
 b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus                              |    8 ++++
 b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus                |    8 ++++
 b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus               |    9 ++++
 b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus               |    8 ++++
 b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus    |   14 +++++++
 36 files changed, 286 insertions(+), 38 deletions(-)
