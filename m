Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935447AbeEXDwi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 23:52:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935171AbeEXDwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 23:52:35 -0400
Date: Wed, 23 May 2018 18:27:55 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
        kernel-team@android.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] rcu: Use better variable names in funnel locking loop
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523063815.198302-1-joel@joelfernandes.org>
 <20180523063815.198302-4-joel@joelfernandes.org>
 <20180523160617.GM3803@linux.vnet.ibm.com>
 <20180523192349.GA5845@linux.vnet.ibm.com>
 <20180524005450.GA171060@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524005450.GA171060@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052403-0056-0000-0000-000004531604
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-24 03:52:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052403-0057-0000-0000-0000089731D4
Message-Id: <20180524012755.GI3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240045
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 05:54:50PM -0700, Joel Fernandes wrote:
> On Wed, May 23, 2018 at 12:23:49PM -0700, Paul E. McKenney wrote:
> > On Wed, May 23, 2018 at 09:06:17AM -0700, Paul E. McKenney wrote:
> > > On Tue, May 22, 2018 at 11:38:14PM -0700, Joel Fernandes wrote:
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > 
> > > > The funnel locking loop in rcu_start_this_gp uses rcu_root as a
> > > > temporary variable while walking the combining tree. This causes a
> > > > tiresome exercise of a code reader reminding themselves that rcu_root
> > > > may not be root. Lets just call it rnp, and rename other variables as
> > > > well to be more appropriate.
> > > > 
> > > > Original patch: https://patchwork.kernel.org/patch/10396577/
> > > > 
> > > > Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > I used to have double Signed-off-by back when I was seconded to Linaro.
> > > But I am guessing that you want the second and don't need the first
> > > one.  Unless you tell me otherwise, I will remove the first one on
> > > my next rebase.
> > > 
> > > Anyway, the new variable names are much more clear, good stuff,
> > > queued for further review and testing, thank you!
> > 
> > And it looks to me like I should fold in the patchlet below to change to
> > rnp_start in a comment.  Please let me know if this would mess things up.
> 
> Yes, missed that. Sorry. It looks great, thanks!

Done!  And not a problem -- this is after all why we do reviews.

							Thanx, Paul
