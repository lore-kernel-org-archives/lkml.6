Return-Path: <SRS0=jjiN=F5=linux.vnet.ibm.com=paulmck@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3467874-1520434424-2-6721446030716319973
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
X-Mail-from: SRS0=jjiN=F5=linux.vnet.ibm.com=paulmck@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520434423; b=NjutxkiMqyLshOUvg4adLUjDccLPqfWMLFEk3gTz7Hu0X5P
    ZTKZVsmfP0edr6GlPcnq/PjaAuAjLlmx1uAKLBnV3d0ZxXSj7qghOeOIuws0xVYn
    DQVOmZsaeGWi2qnvGRrBQ4cOrGO96kgVUaYNtxGZHd002hhAQSg0EoHk4hIIXUis
    EFCBurorVh3fFw0bQQRsGty7WYpRup6vq1EkMSDhUxWuNod6vdZs/cbv3ZE06YZg
    m0aVpaL1ZmaGDAzXjnPsGvISUPScwKbaNoqRWN79IVnPwXhBQjCdBo6GVQtAUbpi
    xG/GpM2X8q299ugE/Od7I8ogqDbyCLArTb2KkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id; s=
    arctest; t=1520434423; bh=ZzeknZ8860FcDfxP0xtnrI19gkNpHYku9nu4jZ
    dlzwQ=; b=dkXImo9PfEFvplB32WVTrSUmENDSt5iD6TqFyZByeymSeWYo8127dI
    3rjL0pjwnM5ZNbtYeH8Q8COIhW5fUgENRa4bC0pyphbwvaBQWiGVmfa8fLurfhv4
    eLMzc8amSMyPzUusktfQwKp1+pTrGIcqlzK96js3Qh9affR/kzddagjfV4P+gutZ
    n/TpuzfheW4K1A8WoUtjAmoAhcfXE0aSoNr75vYJMIPXPxzgTiE3om9dNbZjJCE9
    yr9x5/eybXNrBfpv/SbwAStLuuBkzWFD7U9jgwfTGoMEP6xgfo7czYfL1ZHgKSGK
    qAaL5yBJJLkT+UKFqx0cNeH1ODrXRVhQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=jjiN=F5=linux.vnet.ibm.com=paulmck@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=jjiN=F5=linux.vnet.ibm.com=paulmck@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF46421770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=paulmck@linux.vnet.ibm.com
Date: Wed, 7 Mar 2018 06:54:08 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org, jannh@google.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, kent.overstreet@gmail.com,
        security@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Subject: Re: [PATCH 7/7] RCU, workqueue: Implement rcu_work
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-7-tj@kernel.org>
 <CAJhGHyAuz3TRCpPnCBzZ+om3k9N3ykCWYOq_bv+hucV=XXiY9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyAuz3TRCpPnCBzZ+om3k9N3ykCWYOq_bv+hucV=XXiY9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030714-0052-0000-0000-000002C4DFC8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008629; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999623; UDB=6.00508472; IPR=6.00779022;
 MB=3.00019892; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-07 14:53:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030714-0053-0000-0000-00005BEBACC0
Message-Id: <20180307145408.GC3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070172
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 10:49:49AM +0800, Lai Jiangshan wrote:
> On Wed, Mar 7, 2018 at 1:33 AM, Tejun Heo <tj@kernel.org> wrote:
> 
> > +/**
> > + * queue_rcu_work_on - queue work on specific CPU after a RCU grace period
> > + * @cpu: CPU number to execute work on
> > + * @wq: workqueue to use
> > + * @rwork: work to queue
> 
> For many people, "RCU grace period" is clear enough, but not ALL.
> 
> So please make it a little more clear that it just queues work after
> a *Normal* RCU grace period. it supports only one RCU variant.
> 
> 
> > + *
> > + * Return: %false if @work was already on a queue, %true otherwise.
> > + */
> 
> I'm afraid this will be a hard-using API.
> 
> The user can't find a plan B when it returns false, especially when
> the user expects the work must be called at least once again
> after an RCU grace period.
> 
> And the error-prone part of it is that, like other queue_work() functions,
> the return value of it is often ignored and makes the problem worse.
> 
> So, since workqueue.c provides this API, it should handle this
> problem. For example, by calling call_rcu() again in this case, but
> everything will be much more complex: a synchronization is needed
> for "calling call_rcu() again" and allowing the work item called
> twice after the last queue_rcu_work() is not workqueue style.

I confess that I had not thought of this aspect, but doesn't the
rcu_barrier() in v2 of this patchset guarantee that it has passed
the RCU portion of the overall wait time?  Given that, what I am
missing is now this differs from flush_work() on a normal work item.

So could you please show me the sequence of events that leads to this
problem?  (Again, against v2 of this patch, which replaces the
synchronize_rcu() with rcu_barrier().)

> Some would argue that the delayed_work has the same problem
> when the user expects the work must be called at least once again
> after a period of time. But time interval is easy to detect, the user
> can check the time and call the queue_delayed_work() again
> when needed which is also a frequent design pattern. And
> for rcu, it is hard to use this design pattern since it is hard
> to detect (new) rcu grace period without using call_rcu().
> 
> I would not provide this API. it is not a NACK. I'm just trying
> expressing my thinking about the API. I'd rather RCU be changed
> and RCU callbacks are changed to be sleepable. But a complete
> overhaul cleanup on the whole source tree for compatibility
> is needed at first, an even more complex job.

One downside of allowing RCU callback functions to sleep is that
one poorly written callback can block a bunch of other ones.
One advantage of Tejun's approach is that such delays only affect
the workqueues, which are already designed to handle such delays.

						Thanx, Paul

> > +bool queue_rcu_work_on(int cpu, struct workqueue_struct *wq,
> > +                      struct rcu_work *rwork)
> > +{
> > +       struct work_struct *work = &rwork->work;
> > +
> > +       if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> > +               rwork->wq = wq;
> > +               rwork->cpu = cpu;
> > +               call_rcu(&rwork->rcu, rcu_work_rcufn);
> > +               return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +EXPORT_SYMBOL(queue_rcu_work_on);
> > +
> 
