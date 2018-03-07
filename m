Return-Path: <SRS0=44kz=F5=gmail.com=jiangshanlai@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1928353-1520390993-2-17249160975912381789
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=44kz=F5=gmail.com=jiangshanlai@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520390993; b=hQEZZkhv6TXf/AYEiyrTpTeJBrIe/6S8NIBKhRHb7fyrxEh
    tCfkJTTrKydSEKoV85Psfe1JM5w0iJKUclTwbkR2qknUut6VyxLNqoVYFMQ6Ig7F
    lJPZc0ZLX+9o8hGac8ABtHE93ce8VP/lHje+WHf3OO+m+UoAASbbiV3XEvxaeVPd
    6mYssuFJdl+B4+Pl/B9Sqe10gc8AB5xmu8rsvbSGdEG7Qmw+d/pdIjNCm3lXOizE
    0Ubgw0tvQCb+dsaEMuUSYrfe3P0WlGt/BVM5IbjCK6+dqyAI3mt4GzZLNUNcgiTS
    Bdi2TNaS5kTmHwWbTN8Vjb1F7OGqzUaRvS7K+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1520390993; bh=9U2SAxoZQlgIo4OflKJamALwgH5Ol9f48rXdlw
    t87Bs=; b=FdeZ6W82vOak2PVg0ekn/b4N+LynlxxO6At8Wp8NxBm8Z9y2e7rD7j
    kceXOEcY1p/NNRbFLZhfgMZtQchCgdnx222p7VbgYlmdj6tHDJOl2FOwb0rqeQZW
    CTE4YlCZhtyg35cyjl9EYFPCmbwDmOfmqOBUiDAZ+nmOl1hSy5lfugA+UACULiF/
    1zLYor3N2AqPKxMCRnIJ2hZI/V68/ljq3mSZ3Zp+7cNKbguxa86f+voPVF+pnNIK
    UTmS16vn7dcxbcX9glAOZ4deOCBDErXdD8ev2ytITRgrYH61IOpNXRrj+6zlgAGx
    mrIG+WVAXrVixNoM6Xze0i8O8ivZ3vMw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UMRklnWX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=44kz=F5=gmail.com=jiangshanlai@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EGh17yb0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UMRklnWX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=44kz=F5=gmail.com=jiangshanlai@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EGh17yb0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A79C2064E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=jiangshanlai@gmail.com
X-Google-Smtp-Source: AG47ELtv9TURbHHqSg6bQ07Anud26Kp9dqDDIUcFAQpA/oNAlqp8VbfIwMq3/dF6Bs1Ys5gxWj26ZuOc5uSpFat6Sko=
MIME-Version: 1.0
Sender: jiangshanlai@gmail.com
In-Reply-To: <20180306173316.3088458-7-tj@kernel.org>
References: <20180306172657.3060270-1-tj@kernel.org> <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-7-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date: Wed, 7 Mar 2018 10:49:49 +0800
X-Google-Sender-Auth: YFjM27wPiu_4fVN1_i9GUIfKppQ
Message-ID: <CAJhGHyAuz3TRCpPnCBzZ+om3k9N3ykCWYOq_bv+hucV=XXiY9w@mail.gmail.com>
Subject: Re: [PATCH 7/7] RCU, workqueue: Implement rcu_work
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 1:33 AM, Tejun Heo <tj@kernel.org> wrote:

> +/**
> + * queue_rcu_work_on - queue work on specific CPU after a RCU grace period
> + * @cpu: CPU number to execute work on
> + * @wq: workqueue to use
> + * @rwork: work to queue

For many people, "RCU grace period" is clear enough, but not ALL.

So please make it a little more clear that it just queues work after
a *Normal* RCU grace period. it supports only one RCU variant.


> + *
> + * Return: %false if @work was already on a queue, %true otherwise.
> + */

I'm afraid this will be a hard-using API.

The user can't find a plan B when it returns false, especially when
the user expects the work must be called at least once again
after an RCU grace period.

And the error-prone part of it is that, like other queue_work() functions,
the return value of it is often ignored and makes the problem worse.

So, since workqueue.c provides this API, it should handle this
problem. For example, by calling call_rcu() again in this case, but
everything will be much more complex: a synchronization is needed
for "calling call_rcu() again" and allowing the work item called
twice after the last queue_rcu_work() is not workqueue style.

Some would argue that the delayed_work has the same problem
when the user expects the work must be called at least once again
after a period of time. But time interval is easy to detect, the user
can check the time and call the queue_delayed_work() again
when needed which is also a frequent design pattern. And
for rcu, it is hard to use this design pattern since it is hard
to detect (new) rcu grace period without using call_rcu().

I would not provide this API. it is not a NACK. I'm just trying
expressing my thinking about the API. I'd rather RCU be changed
and RCU callbacks are changed to be sleepable. But a complete
overhaul cleanup on the whole source tree for compatibility
is needed at first, an even more complex job.



> +bool queue_rcu_work_on(int cpu, struct workqueue_struct *wq,
> +                      struct rcu_work *rwork)
> +{
> +       struct work_struct *work = &rwork->work;
> +
> +       if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> +               rwork->wq = wq;
> +               rwork->cpu = cpu;
> +               call_rcu(&rwork->rcu, rcu_work_rcufn);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +EXPORT_SYMBOL(queue_rcu_work_on);
> +
