Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966321AbeBUQSF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:18:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933284AbeBUQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:16:19 -0500
Date: Wed, 21 Feb 2018 08:15:50 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, nborisov@suse.com
Subject: Re: [PATCH RFC tools/lkmm 09/12] tools/memory-model: Add required
 herd7 version to README file
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519169112-20593-9-git-send-email-paulmck@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211009110.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211009110.2032-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022116-0044-0000-0000-000003E7AD39
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008570; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993022; UDB=6.00504544; IPR=6.00772366;
 MB=3.00019674; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-21 16:15:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022116-0045-0000-0000-00000817B300
Message-Id: <20180221161550.GF3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210197
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:10:52AM -0500, Alan Stern wrote:
> On Tue, 20 Feb 2018, Paul E. McKenney wrote:
> 
> > LKMM and the herd7 tool are co-evolving, and out-of-date herd7 tools
> > produce inaccurate results, often with no obvious error messages.  This
> > commit therefore adds the required herd7 version to the LKMM README file.
> > 
> > Longer term, it would be good if .cat files could specify the required
> > version in a manner allowing herd7 to produce clear diagnostics.
> > 
> > Suggested-by: Akira Yokosawa <akiyks@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  tools/memory-model/README | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index 91414a49fac5..ea950c566ffd 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -20,7 +20,8 @@ that litmus test to be exercised within the Linux kernel.
> >  REQUIREMENTS
> >  ============
> >  
> > -The "herd7" and "klitmus7" tools must be downloaded separately:
> > +Version 7.48 of the "herd7" and "klitmus7" tools must be downloaded
> > +separately:
> >  
> >    https://github.com/herd/herdtools7
> 
> The text immediately below this mentions the Docker image and gentoo
> package.  Aren't they both seriously out of date at this point?  In
> which case, shouldn't we remove them from the README?

Agreed, we should.  How about the following?

							Thanx, Paul

------------------------------------------------------------------------

commit b59fd89b465f0bfbfe06bf47e22c0cf160aef66b
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed Feb 21 08:13:48 2018 -0800

    tools/memory-model: Remove mention of docker/gentoo image
    
    Because the docker and gentoo images haven't been updated in quite some
    time, they are likely to provide more confusion than help.  This commit
    therefore removes mention of them from the README file.
    
    Reported-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/README b/tools/memory-model/README
index ea950c566ffd..0b3a5f3c9ccd 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -27,21 +27,6 @@ separately:
 
 See "herdtools7/INSTALL.md" for installation instructions.
 
-Alternatively, Abhishek Bhardwaj has kindly provided a Docker image
-of these tools at "abhishek40/memory-model".  Abhishek suggests the
-following commands to install and use this image:
-
-  - Users should install Docker for their distribution.
-  - docker run -itd abhishek40/memory-model
-  - docker attach <id-emitted-from-the-previous-command>
-
-Gentoo users might wish to make use of Patrick McLean's package:
-
-  https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/herdtools7
-
-These packages may not be up-to-date with respect to the GitHub
-repository.
-
 
 ==================
 BASIC USAGE: HERD7
