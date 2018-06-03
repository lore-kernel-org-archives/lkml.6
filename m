Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2437239-1528043954-2-12027438862547437678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528043954; b=fzCcX9mZ7rslQAVBfKL/oreLG0/AJDuMProS5dXA5j6o7fitjs
    qthiIpLMtYzc7Hs21ucrQNehcXdJcAnxU/ezWUgMNS7fE2qDcuqRP4uxmXmRh0W9
    RrLCQwkViQuzp3g1QUHVqfG5baq8ILov4L3/8DBIHtWY/227GyNs/QCWyC24YKMi
    YmDsnpoevNs15xAlukimk965+w2anQR7A4KLpYMSVoxKruUgKxNWPJeEUuYmOWnC
    7eQ3ju0QmQ2tE3FNVnDFg+ULSYtMFmJL0BFrr9eR/31Q3kmq8HFfAWOxz1gR1bRW
    ouKo5eJqPMCgr8tlHPrAeuYRNPuiBG1GkAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528043954; bh=vS7j51PvHwm9qN1yIjIQGjaBmQbxOJn4VfHLqpIzOB
    E=; b=luKVBifRS5TGQnj5zOxyKAkcEVv5UiEyr7zBbV5f6aM+yMDTosW3ggYZdX
    qLjNV5jglQByES9g/mR2J4+Dk3npnI0LzP258PWHBCpopyqagXm8HN0Zt4vnRI7d
    6WSV3Hm/jc8rSlsUK3dkTW7eRrfwbReRmx/7CtYlKkjE/6un53KpfjpFx5IgjvNi
    cUslq61uglkFd8dAvlnmDbBMvTqlbRY+aTaz0g7jys5+k2mUXOxO1gchPk5N9IzF
    OlGIqrq/uoA4DTIGIhoeY5SQzON9uwPjgaokNQqL2ad/S66Coo//O64bxpebLI7S
    WI5uOgXpmImx8IMiam+AgWTYFk6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=IkX0zX7/
    header.a=rsa-sha256 header.s=google x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=MDqmXAlb;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=IkX0zX7/
      header.a=rsa-sha256 header.s=google x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=MDqmXAlb;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLxZsiJbq2BuyKFDP0nrDTlioSl6IfJEaP+gWGwffxEGI+pfzmPWnzwgtNrhrpBYkrDVK6a1h0jpZPxUrIQQnmYkxnICE5fvywGwln/kZeiQa8bmLSF8
    fnpbxgsenZnLujtF/wwXTebPB4tW+sk24lT+yLNkzxIMRgHwHRa5SaxH9P0fIdnukD6/7FCkpButYa4p1jG53w7lblBDEHyLUCwhIvLqP1tfBofpZjqPEtLy
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=l86AJcckYjSKc5PuxVYA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeFCQjM (ORCPT <rfc822;linux@kroah.com>);
        Sun, 3 Jun 2018 12:39:12 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53797 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeFCQjL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 3 Jun 2018 12:39:11 -0400
X-Google-Smtp-Source: ADUXVKJPU8We1yHgIxdebOyodhOcrNzVl8JtTC0LJBEHtGF3B6euYFlko6shW3FtHSJDs5FpBadcaXRytDHxyeXmcaM=
MIME-Version: 1.0
In-Reply-To: <CALCETrXC2iuvHnTsnz=6Z_OqeMhiv9aSs372cGpsii021jsZrg@mail.gmail.com>
References: <20180601125330.25054-1-hdegoede@redhat.com> <CALCETrXC2iuvHnTsnz=6Z_OqeMhiv9aSs372cGpsii021jsZrg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 3 Jun 2018 18:39:09 +0200
Message-ID: <CAKv+Gu9v+BUTySe=0OWmjPSCe5qShO5r4P4Np7M8q2jR_tMcDQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] efi/firmware/platform-x86: Add EFI embedded fw support
To: Andy Lutomirski <luto@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>,
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Torsten Duwe <duwe@suse.de>, Kees Cook <keescook@chromium.org>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2 June 2018 at 05:39, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Jun 1, 2018 at 5:53 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> Here is v6 of my patch-set to add support for EFI embedded fw to the kernel.
>>
>> This patch-set applies on top of the "[PATCH v7 00/14] firmware_loader
>> changes for v4.18" series from mcgrof.
>>
>> It now also depends on the series from Andy Lutomirski which allow using the
>> sha256 code in a standalone manner. Andy what is the status of those?
>
> They're currently sort of on hold, since Jason Donenfeld is working on
> a more comprehensive solution to the same problem.  Jason, I don't
> suppose the sha256 part of your patch set is ready?
>
> Ard, if Jason's patches are too far in the future, would you be okay
> with merging a cleaned-up version of my patch for sha256 even if the
> sha512 equivalent isn't there?
>

I'm not sure what you are asking me here. I'd be fine merging a
version of Hans's patches that uses a suitable cryptographic hash
algorithm, but the implementation of that would likely belong
somewhere under crypto/, and so it is ultimately someone else's call
(although I'm happy to review)
