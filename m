Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeDPQVb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:21:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752670AbeDPQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:21:28 -0400
Date: Mon, 16 Apr 2018 09:22:28 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH RFC tools/memory-model 0/5] Additional proposed changes to
 LKMM
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041616-0040-0000-0000-0000041BB580
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018804; UDB=6.00519705; IPR=6.00798046;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:21:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0041-0000-0000-00000821B914
Message-Id: <20180416162228.GA18167@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains a few additional changes to tools/memory-model,
however, the members of this series need more discussion and feedback
before they are ready for inclusion.

1.	Add LKMM test scripts.

2.	Add litmus test for full-up multicopy atomicity.

3.	Add experimental .cfg and .cat files for s390.  These are for
	expository purposes only, and would more likely be included in
	the herd tool than in the Linux kernel.

4.	Add LKMM support for spin_is_locked(), courtesy of Luc Maranget.
	It has been suggested that spin_is_locked() be removed from the
	kernel, but in the meantime we should at least have a definition
	of what it does.

5.	Flag litmus test demonstrating the A-cumulativity of
	smp_store_release() and LKMM's propagation rule.

							Thanx, Paul

------------------------------------------------------------------------

 linux-kernel.def                                       |    1 
 litmus-tests/.gitignore                                |    1 
 litmus-tests/IRIW+mbonceonces+OnceOnce.litmus          |    2 
 litmus-tests/MP+polockmbonce+poacquiresilsil.litmus    |   30 +++++
 litmus-tests/MP+polockonce+poacquiresilsil.litmus      |   29 +++++
 litmus-tests/README                                    |   19 +++
 litmus-tests/SB+poonceoncescoh.litmus                  |   31 ++++++
 litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus |    4 
 lock.cat                                               |   53 +++++++++-
 s390.cat                                               |   18 +++
 s390.cfg                                               |   21 ++++
 scripts/checkalllitmus.sh                              |   73 ++++++++++++++
 scripts/checklitmus.sh                                 |   86 +++++++++++++++++
 13 files changed, 359 insertions(+), 9 deletions(-)
