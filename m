Return-Path: <SRS0=x95D=GL=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-335416-1521654843-2-13330458359572673158
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
X-Mail-from: SRS0=x95D=GL=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521654842; b=Cv/i7Kn77mYglflxSHVOG8MxZFPU19liCAcxXyyyDwbvN8H
    eqnEepxKrP8nLBfN3IU3+toLmxOipm9Ik2JmkXX54V8ocslho57xUqOQZ3C01x1W
    5lcM83y9Y0F6C0UdAfn8n8vMVJtZUotQlbggPpCOF8I/iDCfgrZEpp/cAX4AF7La
    PgBGsMx8OwB4sG9KU8QKEewRyqnMUwFodJwMzLAgYjE/T5k/EsgN6bAZTweB+XEK
    AGFdRw2jGioO3EadVvLOu9gOj1ckbwfOYaGl0HgVNwDVOdUDq7JzcmJGFAygaSRk
    xkGKKi+X6fg97Z4tQEoITWSgGqzQk4XbZT9yecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521654842; bh=E+Ysfjj0aO6a+AKNF9Zb/troohFBoElMZfqwC2zaqNY=; b=W
    xnmjgALaO507r3f01v6ALbGrAoaNQmLKrPmxg/97gJI6fWlrpTHRywl6nzPrAMy6
    YstqDDJr1PQaZ0whksyyJP4WonAja4vmFLfqFxBhae1liEzAMyodqtMC4kjrWt1n
    3w1b27WCIMS/LSXbADJd4+WHusy1sGpZ7aymJadqsFp4zpb7J073uxP3xLBbjpot
    QhXnAImiUno8HFQyC3gONjI+jIlyjDN6dzC0B2vpli8qufkh4uf4msVCgxxVsY30
    W8rbgzuHBCnZ0sNz/a66dgHqoUkv5LX2wBKjIGi7AGlDte0+eEhPF/gA6Lt4a7qd
    gZMcUYgcvAU+ff9gTgCdQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=anX3JA+8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=x95D=GL=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tNxNkZIy;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=anX3JA+8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=x95D=GL=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tNxNkZIy;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B05217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELvSHhjy6lo/+/k27olFJmd9MqK1EeDCAqvIETR1DMh5023ujwD4gLOv2Zat7m/+o1lRCTrMdw==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Mar 2018 10:53:56 -0700
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180321175356.GD2149215@devbig577.frc2.facebook.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
 <20180321155812.GA9382@redhat.com>
 <20180321164000.GC2149215@devbig577.frc2.facebook.com>
 <20180321171743.GA12834@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321171743.GA12834@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Wed, Mar 21, 2018 at 06:17:43PM +0100, Oleg Nesterov wrote:
> Mostly I am asking because I do not really understand
> "[PATCH 6/8] RCU, workqueue: Implement rcu_work".
> 
> I mean, the code looks simple and correct but why does it play with
> WORK_STRUCT_PENDING_BIT? IOW, I do not see a "good" use-case when 2 or more
> queue_rcu_work()'s can use the same rwork and hit work_pending() == T. And
> what the caller should do if queue_rcu_work() returns false?

It's just following standard workqueue conventions.  We can try to
make it more specialized but then flush_rcu_work()'s behavior would
have to different too and it gets confusing quickly.  Unless there are
overriding reasons to deviate, I'd like to keep it consistent.

Thanks.

-- 
tejun
