Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KpQzB36zGlthFgAAmS7hNA
	; Fri, 08 Jun 2018 16:49:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DFA6B605A5; Fri,  8 Jun 2018 16:49:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4C57D602FC;
	Fri,  8 Jun 2018 16:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C57D602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeFHQtv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:49:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751643AbeFHQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:49:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58GnIS1120578
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 12:49:50 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jfuqf61dd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 12:49:49 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 8 Jun 2018 12:49:49 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 12:49:44 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58Gni8A11469214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 16:49:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EF0AB206B;
        Fri,  8 Jun 2018 13:51:13 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ACB4B2066;
        Fri,  8 Jun 2018 13:51:13 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.149.181])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 13:51:13 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5893B16C997A; Fri,  8 Jun 2018 09:51:34 -0700 (PDT)
Date: Fri, 8 Jun 2018 09:51:34 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Simplifying our RCU models
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180305030949.GP3918@linux.vnet.ibm.com>
 <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com>
 <20180306203906.GA3918@linux.vnet.ibm.com>
 <20180307155444.GA10367@linux.vnet.ibm.com>
 <CA+55aFzyycJWD2xuo7wSptJ=D045yiZnmO+7iY6CapDvge_uCw@mail.gmail.com>
 <20180308204524.GW3918@linux.vnet.ibm.com>
 <20180410234425.GA30784@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410234425.GA30784@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060816-0040-0000-0000-0000043D727B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009153; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01044051; UDB=6.00534574; IPR=6.00823089;
 MB=3.00021535; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-08 16:49:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060816-0041-0000-0000-000008437764
Message-Id: <20180608165134.GA28693@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=966 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 04:44:25PM -0700, Paul E. McKenney wrote:
> On Thu, Mar 08, 2018 at 12:45:24PM -0800, Paul E. McKenney wrote:
> > On Wed, Mar 07, 2018 at 10:48:50AM -0800, Linus Torvalds wrote:
> > > On Wed, Mar 7, 2018 at 7:54 AM, Paul E. McKenney
> > > <paulmck@linux.vnet.ibm.com> wrote:
> > > >
> > > > Ah, and any thoughts on how best to get feedback from the various people
> > > > who would need to reprogram their fingers?  Or is everyone already on
> > > > board with changing these various names?
> > > 
> > > I really would prefer to not see massive re-naming unless there is a
> > > really good reason for it.
> > > 
> > > I'm all for simplifying RCU from a million different versions down to
> > > just a few thousand, but I'm definitely not convinced we want to do
> > > any search-and-replace.
> > 
> > I am currently in the design (more accurately, reredesign phase) for
> > the simplification.  It is quite possible that there is a good reason
> > for at least some renaming, but in that case, I would come back later
> > with that as a separate proposal.
> 
> And I really am still working on this.  It is a bit tricky, but still
> looks doable.  More likely to be ready for 4.19 than 4.18, though.

I suppose it is well past time for an update...

I believe I have the preparation work done (famous last words!), and I am
now working on making rcutorture properly test the resulting compound RCU
read-side critical sections.  User-level testing might be necessary (and
has been for some of the preparatory work).  The ink-on-paper prototype
is starting to look promising, and I expect to get the corresponding
prototype patch posted by the end of this month.

A bit trickier than I expected (as usual), but still looking doable.

							Thanx, Paul
