Return-Path: <SRS0=C9he=GQ=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1320427-1522076707-2-10322697288218104427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=C9he=GQ=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522076706; b=OmPLE0WiDqinCZddZqImIG2+CKifCI2NDj9k3pv3xxGr+4B
    XalCOGmbZFxUlSiw+nIev0WS0b3Uc7mtvAeDn2sjOvMWCXb0CKhTPXAVJl2qhSyK
    aMOW2raCGFRvnfFTaKo1TpUS+Qj0/KDLOyozoH9isIAWaXPn057Mc42GP4N8Egq6
    05+FXZN86rO/vW4PTELbOQOB3xMgsRCxKCRt6nqu2zQ4cKGkr/8PLhaCwToerTCk
    kt6sRnx3FRPDwJx2Ebjy1uXYr/t4mu5881a9EHe8Qq5AvQn3lZjMbJ+y6AL695qt
    4cfxXAfHZgk/99FhSJ52UoMRv8fHwcTca8LRZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1522076706; bh=u85UtPiR3AlXpDd/2S3HEsG5pmOmH690OaCS6wBB3qo=; b=i
    r6sGIttgu8fdunsM98CNV73aLD6+QQbA1W/c/FFNh6GqJT8B8fU5Y+HsXiwnY6Qo
    h1l6AtF5vFJUX9ODWjPcnyax8BXqG4cf7fMozVUXA9PJm0TbjWvCwTgavEAx0dNb
    uhmlVuQN3nNT4cLxqTkm/dwkEMSv3So+Ts2MsiJuajIZu3ECCLCJmC/mPHnaFvun
    wAxX+A1NXhtA2IKffYhW0IqTZI8bF0sM4MuDaEty7lcOg+tlS0DEws5+Cff3pirL
    jGJ7s2x7NbeOSPVwPK1pQGBw2lSW+JyHObS3wSUQEPwKhGmQmElSuOgYWZAjKFcH
    23Hfk/e0F9CBN4m3o5tYA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Af7v5bkK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=C9he=GQ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Tlfa1DD9;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Af7v5bkK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=C9he=GQ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Tlfa1DD9;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK8KSj6i1h7HhLZywPrwx92CB4Aha3YPmgqsRfKfMJytEQIAOoE/sFmnCyV2gx5S+lK5NMOBB2oeH4T0N8dVka0rkBaQwTVCGKW3t5/lYViSoqCNbKVo
    yBeC1LTr9R6oy8x8C0t3A3c+51JpYQ+codvHPC/B8BV+Gru9zEqX1G/KnDnluvIdhcLWfnAix05zYMd16nDBvmuc8iG3rngyOgo=
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=v2DPQv5-lfwA:10 a=TCqYJkmZY7ueto7nsqAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0312172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELu2YLUzH3hNQrTJZWEAZWrClhq0Y99nG0i+CWwpTULMTBeZje1Yt0FlHtgvko2IEAZCjnR9bA==
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 26 Mar 2018 08:04:59 -0700
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180326150459.GE1840639@devbig577.frc2.facebook.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
 <20180321155812.GA9382@redhat.com>
 <20180321164000.GC2149215@devbig577.frc2.facebook.com>
 <20180321171743.GA12834@redhat.com>
 <20180321175356.GD2149215@devbig577.frc2.facebook.com>
 <20180322112412.GA22183@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322112412.GA22183@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey, Oleg.

On Thu, Mar 22, 2018 at 12:24:12PM +0100, Oleg Nesterov wrote:
> OK. And I agree that the usage of WORK_STRUCT_PENDING_BIT in queue_rcu_work() is
> fine. If nothing else the kernel won't crash if you call queue_rcu_work() twice.
> 
> But why flush_rcu_work() can't simply do flush_work() ?
> 
> If WORK_STRUCT_PENDING_BIT was set by us (rcu_work_rcufn() succeeded) we do not
> need rcu_barrier(). Why should we care about other rcu callbacks?
>
> If rcu_work_rcufn() fails and someone else sets PENDING, how this rcu_barrier()
> can help? We didn't even do call_rcu() in this case.
> 
> In short. Once flush_work() returns we know that rcu callback which queued this
> work is finished. It doesn't matter if it was fired by us or not. And if it was
> not fired by us, then rcu_barrier() doesn't imply a grace period anyway.

flush_*work() guarantees to wait for the completion of the latest
instance of the work item which was visible to the caller.  We can't
guarantee that w/o rcu_barrier().

> > We can try to
> > make it more specialized but then flush_rcu_work()'s behavior would
> > have to different too and it gets confusing quickly.  Unless there are
> > overriding reasons to deviate, I'd like to keep it consistent.
> 
> Perhaps this all is consistent, but I fail to understand this API :/
> 
> And again, at least for fs/aio.c it doesn't offer too much but sub-optimal
> compared to call_rcu() + schedule_work() by hand.

Sure, this isn't about performance.  It's about making code less
painful on the eyes.  If performance matters, we sure can hand-craft
things, which doesn't seem to be the case, right?

Thanks.

-- 
tejun
