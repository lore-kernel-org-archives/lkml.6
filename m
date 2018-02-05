Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2874815-1517848442-2-16359729020558671486
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
    t=1517848442; b=WCwLTn+zXDimI4zc1C7zhzyuu3b7fna33VUt99B5DUqOnaa
    XoB3Oz2Wqir+BwUO1dVMBg+09BnxPhi1VvxhytfXyPH7ynbC9lkHOdhm2p1Ud8oI
    XOQv1qMNbSqIAUvUzwJfrdlusTdjeSyQIJzYE1IKbBiVo31FpVL4IFCsj3uYBTtu
    Br3BwGOMGt5uyI9uGF9bODooKEOqBJvMXKUl6cJ4tI3svYq6bLOdJg96bDntm4Wa
    D+IAbdniGwX3iqb2UYuyDVOfRk1p1GOEDwuAdS4jwHc2ZDnL8+DEV0owaOCPoBDX
    TjZLzB+5p5j8VAugE6NI0ZmhZyOC7rvbjRissvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517848442; bh=seHsUryFZdK70bdFUq3aJRD8EQ
    ECRqquu8GbthrecNA=; b=PhKQNElYkTMB1DQdCCM1Q9/T/Zn4rncWmgc3D5D2MQ
    BZ6R/r7vXUnjSY6KWcCKE3bPR91S7C0PARxcgIxbkGqCuonaSK9pg6zEYj+icXSS
    OF7FNobx/ZuJ+asPl8VpRFNfJYsAjEnqlPyerFeHKicnHBWRgBH0eqoTYbwPziiZ
    nesXBOngd+yP2xfqWb8nO6qjz9a2IuR/yLXVSpbpQ9Co7npSuGv5WkMg61yqJ01V
    JiyYwvNPH8ghqBXIyDdTrcBJfM6TL4A7BbumSS+QA5cqmDoZGhIYejA8O2/3ycBk
    9B0A4FDR/ZQf5wRXFCVq8MJNPmorzOzlJP0ybS44jzPg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VHFNcN6/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RDAF7IaM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VHFNcN6/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RDAF7IaM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbeBEQd7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 11:33:59 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34605 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbeBEQd6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Feb 2018 11:33:58 -0500
X-Google-Smtp-Source: AH8x226PvC4AXctqaHY9O5u6QGpdnE2b1ZS7m2o31gcyMxnUGo+EyZVl6fRJ07v6Yl+/KpuQf2yTAA==
Date: Mon, 5 Feb 2018 17:33:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH for 4.16 00/11] membarrier updates for 4.16
Message-ID: <20180205163353.llyamby4o7ajsvt7@gmail.com>
References: <20180123155733.3404-1-mathieu.desnoyers@efficios.com>
 <CA+55aFxdqXJidPLFb--pa8cmJnepzGpLRD=gNXgktkjNW+jJug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxdqXJidPLFb--pa8cmJnepzGpLRD=gNXgktkjNW+jJug@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Ingo/Peter/Thomas,
>  can you comment on this? I'd like to get this moving one way or
> another, rather than just hold it back forever.
> 
> I _think_ all the concerns were resolved, no?

Yeah, I wanted to apply these bits later today with some minor edits - unless you 
are going to pull it directly.

Thanks,

	Ingo
