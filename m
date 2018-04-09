Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086858-1523278090-2-14832963611523071913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523278089; b=FoR9QYBvFc5DUTCFZehSqnYjA93CecRWZbY5gWnD6oBkkZLavH
    gt89TFw7vXDWu0TO+3AK5XntEZYPh7vQT0aaoPs4gYyAI3iK4YkRJtM4eQ9WcqXo
    AIEjqmTv+8zIX2VZZUtv5Qtfk6AErTNFw5lbgqyZMTGjNckNBZN3VMGT6znkIC8n
    mIpjCN1COwOHuUvqp5qzYsYFF527ck70hDFxsP7LXQL6N1g+ZbQDSlAlitUxqRMu
    cPeqv0DxNyxboZ94BGNBy/A8I11pf6HUfFjf640nx3ZDq4xFcFTvlsm33pYUvgSY
    FEictCjjJxUNwqhFVKoqM4+/w9wveXLt94Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523278089;
    bh=Fii+tlQj+XJobvrf64y7gBR7ksWPs+so2uqb4EaBXvU=; b=wbyIIqpy6oTD
    0mUE7f2XTJOMbFywDS4Wo6BXyG9py0rAidv6mIBRKnOR4qMxPEOTGIS6fZP369Hh
    2nqHuGX1W1jP1bvGMNX8qBFByGXFKrqxeBl0iydk+jX7BKvEeEWfG5Laz6fqyq7v
    4JJOs/FFhqTbqS+zTuAsX5yUy06cFFxN9plCwGg5cx/ctL/KOfJhyKNsvpES0KeT
    ac5zgeIvbzIXhiO7QtdFYT0Y0hbRh4dkxXGcjEd9GgJa4sWzBn7knWj0p8IKB5Yf
    IvohrYjWu3XjCZPc6Vy/iBRmf/YUzHt+If+8xMEtY6B03aH0D9lhxw94Su0DsNfW
    h6Z09NYHEg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHDvAHxGwQa6qfVRWuhctwh3rogn0ci2AYwsZw6KX46y20y3ZxWCk/L21FRiMjEq9bG/3HbLYg6gY011GtJyN5P1jmv8x+kFeThw6bZwWCgpFrzOJCMw
    yKoABlk6hjc6KJhArc3aFfY9inA0jvYLMv1GYPsO++B9kStoW8WgB4E3tysGpdUx0BeULTaYjjoBfbz5Tr8nei2kCvdrcJHBNvp5Az3WtwKQYRVvEZlk/pA5
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=D-lONBbLu7pyb2FttfcA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeDIMsH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 08:48:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40539 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeDIMsG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 08:48:06 -0400
Date: Mon, 9 Apr 2018 14:48:03 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Parag Warudkar <parag.warudkar@gmail.com>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH AUTOSEL for 4.15 142/189] firmware: dmi_scan: Fix
 handling of empty DMI strings
Message-ID: <20180409144803.08293fe4@endymion>
In-Reply-To: <CAPxHnE3uPVC684DzGbdNRsJNsfHN8WF2H7m8GkKz7Z22-V+1yQ@mail.gmail.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
        <20180409001637.162453-142-alexander.levin@microsoft.com>
        <CAPxHnE3uPVC684DzGbdNRsJNsfHN8WF2H7m8GkKz7Z22-V+1yQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Parag,

On Sun, 8 Apr 2018 21:21:19 -0400, Parag Warudkar wrote:
> On Sun, Apr 8, 2018 at 8:18 PM, Sasha Levin <Alexander.Levin@microsoft.com>
> wrote:
> 
> > From: Jean Delvare <jdelvare@suse.de>
> >
> > [ Upstream commit a7770ae194569e96a93c48aceb304edded9cc648 ]
> >
> > [snip]
> >  
> 
> 
> > * Strings starting with 8 spaces are all considered empty, even if
> >   non-space characters follow (sounds like a weird thing to do, but
> >   I have actually seen occurrences of this in DMI tables before.)
> >  
> 
> Unless I am misreading the patch we will now allocate memory for
> len(spaces)+len(string) for this case.

Correct.

> Have you seen BIOSes with lots of <space>string occurrences?

A fair number, yes, but most of them were thankfully not in strings we
are saving. Also note that most of them only have 1 or 2 leading
spaces, not 8+, so this commit makes no difference for them.

> If so what's the point of allocating memory for the leading spaces?

Presented like that, it sounds like we are silly. But look at things
the other way around: what's the point of storing these leading spaces
in the DMI table in the first place? Whenever this happens, the
hardware manufacturer is to blame, not us.

As much as possible, we should stick to the specification and assume
the other party does as well. Stripping the leading spaces would be
trivial, but hiding their mistakes does not help hardware manufacturers
in the long run anyway. If they can't see that it's wrong, it's harder
for them to fix it.

> IOW, what happens if we strip leading space before allocating?

At boot time, we save a few bytes of memory, on the affected systems
only. No code cost, but possibly some confusion as to why we strip
leading spaces (which are rare) but not trailing spaces (which in my
experience are more frequent.)

At run time, the exact matching of the affected DMI strings would be
less error-prone (although strings having leading spaces are likely to
also have trailing spaces, annihilating the benefits.) Non-exact
matching would be marginally faster, again only for the affected
systems.

As a conclusion, it's doable, but the benefit is very small and limited
to a few broken systems, and it has the downside of not discouraging
low-quality tables, so my position is that it's not worth it and not
desirable.

-- 
Jean Delvare
SUSE L3 Support
