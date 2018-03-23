Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeCWPqL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:46:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751400AbeCWPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:46:10 -0400
Date: Fri, 23 Mar 2018 08:46:51 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: mutt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH RFC tools/lkmm 0/12] Reorganize RCU-related cat rules
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032315-0052-0000-0000-000002CE1416
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008729; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01007283; UDB=6.00512933; IPR=6.00786571;
 MB=3.00020201; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-23 15:46:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032315-0053-0000-0000-00005C1732DD
Message-Id: <20180323154651.GA28363@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-23_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803230181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch series reorganizes RCU-related cat-file rules:

1.	Renames link and rcu-path to rcu-link and rb, respectively.
	This avoids unfortunate name collisions with "link" the rule and
	"link" the concept.  Courtesy of Alan Stern.

2.	Redefines "rb" in terms of rcu-fence, explicitly expressing
	the fence-like properties of RCU grace periods.  Courtesy of
	Alan Stern.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |  261 +++++++++++++++++++++++++-----------------
 linux-kernel.cat              |   49 ++++---
 2 files changed, 184 insertions(+), 126 deletions(-)
