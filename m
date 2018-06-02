Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-55656-1527910775-2-13930539767124071642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527910775; b=Q3NBn9cbT+9gnJtx49sLCJrKJR9rVI6Jxvua/6Hik8Fg+1lPeC
    T/sNi6Ywbstd13qEItwQHa+w8DX/KumH9uev9KPQ9XGhIFx6jYd8sjCUH9fOZy22
    m+ewoZGsYCnTsgMiPA3PGLbYa6M248jeQ4VZ6RNW+vJXz8AAeK7C5ETh1Fo7k2NX
    axGUxS65VLQoimp1N0is3b4/Yn2/fjI66NcwHep9Ivl+LlG0Qpkfwijqbsxdhtt0
    H0O4L406JNSS6aQg1B6ZMp6CaYzi35m82DXuD8t4fFW0kyOxKYkRW3p6IV1GnqUb
    BMRz2Q2YGI+gclVOJ+U6yN4Mcj8TZSPmSqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527910775; bh=YUazMft1zsQZXHu+Sz5wCC1Gml/zE/xpBJ7/BZmgzb
    4=; b=DVYog77dpbrgALtLYgsOWBd0LWlKGI6RTV84OFpWc5aCzks/VlbGVvloYb
    TAXJ3TCSuwIsamLNYzQdhHPk6KYgS0nbOkFn4CzNvJkCi5Ach9rZgCiC3xOUhC7T
    86uqARwO+96skcinrsZD64rNn/rHMckNUU3wVv8dqJdiDBbs6qb2qS7BQcXg1BG0
    xjkeUWHp5rndF06iucn73tq8DsMyziDiyDaYnw5i7slMvdKSInSro0ajgzfXqVD+
    JSTIiph2GpXBmfnnW4MCCTiT1b+BKtMfId5+Zk17SRt4Tb1WOLXfWuK/mxOZxSbD
    MC5YhzKlvejiGRZgQTQG5cSM6zpQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=ns5r9fOZ
    header.a=rsa-sha256 header.s=default x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=ns5r9fOZ
      header.a=rsa-sha256 header.s=default x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMC7E3quaPLPnHnjoSibASwf3fwma2bRNwK5JK27Iy6XyI9zkjpg+ZKWBq9skq1xtgqjOlM1Yrxf7VAxjTGzkcprDR/3dJByBTGHq14AVv9j8riLXscx
    r8Acw3tN3LMPSc47TabXs6sibf/xUHe+cp1QbVXn+5Woq0xn49LPSRqaT/N+AD89JXKxVhrMufdm/mGYbYkKKHB/sV4PkGjcoT0DdBOMUlfnEqABsv8OM4UG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=g9tGcsPPlB6mxVtQ2qAA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750905AbeFBDje (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 23:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeFBDjd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 1 Jun 2018 23:39:33 -0400
X-Google-Smtp-Source: ADUXVKIUzzsrekHR0nbM9axLBDQIrsj5YZ0S212SJSKNTY7XHXUMAuxXSXiSAZDG0nC2S5NKzc46rjM9/5R13DQ0Ymg=
MIME-Version: 1.0
References: <20180601125330.25054-1-hdegoede@redhat.com>
In-Reply-To: <20180601125330.25054-1-hdegoede@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 1 Jun 2018 20:39:18 -0700
X-Gmail-Original-Message-ID: <CALCETrXC2iuvHnTsnz=6Z_OqeMhiv9aSs372cGpsii021jsZrg@mail.gmail.com>
Message-ID: <CALCETrXC2iuvHnTsnz=6Z_OqeMhiv9aSs372cGpsii021jsZrg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] efi/firmware/platform-x86: Add EFI embedded fw support
To: Hans de Goede <hdegoede@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>,
        dave@bewaar.me, Will Deacon <will.deacon@arm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Martin Fuzzey <mfuzzey@parkeon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Broeking <nbroeking@me.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, duwe@suse.de,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Jun 1, 2018 at 5:53 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Here is v6 of my patch-set to add support for EFI embedded fw to the kernel.
>
> This patch-set applies on top of the "[PATCH v7 00/14] firmware_loader
> changes for v4.18" series from mcgrof.
>
> It now also depends on the series from Andy Lutomirski which allow using the
> sha256 code in a standalone manner. Andy what is the status of those?

They're currently sort of on hold, since Jason Donenfeld is working on
a more comprehensive solution to the same problem.  Jason, I don't
suppose the sha256 part of your patch set is ready?

Ard, if Jason's patches are too far in the future, would you be okay
with merging a cleaned-up version of my patch for sha256 even if the
sha512 equivalent isn't there?

--Andy
