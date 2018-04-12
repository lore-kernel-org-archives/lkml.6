Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1364822-1523552011-2-12590180246605679118
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
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523552010; b=gPl/7VQT2a24QqGpX5qBj7CDpKoggfgzCzmUQsFj1v8R+fvoSW
    O9QkbNTQYWWMaBnNXDD8+U/CDOBSl5lUZcvEwSBjT2XGOovcY1UhOPR8NGwbIJr7
    99RtplM/5sUldYIetOPxsh1zIzOSuCK20hDO5pehxceGgChDZ53J46O3v65rQBAa
    mFuszrAMuUnXzPDRj7zbHrUoIN23dlQsSDzQYU0GG9R+UAw3W3uLSjy70JlGmeue
    8KC8YwgSCvfoPQno3P7RlS+KBELxB4n+fIyqhhBEBf+fFQbsGMtbEXgubRfuAgHG
    bOQqE+P8ZB2UwwTiNxJAAR+dPSz+RCLtF9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523552010; bh=WoOEHxozjNOFzE0aJYX3cPRnAOYueJpLEIRc9TwRU3
    w=; b=E8HeM4UR9zRVB2SSan//bQXiy0bX8iDqJhurhc58vx1c48zVI5GFEdVixr
    kjxSiOosiV5qYhvr/1zw0glY7e+7h2G+pCOxkrWH+17FL+F4iv87waTTLCnFK1QM
    jropiCtesDY7wvseh+O27jDf6yMyn1NqbbIuXTVU9/DzaJD9h3jCkNqecjyXBWba
    KhCrqd/amHNNf1JbdK927zaS/UNX/yvbQ2w/l6ZeCGo8Eo2hzIIgBLmESsJ1SkxW
    dDflZQoKKTJbiOSbCAzJou33UxmLZCYqNF7ZFHqeq6y75OGLEfp7wrVPP8fJui2f
    hHhHXya8ODgN4SSA/07x/QnQ/mgA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YVEnZt0h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ob3yhzfE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FYf//7jd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YVEnZt0h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ob3yhzfE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FYf//7jd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCr+zhb0wQIWHNr1ksrqk+zkPbLxwHEg/gDnYzWrdaz61jTRsMoV9E6CNsZRlCR9UqnCsEsT4gsC1yu/oRwdk4VaVZMfQop91am/2Aa4aXw57uQroXOv
    nMG6npKXTJPrpzSBCYJj75dJRlqn/vTZF1u4WHSnqwLqIXBaUMC8gZtistJ8iTwy1zZse4R4fE1hmMwYWXPH43z2OvMVJ7iN8ZOthg5RTqjJleVBzTAHStjI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=NZ1Cdi6YAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=NO8SWBgwS0d6KvvJrOUA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=VTb59HSaHn79mzR5dlyk:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeDLQxA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 12:53:00 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51921 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753236AbeDLQw4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 12:52:56 -0400
X-Google-Smtp-Source: AIpwx48oE7L80zFL7x9Pwg5W1bRi1+4Dy7Rm0gsmmJuPL92puKGF9PVAXHHxT4arr8fKgi9kWmeqEDCb5AQTy6EPG8w=
MIME-Version: 1.0
In-Reply-To: <CAFxkdAr5c_bKEKqV2t-PKAo3iSvEkpqO1p+RPg9t-sW4yEUOnw@mail.gmail.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
 <CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com>
 <8z0aRQyD-6Krqntk8UD9WQjK5JSqEai2Pt5oeFU2EplgxoWiHlX5nlJXwCDHQ1WcS1oIprXimgz7UvwHCWDB9Z3dYFrEmZmtkEJSqaYMel8=@protonmail.ch>
 <CA+55aFzvnf=4OeBy5vQQ6HQoCsgCkAJw1LhSBOTkDWm3ck1pZA@mail.gmail.com> <CAFxkdAr5c_bKEKqV2t-PKAo3iSvEkpqO1p+RPg9t-sW4yEUOnw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 09:52:54 -0700
X-Google-Sender-Auth: Cs_IH-1mrQQ72a3BRUwdDRX4P1o
Message-ID: <CA+55aFyEaNGLoSL2SJZkcvApPJQFo1mK9KW6g-_FdAm1KSqGEw@mail.gmail.com>
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
To: Justin Forbes <jmforbes@linuxtx.org>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>,
        David Howells <dhowells@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 6:09 AM, Justin Forbes <jmforbes@linuxtx.org> wrote:
> On Wed, Apr 11, 2018, 5:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> So it's really the whole claim that distributions have been running
>> for this for the last five years that I wonder about, and how often
>> people end up being told: "just disable secure boot":.
>
> Very rarely in my experience.

Good. Do you have a handle on the reasons?

Because I'm assuming it's not /dev/{mem,kmem,port}? Because I'd really
be happier if we just say "those are legacy, don't enable them at all
for modern distros".

That way they'd _stay_ disabled even if somebody cannot handle the
other limitations, like DMA etc.

                 Linus
