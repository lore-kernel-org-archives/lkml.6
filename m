Return-Path: <SRS0=nPmC=F4=gmail.com=linus971@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1039940-1520361035-2-3244180964297678695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=nPmC=F4=gmail.com=linus971@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520361034; b=lYtZSV6vhkStUT3Bul8w1Fvnb6pITtDamw/YAae1aIfsO+3
    Gw4ydvgjjhQhJ+AWp0YTGOz/dR85QNTWzlvnlbr56h6TByYziMg4thpFia/qtSaP
    jos83rgupKb2cTAm786fzehX4aabtvHJWe+MSfFT32wVav3gFSrNYuFibmadR9dY
    KffMbLvUwdr92I7eAW50H3eW8O82aoqNUILauJfg98RN8Vv9+UyjYWo0ezorpwzF
    K0xEOq7WcBhs/QB2QlY+S8/DB8PcFNex1nSP27uw63j4E6QSCnR53A83uoBiWd3P
    rSvz25uBEEp3DY5QAZLvC/lAkl40Mgl81YelsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:sender:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type; s=
    arctest; t=1520361034; bh=Sn/iHIDnBYJwPVFLyuob962lIzYVR37ZlZDcYJ
    AczDo=; b=uzrh2dPZKEa72nGYkqiOTynO1mjXpBFF+4X4qZcuZ2oxM71DBJJmi1
    NEjLM6gG7PA6zZgdLnDqmlx+RD4M4l7YXwILbDZKf0c4430E8M1DqIgv4u5QDWiL
    Kyeobby5V2jKt6/sN8CTQoUkXZIqTDV9lSRsxFGNBL0YulImPIVFL4nr/2rdrG0a
    Q6Tiu4iJ5mHdE2bgMTjGASzw1GBY4CvCOF3i/oOL3lvioWkRPrjcDoSZHnIYQH6e
    uyYGOaFGaQedbwW1AqU+LyUI12BmEDo0CBy361ojRXNER5bErjbkWDRDCyq6LXDi
    ZQ2TTgt2IGlYwK/bdNgDyiPkZmrXvCNA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ynyd4ZAg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D/88R1Gg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=nPmC=F4=gmail.com=linus971@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oyFBuUa+;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ynyd4ZAg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D/88R1Gg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=nPmC=F4=gmail.com=linus971@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oyFBuUa+;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112072178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELtN9g2opPjAFn/B2L0N4ijpgmXPs/tURbIewBPLMJlKkyb2L2pR81iFt5YBqTTWYDEuZ8MbSWnud4DxRSvPXKM=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180306173316.3088458-7-tj@kernel.org>
References: <20180306172657.3060270-1-tj@kernel.org> <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-7-tj@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 10:30:29 -0800
X-Google-Sender-Auth: rCh8__8UDevme8GKJwG4CA41NXo
Message-ID: <CA+55aFxnCAufp2e0uk55YYDgYcJAoJ+T+Ju7bWsneYo0eHHBeQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] RCU, workqueue: Implement rcu_work
To: Tejun Heo <tj@kernel.org>
Cc: Jann Horn <jannh@google.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>,
	Benjamin LaHaise <bcrl@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Kent Overstreet <kent.overstreet@gmail.com>, security@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 9:33 AM, Tejun Heo <tj@kernel.org> wrote:
>
> This patch introduces rcu_work, a workqueue work variant which gets
> executed after a RCU grace period, and converts the open coded
> bouncing in fs/aio and kernel/cgroup.

So I like the concept, but I have two comments:

 - can we split this patch up, so that if somebody bisects a problem
to it, we'll see if it's cgroup or aio that triggers it?

 - this feels wrong:

> +struct rcu_work {
> +       struct work_struct work;
> +       struct rcu_head rcu;
> +
> +       /* target workqueue and CPU ->rcu uses to queue ->work */
> +       struct workqueue_struct *wq;
> +       int cpu;
> +};

That "int cpu" really doesn't feel like it makes sense for an
rcu_work. The rcu_call() part fundamentally will happen on any CPU,
and sure, it could then schedule the work on something else, but that
doesn't sound like a particularly sound interface.

So I'd like to either just make the thing always just use
WORK_CPU_UNBOUND, or hear some kind of (handwaving ok) explanation for
why something else would ever make sense. If the action is
fundamentally delayed by RCU, why would it make a difference which CPU
it runs on?

One reason for that is that I get this feeling that the multiple
stages of waiting *might* be unnecessary. Are there no situations
where a "rcu_work" might just end up devolving to be just a regular
work? Or maybe situations where the rcu callback is done in process
context, and the work can just be done immediately? I'm a tiny bit
worried about queueing artifacts, where we end up having tons of
resources in flight.

But this really is just a "this feels wrong". I have no real hard
technical reason.

                Linus
