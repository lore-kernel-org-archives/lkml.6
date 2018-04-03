Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeDCPPx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:15:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751233AbeDCPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:15:52 -0400
Date: Tue, 3 Apr 2018 08:16:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180402193154.GA3948@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1804030946400.1399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1804030946400.1399-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040315-0048-0000-0000-00000254A1DC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008795; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012553; UDB=6.00516057; IPR=6.00791819;
 MB=3.00020392; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-03 15:15:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040315-0049-0000-0000-000044A54043
Message-Id: <20180403151642.GK3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804030157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 09:50:19AM -0400, Alan Stern wrote:
> On Mon, 2 Apr 2018, Paul E. McKenney wrote:
> 
> > > > I will look at this more later, reaching end of both battery and useful
> > > > attention span...
> > 
> > Like the following, perhaps?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > s390
> > 
> > include "fences.cat"
> > include "cos.cat"
> > 
> > (* Fundamental coherence ordering *)
> > let com = rf | co | fr
> > acyclic po-loc | com as coherence
> > 
> > (* Atomic *)
> > empty rmw & (fre;coe) as atom 
> > 
> > (* Fences *)
> > let mb = [M] ; fencerel(Mb) ; [M]
> > 
> > (* TSO with multicopy atomicity *)
> > let po-ghb = ([R] ; po ; [M]) | ([M] ; po ; [W]) 
> > acyclic mb | po-ghb | fr | rf | co as sc
> 
> Yes, that should work okay (apart from issues related to ordering of
> atomic accesses).
> 
> By the way, what does that last "sc" stand for?  Surely not Sequential
> Consistency!  You might consider renaming it to "tso-mca".

Good point, fixed.

But it is the closest to SC in commercial computing systems, for whatever
that is worth.  ;-)

							Thanx, Paul
