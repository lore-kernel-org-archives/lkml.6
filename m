Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389914-1522788790-2-3818441521255802947
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522788790; b=HQgiZNrYvfkg1b3yw90G7ArxinQgQsLNPn3cwrfSLCkvfdnaud
    lyZlDo4ozj3t2kiwLlpXgDcmsDraA+Y8ngGSazmQjrWzoKLl9GY6yXHH9JugXjvu
    qDoh0nv9/QZBcnhLQTIgjkTcScbpP6/p3vOyaDbhx0OaX2JY0RZ2FhU5kdEBCP/8
    MtHkjStCA4c3+zNmrrpvtBcvZ/vhVzs+En9E8zB7pNePQA+TteJPC/7GM8mbraas
    w/k9Fxgn5dKLD2LU8svphufapfe0f7qs+n8axOvpyPsuzl2N3B/N4lWaQX6RHJJI
    cH7b4avbpbubZsOunDXASHGx2IYIJezlgoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522788790; bh=a4+YWn1mnJ63fPLii4VrWhuueH5vpoPrcF3RoMHNY0
    Y=; b=MqwSbC8uZ91VJ/VHR/QRDwhbzd2QZ4k2cf05O8ABar+3P2CLuKWpvUG/qE
    W1ocXtz6e7EqzU/j9x3tF6fv4+o+X6r42Uht6iZ95jwv2M51zpGAKdHaGpWg6Mkx
    WzuA9zLBW19TDDLU1HCxcNQoI1u2ldfW+PvxcsoCyBIjq5JpaF6SddDkkTpTZ+sL
    FcFEpU+wQvU6iN1MpZ/uu0JQT0dIicWWUtz5SzQt2luuR9ODUSKsCy14nu4RAx40
    4wAabhK6F3ZyKdIKWJOMPKJm8fGrA8xGC80iWjmtCEyTbJt9IhqghWdPQHb9UDgz
    GXBsXT4Z1bpvyW/dXB+BfArOPH+A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U+XFRM3p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iIY1/HZJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZcxsnE8m;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U+XFRM3p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iIY1/HZJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZcxsnE8m;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMDKEfhpFfBMzsBiGmlQsFwjeaz1JiGWDDGOmnRdkR0nI5CEeeUAOajsSccpOztNvYGsw2nLW6VDTdzlaTqlbMZWPEcIK8i6gZBW+ipslS3Vdkp+rE1x
    GsV7iRkS05JNTRkh28cWKe0PsKrmia/4iBbJ0pYsaFKfB7OcvfCiwlU1/VKmdJZn+usMakcDBlY/5S0wob+RLnDbEO5HcYuojZPYvcSUhVs22vxpWHhDvcax
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=QWFicqOWBCH2QOgWkS0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeDCUxJ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 16:53:09 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37633 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeDCUxH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 16:53:07 -0400
X-Google-Smtp-Source: AIpwx4+lkmJzgzfgikvHGw5E3Wh5wBSIpeVRppypnbZjPokzV6qnqwNo7Ii5PnLX3jyid5X4QL3FMXvD+WBMb9G8T4c=
MIME-Version: 1.0
In-Reply-To: <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com> <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 13:53:06 -0700
X-Google-Sender-Auth: 438gIRbonk9XzwExN1seccqPHiw
Message-ID: <CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 9:29 AM, Matthew Garrett <mjg59@google.com> wrote:
> On Tue, Apr 3, 2018 at 8:11 AM Andy Lutomirski <luto@kernel.org> wrote:
>> Can you explain that much more clearly?  I'm asking why booting via
>> UEFI Secure Boot should enable lockdown, and I don't see what this has
>> to do with kexec.  And "someone blacklist[ing] your key in the
>> bootloader" sounds like a political issue, not a technical issue.
>
> A kernel that allows users arbitrary access to ring 0 is just an
> overfeatured bootloader. Why would you want secure boot in that case?

.. maybe you don't *want* secure boot, but it's been pushed in your
face by people with an agenda?

Seriously.

                  Linus
