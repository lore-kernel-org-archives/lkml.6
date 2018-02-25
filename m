Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-153198-1519573520-2-4215891650858890695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519573520; b=ZEA1hu3fEeoKXvSQHLulKfOraTvCEn/00Gfitu+i7YLvkJx
    UFaTJDa9vRhYzn6/YyMJyyWj9BHPswSMWzyiJtUTIux+OS/k9sevcu8VEd+wj6Lz
    uST3q6A70YaxNcalkzmKnGXOE+FgwwgQUAuEW/R+R6yHX+45I8iohsZoxObkNm5h
    yk1KzHWOfpC34zo1wMKsXOXu4UqC658pLr0LZlij8ulP9uwH3N2MRcJHUdLEx3wW
    VPhX9O/oec3LyGS4j4W/7zHlv3FoqKmT0ZGOLA74JKgxmZYHEzTqA2E+HgqhIjJS
    n3QOwMiQy7yPWAINWROvDGrx4gvownbpFK0YLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519573520; bh=+dT5irPRDPviYdZbyj55+ij4R0pOtzFZhh28Rj
    d6Syo=; b=No8XeHXuHEJPC0WdAehKR4+eAJzvTd+aBsC68+UkVO3P2CYsXQp1Ol
    ZlRLpO27q7aPxWt7dNtK9ImzA7OjLWIDPE1q3DMZe0eU3JaUK4Jl7qtSd8xmazgP
    lKSzrXL1G6aolqa+peYoItGU9NvItAP2qbGmSka5XaxpzmYjrXBZHfQwWS72UapA
    2xlJRJHFYpm6S2HnvGUBvVdRlEfUSDff+/WFvbdtCueE0PdcSdXdZ+6AIIBhdWz3
    IoPeYIOWJ3DPwDc4Tz67nhZFh+B6cz/Gxtdw5RNyH0eXFpEHpRy8zjff2zG/fjFa
    z80ZjUvQrGWYKVhghPiaC8Um8vUEZGdA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uDT2EjCc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uDT2EjCc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeBYPpF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:45:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51223 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeBYPpD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 10:45:03 -0500
X-Google-Smtp-Source: AG47ELtfG4EMp+c1jYVVJb7SGNMGgi8aYP7dRsTaoHNCGReuP3JNCafpWxud2JOonVjzYqH+7bifscaXjPmUy/kVrGc=
MIME-Version: 1.0
In-Reply-To: <20180225151821.GA20478@bombadil.infradead.org>
References: <20180225123833.31299-1-kai.heng.feng@canonical.com> <20180225151821.GA20478@bombadil.infradead.org>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Sun, 25 Feb 2018 23:45:01 +0800
Message-ID: <CAAd53p74haT9+cwVcToV7OSCxeuJM4sDhadBYvTvD7ZwzdOimQ@mail.gmail.com>
Subject: Re: [PATCH v3] usb: core: Add "quirks" parameter for usbcore
To: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 25, 2018 at 11:18 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Feb 25, 2018 at 08:38:33PM +0800, Kai-Heng Feng wrote:
>> v2: Use in-kernel tolower() function.
>
> ... why are you using tolower at all?
>
> You've got 13 quirks already; you may need to use upper case as well
> before too long.

Makes sense. I'll remove tolower() in next version.

>
>> +             quirk = vmalloc(sizeof(struct quirk_entry));
>
> vmalloc?  For a struct that's 24 bytes?  You know that allocates an
> entire 4k page, right?
>

Right, I'll use kmalloc() instead. Or is there any more efficient
malloc function?
