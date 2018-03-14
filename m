Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1338708-1521020636-2-7840368635866086819
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521020636; b=whv5DdHpdB0dueV8hLaKALX8tvlfuzOgaPBpKiPVvvl2JXk
    rBqEo55Ms2BtvPvsrfYUguVHPioSsX0XXsBq+2qI6f71YOkQtzDwk1UzwclbQmeT
    HVFkvrP79SwZHClrD/zmRKr+QjEm9fH46VEqyWgk1YmxBHcSIJYRtj8+BpduZfqn
    FaqTpp3jrZtuq58D8nuonHwSx16CtrhJ1F2eE4lIRLn/UlnOpiFcGQ3k7R3i06Di
    q5DGtN1ZbpVGxjCzV2KG2p5kZw4VFYsf3kgg2+DSEXgxuLU+sqhvtr78bis4RiMk
    eG7KSBzk9/YRqLgRxXX01Iq40qdgOKMQIPYfJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521020636; bh=lSVC9VxYBNw1xxAIL/N6bBybh6JIMRfFnEQdgbz5aJY=; b=T
    PFK8yTfAzo+vN65ABx8uN0JOiSGSZ2Y+A0AX5Eyf3R6HxgiEgaebJ08DrGAqmj3M
    F3Q5POHbRDq86DKl+944RQ4WT9ZeNXnav8HZgOtWFM1a8QyprfgI3zIoKRCS7YBk
    Cj85aw1lwx4ec5GBkmVAKd4dS0mGne6SLQPFznK/i6dHYBuN33IQilp+FinwVrfo
    /Jaq/PP37rsw2I/bVqAG78Ql2CNML0X8OgTDRNpHdWqwefDcKoZEvaZlQygIXmHh
    uSInJwzr4j/bjN6iGG8Ji4+Mw6cAD1mttA+4P0+IgJGr8DcEpbQNVmqnI0d6X2g/
    KWqb0/7/3qKyLflorlNAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=oxC/rbCF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=oxC/rbCF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeCNJnz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 05:43:55 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:60274 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNJny (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Mar 2018 05:43:54 -0400
X-IronPort-AV: E=Sophos;i="5.47,469,1515456000";
   d="scan'208";a="599674684"
From: "Tautschnig, Michael" <tautschn@amazon.co.uk>
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Andy Lutomirski <luto@amacapital.net>,
        "Tautschnig, Michael" <tautschn@amazon.co.uk>,
        Jann Horn <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86: always use SYSCALL_DEFINE*
Thread-Topic: [PATCH] x86: always use SYSCALL_DEFINE*
Thread-Index: AQHTuLIpRQ4EwEJShkmMNsa2rpeMXKPOr5WAgAAiHgCAAGzwAIAAQesA
Date: Wed, 14 Mar 2018 09:43:46 +0000
Message-ID: <C59EE7A8-35FC-47D6-AB63-33690684310E@amazon.com>
References: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com>
 <CAG48ez1RBhBbH8jHwseeZMQwdKciLdjYhoy3O9yDs8WEpMk2TQ@mail.gmail.com>
 <CALCETrXh7BLrv4AsQm-Vpwmd=ttnGWQXV6dAxxi3GVevxnMO7w@mail.gmail.com>
 <20180314054802.GC8354@light.dominikbrodowski.net>
In-Reply-To: <20180314054802.GC8354@light.dominikbrodowski.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.111]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F3233CC6032AC469BA6E237B069A039@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dominik,

> On 14 Mar 2018, at 05:48, Dominik Brodowski <linux@dominikbrodowski.net> =
wrote:
> [...]
> ... the ioperm change is already in mainline (did an equivalent change a
> couple of days ago), but the sigreturn/rt_sigreturn changes still seem
> useful. Could you send a fresh patch with just these two changes; and -- =
if
> the x86 maintainers agree -- I will push it with my syscall-related chang=
es?

Thanks for all this cleanup work. I have posted the {rt_,}sigreturn changes=
 as
"[PATCH] x86/sigreturn: use SYSCALL_DEFINE0".

Best,
Michael






Amazon Web Services UK Limited. Registered in England and Wales with regist=
ration number 08650665 with its registered office at 1 Principal Place, Wor=
ship Street, London, EC2A 2FA, United Kingdom.



