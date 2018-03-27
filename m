Return-Path: <SRS0=Rz/V=GR=redhat.com=oleg@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3923526-1522160935-2-12924697587141755314
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=Rz/V=GR=redhat.com=oleg@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522160934; b=EtUvpOUD0D7f8bdqUQ3ewCYeIuxwBq83NBI0A/i3OL2x+zk
    0Y+mZdszO2WzPeNQdEmyAU2B3t/yK8tMlOBRTv/zU/GrfB1L01qY2o8voo20+l15
    xAvxWrx56GY6inCFJcsTdvz+7YIF1LA+pt87TaQyOy+AI8IzJ+tepfTPE3sOJLLM
    2KVMDrVU2eXCjIIyNFugEf+bJZniRdL6HxgAfDtL81qKKOPu0Fl8q5NVBbVQhnJa
    ImsYoY9dTaxngqBS24tNQP82Lah9zo9OmeyjvYMrJKkenJCAQhp+uPKrJZX+Ko3m
    Yu6RP5slfUe3xCJVD1pGNC43F/oKkJh8k2vAwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1522160934; bh=4jq4f3iVJQPbNHi1oW2XfThGDd+SIaP9sGfJBqaVtrA=; b=h
    JWrSvIAWeNFMR+4Dc3a9aCOSvQ+anG7zTfnhSwthGDGbVR67jd4C+ck1xVWWwjQl
    Ijz1Nv4wv6erk0+a2P8RzIEBtVWsUznMF52EvVdwwd4Eb8WhhkTVsYuDn+5JMSD0
    /68IAMIUHYSSfUh8baND1GKsmBCmO1IaD/y+f5NwHJ1GzhkOSOAaTX0LfWxVQsde
    jGml2GPshLIICgQ+CR1hQ88rmhc10v1xsHpjdMimKE9tSzZbQ3EU0+7oxxmdeKyF
    ZkIWAE68QDQAc9uGCEF+5DZSKHHKem6j/nUvfprPU33q41qUUcCu/+zBGMhZzk5G
    t4ptqxjXuOfni4wjVdtTA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Rz/V=GR=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Rz/V=GR=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNdx5UDep8vMdFrgaXHDFr8YXrG/FNn4jxp3T8XAa/PcJysQ08mif2KhrnwCc3flr8oKRbupHCax5Ed3Q5Fp8iklCRVbwLqBV635M6xmuzZOeHkXqx+z
    QPGzuTBtzseNmsgRlSbxjiDkpK4gd4BSYFlRQxDmbtr67ygGxsNvommcjzhSTa/07XFnF5w7RvqGU4E/DhwAFiLvqfJGf/EkfWE=
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=GK1XYBiN6vrFDH1KWYIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F397621718
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=oleg@redhat.com
Date: Tue, 27 Mar 2018 16:28:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180327142848.GA19341@redhat.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
 <20180321155812.GA9382@redhat.com>
 <20180321164000.GC2149215@devbig577.frc2.facebook.com>
 <20180321171743.GA12834@redhat.com>
 <20180321175356.GD2149215@devbig577.frc2.facebook.com>
 <20180322112412.GA22183@redhat.com>
 <20180326150459.GE1840639@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326150459.GE1840639@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tejun,

On 03/26, Tejun Heo wrote:
>
> On Thu, Mar 22, 2018 at 12:24:12PM +0100, Oleg Nesterov wrote:
> >
> > But why flush_rcu_work() can't simply do flush_work() ?
> >
> > If WORK_STRUCT_PENDING_BIT was set by us (rcu_work_rcufn() succeeded) we do not
> > need rcu_barrier(). Why should we care about other rcu callbacks?
> >
> > If rcu_work_rcufn() fails and someone else sets PENDING, how this rcu_barrier()
> > can help? We didn't even do call_rcu() in this case.
> >
> > In short. Once flush_work() returns we know that rcu callback which queued this
> > work is finished. It doesn't matter if it was fired by us or not. And if it was
> > not fired by us, then rcu_barrier() doesn't imply a grace period anyway.
>
> flush_*work() guarantees to wait for the completion of the latest
> instance of the work item which was visible to the caller.  We can't
> guarantee that w/o rcu_barrier().

And this is what I can't understand.

So let me repeat. Could you please describe a use-case which needs flush_rcuwork()
with rcu_barrier() ?


> > And again, at least for fs/aio.c it doesn't offer too much but sub-optimal
> > compared to call_rcu() + schedule_work() by hand.
>
> Sure, this isn't about performance.  It's about making code less
> painful on the eyes.  If performance matters, we sure can hand-craft
> things, which doesn't seem to be the case, right?

OK, I won't insist.

Oleg.
