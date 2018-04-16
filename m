Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeDPQLJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:11:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751151AbeDPQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:07 -0400
Date: Mon, 16 Apr 2018 09:12:09 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH tools/memory-model 0/17] Memory-model changes
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041616-0024-0000-0000-00000347CE50
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018801; UDB=6.00519703; IPR=6.00798042;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:11:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0025-0000-0000-000047AEE9F9
Message-Id: <20180416161209.GA6895@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=34
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains changes to the memory model, including the formal
model in tools/memory-model and documentation in memory-barriers.txt (plus
the Korean translation).  These changes are ready for inclusion in -tip.

1.	Rename LKMM's "link" and "rcu-path" relations to "rcu-link"
	and "rb", respectively, courtesy of Alan Stern.

2.	Redefine LKMM's "rb" relation in terms of rcu-fence in order
	to match the structure of LKMM's other strong fences, courtesy
	of Alan Stern.

3.	Fix memory-barriers.txt's ordering example contrasting DMA to
	MMIO, courtesy of Will Deacon.

4-6.	Fixes related to spin_is_locked(), courtesy of Andrea Parri.

7-11.	Updates to Korean translation of memory-barriers.txt, courtesy
	of SeongJae Park.

12.	Update required version of the herd7 tool, courtesy of Akira
	Yokosawa.

13.	Fix "RWM" typo in cheatsheet.txt, courtesy of Paolo Bonzini.

14.	Improve cheatsheet.txt's key.

15.	Fix cheatsheet.txt's ordering rules for smp_mb__after_atomic().

16.	Add smp_store_mb() to LKMM, courtesy of Andrea Parri.

17.	Use consistent coding style in linux-kernel.def, courtesy of
	Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                    |   17 -
 Documentation/translations/ko_KR/memory-barriers.txt |   56 ++--
 arch/arm64/include/asm/spinlock.h                    |    5 
 include/asm-generic/qspinlock.h                      |    2 
 include/linux/mutex.h                                |    3 
 include/linux/spinlock.h                             |   18 +
 tools/memory-model/Documentation/cheatsheet.txt      |    7 
 tools/memory-model/Documentation/explanation.txt     |  261 +++++++++++--------
 tools/memory-model/README                            |    2 
 tools/memory-model/linux-kernel.cat                  |   49 ++-
 tools/memory-model/linux-kernel.def                  |   29 +-
 11 files changed, 268 insertions(+), 181 deletions(-)
