Return-Path: <SRS0=chh4=GR=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4056126-1522166117-2-11678532693599280259
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
X-Mail-from: SRS0=chh4=GR=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522166117; b=fX3OB272pbPsgtkALewGNvS0M3VCoignQIU5fO+UQQsr3U/
    bYuUm3V9ea8WQ4+x3TBxCAa8rx4Z27wUSbU09U2U7ojZ2VP43WCqPsHpfsO/fXUi
    XYA0i0zNIBdYIDhvAFeauq5HgjMhn+bgGCTI2gtiuE89w+tMNo38C0BuVrDVjCyX
    DT5DAR/J5GKuXNKsfRWM8JqjfvS+YCwDHd9KsFY7jp4VmTy/cROAtni+ddhW20Bh
    VfpbnIVqy783kI6X+GYhxbttOEacnDGOXVF5Uoluc9EABCUiqnov5ztdLKIxrARt
    87SQF3+HtZSh//LJxgNcsJGrcfWNt2ZfD/5kYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1522166117; bh=drk6yYU58bzwPzXV3851i9Z6SLtbZuE9mnAfagBQN1M=; b=D
    tvJpwnK6NMNIefRTqi/spyREpwNpxPd2zAiabpOSwq4t6OCmdWYqLOuChwvHIs2e
    rTVQYmtJFq7YIhctCxrpOJVg+VXixIUu+sB/CmzAip373Bw9IWNrzc+fiB/mFBHq
    vmmcODg/Y0gpoR5T2B3O5VIgJBk0X+H9VnnHGZb9/k1WuL71Mew+XR6exjtQyYhl
    oTj2t98ueTEOyyf35OToQAYRfcwrHd1GmIlS1+ZkLa3rh1IWE/es/t6TnpRTV/vS
    7TekEfcXkaCbjtpf8mzzYRZMvuBSy8Wo66XPTb6VBycSaKD3LFA71J4wnvCj5CoE
    PCYtgqMCvjEeehrrnyb+A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J7aJRgKw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=chh4=GR=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Vf0C2HBx;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J7aJRgKw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=chh4=GR=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Vf0C2HBx;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGns6YfI2WeZJSkIs7K537vJKpk5iZgvIUg2il2/y5bNcjk2zYMOfqFGHA+wezABmpVORAAhAEi3k5RHpMgjk7GpPVks36TWyZOuC2PBAX7hRD0ifBmN
    9ivU9xPVWcdncONKSXI1rTc3lmWmkheoqo0K0yEQvS2KXIRowJ0+SwMa1TsOdqIykt3jVsk1tVG6UZpVii55UxzE/Ybz/o4G8rE=
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=v2DPQv5-lfwA:10 a=Fqp18RcmKgBydboXipUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8922177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELteHEojmpCJE41WMQ0qviOrD295svsBm6mqs/L9Bys9sZIuB8wa3NA4uGjSZwHx+ICLuLU2pg==
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 27 Mar 2018 08:55:06 -0700
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180327155506.GA2779604@devbig577.frc2.facebook.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
 <20180321155812.GA9382@redhat.com>
 <20180321164000.GC2149215@devbig577.frc2.facebook.com>
 <20180321171743.GA12834@redhat.com>
 <20180321175356.GD2149215@devbig577.frc2.facebook.com>
 <20180322112412.GA22183@redhat.com>
 <20180326150459.GE1840639@devbig577.frc2.facebook.com>
 <20180327142848.GA19341@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327142848.GA19341@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey,

On Tue, Mar 27, 2018 at 04:28:48PM +0200, Oleg Nesterov wrote:
> > flush_*work() guarantees to wait for the completion of the latest
> > instance of the work item which was visible to the caller.  We can't
> > guarantee that w/o rcu_barrier().
> 
> And this is what I can't understand.
> 
> So let me repeat. Could you please describe a use-case which needs flush_rcuwork()
> with rcu_barrier() ?

So, if you skip that, flush_work() in itself won't wait for PENDING
bit at all.  It'll return right away if the work item is waiting for
rcu grace period.

Thanks.

-- 
tejun
