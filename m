Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934249AbeEWTU2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:20:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934090AbeEWTUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:20:25 -0400
Date: Wed, 23 May 2018 12:10:44 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@fb.com
Subject: Re: [PATCH] bdi: Move cgroup bdi_writeback to a dedicated low
 concurrency workqueue
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
 <20180523183907.GZ3803@linux.vnet.ibm.com>
 <20180523185143.GS1718769@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523185143.GS1718769@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052319-0004-0000-0000-000014255D95
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009073; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036619; UDB=6.00530319; IPR=6.00815747;
 MB=3.00021262; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 19:20:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052319-0005-0000-0000-000087567014
Message-Id: <20180523191044.GC3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230188
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:51:43AM -0700, Tejun Heo wrote:
> On Wed, May 23, 2018 at 11:39:07AM -0700, Paul E. McKenney wrote:
> > > While this resolves the problem at hand, it might be a good idea to
> > > isolate rcu_exp_work to its own workqueue too as it can be used from
> > > various paths and is prone to this sort of indirect A-A deadlocks.
> > 
> > Commit ad7c946b35ad4 ("rcu: Create RCU-specific workqueues with rescuers")
> > was accepted into mainline this past merge window.  Does that do what
> > you want, or are you looking for something else?
> 
> Ah, that does it.  Sorry, was looking at an older kernel.

No worries -- after all, I must confess that I was a bit slow in getting
to this.

							Thanx, Paul
