Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-888773-1525895422-2-2296603162497470070
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525895422; b=UTk7yaIcWNE+H81iWKl/mkkT3BblVg4iTQQHhS6X1qjxE3xaUU
    WwhFaOf+R/rwQuZgV/dvUq0uAE/CnBXeHfEOrzk2Ob/XM4Ch19IQxUhfYV4GAfHy
    0ot7xTwCool8x2mnBdi/xNqyHHDjplayIiiFAC6o/Y1Bdwj/Q3pKghjiJFAyxd3g
    IwUuWg3yd5zWA1+ZII5la8LeEPKuf1sTqXSi9qZs4PUHq2r4ynYJbU2NtfehvEnG
    uvnthF1XtjRq2bVoJwz6ztoemMQCLzrDIPOhn5oJchCGc6sQgeTyeIaRZixjOLPv
    E+kmSEQF0i1GN/i6aOX8clhb/WxD/1D5raaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525895422; bh=53NXuVFlikak6EON1hNLvanrb5FfesIHGzN5rjINPD
    Q=; b=jDRWy/9kGLHlff8EMkgN+Ojxz7s97IctsGij1qZZ0s7f79otbnAxM/EBi9
    evvOk64j6bsdC4PDH3zmrMgoAwy3b9EMoWN7FAWLWbRAFSX+X7GcNrS3kx0OYq3I
    E3HdEVB5UzN0SmMKMoz+5ZIr6f1bPP5DH+q7dYJtw08NVCzuJrilmyJJk+vx+oTr
    //OU2WwUEDJUF6XQUzLTEhey06xgNn7YKOFk+bdSM7+ewCioiu9a4nVUID1j/3Sa
    QYt7cdqqFhZXiPWFSvjWgo8x/fMzPndmG8pVX1ZbWI4NmOw/Aj04iJuE1DPN6Yy1
    bRS2jLQO6ivoDdo8lZ7S+MnYeycA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=JgSSAKFZ
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=UP8Ay6kc x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=QEtdeBV3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=JgSSAKFZ
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=UP8Ay6kc x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=QEtdeBV3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEAJKjZd26381pWeN0AgJvYwPb/Zn/pGShKrOujfdc5bWOCj3dXpfACRFLs1/2jNdJFyBL6nUNPQfVCXTCu8EZU15B6fs5IP4G3FSV031p6Qn1R22BEO
    yBMoK7dP/nIomx3XetHdQSRa11/b0PNTCy3y/Lk+6rUK/3IQC7/uY1tU3sO0eddTha4/NKrDzW9iaa8Igma0N/gsgWw3tQ/6G94r9B/SETupLZCgYe9dI+W7
    ll4huw+RnKzAAFue9mXTjA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=K6HrmWtEAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=ZPKuonR7uMj3GVCYAn0A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=yV38gEssg_2GhkhKF82i:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965567AbeEITuT (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 15:50:19 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43378 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965633AbeEITuS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 May 2018 15:50:18 -0400
X-Google-Smtp-Source: AB8JxZok7E+ndzO2ra5m36oATR/8hqOKSzCtWvUtFmiPEJMRo8/20xT4eJz9V1HYI3cv8QrmT7mjS02V1jgEIMcTkco=
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1805100520100.12749@namei.org>
References: <20180424202639.19830-1-tycho@tycho.ws> <CAGXu5jLL7NeX+zUNqcYW_LDF87CPg-5Z4R5+FZ5uPDT-sTisng@mail.gmail.com>
 <alpine.LRH.2.21.1805100519200.12749@namei.org> <alpine.LRH.2.21.1805100520100.12749@namei.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 9 May 2018 12:50:15 -0700
X-Google-Sender-Auth: q0zJZ1eMcf6zQuK64bDE34GBQrk
Message-ID: <CAGXu5jKr=E5bnJPX7nHov-UfWRr4EFd1Ni+WFgaikD0dyYiMZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] big key: get rid of stack array allocation
To: James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>
Cc: Tycho Andersen <tycho@tycho.ws>, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 12:21 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 10 May 2018, James Morris wrote:
>
>> >
>> > Reviewed-by: Kees Cook <keescook@chromium.org>
>> >
>> > James, are these something you can take into your tree?
>>
>> Sure!
>
> Although, normally, these would likely come in to mine via David's tree.
>
> Please do that unless there's a special case here.

David has not replied to any of the threads or versions since
originally posted on March 12. David, can you take these or at least
Ack them for James?

-Kees

-- 
Kees Cook
Pixel Security
