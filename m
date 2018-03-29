Return-Path: <SRS0=0/dQ=GT=redhat.com=oleg@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1224189-1522342171-2-14204598968832979443
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
X-Mail-from: SRS0=0/dQ=GT=redhat.com=oleg@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522342171; b=Rgh95YS7SdJsiHyvx90CcAoTF8hkS0aZYSMGGLTmTd8YzLSO3R
    946tqZqOJj6ZSJanABD0g9Ndyc+nYeTZKNC+Uttq3VeeicFzkmD0A/dThFKQXASH
    i+B5rizTG9g/Hg5bJfn7sM0dxyDxGmxnBSHv+2lPZtXYKPfk0o2AtHc8yKenu/FY
    HGtvLqqllBJSVR524c1k8v7jmFMISYNCSwNmvbTVtVsfd/C6PBzQzrxr1PCpWPt6
    1AbkpyAGqHyfH/HazpLFbC5ZwPfV+gY2QykWwSV4stVxFvfbNAHGs2BWs7vTb40Q
    XG9gPT019bbWOKwL8Wv49PXZAKAs6YdoY/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1522342171; bh=O2lOLzxpQTjquT1/PmYd8wQnPlIa9q68t/J67KYTWuU=; b=b
    MfVnHMZm1kp/wrZeqvSlJsnqU6gia89z3Al8mRYzg58647dJPMQjeGqWw19K9rbZ
    QH80bg8PAaPcsVq2/l6rySoA7l73WM59jflpKSXlPDixSXyq4HdLTOId6jxPh/6i
    NkiXaGjxRyMq3tMkdaO2mvwlWRBd5l//4Sp6FPM822v54VxRSWaM+3If66eisGWZ
    QX/H4Tw24GBkJBGvXc0SyUFmVms9CrVynpC2gU3D1qSQmzAtPvUnZBK2ZjfFB+Hi
    lQnDFZyxitKbkDE11Z72I0znXLgiNgxbygbVf45mN9ohuUZ9xw3CJSXRMLxdhd8F
    uEmhWtk4/rU+oS9NOQE+w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=0/dQ=GT=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=0/dQ=GT=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAcaDFgH+2FeZq3g/HJiEH9F/XaTa4eVsF9T9h/0k7X5UtEoZzbRoPzj4dfH14q65tGIpkA0orHhCBVZAAip+YepSB1VOQhsOKqFhS8Ot3fG3IyXDO2R
    vBa09oLgEiyvjyE4G1jSdy1Uo+rH+Wmtn4/Hrd2SnIW2+kDHucupxCNGri1hvmGY/e6lI8YuECkozH/ZpiGvEN8Cm8O9EiqA8yc=
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=BCcCOY-bhosC6VzhywgA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4172175B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=oleg@redhat.com
Date: Thu, 29 Mar 2018 18:49:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180329164925.GA7175@redhat.com>
References: <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
 <20180321155812.GA9382@redhat.com>
 <20180321164000.GC2149215@devbig577.frc2.facebook.com>
 <20180321171743.GA12834@redhat.com>
 <20180321175356.GD2149215@devbig577.frc2.facebook.com>
 <20180322112412.GA22183@redhat.com>
 <20180326150459.GE1840639@devbig577.frc2.facebook.com>
 <20180327142848.GA19341@redhat.com>
 <20180327155506.GA2779604@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327155506.GA2779604@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/27, Tejun Heo wrote:
>
> On Tue, Mar 27, 2018 at 04:28:48PM +0200, Oleg Nesterov wrote:
> > > flush_*work() guarantees to wait for the completion of the latest
> > > instance of the work item which was visible to the caller.  We can't
> > > guarantee that w/o rcu_barrier().
> >
> > And this is what I can't understand.
> >
> > So let me repeat. Could you please describe a use-case which needs flush_rcuwork()
> > with rcu_barrier() ?
>
> So, if you skip that, flush_work() in itself won't wait for PENDING
> bit at all.  It'll return right away if the work item is waiting for
> rcu grace period.

Still no use-case... But yes, I forgot this is needed for correctness.

OK, thanks for your patience. But fyi now I hate this interface even more,
exactly because I was technically wrong in this discussion ;)

Oleg.
