Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004AAC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A682089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A682089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeJPEz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:55:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbeJPEzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:55:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FL4JZN137734
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 17:08:57 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n4wv4bndm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 17:08:57 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Oct 2018 17:08:56 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Oct 2018 17:08:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9FL8pi437748938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 21:08:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAA67B2065;
        Mon, 15 Oct 2018 17:06:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6162B205F;
        Mon, 15 Oct 2018 17:06:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Oct 2018 17:06:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3634916C2455; Mon, 15 Oct 2018 14:08:56 -0700 (PDT)
Date:   Mon, 15 Oct 2018 14:08:56 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Reply-To: paulmck@linux.ibm.com
References: <20181014231731.GN2674@linux.ibm.com>
 <20181015020827.GA217384@joelaf.mtv.corp.google.com>
 <20181015021349.GB217384@joelaf.mtv.corp.google.com>
 <20181015023328.GP2674@linux.ibm.com>
 <20181015024758.GA227989@joelaf.mtv.corp.google.com>
 <5151da01-343b-bb37-353e-b6652ae530f5@suse.com>
 <20181015112112.GT2674@linux.ibm.com>
 <20181015193951.GA33528@joelaf.mtv.corp.google.com>
 <20181015195426.GD2674@linux.ibm.com>
 <20181015201556.GA43575@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015201556.GA43575@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101521-0052-0000-0000-000003440F8C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009882; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103178; UDB=6.00570999; IPR=6.00883229;
 MB=3.00023767; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-15 21:08:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101521-0053-0000-0000-00005E6CE6CB
Message-Id: <20181015210856.GE2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 01:15:56PM -0700, Joel Fernandes wrote:
> On Mon, Oct 15, 2018 at 12:54:26PM -0700, Paul E. McKenney wrote:
> [...]
> > > > In any case, please don't spin for milliseconds with preemption disabled.
> > > > The real-time guys are unlikely to be happy with you if you do this!
> > > 
> > > Well just to clarify, I was just running Oleg's test which did this. This
> > > test was mentioned in the original documentation that I deleted. Ofcourse I
> > > would not dare do such a thing in production code :-D. I guess to Oleg's
> > > defense, he did it to very that synchronize_rcu() was not blocked on
> > > preempt-disable sections which was a different test.
> > 
> > Understood!  Just pointing out that RCU's tolerating a given action does
> > not necessarily mean that it is a good idea to take that action.  ;-)
> 
> Makes sense :-) thanks.

Don't worry, that won't happen again.  ;-)

> > > > > > +		pr_crit("SPIN done!\n");
> > > > > > +		preempt_enable();
> > > > > > +		break;
> > > > > > +	case 777:
> > > > > > +		pr_crit("SYNC start\n");
> > > > > > +		synchronize_rcu();
> > > > > > +		pr_crit("SYNC done!\n");
> > > > > 
> > > > > But you are using the console printing infrastructure which is rather
> > > > > heavyweight. Try replacing pr_* calls with trace_printk so that you
> > > > > write to the lock-free ring buffer, this will reduce the noise from the
> > > > > heavy console printing infrastructure.
> > > > 
> > > > And this might be a problem as well.
> > > 
> > > This was not the issue (or atleast not fully the issue) since I saw the same
> > > thing with trace_printk. It was exactly what you said - which is the
> > > excessively long preempt disabled times.
> > 
> > One approach would be to apply this patch against (say) v4.18, which
> > does not have consolidated grace periods.  You might then be able to
> > tell if the pr_crit() calls make any difference.
> 
> I could do that, yeah. But since the original problem went away due to
> disabling preempts for a short while, I will move on and continue to focus on
> updating other parts of the documenation. Just to mention I
> brought this up because I thought its better to do that than not to, just
> incase there is any lurking issue with the consolidation. Sorry if that ended
> up with me being noisy.

Not a problem, no need to apologize!

> Just curious, while I am going through the documentation, is there anything
> in particular that particularly sticks out to you that needs updating? I
> think I am around 50% there with the last several rounds of doc patches but I
> have lot more to go through. "Just keep doing what you're doing" is also a
> perfectly valid answer ;-)

It is the things needing updating that I do not yet know about that worry
the most, so "Just keep doing what you're doing" seems most appropriate.  ;-)

							Thanx, Paul

