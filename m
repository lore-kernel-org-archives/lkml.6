Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9C516256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2292920881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TyndbDM3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BZOVqvM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2292920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeG3ShG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:37:06 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41269 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeG3ShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:37:05 -0400
Received: by mail-yw0-f196.google.com with SMTP id q129-v6so4626394ywg.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oFaRyuf4+qydY3RMx1mQ50w+ttRntvwrBUNMdd7cS1Y=;
        b=TyndbDM3LeJyUpkRsEbnk0ESxESbpqtWhrR9gdTvNakWyK9GYONyUFIEwsfpNNlVZb
         9MAcU3QNns0LVR/gnW3umwStgDugYwspmMqxWZENTnNAJILXslQroOBmU476Mw4vSn2c
         T1w2ua0cl7lAYjvB6NX7I4waWUWHcyS7PdY02172FWCeyU44lsMKghLBInwMkcXe5f3K
         WW6BiXJwHm9jr6lSPrxS8W1WpqqotAlDZ2sav7CLk78MfnCeLC3cb2ew+Y7wG2Ur8ajj
         36EhR+nKW1vwV5cWkI3/9RiQwDuThe+1U/3B6iwmYN3YqMWpn6BIlXJsmjuzoP5Hag/j
         QtaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oFaRyuf4+qydY3RMx1mQ50w+ttRntvwrBUNMdd7cS1Y=;
        b=BZOVqvM7XRf59aogjF8ghuYSiQnACFJzBWr2QhHYXg//bZyK/k1Zl4nHcPb1vzvw0W
         4AUBQ0JjqYzuGtiXwDCj4LZFtslhcmH3lDxzvRydGvY4heOYgnnr5/Y39HSkAHNsJLSQ
         9DYsq+qPLlwzpjCcWs2kdS+CILxBFYG9rgH4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=oFaRyuf4+qydY3RMx1mQ50w+ttRntvwrBUNMdd7cS1Y=;
        b=cN6hJKYpgLGvNfnbe4rJ/PhPzObFKLKob7Ji3uifBXESERxosCrFlwm/MSQTCpn0ti
         U0bp2h3ydS1BZYfOS9F5hDqw2oweid4iP/iLVV4BZTiI1b4LVTg7MqmhnSQjxb7jJDKV
         Xm4Oh84iDQYcq5VkZ4YyS1383O++yPk9lscr5mUpq48yIWK92x4hPhsPB4xTgPkAo1Eb
         G9gPfcHow0OpFv57KM5Bt0K8nlVS7+t/m7B/WnW85BS4CIvZ35gj8T2PGrL7xIDWPSN2
         WZmVpGAquBwL6aHTrJMi6U/LKhsbDHnot+UebUL1u6Y5kVEhXIAbBK6jnz84MvnJIhWT
         glEw==
X-Gm-Message-State: AOUpUlFMgf2x5y9gLQParnATHM5EpPNMXDj63RlW5lxJ6pRChPS6zLsS
        hsVyTqDDLZBGaTAkWy5svdn02CpZcL10CbRz/FewKg==
X-Google-Smtp-Source: AAOMgpeWcmSwbVgo0ODj/v9kpJ5mKpcG27HM2CHlouyd9j/mxiLDS+kWq18V63z/J0WDfZ0dPeG55MN4yFgWOM7jsAU=
X-Received: by 2002:a81:39d7:: with SMTP id g206-v6mr9458192ywa.416.1532969670692;
 Mon, 30 Jul 2018 09:54:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 09:54:29
 -0700 (PDT)
In-Reply-To: <CAJHCu1+S_tv8Ju4m_QuWPm5Ke6rmByxT7jVhSo2kfVoCO_wMFg@mail.gmail.com>
References: <1531935483-30784-1-git-send-email-s.mesoraca16@gmail.com>
 <CAGXu5jK4q6HLDZ6jokTeDABbzVasY85Jo0HFNKYeaKWZYPjPKg@mail.gmail.com> <CAJHCu1+S_tv8Ju4m_QuWPm5Ke6rmByxT7jVhSo2kfVoCO_wMFg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 30 Jul 2018 09:54:29 -0700
X-Google-Sender-Auth: CyL59wOYuNvpxSEI_vOZ-62k8CM
Message-ID: <CAGXu5jJCwAO1u4U0hAqAnd3ktgR-WcDzNUTpTeGoiUNVOzbYFg@mail.gmail.com>
Subject: Re: [RFC] kconfig: add hardened defconfig helpers
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 9:11 AM, Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> I'm sorry for the late response, I've been unexpectedly busy in the last week.
>
> 2018-07-20 7:15 GMT+02:00 Kees Cook <keescook@chromium.org>:
>> +lkml, Masahiro, and linux-doc, just for wider review/thoughts.
>>
>> On Wed, Jul 18, 2018 at 10:38 AM, Salvatore Mesoraca
>> <s.mesoraca16@gmail.com> wrote:
>> [...]
>>> +CONFIG_CC_STACKPROTECTOR_STRONG=y
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +**Negative side effects level:** Medium
>>> +**- Protection type:** Self-protection
>>> +
>>> +Functions will have the stack-protector canary logic added in any
>>> +of the following conditions:
>>> +
>>> +- local variable's address used as part of the right hand side of an
>>> +assignment or function argument
>>> +- local variable is an array (or union containing an array),
>>> +regardless of array type or length
>>> +- uses register local variables
>>> +
>>> +This feature requires gcc version 4.9 or above, or a distribution
>>> +gcc with the feature backported ("-fstack-protector-strong").
>>> +
>>> +On an x86 "defconfig" build, this feature adds canary checks to
>>> +about 20% of all kernel functions, which increases the kernel code
>>> +size by about 2%.
>>
>> bikeshed: I think both stack protector items should be "Low", but
>> that's just me.
>
> I tried to be cautious when selecting the levels, but if nobody is
> against it, I can change the level.

