Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeBZVz5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:55:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751487AbeBZVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:55:52 -0500
Date: Mon, 26 Feb 2018 13:56:14 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: [PATCH tip/core/rcu 0/5] SRCU updates
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022621-0008-0000-0000-000002DB9D5B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995531; UDB=6.00506033; IPR=6.00774859;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:55:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0009-0000-0000-00003864E609
Message-Id: <20180226215614.GA31616@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260275
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides minor SRCU updates:

1.	Use __func__ instead of hard-coded function names.

2.	Prevent sdp->srcu_gp_seq_needed_exp counter wrap, courtesy of
	Ildar Ismagilov.

3.	Reduce scans of srcu_data in counter wrap check, courtesy of
	Ildar Ismagilov.

4.	Remove dead code in srcu_gp_end(), courtesy of Byungchul Park.

5.	Remove SRCU throttling.

							Thanx, Paul

------------------------------------------------------------------------

 srcutree.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)
