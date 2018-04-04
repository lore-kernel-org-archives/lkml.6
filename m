Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522859035-2-1638703570740399183
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522859034; b=qrT747aE2RQf6oj2TjHpJ2SQBtVoz3AAjYC6CXf6ZOZASMz4/S
    XS4yt6ppDUXR8FqlkGX04qYGwwqPM1J+Tw1QB5RXNVFZ6d0GfphmlUdGSPX82o8X
    /4tQw9JZiAe0ajteTLgd4qorZbkua91JU7LB2C5A2WF7AhNGZVaFaWBd2f3sS2XL
    9YVavk65Yixhmxq4kGUMYSC65qYP+6hkCywpVhI7j8HKA7dLpArRgpafoluWJeo+
    +E1OJMp1mv4LxdKTzJ/Pe+ORhJE+Y73fdn2zkqihagl7R6cgufJt6gdhb1xU3v+4
    Qw38rt3Miq+T7gACXGnAaNoKWqLrvuJdEKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522859034; bh=FjzS7DkNCc3UsdP7Kuw9o8pY5w8H6UuzToJNX9FbYA
    0=; b=osH+AO52mh7bBfWvsDwA8XOQJlPOelo22Q4FAiSfWFE42HgrY3Qd0LiU5c
    e/0XNaUv7V+IZRhFIzfB3cCtNG4/UM1aBZe/XScVi6FRuV35p4DB4JMt2KIhXIQ0
    9r9rCGnh2yy05m9DzAd+1/ALeOkwfXaNoKsMwe/9Cx51TDLzj3K7QBNZSEqzZgbN
    fphMyclkajo+4+bB2o04a5CMsO/W9F5wVvgth2wCxTr7XsvFl/YyZ+/xBf1LaY0R
    ENDYIqTGgGfjptMw2uozW1I/epFB6o+TU5UQAd5dxzATiam3rGnvocpWzlFgpo/b
    JSiI4kyx4hwsIXbaL49ayZvOXCzw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=St77MAmZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JLK4lDLL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=St77MAmZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JLK4lDLL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEPtLitRriJ6ZNXKNNjm1cT/t6kgaEAw5+gY9Gwrsul7mmYQmcytcWT1Apu3/lCS9bX7vbH4WPgKOK9zViWGeFs63ov+hS95p1ai21yiieY9G0MKbNPq
    5qHw/3kxCeUda14ynpSdHOppXUJpzsiQYL9gKai9obnMnvaBNzz1uBXy5uWf93mcm29+s9SjWUKq62XgJ+DlMkTPBxxWUV/K5siHkWwk5f/I9wlqpjf2sfZQ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=9yog9L429hiQCA4T1W8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDDQXu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:23:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46112 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeDDQXt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 12:23:49 -0400
X-Google-Smtp-Source: AIpwx4/B6h7RzWzPjoU+v8x1IoGE6Qo5iolApNlttwYRCy3vIE9mSiJzBPw/eEPG0ljWFZXHbV5C2VtRBqUlrkYU6ic=
MIME-Version: 1.0
In-Reply-To: <1119.1522858644@warthog.procyon.org.uk>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
 <1119.1522858644@warthog.procyon.org.uk>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Apr 2018 18:23:28 +0200
Message-ID: <CAG48ez3edmZo1iFXqpvzOKNY0jLzcqa18KuoRrBaPyfp=7huZQ@mail.gmail.com>
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure boot)
To: David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+ast@kernel.org

On Wed, Apr 4, 2018 at 6:17 PM, David Howells <dhowells@redhat.com> wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
[...]
>> 3. All the bpf and tracing stuf, etc, gets changed so it only takes
>> effect when LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY is set.
>
> Uh, no.  bpf, for example, can be used to modify kernel memory.

I'm pretty sure bpf isn't supposed to be able to modify arbitrary
kernel memory. AFAIU if you can use BPF to write to arbitrary kernel
memory, that's a bug; with CAP_SYS_ADMIN, you can read from userspace,
write to userspace, and read from kernelspace, but you shouldn't be
able to write to kernelspace.
