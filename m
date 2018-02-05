Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3405251-1517862688-2-8358183541863718570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517862687; b=doIuyusJFM7ZNvFvCP1SpOvF9FTLItfD9/84p8uCdoBJ1XW
    nx8DoLYrg8+3i32VKRzEHLaNi24ibB0PqT5liQUlx4E8qc3y1aQlLzBdUM1HtqSP
    65Lq3lsLc9LH5ohvx/FPqZ1pKO0CxjiOjg8lo4qETwTj+9GS7+I44WwS6EAt334x
    EHK/UnjuOfY99gouI8jDC4MBqlf0tlSkAT6UQm+klJL5nfdtn7WpVJHOSVxD9e+7
    YjE5Llz59mSDGb3ZMpKhFLCip8b3cOrmMRAZ2MIsib3npxkvuTEfESh2CXNtpW1K
    67nIie/afxZnk8sIQ6tNmmvh2+IzjyBG8KsPuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517862687; bh=8C+JLJQkRJDuaiw4FsVCyR7EncGSONidMvePxaxo2iw=; b=I
    nN9uxSxeldCTFJnDa9pBmMdknzOlQ2lEbyWlwHXvQ6TmnKiqQOoO9xi+u11XSodP
    fsXACSg4oYSe9ICoqYzMQ54f6QNymR+QR2e66Px3P4Ub7pi3YYabkY3NAUm2ma8u
    1ovMCL9SufUNXVNdlN6gVOlI3DJLBjuidBgNkLieqnC/wWpjs5JmvficZ5nNHqQ6
    DfnNyJdt1x7EE/KrQ94s8ajHNyjXper2rC8be33nCJAVPSzhAQQ3Y5bwGe2WTFXa
    GcxVSikjBl9+0ljqZ7vdcLOrAbfP/CQ2dZtRweKCl/5n2aH5NlkTZVBwlkx3NJYj
    bAyHIIrEcDyvrZD1uL8AQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeBEUb0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 15:31:26 -0500
Received: from mail.efficios.com ([167.114.142.141]:57670 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBEUbZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Feb 2018 15:31:25 -0500
Date: Mon, 5 Feb 2018 20:32:08 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        maged michael <maged.michael@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Watson <davejwatson@fb.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Will Deacon <will.deacon@arm.com>,
        David Sehr <sehr@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <1407075321.16343.1517862728006.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180205202242.6ilyjh35byycf3ez@gmail.com>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com> <20180129202020.8515-3-mathieu.desnoyers@efficios.com> <20180205202242.6ilyjh35byycf3ez@gmail.com>
Subject: Re: [PATCH for 4.16 v7 02/11] powerpc: membarrier: Skip memory
 barrier in switch_mm()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: powerpc: membarrier: Skip memory barrier in switch_mm()
Thread-Index: M1Yhfw492UBZVM0u5ISRDRh93mkzBA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Feb 5, 2018, at 3:22 PM, Ingo Molnar mingo@kernel.org wrote:

> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>  
>> +config ARCH_HAS_MEMBARRIER_HOOKS
>> +	bool
> 
> Yeah, so I have renamed this to ARCH_HAS_MEMBARRIER_CALLBACKS, and propagated it
> through the rest of the patches. "Callback" is the canonical name, and I also
> cringe every time I see 'hook'.
> 
> Please let me know if there are any big objections against this minor cleanup.

No objection at all,

Thanks!

Mathieu

> 
> Thanks,
> 
> 	Ingo

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
