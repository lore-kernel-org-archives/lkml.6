Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2496537-1522791463-2-16448382062299053833
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522791463; b=hYJqzFA/KmYPzXTRPaceCSnOb0rwHUC6VjRczvzf9RZUVse9HY
    +nqz3VECQU4XmR8wcMVne36MyQ1lfpLjSjdZJJCpQfJhxoicSNHiI3wbdLqUzGhq
    9Vw08bew253kIhatOmr+OKUgk8R5HvsxIp4tQaidShnuNsDneOcSKA1/vM7W54pz
    JnnbeHTf9pcQKZBAWjX8xU5TB2B8OkqzgMhpV779S9jA7e2rZFtPbog4DZuyEN/J
    VNQxWgSv11coCmx17o4Tn1IvlsZeBI9nq74cEq2iAPnJfvJsB10Xyqs9WYuhY9wC
    irIJQQUTJ7L6qh0JxpxEuIYMPisvkV8AQPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522791463; bh=1yutX9seriy1BHdNGpl98ULjJfTbLpo02P7NP/cJJI
    I=; b=QGxZGociGpWAnohmg0UTzuXwkhNpyHTdgAhyGUVELTDUdILbVj9VROxio8
    Sl5PFTdzMwppOpif6phliJUJmfZb3Qyb+GSkhTQ6i21DrdI2lxe1bbOfz0W0FiVT
    1zu67k6Y2Ku49Z3pDuz62dYxhqv0bW4H89FLh2dYdpHijijoImStxNibEuW0brEA
    KJCLl8Oeaggk6DanKIZjsbOGoA1NDpOVJbo2hvQPnNjA6XaNOuOizmkuDr/2XxRw
    IHA5lZL4qS9C8SMRBekBho9KnzIGS830KnsGnJGY2E3fakj/96noed51/b/ZCX+d
    tFCuc7FVoOun+rX1yJ/z1IXQ0rTg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=DPFUvLMN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LTXeG+Fe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=DPFUvLMN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LTXeG+Fe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKZGe7bKBd7Lxoct4zwvk8mEZQboZK46hKLZ3/pEymlcc7i49rVIjRFjSbSByDgEud2Q/KkhCHuMSHRzZAkZpezia7g2O0vi7vWt0rv9mnQqYu6PsdmR
    alyzyRufnfjZEIKtpZarReYQhdtkyFts33v3tZAzWR+eIotMbQKyrx9JAoO2JLnxweG3iCZ6POqooF3qIk+ssjrA7dwhphlWF6qDvBdFemE4u7QVegaxDpqe
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=gHfW8GsfNg_571oCiZMA:9
    a=TP3JRWg6e6J6SPuL:21 a=Oa0-ItCZej9EOn35:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeDCVhl (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 17:37:41 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51731 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753289AbeDCVhj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 17:37:39 -0400
X-Google-Smtp-Source: AIpwx4+kuAYDj2Ojh46mkfpQH/rFn4mSMfrBQU5vaz25PBmqkpiWIOPk60wqcojOJccJdWwbijF9Nca8tJjTOoSC8ws=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com>
 <CACdnJuuXOP5T-BRAwMvc7XF8S49wyvp4ZYgcU=EZkaGNgPAQig@mail.gmail.com>
 <CA+55aFzGFZT68ih446DeQbB69Fyk_wT6b7PGq0iz-gctUGQq_A@mail.gmail.com>
 <CACdnJuvheCbuvTLyDWMQWcUytc4EvuSUaEKywfEX8Kp6qYL9dg@mail.gmail.com> <20180403212102.GL30522@ZenIV.linux.org.uk>
In-Reply-To: <20180403212102.GL30522@ZenIV.linux.org.uk>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 21:37:28 +0000
Message-ID: <CACdnJuvfDugkqZeW-0Y=vH-Gr+SpnnH7boRD5WygMff+rYXMug@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 2:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Tue, Apr 03, 2018 at 09:08:54PM +0000, Matthew Garrett wrote:
> > If you don't want Secure Boot, turn it off. If you want Secure Boot,
use a
> > kernel that behaves in a way that actually increases your security.

> That assumes you *can* turn that shit off.  On the hardware where
manufacturer
> has installed firmware that doesn't allow that SB is a misfeature that has
> to be worked around.  Making that harder might improve the value of SB to
> said manufacturers, but what's the benefit for everybody else?

This is why Shim has support for its own key database, as well as allowing
you to disable further signature validation. If the hardware supports third
party code at all, you can just use Shim to sidestep any unreasonable
restrictions the vendor has imposed.

(This doesn't help with systems that don't support third party code at all,
but this patchset does nothing to make that worse - that hardware wouldn't
boot your own kernel before this patchset, and it won't afterwards either)
