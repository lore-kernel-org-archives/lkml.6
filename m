Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3236225-1524583364-2-5028161684705378472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524583363; b=GTHftrqmaN2Yo4b4RnoarZ1xG+9fHJF2Xbtg3+IIKvQbcv2M99
    RYVIisk+e+xG91xBIR7i1K0VS9Qd90+zCbHhxXVzkGdVACjk6f5ERj8hzZ+51H+8
    RCY+0l7PQA9yDOIkyoNDklzzxrfFqqLvA2obrO6QTQcWKFUDK/E1OVc3SRrXxUGv
    i1ZgHh+O4eRSdasH9M+6+5eaSi69NgbdEI2+l4Pxqybf3hJaWB14rY8q+QPl+4ya
    zFY5HH2C/zNt5Zangpwq83nC288YvX2r5OTJg0QgNOar+2JT2kI2Q76ojRAu1FQq
    YAoC6ynbZDR3DK2shihFacMI6FZeGETR/gIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524583363; bh=CfjG1Gs3HY2qRLbjtkThA3kmDtrjWYw9q38+5+jQI2
    Y=; b=uULHYz8ODhU17cP7WWGDeboZee0Sz31UUtLXcowqLRnvwf6KkAUWa6l4LI
    99JsllpSUFbDMc1LmZcpX6QhKah3zUVLyr3/GzOmHxxjznW/kJJDpOvDFJfR4eP8
    H+OK7T8UqKJMWjTD1PrhGj2OKwbRHeK+h7Z4uOJH0blTi1+dGZOrv36n8DHvLMo2
    iW6bwBYTL4ibycBHqcQjWa9Ax8FFfm5UX1Lioohkujwx0OByp90jyyB3YLe9DV+V
    4ADC3OL++vxN2R64QR4EB0NBd7Cny9atSSrMrVPCKyn/f9n0xqidWkmb9p9Q3IRF
    OEPu1YhPTnciHvvQ7oH8NYQpmgJQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HL3cNnUz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=V5lhEE0q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZSVx792n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HL3cNnUz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=V5lhEE0q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZSVx792n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLvtlsFy7NSUu1ftYjGPN3GEWrBjt1LVU1mGbPbUXQ9n2KGXgv7ye3vWED0Ld3ATRcYT26Xsw/pwlXfqIhcDpymvOGEKKzr15tICub8tdkN7D1r6FzKE
    h1t9ZDGTsuCdAKYXi1gCFUP0x7Gcwws0ui5MN83xzRvzPSJeFpnXeJk4nd0x/ehDPoWblr06jSscW9NhPmB/DDe9gQMNYX5i5tjdPmdrchXW7m+NRYPzEqs6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=iKdub3Vghw6hvvXZx3oA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbeDXPWi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 11:22:38 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33142 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeDXPWg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 24 Apr 2018 11:22:36 -0400
X-Google-Smtp-Source: AIpwx4+OgrPuoPldrZtAF7T/Sf6KWwzrCS9Rr1crhrhGzaKk6qVrMvzyXB72i9Kb6i6sRu2Lkbzn6NQtkq0iRIcNJyU=
MIME-Version: 1.0
In-Reply-To: <CA+icZUUvV0wLs4795zZz3AxG1ccHaCNwhU1nYQu-DTpohVEMPQ@mail.gmail.com>
References: <CA+icZUUvV0wLs4795zZz3AxG1ccHaCNwhU1nYQu-DTpohVEMPQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Apr 2018 08:22:35 -0700
X-Google-Sender-Auth: or6GjGKoNjfzV3xWcocurGSoK34
Message-ID: <CA+55aFwsRB5fq7Djgw5S7yR2y3GdBQ+1thHU9jYyAomBRPQaTg@mail.gmail.com>
Subject: Re: Clang and X86-EFlags (was Re: [PATCH] usbhid: Fix lockdep
 unannotated irqs-off warning)
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        David Laight <David.Laight@aculab.com>,
        Jiri Kosina <jikos@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Hordijk <hoffbrinkle@hotmail.com>,
        Chandler Carruth <chandlerc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 6:28 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> $ objdump -S clang-eflag.o
>
> Does this now look good?

Looks fine to me. The instruction choice is still pretty odd:

  1a:   f6 c3 ff                test   $0xff,%bl
  1d:   74 02                   je     21 <bar+0x21>

that "test   $0xff,%bl" is a rather odd way of testing the byte for zero, since

  1a:   84 db                test   %bl,%bl
  1c:   74 02                   je     20 <bar+0x20>

would have been a byte shorter and is the canonical way on x86 to test
a register against zero.

But that's just a "looks odd to somebody who is used to x86 asm", not
a bug or anything really noticeable.

                  Linus