My thought about the "Low" stuff was: if a distro has it enabled by
default, it must have been decided it was a sane default. So for
things that distros have enabled, set it to "Low" here. (Which is why
I cringed with KPTI: distros have it, but wow does it hurt...)

>>> [...]
>>> +CONFIG_DEVMEM=n
>>> +~~~~~~~~~~~~~~~
>>> +
>>> +**Negative side effects level:** Extreme
>>
>> Why is this extreme?
>
> I tried to be very cautious and I had the impression that this option
> could break many programs,
> isn't Xorg one of these?

These days, (almost?) all graphics drivers run without needing
userspace access to these things (and I think they never needed _RAM_
access, just IO space). Setting this to Medium or High seems better to
me. (The STRICT_DEVMEM, though, should be Low, since that's been a
distro setting forever.)

>> [...]
>>> +CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +**Negative side effects level:** High
>>> +**- Protection type:** Self-protection
>>> +
>>> +With this pluging, the kernel will instrument some kernel code to
>>> +extract some entropy from both original and artificially created
>>> +program state. This will help especially embedded systems where
>>> +there is little 'natural' source of entropy normally.  The cost
>>> +is some slowdown of the boot process (about 0.5%) and fork and
>>
>> This doesn't feel like "high" to me.
>
> Medium maybe?

Sounds good.

>> [...]
>>> +CONFIG_PAGE_POISONING=y
>>> +~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +**Negative side effects level:** High
>>> +**- Protection type:** Self-protection
>>> +
>>> +Fill the pages with poison patterns after free_pages() and verify
>>> +the patterns before alloc_pages. The filling of the memory helps
>>> +reduce the risk of information leaks from freed data. This does
>>> +have a potential performance impact.
>>> +Needs "page_poison=1" command line.
>>> +
>>> +
>>> +CONFIG_PAGE_POISONING_NO_SANITY=y
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +**Negative side effects level:** High
>>> +**- Protection type:** Self-protection
>>> +
>>> +Skip the sanity checking on alloc, only fill the pages with
>>> +poison on free. This reduces some of the overhead of the
>>> +poisoning feature.

So, I spent some time looking at these again for unrelated reasons and
rediscovered that enable CONFIG_PAGE_POISONING has virtual zero
overhead since the actual poisoning doesn't happen unless you turn it
on with a command line argument. So I would classify both of these as
"Low".

>>> +CONFIG_PAGE_POISONING_NO_SANITY=n
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +**Negative side effects level:** Extreme
>>> +**- Protection type:** Self-protection
>>> +
>>> +Skip the sanity checking on alloc, only fill the pages with
>>> +poison on free. This reduces some of the overhead of the
>>> +poisoning feature.

This one, though, yes, Extreme or High. It makes things much slower.

>>> +CONFIG_PAGE_POISONING_ZERO=y
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +**Negative side effects level:** High
>>> +**- Protection type:** Self-protection
>>> +
>>> +Instead of using the existing poison value, fill the pages with
>>> +zeros. This makes it harder to detect when errors are occurring
>>> +due to sanitization but the zeroing at free means that it is
>>> +no longer necessary to write zeros when GFP_ZERO is used on
>>> +allocation.

This one is interesting: enabling it with poisoning means you gain
back some of the performance hit (since now GFP_ZERO allocations don't
need to do any work: the space was already freed), but you lose a bit
of coverage since a write-after-free will not get zeroed at allocation
time. So I think I would set this as:

CONFIG_PAGE_POISONING_ZERO=y
at Low

CONFIG_PAGE_POISONING_ZERO=n
at High (or Medium?)

>> [...]
>>> +CONFIG_STATIC_USERMODEHELPER=y
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +**Negative side effects level:** Extreme
>>
>> I mean, this SHOULD be Low but no distro has actually implemented a
>> helper to do this yet.
>
> Infact I set it as extreme because I expect very few people to make an
> use of it.
> Maybe I could just drop it.

Until it's actually usable, yeah, I'd say drop it.

> [...]
> Thank you very very much for taking the time to look at this very long patch!

You're welcome! Thanks for _writing_ it. :)

-Kees

-- 
Kees Cook
Pixel Security
