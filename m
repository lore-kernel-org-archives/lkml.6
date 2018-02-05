Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3213742-1517856850-2-43745751173377344
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
    t=1517856849; b=aPfZmz44ENGaXN/epQ+gzPGHyenSlNfAwhS7J3FCK0Q+k5D
    huER/oDbqg4d0jPjVXFC37ij5iDr84GcZy2a270Hd0wHZrqgKV3KR4ZNigr+pm6S
    c6j8KGV9bd+sBL2bzBrePyC7nLN7YjXf9+Vu8FyGAZMGTDUpmiwGyGz9dAb9/+zH
    NYG5YNObGw1hiI80leIZpqiDvassvnFiMvL5sZR7WjW4wVLh1B+7t6rFSWo0ssOf
    if60qXwPdiY179HwWpgwf6mHm5jNiX/ovQ4UD4y/vyuUTYYrpQinT18xZvuTz32I
    1kgf9tq5TOGyMUWBs2TjM9Zpvq2VhEvoFL3B8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517856849; bh=0cT0NOQY8lgezxl9H6iPT2B93KN2SO4og2F8VJuwtoU=; b=V
    eMf177F0PrtoC59rLOBL8C0y5z9jaC2txk7nR6RoTXOMYOnqPJC6U2++IqyMtCBZ
    CnDMvKrFNv7NQnTSsCeddX3n1oisGz5Tv4T4H0FbzeWYm+zDiIQMMO/uSqD82tsw
    WWcV+6NPS0Voi5ghYbJwgBE32tP2LNPErZsBzX0RJ1tAnA/Jhv7jdQo2oX+N5WaL
    CePy4gDQqAEAD2vA7g54zKBV5E4ngReYbFTMEknd3XD0km3SVn/RK157tVZsXkUu
    bcU7Yf254QwAMtAoh6v2Fd6erkLmsfJU0KGuQKdncE/vbk2blXBeJM1X8/D1vdnK
    0XPuJk6CjihmPnCF2JKpQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeBESxH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:53:07 -0500
Received: from mail.efficios.com ([167.114.142.141]:56262 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753556AbeBESwS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Feb 2018 13:52:18 -0500
Date: Mon, 5 Feb 2018 18:53:00 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
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
        David Sehr <sehr@google.com>, x86 <x86@kernel.org>
Message-ID: <1659703322.16254.1517856780591.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFw9r1bLhPZ8bOApD7dBPTtFLBk+A71qLNF+XrEOL8+1oA@mail.gmail.com>
References: <20180123155733.3404-1-mathieu.desnoyers@efficios.com> <CA+55aFxdqXJidPLFb--pa8cmJnepzGpLRD=gNXgktkjNW+jJug@mail.gmail.com> <20180205163353.llyamby4o7ajsvt7@gmail.com> <CA+55aFw9r1bLhPZ8bOApD7dBPTtFLBk+A71qLNF+XrEOL8+1oA@mail.gmail.com>
Subject: Re: [PATCH for 4.16 00/11] membarrier updates for 4.16
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: membarrier updates for 4.16
Thread-Index: KHWosuSgzsdS5gFNGjAN87DEfXAwJQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Feb 5, 2018, at 12:23 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Feb 5, 2018 at 8:33 AM, Ingo Molnar <mingo@kernel.org> wrote:
>>
>> Yeah, I wanted to apply these bits later today with some minor edits - unless
>> you
>> are going to pull it directly.
> 
> I have not pulled yet, I wanted to check. But I do want to get it merged.
> 
> It gets easier for me if I can just pull.
> 
> Mathieu, do you have a git tree? I don't think I've pulled from you,
> so in that sense it's more convenient for me if it goes through Ingo.
> 
> But if you have a git tree already set up, just holler.

I indeed have a git tree setup. The URL is in the pull request I sent you this
morning.

But I favor letting it go through Ingo's scheduler tree and benefit from the extra
bit of automated testing this could add.

Thanks to you both,

Mathieu

> 
>              Linus

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
