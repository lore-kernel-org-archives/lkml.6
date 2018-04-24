Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3291660-1524584833-2-9746558616006002696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524584833; b=ofCd4pLaclClkCh24MZtZwJh551iy0aWXVPxRGjVsgEq4K0BH+
    QxZVGpCOexxzSC1kvCSBEmyjgbSn/Yqh82DJWFUNX6bkpbRVqFmM/gPRBYa0lzVN
    0Ja+fKqXuL/8A2irNadOIvj7J6eerQ8jnq+3AYhDBpKelbFP4njgQ8kb/cISDIvE
    wdps6KMYQggVtB4WYoazmbZlNgyOEupjEow3oDhf1Axwo2LX0bW8sKetBadOuWU2
    e6aAdSzU8J5RbxCPjkbDMjkAHa+x2LN4JF5hCerPNCQQ3ecv60dKpXX3pNTV4Mba
    zTgy9S1FnJMG3n0XCvlwUtQrxI8yAec11MZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:reply-to:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type
    :sender:list-id; s=fm2; t=1524584833; bh=7RC0roKUcPd58spylbGgMm7
    Mb9qrB6B9LM2Fhkn3NUY=; b=iwx4Kh9poBQCbh1OT0UD0BsJ0nY5qF4CT77Hq2y
    U2XOwV/Wz+pmqMP71oOc6DYx4gXbFP36/gl4yvNtoqAf/5N/vCCCLapSjQzPQbA/
    a04ihnSk6uaDbDQCpq76jVub+XRnZNjtQyXehhaanDWgdLS63lmn7egw4xKASv9J
    4dUfdArvNgQk72FTdtQ7HNVMOXs58H3bsDIooiMo40Hz4w9FHp+6TqSWcshIZLjf
    I3JwgA07HQdbvseW8dm2OPPn8XkqOucKZZaJREzAw9Jo/5ohowLf752cxNC0t9HL
    FHntuuRaLBcjuA6u/VSCJcm1QZVO5/Amjqp9UqgnW3htCUw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bol5nIt0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J9b1OD8E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bol5nIt0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J9b1OD8E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHbLe9n3jqPr34eUmumlv+RwxWfHG6/9t8AlTLXsJzeCPG8ZbqZH5F5w8ILYVYG0ZV1zV+NK8j78xXbuJmNbS/8Zt0ldPQEkLp2Ie8E23VRVXeN3eskI
    TRI1ujXuWT+OhVzFVGBUwbx2v76bO+lWUL0MtAth9oYkZ+H07Sb/W7fAQ0aXBIalanSchRZmGaYNQDVmYb02sfRenL6iGXI1HC7ExmqbfDMYIz6tFX8ytHQD
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IzEFBFVBfwYA:10 a=IkcTkHD0fZMA:10
    a=x7bEGLp0ZPQA:10 a=Qtx8U6EcU7sA:10 a=Kd1tUaAdevIA:10 a=Z4Rwk6OoAAAA:8
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=toF0noQasDrJLWomTfkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=4riroR3Ex10hVRXakXrT:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbeDXPrJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 11:47:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37951 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeDXPq5 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 24 Apr 2018 11:46:57 -0400
X-Google-Smtp-Source: AIpwx4/VY1wCcq/hZ3yTYVTXMP9NLRFgF+vS1Ci3Z99SIz5jIPd5o4uGCNRLg2hF0ixS3MX/hpLvblDMfTLRMn7IR6c=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+55aFwsRB5fq7Djgw5S7yR2y3GdBQ+1thHU9jYyAomBRPQaTg@mail.gmail.com>
References: <CA+icZUUvV0wLs4795zZz3AxG1ccHaCNwhU1nYQu-DTpohVEMPQ@mail.gmail.com>
 <CA+55aFwsRB5fq7Djgw5S7yR2y3GdBQ+1thHU9jYyAomBRPQaTg@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 24 Apr 2018 17:46:55 +0200
Message-ID: <CA+icZUXPGBXeRWUuv7_Rksg79=0ABrcUCUCM1Tfxg261=90=ug@mail.gmail.com>
Subject: Re: Clang and X86-EFlags (was Re: [PATCH] usbhid: Fix lockdep
 unannotated irqs-off warning)
To: Linus Torvalds <torvalds@linux-foundation.org>
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

On Tue, Apr 24, 2018 at 5:22 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 24, 2018 at 6:28 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> $ objdump -S clang-eflag.o
>>
>> Does this now look good?
>
> Looks fine to me. The instruction choice is still pretty odd:
>
>   1a:   f6 c3 ff                test   $0xff,%bl
>   1d:   74 02                   je     21 <bar+0x21>
>
> that "test   $0xff,%bl" is a rather odd way of testing the byte for zero, since
>
>   1a:   84 db                test   %bl,%bl
>   1c:   74 02                   je     20 <bar+0x20>
>
> would have been a byte shorter and is the canonical way on x86 to test
> a register against zero.
>
> But that's just a "looks odd to somebody who is used to x86 asm", not
> a bug or anything really noticeable.
>
>                   Linus

Thanks for the quick reply and the confirmation.

Personally, I do not speak x86/asm.
I hope CCed LLVM folks know on how to improve things.

- Sedat -
