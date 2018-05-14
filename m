Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeENW7l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:59:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752138AbeENW7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:59:39 -0400
Date: Mon, 14 May 2018 16:01:05 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/3] Kernel fixes to spin_is_locked()
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051422-0048-0000-0000-0000026CF0C4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032372; UDB=6.00527778; IPR=6.00811503;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 22:59:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051422-0049-0000-0000-0000451F35A4
Message-Id: <20180514230105.GA6421@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains fixes to the kernel related to the semantics
of spin_is_locked(), all courtesy of Andrea Parri, and all ready for
inclusion in -tip:

1.	Document the semantics of spin_is_locked() by adding a docbook
	header comment.

2.	Remove smp_mb() from arch_spin_is_locked(), given that the
	new order-free spin_is_locked() semantics require no such barrier.

3.	Clean up comment and #ifndef for {,queued_}spin_is_locked().
	The comment was "XXX think about spin_is_locked", and I can
	attest that we have now done some serious thinking.  ;-)

							Thanx, Paul

------------------------------------------------------------------------
