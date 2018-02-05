Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3281902-1517862172-2-18094342098915627354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 3.2, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517862171; b=TKbALa3LpvT0yWFB6l1CPdGKycvd2fVLY2IIpRZLmC3CWqr
    SyF9stNXNkNq61TUElt7qduYglwcUqiu9vNiu5nHCZ4UWNkcHxbcfaE2CtHXwHO7
    8JIU2Ig1ksBsHfjSm+8m++Yr21AE2IDf36mXNHBsXoI+vpGfaNiXVpqSq6hxdApa
    F2jS6vBnQPxo21Sr1qOR5cGk9WLGF8EtyXzCG0dojgpp0wM94V/z1I97AMMPnlaf
    ksC/cDb2HdMXXPvcsQ8t/8/LUfM8p94T/KUrk+fJFvAq6GA6yxvl/Max6eDyYMQB
    1v8RZqaMuNIK+yuDXkPoCpHe7AgfaEJPGITMMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517862171; bh=dtbzuP7uHiS7XXY18enXadLA/E
    WN0eFHzOj5enXGkcY=; b=OkA7g015b8ZQTfDLfU61O8ZGAQRZcEF5J91Pr+VviF
    vlq3/tw8npErGJ/4bZz3UhQLdar15HADRPVYki7hGgUBiCKGqwSwP4tlR4roljgy
    rb+rtr7oAg/9GTYlu7kwrpYJLF2BUqZWJuJwAdCBb0Fj9uMO7cFHa84993GS3lma
    KAT/Uh6HmxXUrgCUUznzId7T8X7oUdzZdOcmxpym5QKyGdDcVYwCYNmm70fxICmV
    vXSzosbEAvQbDDeJUb0aJ5ezsovEbvy0L2V7ix4EiUQonXqctzWd0EafH0H6wP8J
    ca8OYitEVzz0ik0V6tmb1gAfyyMsE0pO19xY4tXE/w5A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Np2Hcr2u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lChCo4GS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Np2Hcr2u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lChCo4GS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeBEUWt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 15:22:49 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35576 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeBEUWr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Feb 2018 15:22:47 -0500
X-Google-Smtp-Source: AH8x225Ga/ppxP7JzNV4KcZDwswXc7XAoeamD31TAm3B0rEX3m1b/PWiCFDZJ90o/eNwXJAHCf1phQ==
Date: Mon, 5 Feb 2018 21:22:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Maged Michael <maged.michael@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Watson <davejwatson@fb.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Will Deacon <will.deacon@arm.com>,
        David Sehr <sehr@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH for 4.16 v7 02/11] powerpc: membarrier: Skip memory
 barrier in switch_mm()
Message-ID: <20180205202242.6ilyjh35byycf3ez@gmail.com>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com>
 <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

>  
> +config ARCH_HAS_MEMBARRIER_HOOKS
> +	bool

Yeah, so I have renamed this to ARCH_HAS_MEMBARRIER_CALLBACKS, and propagated it 
through the rest of the patches. "Callback" is the canonical name, and I also 
cringe every time I see 'hook'.

Please let me know if there are any big objections against this minor cleanup.

Thanks,

	Ingo
