Return-Path: <SRS0=/gKK=F6=linux.vnet.ibm.com=paulmck@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2441712-1520530073-2-7153163920070339129
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=/gKK=F6=linux.vnet.ibm.com=paulmck@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520530072; b=gyLMLmqvSSRbZNSRJEyjP5Xjyth5p07QnwFyNIYpYR5/h3e
    g90+Q3l1Nlz/MfRHTZsSS0aZeFv/OVzzly54aVKwNc8QFS//1y46N6X/lPsWEcdQ
    ojBodWMfG3m7FwCeSEN1TNJ0fOsPFiNcsvj1BVyxuVIgnVNSDYST1MnkCPFy7bpp
    GvyaIwAcMogOZeHGQfPtIMMtIxGI5QmRA9LEVHbOG2Agw+TMYZczLs5NqYbP7ne3
    omtpfTlyWXwpORlPiThJ8D+GUlCK2whCdBj9Vv7YXOCH613Dwyq0CQKLshy6t+Z5
    4CT2YM5a0zkL78fbcpauBTt+y85IaFe6lol98og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id; s=
    arctest; t=1520530072; bh=59efAQXGB1gv5YblG4yEbjs29oGKIwyxmUDr53
    aOfxI=; b=Sbftrg0mVx7WlixuYCM/Ne4EHQRffHRqWbvGYZMs4RN5Y3T170hoZZ
    kOWD6LSehJB6lHxxgm5oH4u55/9Q/VbM2Mdcbea5KWIV8p2DHHivYoXvNtHdZuCO
    WLjhJxFP8S1q6sjLm6r3QaMq4fceb9+9HOLjHolc9D+tiMn5RaMJGylA1hBGISfd
    LAZsIxUVvV9FANKPftPDpCPHKeTA8Zh+xsXlhrIVqvoyfM4dbvTukX+1n1z07GVN
    KHI/NAKJYOZBmss2+RTV/lSn5gZC+plzd9n0Xefl1MGAG7j95xo5iyKwfje7GBP3
    6pgJ8vG14ctqEkXNK1S+g870+wXR3EYg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=/gKK=F6=linux.vnet.ibm.com=paulmck@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=/gKK=F6=linux.vnet.ibm.com=paulmck@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C802133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=paulmck@linux.vnet.ibm.com
Date: Thu, 8 Mar 2018 09:28:18 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        Jann Horn <jannh@google.com>, bcrl@kvack.org, viro@zeniv.linux.org.uk,
        Kent Overstreet <kent.overstreet@gmail.com>, security@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 7/7] RCU, workqueue: Implement rcu_work
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-7-tj@kernel.org>
 <CAJhGHyAuz3TRCpPnCBzZ+om3k9N3ykCWYOq_bv+hucV=XXiY9w@mail.gmail.com>
 <20180307145408.GC3918@linux.vnet.ibm.com>
 <CAJhGHyDEpXG88uDHiogxUH0Yp5sU3v1p-kUSvJbGYCZ+HGucvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDEpXG88uDHiogxUH0Yp5sU3v1p-kUSvJbGYCZ+HGucvQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030817-0008-0000-0000-000002E20B4A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008636; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000130; UDB=6.00508693; IPR=6.00779461;
 MB=3.00019919; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-08 17:27:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030817-0009-0000-0000-000038803A95
