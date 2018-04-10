Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeDJXnc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:43:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753423AbeDJXn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 19:43:28 -0400
Date: Tue, 10 Apr 2018 16:44:25 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>,
        Jann Horn <jannh@google.com>, Benjamin LaHaise <bcrl@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Simplifying our RCU models
Reply-To: paulmck@linux.vnet.ibm.com
References: <CA+55aFyOi1XnSqHtg=VfcUiBL+egNL==NRX1Zaeihe8W5OJVgw@mail.gmail.com>
 <20180305030949.GP3918@linux.vnet.ibm.com>
 <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com>
 <20180306203906.GA3918@linux.vnet.ibm.com>
 <20180307155444.GA10367@linux.vnet.ibm.com>
 <CA+55aFzyycJWD2xuo7wSptJ=D045yiZnmO+7iY6CapDvge_uCw@mail.gmail.com>
 <20180308204524.GW3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308204524.GW3918@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041023-0052-0000-0000-000002D858C8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008833; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01016077; UDB=6.00518136; IPR=6.00795324;
 MB=3.00020511; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-10 23:43:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041023-0053-0000-0000-00005C48CB00
Message-Id: <20180410234425.GA30784@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804100216
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 12:45:24PM -0800, Paul E. McKenney wrote:
> On Wed, Mar 07, 2018 at 10:48:50AM -0800, Linus Torvalds wrote:
> > On Wed, Mar 7, 2018 at 7:54 AM, Paul E. McKenney
> > <paulmck@linux.vnet.ibm.com> wrote:
> > >
> > > Ah, and any thoughts on how best to get feedback from the various people
> > > who would need to reprogram their fingers?  Or is everyone already on
> > > board with changing these various names?
> > 
> > I really would prefer to not see massive re-naming unless there is a
> > really good reason for it.
> > 
> > I'm all for simplifying RCU from a million different versions down to
> > just a few thousand, but I'm definitely not convinced we want to do
> > any search-and-replace.
> 
> I am currently in the design (more accurately, reredesign phase) for
> the simplification.  It is quite possible that there is a good reason
> for at least some renaming, but in that case, I would come back later
> with that as a separate proposal.

And I really am still working on this.  It is a bit tricky, but still
looks doable.  More likely to be ready for 4.19 than 4.18, though.

							Thanx, Paul
