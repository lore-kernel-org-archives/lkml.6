Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3157214-1518623380-2-8322340655549220449
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518623380; b=LosUOXhbYcNWQw5+oS4boGp/EwbR3n/lMVEZjauOe7CHK01
    3BU9dj62C9ls00fLvq8ATDUmf89b4OZkCJ6Vy2+Rz3JSh+66ciI0Z7ZFdZvwEqja
    FQiRca79m3cTSFC5bMnO6cQOZGFCvVMfy339zqzlXLNL+zfKs0gKwM1PbtfIt9sz
    4mQR3Kiz97NEzaYv/FSVv7mrvM+O49OTeFgi2OcZNgv6WksPNoNHbFl9KYmZpcuW
    ZMtZraBV3++bmvWUL5mL+yMx1JXhjhHeZvETcACwjmXQO78Jd8TArz64OR4/Vd0x
    Py/Dbqi6xhJXrz7ddf/Qg38gmH2WVeUbCjeBIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518623380; bh=rvSNiWBwsiKV1HqyhIwEptkxqdd45mfiRaN10r
    IOqmA=; b=hMXliDp6/htlkPnDBJTk9btBLW63YaDK/rsgA1QDqCIXbVsS6FMoKU
    5xzHhl0lim0pd0D0uB2JPnvLhLWyKgfibOhS/ygPLE834n598XK+KPvQkAZwW6N6
    m7Qi+WswAlOdxn0A9FknCZeqkkQR79Uc5wa+AqbEz/Tl8DTIw+k9TH8owranwrZR
    pP9FW09WMacZU2DOVM5RET5B9yTrUFisGBBdbYOLtVClsUVRw7QfBtJmG4M8oNLl
    ELhPMAoM8h60n2OI4KalBI7T39teBJZ7HlSLB/TjimAaQBcGOiOoLxk9jT1L1y9f
    H5IbAmO4Act+4/VaW2+b13ZJJGCanGjg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OIKlBV5s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kKj2nzmu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OIKlBV5s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kKj2nzmu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031789AbeBNPti (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 10:49:38 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:32774 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031769AbeBNPth (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 10:49:37 -0500
X-Google-Smtp-Source: AH8x227GMC8O/cshrTPhcEoncjAAh22GuiOXVVlmCp/Yp1AoCP53xcsqbDQTOI7+WjZbwHO1ETSg1SrJIQaKFoZ8ju4=
MIME-Version: 1.0
In-Reply-To: <20180214154033.GA2745@kroah.com>
References: <20180212113801.2552-1-ard.biesheuvel@linaro.org>
 <20180214135420.GB24189@kroah.com> <CAKv+Gu_uqudgFU1_+cWZtvyQmZMxjCYuUr-2L59yEfoY8EyWQA@mail.gmail.com>
 <CAKv+Gu-D6E02FE+zaqbksM_w-S_y8ueNGc=xPDAieJHjKp1=bg@mail.gmail.com> <20180214154033.GA2745@kroah.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 14 Feb 2018 15:49:36 +0000
Message-ID: <CAKv+Gu8hfhoSC9Zs75E6_NWxQZXC5pgVp3c7JT9qFxaRPAZSMA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for v4.14-stable
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Brown <broonie@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 February 2018 at 15:40, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Feb 14, 2018 at 02:34:01PM +0000, Ard Biesheuvel wrote:
>> On 14 February 2018 at 14:24, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 14 February 2018 at 13:54, Greg KH <gregkh@linuxfoundation.org> wrote:
>> >> On Mon, Feb 12, 2018 at 11:38:01AM +0000, Ard Biesheuvel wrote:
>> >>> Hi Greg,
>> >>>
>> >>> As mentioned by Will, I have created the v4.14 counterpart of his stable
>> >>> backport of the arm64/ARM Spectre/Meltdown mitigations that have been pulled
>> >>> into v4.16-rc1.
>> >>>
>> >>> Given that this is the v4.15 version backported to v4.14, I have removed any
>> >>> mention of 'conflicts' from the commit logs as they are now ambiguous. The
>> >>> patches applied surprisingly cleanly, I only needed to drop two patches that
>> >>> are already in (the same ones Will mentioned in his PR), and drop another one
>> >>> dealing with SPE, support for which did not exist yet in v4.14. I also included
>> >>> the patch
>> >>>
>> >>>   arm64: move TASK_* definitions to <asm/processor.h>
>> >>>
>> >>> from v4.15 to make Robin's Spectre v1 patches apply more cleanly.
>> >>
>> >> I've queued these up now, but if you could pull the whole quilt tree and
>> >> verify I got things right, that would be great.  There was some
>> >> conflicts with a few previous patches I had already queued up that
>> >> touched some "Falkor" errata code.
>> >>
>> >> Specifically 932b50c7c1c65e6f23002e075b97ee083c4a9e71 "arm64: Add
>> >> software workaround for Falkor erratum 1041" is the offending patch.  I
>> >> think I resolved the merge issues properly, but verifying this would be
>> >> wonderful.
>> >>
>> >
>> > No, the build is broken now. I will investigate.
>>
>> Your patch 977c3d2cb684e143a18e1564fbf5ecf7576a1c98
>>
>> arm64: Move post_ttbr_update_workaround to C code
>>
>> removes the pre_disable_mmu_workaround macro from asm/assembler.h but
>> it should only remove post_ttbr_update_workaround
>>
>> Once I add that back, things seem to build and run as expected.
>
> Can you provide a "fixed" version of just this patch so I know to get it
> correct?
>

Sure. I will send it in a separate email, or Gmail will clobber the patch.
