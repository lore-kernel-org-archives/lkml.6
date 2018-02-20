Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeBTXYH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:24:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751764AbeBTXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:24:05 -0500
Date: Tue, 20 Feb 2018 15:24:05 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com
Subject: [PATCH RFC tools/lkmm 0/12] Miscellaneous fixes
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022023-0052-0000-0000-000002BB5DCF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008566; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992684; UDB=6.00504342; IPR=6.00772030;
 MB=3.00019661; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 23:23:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022023-0053-0000-0000-00005BC22B7D
Message-Id: <20180220232405.GA19274@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200276
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

5.	Fix punctuation errors in litmus-tests/README.

6.	Add Akira Yokosawa as an LKMM reviewer.

7.	Cross-reference tools/memory-model from memory-barriers.txt,
	courtesy of Andrea Parri and Akira Yokosawa.

8.	Fix description of data dependency barriers, courtesy of
	Nikolay Borisov.

9.	Add required herd7 version to README file.

10.	Add a S lock-based external-view litmus test, courtesy of Alan
	Stern.

11.	Convert underscores to hyphens in .bell and .cat files for
	consistency with typical cat-language code.

12.	Remove rb-dep, smp_read_barrier_depends, and lockless_dereference,
	which reflect recent Linux-kernel changes, courtesy of
	Alan Stern.

Changes since v1:

o	Applied feedback from v1 posting.

o	Squashing patches together, as promised in v1.

o	Added patches 7-10 and 12.

							Thanx, Paul

------------------------------------------------------------------------

 /tools/memory-model/MAINTAINERS                                                            |   15 -
 b/Documentation/memory-barriers.txt                                                        |    8 
 b/MAINTAINERS                                                                              |   18 ++
 b/tools/memory-model/Documentation/cheatsheet.txt                                          |    3 
 b/tools/memory-model/Documentation/explanation.txt                                         |   81 +++++-----
 b/tools/memory-model/MAINTAINERS                                                           |    2 
 b/tools/memory-model/README                                                                |   17 +-
 b/tools/memory-model/linux-kernel.bell                                                     |    9 -
 b/tools/memory-model/linux-kernel.cat                                                      |   15 -
 b/tools/memory-model/linux-kernel.def                                                      |    8 
 b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus                              |    7 
 b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus                              |    7 
 b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus                              |    7 
 b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus                                   |    7 
 b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus                         |   10 +
 b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus                         |   10 +
 b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus               |   41 +++++
 b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus                                  |    9 +
 b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus |   11 +
 b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus                        |   11 +
 b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus                    |    8 
 b/tools/memory-model/litmus-tests/LB+poonceonces.litmus                                    |    7 
 b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus                           |   11 +
 b/tools/memory-model/litmus-tests/MP+polocks.litmus                                        |   11 +
 b/tools/memory-model/litmus-tests/MP+poonceonces.litmus                                    |    7 
 b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus                    |    8 
 b/tools/memory-model/litmus-tests/MP+porevlocks.litmus                                     |   11 +
 b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus                        |    8 
 b/tools/memory-model/litmus-tests/R+mbonceonces.litmus                                     |    9 +
 b/tools/memory-model/litmus-tests/R+poonceonces.litmus                                     |    8 
 b/tools/memory-model/litmus-tests/README                                                   |    4 
 b/tools/memory-model/litmus-tests/S+poonceonces.litmus                                     |    9 +
 b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus                       |    7 
 b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus                                    |    9 +
 b/tools/memory-model/litmus-tests/SB+poonceonces.litmus                                    |    8 
 b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus                              |    8 
 b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus                |    8 
 b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus               |    9 +
 b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus               |    8 
 b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus    |   14 +
 40 files changed, 380 insertions(+), 88 deletions(-)