Message-Id: <20180308172818.GN3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080197
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 08:29:53AM +0800, Lai Jiangshan wrote:
> On Wed, Mar 7, 2018 at 10:54 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Wed, Mar 07, 2018 at 10:49:49AM +0800, Lai Jiangshan wrote:
> >> On Wed, Mar 7, 2018 at 1:33 AM, Tejun Heo <tj@kernel.org> wrote:
> >>
> >> > +/**
> >> > + * queue_rcu_work_on - queue work on specific CPU after a RCU grace period
> >> > + * @cpu: CPU number to execute work on
> >> > + * @wq: workqueue to use
> >> > + * @rwork: work to queue
> >>
> >> For many people, "RCU grace period" is clear enough, but not ALL.
> >>
> >> So please make it a little more clear that it just queues work after
> >> a *Normal* RCU grace period. it supports only one RCU variant.
> >>
> >>
> >> > + *
> >> > + * Return: %false if @work was already on a queue, %true otherwise.
> >> > + */
> >>
> >> I'm afraid this will be a hard-using API.
> >>
> >> The user can't find a plan B when it returns false, especially when
> >> the user expects the work must be called at least once again
> >> after an RCU grace period.
> >>
> >> And the error-prone part of it is that, like other queue_work() functions,
> >> the return value of it is often ignored and makes the problem worse.
> >>
> >> So, since workqueue.c provides this API, it should handle this
> >> problem. For example, by calling call_rcu() again in this case, but
> >> everything will be much more complex: a synchronization is needed
> >> for "calling call_rcu() again" and allowing the work item called
> >> twice after the last queue_rcu_work() is not workqueue style.
> >
> > I confess that I had not thought of this aspect, but doesn't the
> > rcu_barrier() in v2 of this patchset guarantee that it has passed
> > the RCU portion of the overall wait time?  Given that, what I am
> > missing is now this differs from flush_work() on a normal work item.
> >
> > So could you please show me the sequence of events that leads to this
> > problem?  (Again, against v2 of this patch, which replaces the
> > synchronize_rcu() with rcu_barrier().)
> 
> I mentioned a subtle use case that user would think it is supported
> since the comment doesn't disallow it.
> 
> It is clear that the user expects
>    the work must be called at least once after the API returns

I would have said "before the API returns" rather than "after the
API returns".  What am I missing here?

>    the work must be called after an RCU grace period
> 
> But in the case when the user expects the work must be called
> at least once again after "queue_rcu_work() + an RCU grace period",
> the API is not competent to it if the work is queued.
> Although the user can detect it by the return value of
> queue_rcu_work(), the user hardly makes his expectation
> happen by adding appropriate code.

Beyond a certain point, I need to defer to Tejun on this, but I thought
that a false return meant that the work executed before the flush call.
Here I am assuming that the caller knows that the queue_work_rcu()
already happened and that another queue_work_rcu() won't be invoked on
that same work item until the flush completes.  Without this sort of
assumption, I agree that there could be problems, but without these
assumptions it seems to me that you would have exactly the same problems
with the non-RCU APIs.

What am I missing?

						Thanx, Paul

> >> Some would argue that the delayed_work has the same problem
> >> when the user expects the work must be called at least once again
> >> after a period of time. But time interval is easy to detect, the user
> >> can check the time and call the queue_delayed_work() again
> >> when needed which is also a frequent design pattern. And
> >> for rcu, it is hard to use this design pattern since it is hard
> >> to detect (new) rcu grace period without using call_rcu().
> >>
> >> I would not provide this API. it is not a NACK. I'm just trying
> >> expressing my thinking about the API. I'd rather RCU be changed
> >> and RCU callbacks are changed to be sleepable. But a complete
> >> overhaul cleanup on the whole source tree for compatibility
> >> is needed at first, an even more complex job.
> >
> > One downside of allowing RCU callback functions to sleep is that
> > one poorly written callback can block a bunch of other ones.
> > One advantage of Tejun's approach is that such delays only affect
> > the workqueues, which are already designed to handle such delays.
> >
> >                                                 Thanx, Paul
> >
> >> > +bool queue_rcu_work_on(int cpu, struct workqueue_struct *wq,
> >> > +                      struct rcu_work *rwork)
> >> > +{
> >> > +       struct work_struct *work = &rwork->work;
> >> > +
> >> > +       if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> >> > +               rwork->wq = wq;
> >> > +               rwork->cpu = cpu;
> >> > +               call_rcu(&rwork->rcu, rcu_work_rcufn);
> >> > +               return true;
> >> > +       }
> >> > +
> >> > +       return false;
> >> > +}
> >> > +EXPORT_SYMBOL(queue_rcu_work_on);
> >> > +
> >>
> >
> 
