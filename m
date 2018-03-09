Return-Path: <SRS0=NefA=F7=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-841545-1520609841-2-5169271063070951208
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
    t=1520609840; b=ltWpgcrvOdYuqsHLYXN+QvArsfiK7aRMUQ25PIeV7hoDO/L
    WVYPDfsXpWBHo9d6SgWX0saoTDZozcUHu75eRf8R33bRmpB3cOqidRQ+pojQ2TDj
    WRJ0oKFJyPxk1qJLrMPbbColjFVjOvP7SNYfQSwCYJP8MRyYys3ZKVulh0IPKCqT
    V+cS64HG+Y6hsSg0GhIcEGtkmnh+8o1Hx38lXRrdUAgjSrw3iYGPVdtAzW9LChpz
    wbNLN7GzsRqblHsyLWcerMKT4Fxgcviu+t7ymSK4Pqw+QlhM5jkVcrq9/oz9BuN8
    rK7mfjnBDbA+0TBAx038twDAra7TffohdGpUVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520609840; bh=35tVm/5yxuzKkyeznfJcsm4N/E1thspSKOd/BnVU7Z0=; b=U
    1crbwss1JkMBm4GPdqhb1HRHnyQWVsXJm42KYm627ajA1wx5pVQwGjl9ggYlRtYY
    CGB8eYiLd576QbSmUTTJ/uqu0OPMWUwC4HchqKTZJIlcF5vlU+sVbh2I+EXjIT8S
    BH75tl0q5N0+AoFqyRDOaxUIrfh+Gr6EMAk8fDSMrtNxfV3tiE9InLJAvt+2+kDO
    RYS5Pck7Q2KYFiMo1oEa4BqO6KrIfpaIKuqoK+S3z50gC1HFdbnXISwIEdB/zB8B
    Wr6o0pqyf58ERJkNkrgurkLyGxdlY6kobe/N7jT44idWrYXSf9jOfSzwDrb3/JU2
    JZtfnRIDFCXcgpyowLqZg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XK8UnhHZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=NefA=F7=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GzHWvPCv;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XK8UnhHZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=NefA=F7=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GzHWvPCv;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53306205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELu2Avyw7WWEu72omTNhGfDKftyGz1q3KDTEJ8gwLM+z+xXx9Z9EfiZTDGj1lSKBxVWC3wpNFg==
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 9 Mar 2018 07:37:11 -0800
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>,
	Paul McKenney <paulmck@linux.vnet.ibm.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kent Overstreet <kent.overstreet@gmail.com>, security@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH 7/7] RCU, workqueue: Implement rcu_work
Message-ID: <20180309153711.GB2943022@devbig577.frc2.facebook.com>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-7-tj@kernel.org>
 <CA+55aFxnCAufp2e0uk55YYDgYcJAoJ+T+Ju7bWsneYo0eHHBeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxnCAufp2e0uk55YYDgYcJAoJ+T+Ju7bWsneYo0eHHBeQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, Linus.

On Tue, Mar 06, 2018 at 10:30:29AM -0800, Linus Torvalds wrote:
>  - can we split this patch up, so that if somebody bisects a problem
> to it, we'll see if it's cgroup or aio that triggers it?

Will do.

> So I'd like to either just make the thing always just use
> WORK_CPU_UNBOUND, or hear some kind of (handwaving ok) explanation for
> why something else would ever make sense. If the action is
> fundamentally delayed by RCU, why would it make a difference which CPU
> it runs on?

It was mostly for consistency with other interfaces.  Let's drop
queue_work_on() for now.  If ever necessary, we can easily add it back
later.

Thanks.

-- 
tejun
