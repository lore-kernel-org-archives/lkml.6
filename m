Return-Path: <SRS0=NefA=F7=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872320-1520612520-2-3077408226570638122
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
X-Mail-from: SRS0=NefA=F7=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520612519; b=dmOYhueFvmnJSp1SwHy2O5Q2NMXM9OcdkCvkMdUxi9QN7bv
    cUFNM0YuTLQHblLMhVO1OkdkMCRLwx3Wm/QxGrRPQ5GDqWOZK7kmJOznbm8E3GXh
    k06yOyywPMNr8ItnZ7QmYcumyEGLQ1Q9I7riHP0qzJh4m/hveSTnHik49Q+F142L
    L1G0BXpEt7kkXDiQPaDPjD7QVDjz7y012aAMvoSfbJAyCp+AOGy07ezuwvges8GX
    HV6nIxfwsb1XU47KndGJqFfHsKxOZcMwDaSXGhpTqJmZmRvOj14FKzhb8kU2nLY6
    XgH9nRK52GhazHQbF8bqF8uU+ypC64qmT/j18rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520612519; bh=9tVU5LF2w9A9q8uDUo++Cqgj94x8Mq979i0Nyj2/8XU=; b=m
    YMhvrd3Ev0NNYDz44zQmUmbA8HaidxHIXxmWsXsV69LmtQ1ySpjg3Ta6uCGJqWJE
    RVXSxtNVBSqV93OVEqPW5Atz4seTwcZM9IALUFdkczX1/3C7BWJB/fniMplkdZo2
    AJEXicnZnrB46o/ArnOLib3dFgJZMytI0hMQfnkAPq+1ES05q/zGbT4+T/hp7EFO
    DPAhfa4Vyt78z22sm3y4m9oAqSnujM8JMHeKX/iIhD9E+5Eg1c181RCaXNnbPCXK
    zC36FGpkJrDnEInM2Rfj/4SkSv5fqm5JX5TteOi+sZTVhAhGUSLyzJowDA2e1xMM
    bK52JMTTCqPUlZVSK5VrQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IDoamUxL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=NefA=F7=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E+1wQ3rf;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IDoamUxL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=NefA=F7=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=E+1wQ3rf;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E21205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELuGsZvAdL9Xw9vDNFyWsyZdglagUr+vKI5k5fVSsmjQd5z6oRtdrz8EyU1O5FNq6BkGtEqTXg==
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 9 Mar 2018 08:21:37 -0800
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	torvalds@linux-foundation.org, Jann Horn <jannh@google.com>,
	bcrl@kvack.org, viro@zeniv.linux.org.uk,
	Kent Overstreet <kent.overstreet@gmail.com>, security@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 7/7] RCU, workqueue: Implement rcu_work
Message-ID: <20180309162137.GC2943022@devbig577.frc2.facebook.com>
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
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Thu, Mar 08, 2018 at 08:29:53AM +0800, Lai Jiangshan wrote:
> I mentioned a subtle use case that user would think it is supported
> since the comment doesn't disallow it.
> 
> It is clear that the user expects
>    the work must be called at least once after the API returns
>    the work must be called after an RCU grace period
> 
> But in the case when the user expects the work must be called
> at least once again after "queue_rcu_work() + an RCU grace period",
> the API is not competent to it if the work is queued.
> Although the user can detect it by the return value of
> queue_rcu_work(), the user hardly makes his expectation
> happen by adding appropriate code.

We should definitely document it better but it isn't any different
from delayed_work, and I don't see a reason to deviate.

Thanks.

-- 
tejun
