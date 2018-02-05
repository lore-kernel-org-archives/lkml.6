Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3245219-1517860203-2-18312384211931839769
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
    t=1517860203; b=okKigeFqR2n7KBG2rN1FXZSEf3jIySI+gsFmJbuAv2gz/0H
    IZXF4Bza/t8ktil7KpcFOIYaMOIlJ9NRSkMSATiamBSUtbQk8VLwwl0ueZAxa8kk
    4fbkYyu59jNsIR2yvEQbweZvn+VK2GxI1tBV49BJPS9CkgZ/cAgZt3W634+vDazr
    jopMkY4/WinX11gE+SI1yD+H3KgKLse5rsGyxSJuIA4BuB7ebsfcWIhXvcP2GF9l
    4EzXey0tWPVzwzcYOdVvnicVLHkeZEyTWxN6UVoE70eyBB4VQOzZ0Pv4PNxvzIWR
    OQpWrnpPSsxYHIGvSmR43K4JoC83s+MzCTlQT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517860203; bh=y+4c6tJDTiQP4e4JhSnnsXV2hP
    zci7pnDocCw61z6a4=; b=vy27zUtasnawqxfQDI0c0qr16RPj5IflCq2s4lRr9z
    25w1pockVvqnoNrpnhqOYozRvtkRisunsSNskL+5ITTNbFenbKJEusLBv5HTvhNy
    pCAivoBFsZzU9zGHTLSH+oGfgjghBAeGk0cB+wVOzDdFIjJPZrN7XBH8peR/hJQg
    HD9Y64npZgp3i/Zd6jp6NG1VYAF/QxZLlneqEW3v3ScWc1enlwgLZL4oCgjNWJ0G
    lv3Cl7Sna4fyXkjoqPYYSaQ0H5ZvJ4XZu9VuX7rXmdXqBHA14mSj+Qp15Suowams
    rQY4W7UzRRFVjk+XyHlReOTgBLoq03zjxpzC5mvooIrQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AZj+CaNN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PGWeBEU8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AZj+CaNN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PGWeBEU8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeBETuA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 14:50:00 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43556 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeBETt7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Feb 2018 14:49:59 -0500
X-Google-Smtp-Source: AH8x227Dh6VWhIGkiER28s//VT5a71vu6weAw/8syVBQSMbPXgGPH4qIJ0l6qwt1p12iOOlHofN4BQ==
Date: Mon, 5 Feb 2018 20:49:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        David Sehr <sehr@google.com>, x86 <x86@kernel.org>
Subject: Re: [PATCH for 4.16 00/11] membarrier updates for 4.16
Message-ID: <20180205194954.dbd4zvs76a5xwy6g@gmail.com>
References: <20180123155733.3404-1-mathieu.desnoyers@efficios.com>
 <CA+55aFxdqXJidPLFb--pa8cmJnepzGpLRD=gNXgktkjNW+jJug@mail.gmail.com>
 <20180205163353.llyamby4o7ajsvt7@gmail.com>
 <CA+55aFw9r1bLhPZ8bOApD7dBPTtFLBk+A71qLNF+XrEOL8+1oA@mail.gmail.com>
 <1659703322.16254.1517856780591.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659703322.16254.1517856780591.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Feb 5, 2018, at 12:23 PM, Linus Torvalds torvalds@linux-foundation.org wrote:
> 
> > On Mon, Feb 5, 2018 at 8:33 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >>
> >> Yeah, I wanted to apply these bits later today with some minor edits - unless
> >> you
> >> are going to pull it directly.
> > 
> > I have not pulled yet, I wanted to check. But I do want to get it merged.
> > 
> > It gets easier for me if I can just pull.
> > 
> > Mathieu, do you have a git tree? I don't think I've pulled from you,
> > so in that sense it's more convenient for me if it goes through Ingo.
> > 
> > But if you have a git tree already set up, just holler.
> 
> I indeed have a git tree setup. The URL is in the pull request I sent you this
> morning.
> 
> But I favor letting it go through Ingo's scheduler tree and benefit from the extra
> bit of automated testing this could add.

Sorry about the delays, I will handle your patches with priority tomorrow!

Thanks,

	Ingo
