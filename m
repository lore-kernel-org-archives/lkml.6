Return-Path: <SRS0=Ew++=GL=redhat.com=oleg@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-335416-1521652671-2-11948121710361386327
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
X-Mail-from: SRS0=Ew++=GL=redhat.com=oleg@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521652670; b=be9Mu/vG5z+8+oBWYt2BHVk6LV22GHCVpE/9rTawJjRPTLC
    poHVwqyIe8eGptE/qq7O7vfnnVbU5z+TuYthwjgpzxu/mctKxcQuleOO+I7iuNYf
    AIUzE2eApTpLU3Ws77tUN4Jzek2YKbSHYS7KTaqSENMyDJ4I++dR7lpN/zv2U0et
    r5hR6UrAWjG6yaGIZbo/i5jwM7QbYrGx3O23xWhqAx8gFK/Eh5wsW7AgrrvI8xnu
    +e9Em80TorCuKSEggWb/JYR7WtmgSUrwOtTLYVcC8On75iAT7AI+gQQqbe+6IyKh
    /saxvpfdA3mhKO+IUTSL3ry40b8Qu4ifVZCWu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521652670; bh=RRJTt6XO42fD58hVRmVrpqlQfAojlL9IV1DxqGROf44=; b=a
    2abiezAfRXNkck8K6VS8WJ+o7puCHW3yMbVRlB+Gi8kuXC3tQ2JHd2xWsf01AxJz
    c7Tn29PLccVX/Q7VOWxueqquSLrhpU6OI0Xucc2/S8KGi8JV1IdVDi5GarfbzvXB
    E6FbO4WmeWntnxI6NxwNw0J2ex2K1B/ko83SH6ep013hOXhMO5sBXFQ5RTIF0IPn
    lqHhqZkdw5oUPjMwetGVEEGkrOhRIGTFDDozqZHPXiCXTTHj397l9WzZrf8lv/t1
    6S6ngD6SIWFy1RJAsGLWI2GEjc3DW+69ispvhfNGCXL2Vlb0I42xcVVY/Xmn/PRL
    6P4qMfNokdiw00Ux8sAmg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Ew++=GL=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Ew++=GL=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C07217DF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=oleg@redhat.com
Date: Wed, 21 Mar 2018 18:17:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180321171743.GA12834@redhat.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
 <20180321155812.GA9382@redhat.com>
 <20180321164000.GC2149215@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321164000.GC2149215@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/21, Tejun Heo wrote:
>
> Hey, Oleg.
>
> On Wed, Mar 21, 2018 at 04:58:13PM +0100, Oleg Nesterov wrote:
> > > -	struct rcu_head		free_rcu;
> > > -	struct work_struct	free_work;	/* see free_ioctx() */
> > > +	struct rcu_work		free_rwork;	/* see free_ioctx() */
> >
> > IIUC, you can't easily share rcu_work's, thus every kioctx needs its own
> > ->free_rwork and this looks sub-optimal.
> >
> > What do you think about the (untested) patch below?
> >
> > Oleg.
> >
> >
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -115,8 +115,10 @@ struct kioctx {
> >  	struct page		**ring_pages;
> >  	long			nr_pages;
> >
> > -	struct rcu_head		free_rcu;
> > -	struct work_struct	free_work;	/* see free_ioctx() */
> > +	union {
> > +		struct rcu_head		free_rcu;
> > +		struct llist_node	free_llist;
> > +	};
>
> It really depends on how much we want to optimize.  Do you think it
> matters enough?

I have no idea, probably not.

Mostly I am asking because I do not really understand
"[PATCH 6/8] RCU, workqueue: Implement rcu_work".

I mean, the code looks simple and correct but why does it play with
WORK_STRUCT_PENDING_BIT? IOW, I do not see a "good" use-case when 2 or more
queue_rcu_work()'s can use the same rwork and hit work_pending() == T. And
what the caller should do if queue_rcu_work() returns false?

Oleg.
