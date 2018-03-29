Return-Path: <SRS0=Ism+=GT=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1351814-1522345291-2-1085995711830125585
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
X-Mail-from: SRS0=Ism+=GT=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522345291; b=dIh1UsbXu7LjGZxuxsiRAVTBJSrogbpy+F/j19XerhTW7goRvd
    2/qjYHxM+zQQHQHvdDuo/0OideFMiN+cGu4eCumn6/wS+qolK3/YgQCBPPeFyYsf
    7ZN8khXxmpRdlLRwkqJWjx40+EViBVQcqPBBlqs0zrvBR9KPRGX0ae6yxWy6uncf
    dmB91hwSGALBVHJ6bv4T01OrbEI1Q6yv2BJNHWdnADn4TrCwGjgWkiiJhXEwe/6x
    xjmUbSSxKD23UfZOlO3V5qSW4h7sT0d+t/tTBxyokyegJv0IZIb8I/mckruc28kf
    QQk+qFKdocVSuwtc6ILuXn436PTeLtRCnlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1522345291; bh=doXk9FxlvNLipTO53uNrRVTP8e4ov/L+nskSnu+aqK8=; b=W
    XippLTKWZ/JO9LuiqEW1QQ7W9S7NILmAUYQDeWzL+72E5aCbZPQTmouuphx7kCyB
    gX9sdNTMcXgfWkRmpncbjN3D5pkONTSwxcwujv71l65Qa4YqG8oO/smerMXIffOg
    VfcDJjTWUjzEqw8zEJEH4Qy+5oX0pvrEGQWIlkNu5iRdFsWAfKelsu4yuBIO7EUQ
    bpHFmosauBA5xWf5gGb2Xc9fnVZH33sP+KFnHo1ojO7hd/rz171t+FoDodjB4rQe
    yoO8yqKHI2hwUOvIex/oXsMhQhusEEEDO8c09MJeEuDGC+c0T7Yo7mXhJSkzlJAD
    0+GpwEXFaGFq0oOV79x/g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gohdoz/g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Ism+=GT=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TC0RW4iY;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gohdoz/g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Ism+=GT=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TC0RW4iY;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJublMy+gGRX7fIv5iJ9SV0s0dD/mKp5S+FYdQSN4177HjbjNjBRNamy2ERY925Ga744lI68D/aw/JIKm38q4TDlCMFBzDnRsIQYkxCsTXFWQuRRPqGC
    liOv1Ir3kCqH16tjPoovsuq8cDO8WU5cUUmiHkTOdHW+YrzWhLWi0UH/gvDmq3iERvf23HlpuFMC3Os/UoibJg4Q6VTBmV4WdXE=
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=v2DPQv5-lfwA:10 a=VrbSLzi7VSr5zFmVrHEA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A0521777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx4+Kix5P0Qkz1zx2NLI6jThj7Mk+i1afyK26JM4rc8J7Tm97zOWkLdZd12fq+HQFZz9rGjBSFw==
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 29 Mar 2018 10:41:22 -0700
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180329174122.GA388343@devbig577.frc2.facebook.com>
References: <20180314194515.1661824-8-tj@kernel.org>
 <20180321155812.GA9382@redhat.com>
 <20180321164000.GC2149215@devbig577.frc2.facebook.com>
 <20180321171743.GA12834@redhat.com>
 <20180321175356.GD2149215@devbig577.frc2.facebook.com>
 <20180322112412.GA22183@redhat.com>
 <20180326150459.GE1840639@devbig577.frc2.facebook.com>
 <20180327142848.GA19341@redhat.com>
 <20180327155506.GA2779604@devbig577.frc2.facebook.com>
 <20180329164925.GA7175@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329164925.GA7175@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Thu, Mar 29, 2018 at 06:49:25PM +0200, Oleg Nesterov wrote:
> Still no use-case... But yes, I forgot this is needed for correctness.
> 
> OK, thanks for your patience. But fyi now I hate this interface even more,
> exactly because I was technically wrong in this discussion ;)

Yeah, we might as well omit it for now and add it later when it's
actually needed.  It's just that given that queue and flush are the
two core interfaces, I didn't want to leave it out, and the current
implementation is the lowest-effort one.  I'd be happy to make it
better if you have good suggestions.

Thanks.

-- 
tejun
