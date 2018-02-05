Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3245219-1517860502-2-2485240769271743990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517860502; b=mNW8IqUCci6jxq6ThCbvz/PdEMr9xrdoDm1pv3TaEW7QzsR
    tAWn/UIbcHiOcEaL+u2ykFOpZlHIE5xddn7IdC4GgKVDW5cdjGKrlJI63DsBtjkY
    nAv3G4qr68/b0M70Xb2oKmsJVHh6lsfLgCTa83poCqSfaQQTcq33gFN+W3qfskLb
    3xVndMBu4XC+jI769evw9ZPl6dPKaTlbTktIuW9UBrUhZ+1OzPmmO6vmIAbKPeU7
    nGIn2YjBYrlK8tLYi4bngJSvyGPnpRdOy1/HKZryS0I9WB52b5FeGGOTcOr8+4fl
    VhFqkGXV20HjvHIA4+wBXMh9Zwz2MOgsq8kCgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517860502; bh=UVJRZ24uKCw52YLwdcjrJdyVO2xfyyzpT6fOdX
    m1Er0=; b=tDyQfo10LpONbJ5213XiFtIn7oE3xQVFWKRSn+WbTvzVBuF/MFc90k
    NT73CGWMQB9XXvOZ9CDbP7ZBacd/CTI40MI9HXl38aWuv3PInt04UUg28HTs4i3y
    YsfloyOBO3rBzlHGVOq36zD1pbOpfgR+n9ftEnrMcDqdJaFkVkAtPxWPMF60nzKB
    fLBUbVpQlAjUKXwDVesptja9eG7z3+SrXmIwEp4U8IAjYHH/Hd0iTuseU5ZGz/UR
    ptXFW6cyZi36yRHRrl7u6MkoU/ehQZ7hTmece5+Gz5c+ocy3kohQzoFx23U0DVry
    z2vJqKVbv6tGlk1IU82M8GcL9Xp740Dg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aYY5YJBI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dJWiRwgV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aYY5YJBI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dJWiRwgV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbeBETy7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 14:54:59 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:45304 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBETy7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Feb 2018 14:54:59 -0500
X-Google-Smtp-Source: AH8x225EobAxGHw1+w/IQ9YPa4l29OOEyAeX8cd9i8Mu7zReP3tDKj2B+2gT3jdAhU7keLU3Wtsyvo11jZjFqnO9ETw=
MIME-Version: 1.0
In-Reply-To: <1659703322.16254.1517856780591.JavaMail.zimbra@efficios.com>
References: <20180123155733.3404-1-mathieu.desnoyers@efficios.com>
 <CA+55aFxdqXJidPLFb--pa8cmJnepzGpLRD=gNXgktkjNW+jJug@mail.gmail.com>
 <20180205163353.llyamby4o7ajsvt7@gmail.com> <CA+55aFw9r1bLhPZ8bOApD7dBPTtFLBk+A71qLNF+XrEOL8+1oA@mail.gmail.com>
 <1659703322.16254.1517856780591.JavaMail.zimbra@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 11:54:51 -0800
X-Google-Sender-Auth: eObhU8ltlvSIJl-eHi2md2kSm5A
Message-ID: <CA+55aFy8Aie9UZsz_Eju5MKvVTgR1VZU-y1wuEgScZN39zNP=g@mail.gmail.com>
Subject: Re: [PATCH for 4.16 00/11] membarrier updates for 4.16
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 10:53 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I indeed have a git tree setup. The URL is in the pull request I sent you this
> morning.

Yeah, too much email, so I hadn't gotten to that yet...

> But I favor letting it go through Ingo's scheduler tree and benefit from the extra
> bit of automated testing this could add.

Ok, good. I'll ignore your pull and expect it all from Ingo. Thanks,

              Linus
