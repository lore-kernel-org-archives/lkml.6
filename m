Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeC2EyD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 00:54:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751146AbeC2EyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 00:54:01 -0400
Date: Wed, 28 Mar 2018 18:33:16 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, schwidefsky@de.ibm.com,
        borntraeger@de.ibm.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, parri.andrea@gmail.com,
        will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180328134232.GA29274@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1803281057280.1375-100000@iolanthe.rowland.org>
 <20180328175136.GL4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328175136.GL4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032904-0036-0000-0000-000002D89F73
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008763; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009946; UDB=6.00514528; IPR=6.00789225;
 MB=3.00020304; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-29 04:53:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032904-0037-0000-0000-000043CC695A
Message-Id: <20180329013316.GU3675@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803290054
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 07:51:36PM +0200, Peter Zijlstra wrote:
> On Wed, Mar 28, 2018 at 11:01:25AM -0400, Alan Stern wrote:
> > I don't quite see the point of this.  You're not suggesting that we
> > have one Linux Kernel Memory Consistency Model for s390 and another
> > one for all the other architectures, are you?
> > 
> > If the idea is merely to provide a herd model for s390 then it should 
> > go into the DIY repository, not into the LKMM repository.
> 
> I suspect the use-case was validating s390 arch code which might not
> have followed all the regular linux rules because they know its TSO. But
> yes, I'm tempted to agree that even arch specific code ought to follow
> the regular rules, just to avoid completely messing up the reader.

Another use case is testing an s390 .cat file without having to teach
herd about s390 assembly.  ;-)

							Thanx, Paul
