Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbeD3Pdz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:33:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753334AbeD3Pdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:33:53 -0400
Date: Mon, 30 Apr 2018 08:35:05 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Triplett <josh@joshtriplett.org>, NeilBrown <neilb@suse.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-nfs@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rculist: add list_for_each_entry_from_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <152506256513.7246.13171564155614823841.stgit@noble>
 <152506269061.7246.13075216914692813995.stgit@noble>
 <20180430052032.GA16963@localhost>
 <20180430134308.GT26088@linux.vnet.ibm.com>
 <20180430111454.722c2aa8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430111454.722c2aa8@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18043015-0052-0000-0000-000002E6570D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008951; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01025507; UDB=6.00523683; IPR=6.00804738;
 MB=3.00020863; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-30 15:33:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18043015-0053-0000-0000-00005C8358B7
Message-Id: <20180430153505.GW26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804300148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 11:14:54AM -0400, Steven Rostedt wrote:
> On Mon, 30 Apr 2018 06:43:08 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Sun, Apr 29, 2018 at 10:20:33PM -0700, Josh Triplett wrote:
> > > On Mon, Apr 30, 2018 at 02:31:30PM +1000, NeilBrown wrote:  
> > > > list_for_each_entry_from_rcu() is an RCU version of
> > > > list_for_each_entry_from().  It walks a linked list under rcu
> > > > protection, from a given start point.
> > > > 
> > > > It is similar to list_for_each_entry_continue_rcu() but starts *at*
> > > > the given position rather than *after* it.
> > > > 
> > > > Naturally, the start point must be known to be in the list.  
> > > 
> > > I'd suggest giving an explicit advisory comment to clarify and suggest
> > > correct usage:
> > > 
> > > "This would typically require either that you obtained the node from a
> > > previous walk of the list in the same RCU read-side critical section, or
> > > that you held some sort of non-RCU reference (such as a reference count)
> > > to keep the node alive *and* in the list."
> > > 
> > > (Feel free to wordsmith the exact wording, but something like that seems
> > > like it would help people understand how to use this correctly, and make
> > > it less likely that they'd use it incorrectly.)  
> > 
> > What Josh said!  Could you also contrast this with the existing
> > list_for_each_entry_continue_rcu() macro in the header comment as well
> > as in the commit log?
> 
> Should Documentation/RCU/whatisRCU.txt be updated?
> 
> Specifically section: 7.  FULL LIST OF RCU APIs

Very much so, thank you for catching this!

							Thanx, Paul
