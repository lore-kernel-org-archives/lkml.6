Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3105817-1517855664-2-48016886307945658
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
    t=1517855664; b=MzJwQhBgyMhlsTJT9KTfh1D52TDV2LEfEIwYmHEOjF2bBpN
    udnP0l9t1LJ8Df84TUfAnGU2InuTSQfpZJs0c4po23BisXR4CDPf1YkUD56C/xjX
    QGvEQ4uirzDQni9wj8HNNWPHuTmfnk+kLBpfjdYtynKDyLAxruDqXFJANRp3b7WG
    lB0R1haFbMzQoBVWZEQ77UoYN+AurlWPfHufM7QF9WRvJBbT61sBKAy74NU34TmK
    XxyO2XdPXcTonvAK5khG9qReFhf/sDlIKWjwia/A7X3CK2jcHKCRxLTwAzOuT9BC
    ZBR5lw0g7mJQmO810f9zlK6kbngmcMsqKtneVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517855664; bh=BoNsKYKWNDLNevJ3e+1XWATB7E
    n4RlUfvtkz6a4e1w0=; b=wFSLywmxqzDEGK3c2EHw9faxtQnTym8C9AoUSXPp8H
    YvIr7JWNRl63IQyQ4iO7xJvakM0UAN9kuZqppAMcknGCgWiAQRIeWcLknow4mX/p
    fZJ+76xPVLHy5fS7yLRa04A217Lkey2AMebP/WPJDMRcSYrZm5eXUEu2y97m/1ua
    o7q4tvWyLpvF8ylitDUrNZhe9WiwVaoJJix88ACzQEKJR73PMW8ifu7B81f1I1cR
    jMl61JOgRLIuyPtCerc3DfSVWk6uojTN9bjlPwv/T0k+hOc/6loXM2Q3hWwlPha+
    A6ZJoXb3D1dWZTTMb+HSn8uR9lrbq1ldFxasrucRWeZg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TK7uzI4S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QDp0jNHl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TK7uzI4S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QDp0jNHl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753681AbeBESeG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:34:06 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44203 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeBESdd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Feb 2018 13:33:33 -0500
X-Google-Smtp-Source: AH8x224ubDynwhX9d+epTwP/FVVzY2YbIYgNQt+jKokH5oz+t5SvRfIvYvUPxIomkT2TQbVDM1uLQQ==
Date: Mon, 5 Feb 2018 19:33:29 +0100
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
Message-ID: <20180205183329.4enqczd2fdvi4mk4@gmail.com>
References: <20180123155733.3404-1-mathieu.desnoyers@efficios.com>
 <CA+55aFxdqXJidPLFb--pa8cmJnepzGpLRD=gNXgktkjNW+jJug@mail.gmail.com>
 <20180205163353.llyamby4o7ajsvt7@gmail.com>
 <CA+55aFw9r1bLhPZ8bOApD7dBPTtFLBk+A71qLNF+XrEOL8+1oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw9r1bLhPZ8bOApD7dBPTtFLBk+A71qLNF+XrEOL8+1oA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Feb 5, 2018 at 8:33 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Yeah, I wanted to apply these bits later today with some minor edits - unless you
> > are going to pull it directly.
> 
> I have not pulled yet, I wanted to check. But I do want to get it merged.
> 
> It gets easier for me if I can just pull.

Yes, I'll apply them - and I'd feel better if this went through the scheduler 
tree, because there's been significant review feedback both from PeterZ and from 
Thomas.

If it passes all testing then I'll send it to you tomorrow at the latest.

Thanks,

	Ingo
