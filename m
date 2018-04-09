Return-Path: <kernel-hardening-return-12915-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+mVbZDBxW0tdcIPnh3MF5mp+86IlJzjBFybvb107cPvgak32JSp3FT/91yoL2mp0Ou8gZ2
ARC-Seal: i=1; a=rsa-sha256; t=1523279182; cv=none;
        d=google.com; s=arc-20160816;
        b=NATwNe7pf3P9RxDRHnN0W+9u5Z5x+svthWYfzeWoGr9LJVDTTqZRTcuHLx2swM336c
         uhkhTgSavVH/Ak2mRdEcAVV5AIULFEtVq8wuQDVi/7bpWFMpVreQ8cvn5vb7ec7Bb3j0
         tidRdxvy47/o9qlBgczkG9dk9l8wpMlkdk1lD9kEq2EhXEqLf95xK6qGbqgOO7gk1M/C
         V0qjoQcebMhnkhQBKoUSpOZ4M5TLRs0BZ0xs+SYWTVrkr9YbXQ/9qFwC1SYlYUDUjYgQ
         gR0EsIPo6N7XR6cZWklaO2IDdiTzyh+Q4krE1WEBQLHf4D1ocWC8EKFBCc5vqz9WQ2m6
         lTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=0X6zq2ik/67mbBqDz29/Dke7ev5v27MG/HKSGhJLT+Q=;
        b=u2UwG7+SxWXU/GhwIuZ/WQzidWfRzrHQT99SQJvnvzgpEqLXp6l34UvPDYNidSJwTY
         q6UuoAk2/8vPQZfqyuzCV7rICAWAT7ncs9tA4QR7YWL2tIyu+Q68Jx7mofNJRc6Zc7q9
         FaKlcEZKQbuQGP8Qk+CUe2wjnOLqxvhfOyvgrv9+zuX5xnm3zRC1dA0w0qI4NfQl3ntT
         BTxUCcXPssFEFdjYHaUB6WVKKySNF1Lgy2XlmG2f8BMETzErrrVaDxUffqs9l0Z6izYA
         fC3naaEHAIc/AHHaU5x0kZqkzOBAwlTJ8IgLDX5WDQxrHp7gdHHxkZ+zw6qYbVOcOokL
         yZGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@christofferdall-dk.20150623.gappssmtp.com header.s=20150623 header.b=k/J22Z+4;
       spf=pass (google.com: domain of kernel-hardening-return-12915-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12915-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@christofferdall-dk.20150623.gappssmtp.com header.s=20150623 header.b=k/J22Z+4;
       spf=pass (google.com: domain of kernel-hardening-return-12915-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12915-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: Christoffer Dall <christofferdall@christofferdall.dk>
Date: Mon, 9 Apr 2018 14:58:18 +0200
From: Christoffer Dall <cdall@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>,
	linux-arch@vger.kernel.org, cdall@linaro.org, arnd@arndb.de,
	marc.zyngier@arm.com, catalin.marinas@arm.com, yao.qi@arm.com,
	kernel-hardening@lists.openwall.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, awallis@codeaurora.org,
	kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 10/12] arm64/kvm: context-switch ptrauth registers
Message-ID: <20180409125818.GE10904@cbox>
References: <20171127163806.31435-1-mark.rutland@arm.com>
 <20171127163806.31435-11-mark.rutland@arm.com>
 <20180206123847.GY21802@cbox>
 <20180309142838.uvcv3mhvqqlprktt@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309142838.uvcv3mhvqqlprktt@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1585238074122761401?=
X-GMAIL-MSGID: =?utf-8?q?1597273991516234012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mark,

[Sorry for late reply]

On Fri, Mar 09, 2018 at 02:28:38PM +0000, Mark Rutland wrote:
> On Tue, Feb 06, 2018 at 01:38:47PM +0100, Christoffer Dall wrote:
> > On Mon, Nov 27, 2017 at 04:38:04PM +0000, Mark Rutland wrote:
> > > When pointer authentication is supported, a guest may wish to use it.
> > > This patch adds the necessary KVM infrastructure for this to work, with
> > > a semi-lazy context switch of the pointer auth state.
> > > 
> > > When we schedule a vcpu, 
> > 
> > That's not quite what the code does, the code only does this when we
> > schedule back a preempted or blocked vcpu thread.
> 
> Does that only leave the case of the vCPU being scheduled for the first
> time? Or am I missing something else?
> 
> [...]

In the current patch, you're only calling kvm_arm_vcpu_ptrauth_disable()
from kvm_arch_sched_in() which is only called on the preempt notifier
patch, which leaves out every time we enter the guest from userspace and
therefore also the initial run of the vCPU (assuming there's no
preemption in the kernel prior to running the first time).

vcpu_load() takes care of all the cases.

> 

[...]

> > 
> > I still find this decision to begin trapping again quite arbitrary, and
> > would at least prefer this to be in vcpu_load (which would make the
> > behavior match the commit text as well).
> 
> Sure, done.
> 
> > My expectation would be that if a guest is running software with pointer
> > authentication enabled, then it's likely to either keep using the
> > feature, or not use it at all, so I would make this a one-time flag.
> 
> I think it's likely that some applications will use ptrauth while others
> do not. Even if the gust OS supports ptrauth, KVM may repeatedly preempt
> an application that doesn't use it, and we'd win in that case.
> 
> There are also some rarer cases, like kexec in a guest from a
> ptrauth-aware kernel to a ptrauth-oblivious one.
> 
> I don't have strong feelings either way, and I have no data.
> 

I think your intuition sounds sane, and let's reset the flag on every
vcpu_load, and we can always revisit when we have hardware and data if
someone reports a performance issue.

Thanks,
-Christoffer
