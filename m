Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526282080-2-2774128409417502614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526282080; b=KFu2ji1syqUlMPVbfAOMfD6znRIjXQfkGHD3p7uyIOsEXl/tgv
    fPw3uwaw9i6pu7Io2UZJx/MUWou35GscexASdoAx1h5RqyJRGy86sgmPx+BKePnk
    1PESfy7Pt4n/kuYHfaM9g8+P0pEM8fk+L0xlMUi6Q32+Q5Eo7uWS+/BUzOuOeymT
    22+4z+COJrM4KUVavN5rQllCkSSg2yTeMQsiwVDzw/HQ6VFbnEwb8n6J1z6QtIDO
    U04Qdlf00do37Yz6dY4L7QNEa0JUee4RiqYzJh/6CrBk7FuINRfiz12h7gMH7JX9
    32qCh/Z02H9ZvwBFTKPq2l5iW8feudCrMKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526282080; bh=IQt3QNDdtZ+etZjhZ9pOf4l+6quCTr
    pNFSJ+dm+iGoo=; b=lraqExZ2vGmZ3D+5XHwYK0w+Rsd7Nq2YINnrpqs6yA+91E
    O+7XSpQ7aQSaoMR0ELggfDtKbD15mli4jjUa/esMv1gEsqs+G9Wlepe4ZSkMXrEy
    v8VR8U8wZVXmysi9njet8piYraa4nBvOnPcmlUeyTFsgWHXAns07vKq00W3FEQhw
    qPza/MU8xdG2hz7yZ5XV5UU5ejfjuxQft9h6riHTDd1+4Kd6azc7icraH0P2cA74
    sYsZLE0F4+BJYh8qpj1vsnOVgh6VAscg6mkEZ1d7fzN+sJZ3pf1zGogoNZRkHKgK
    c6MuTuv5hi0v0EkqJtnr4jUFfQfAbRdk3HUDtc5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=oE9BpAFG x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KwCTwkk1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=oE9BpAFG x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KwCTwkk1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGszoh8pw8gEaue3Xa8FAkSZvYUz4cNcc+29R8Hjtrp32cAqGr0d/sQ54G2kndI/BR4ViDDP74hgyUUoOKXxvwm4a7fl4S7MG0Xff+m+0t5Jb3UUfrPR
    dqTciuKe+6Fg06MhML7AxQ/YpjKZ5ec1FgsHpA3/369GCEbKbyIxvrBizdvt0F27vHyp3C0MfN2n1n4z4Do8sB+oMm6d49t5ZJ4ZWzm0fzYcY8vbthCsrCVY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=njYEvQF1GSc67On_AgkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeENHOh (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 03:14:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40797 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753723AbeENG5s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 May 2018 02:57:48 -0400
X-Google-Smtp-Source: AB8JxZo7cyDkSAsESfL50ktFYNBPRhXsp7aow0msUK2gFnyRJE0WEAIXryQDnK3EZ3Nj3KboUbErfQ==
Date: Mon, 14 May 2018 08:57:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] efi: fix efi_pci_io_protocol32 prototype for mixed
 mode
Message-ID: <20180514065744.GD16596@gmail.com>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
 <20180504060003.19618-13-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504060003.19618-13-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Mixed mode allows a kernel built for x86_64 to interact with 32-bit
> EFI firmware, but requires us to define all struct definitions carefully
> when it comes to pointer sizes. efi_pci_io_protocol32 currently uses a
> void* for the 'romimage' field, which will be interpreted as a 64-bit
> field on such kernels, potentially resulting in bogus memory references
> and subsequent crashes.

Yeah, so the first confusion I ran into is:

 s/efi_pci_io_protocol32
  /efi_pci_io_protocol_32

Once I found it in the code I made this change:

 s/efi: fix efi_pci_io_protocol32 prototype for mixed mode
  /efi: Fix 'struct efi_pci_io_protocol32' definition for mixed mode

Because we normally use the 'prototype' name for function declarations, not for 
data type definitions. Adding 'struct' and putting it between quotes makes it 
obvious at a glance that we are talking about a structure definition here.

BTW., since it's marked -stable, due to:

 > potentially resulting in bogus memory references
 > and subsequent crashes.

I'm moving it to efi/urgent: the principle here is that if a patch is urgent 
enough for -stable then it should generally not wait for the next merge window.

Also, because this actually fixes a crash, I extended the title to spell this out 
more clearly:

  Subject: efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32' definition for mixed mode

... which also makes it easier for maintainers of older stable kernels to decide 
whether to backport the patch or not.

Anyway, the patch is looking good otherwise, no need to resend.

Thanks,

	Ingo
