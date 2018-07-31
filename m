Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A6BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2693A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmoZxou1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2693A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbeGaJWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:22:49 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33540 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbeGaJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:22:48 -0400
Received: by mail-vk0-f66.google.com with SMTP id y70-v6so7033031vkc.0;
        Tue, 31 Jul 2018 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aKQiLLuW4DpWJnlD9EIEKvcLbFU/4kAI5GS0dKACVLM=;
        b=kmoZxou1RO5etsGi8LUAcgU5U7a2L6Aq+NplItV6V/S8pnYrGfvCwETmcIlhVK7OGk
         Zn2xdm88vSetgHtAwn8qM9cQRmkn2stZSwuWsAfmjd0lMZYHHJHAg9AlzlQGUaFeQLJQ
         O8MgJTwuYynULPitoc/spniV6t2pFKhkN0vI5brucc96dAjB9KZo/QzxtOds6MPy59nH
         RSXy0jml/uwF4Ll6NYwy3/fBSkzhDpxaA1xqk8aCtyosffFXvTdrq8DcEFf2iYsuBNRq
         Sc1b2/BlkOOKr3Lp+8/sPTwmIbyNwqf0YMuZBfC3KOmbpqe5QXuQmf/V1U/G6tmYa5Mg
         DRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aKQiLLuW4DpWJnlD9EIEKvcLbFU/4kAI5GS0dKACVLM=;
        b=iJKlS0Et0djU9R8ni6C3JStzWA0h0dkHnlj5b3NZsRYtR6eRFQ+4en7saBxWqWahEv
         tem2IihzyiQU7ikL9tqCZLcxgHWWPxBceQOMM790Q23oXdSjWQIzDr67Ow7NJQtgnd+X
         Eo/MbOD5gqHUPqpP6zjwaFG5zcEVvVLNDE7WE3e8QIj0DTrnKS2NGvb3lza1nQTPtQ1j
         5DLC2f2Prhv1jTGpPlItnf70gFZQVtBDmem3IB8+sysyjnF43lTe/1Nn+1deiNuulODG
         aoPjuicgw6R8R6iE8IgPKzzB5ItsEWX0e1HFX9t44/RAb/vOsjdzt0X0PpEPoKT/iFL0
         y+QQ==
X-Gm-Message-State: AOUpUlGWuKsOYmSeDT0+AfzYZ4vgV1/MtdffYpz8j+O8fBVBBShkpOz0
        vd4UdsFOqjOH7t9cewZ8AcbXu3C88awxGllztDo=
X-Google-Smtp-Source: AAOMgpeEM3aJuksX1MvFSPmMeO4dK6+B+X8nyIdMRebuoPfH/feZKF/cR2JMnD+wLZ4hdlR08QaRyXdWDOIDb0KtDgw=
X-Received: by 2002:a1f:5981:: with SMTP id n123-v6mr13216185vkb.43.1533023026686;
 Tue, 31 Jul 2018 00:43:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7cc8:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 00:43:26
 -0700 (PDT)
In-Reply-To: <CAGXu5jJCwAO1u4U0hAqAnd3ktgR-WcDzNUTpTeGoiUNVOzbYFg@mail.gmail.com>
References: <1531935483-30784-1-git-send-email-s.mesoraca16@gmail.com>
 <CAGXu5jK4q6HLDZ6jokTeDABbzVasY85Jo0HFNKYeaKWZYPjPKg@mail.gmail.com>
 <CAJHCu1+S_tv8Ju4m_QuWPm5Ke6rmByxT7jVhSo2kfVoCO_wMFg@mail.gmail.com> <CAGXu5jJCwAO1u4U0hAqAnd3ktgR-WcDzNUTpTeGoiUNVOzbYFg@mail.gmail.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Tue, 31 Jul 2018 09:43:26 +0200
Message-ID: <CAJHCu1LN4YkLqqT6TBEDw8YoW81VCvKnQam+v0NTvu1kDLMvsQ@mail.gmail.com>
Subject: Re: [RFC] kconfig: add hardened defconfig helpers
To:     Kees Cook <keescook@chromium.org>
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

2018-07-30 18:54 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Mon, Jul 30, 2018 at 9:11 AM, Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
>> I'm sorry for the late response, I've been unexpectedly busy in the last week.
>>
>> 2018-07-20 7:15 GMT+02:00 Kees Cook <keescook@chromium.org>:
>>> +lkml, Masahiro, and linux-doc, just for wider review/thoughts.
>>>
>>> On Wed, Jul 18, 2018 at 10:38 AM, Salvatore Mesoraca
>>> <s.mesoraca16@gmail.com> wrote:
>>> [...]
>>>> +CONFIG_CC_STACKPROTECTOR_STRONG=y
>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> +
>>>> +**Negative side effects level:** Medium
>>>> +**- Protection type:** Self-protection
>>>> +
>>>> +Functions will have the stack-protector canary logic added in any
>>>> +of the following conditions:
>>>> +
>>>> +- local variable's address used as part of the right hand side of an
>>>> +assignment or function argument
>>>> +- local variable is an array (or union containing an array),
>>>> +regardless of array type or length
>>>> +- uses register local variables
>>>> +
>>>> +This feature requires gcc version 4.9 or above, or a distribution
>>>> +gcc with the feature backported ("-fstack-protector-strong").
>>>> +
>>>> +On an x86 "defconfig" build, this feature adds canary checks to
>>>> +about 20% of all kernel functions, which increases the kernel code
>>>> +size by about 2%.
>>>
>>> bikeshed: I think both stack protector items should be "Low", but
>>> that's just me.
>>
>> I tried to be cautious when selecting the levels, but if nobody is
>> against it, I can change the level.
>
> My thought about the "Low" stuff was: if a distro has it enabled by
> default, it must have been decided it was a sane default. So for
> things that distros have enabled, set it to "Low" here. (Which is why
> I cringed with KPTI: distros have it, but wow does it hurt...)

mmm, I think you are right.

>>>> [...]
>>>> +CONFIG_DEVMEM=n
>>>> +~~~~~~~~~~~~~~~
>>>> +
>>>> +**Negative side effects level:** Extreme
>>>
>>> Why is this extreme?
>>
>> I tried to be very cautious and I had the impression that this option
>> could break many programs,
>> isn't Xorg one of these?
>
> These days, (almost?) all graphics drivers run without needing
> userspace access to these things (and I think they never needed _RAM_
> access, just IO space). Setting this to Medium or High seems better to
> me. (The STRICT_DEVMEM, though, should be Low, since that's been a
> distro setting forever.)

Yes, agreed.

>>> [...]
>>>> +CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> +
>>>> +**Negative side effects level:** High
>>>> +**- Protection type:** Self-protection
>>>> +
>>>> +With this pluging, the kernel will instrument some kernel code to
>>>> +extract some entropy from both original and artificially created
>>>> +program state. This will help especially embedded systems where
>>>> +there is little 'natural' source of entropy normally.  The cost
>>>> +is some slowdown of the boot process (about 0.5%) and fork and
>>>
>>> This doesn't feel like "high" to me.
>>
>> Medium maybe?
>
> Sounds good.
>
>>> [...]
>>>> +CONFIG_PAGE_POISONING=y
>>>> +~~~~~~~~~~~~~~~~~~~~~~~
>>>> +
>>>> +**Negative side effects level:** High
>>>> +**- Protection type:** Self-protection
>>>> +
>>>> +Fill the pages with poison patterns after free_pages() and verify
>>>> +the patterns before alloc_pages. The filling of the memory helps
>>>> +reduce the risk of information leaks from freed data. This does
>>>> +have a potential performance impact.
>>>> +Needs "page_poison=1" command line.
>>>> +
>>>> +
>>>> +CONFIG_PAGE_POISONING_NO_SANITY=y
>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> +
>>>> +**Negative side effects level:** High
>>>> +**- Protection type:** Self-protection
>>>> +
>>>> +Skip the sanity checking on alloc, only fill the pages with
>>>> +poison on free. This reduces some of the overhead of the
>>>> +poisoning feature.
>
> So, I spent some time looking at these again for unrelated reasons and
> rediscovered that enable CONFIG_PAGE_POISONING has virtual zero
> overhead since the actual poisoning doesn't happen unless you turn it
> on with a command line argument. So I would classify both of these as
> "Low".

Ah, OK.

>>>> +CONFIG_PAGE_POISONING_NO_SANITY=n
>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> +
>>>> +**Negative side effects level:** Extreme
>>>> +**- Protection type:** Self-protection
>>>> +
>>>> +Skip the sanity checking on alloc, only fill the pages with
>>>> +poison on free. This reduces some of the overhead of the
>>>> +poisoning feature.
>
> This one, though, yes, Extreme or High. It makes things much slower.
>
>>>> +CONFIG_PAGE_POISONING_ZERO=y
>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> +
>>>> +**Negative side effects level:** High
>>>> +**- Protection type:** Self-protection
>>>> +
>>>> +Instead of using the existing poison value, fill the pages with
>>>> +zeros. This makes it harder to detect when errors are occurring
>>>> +due to sanitization but the zeroing at free means that it is
>>>> +no longer necessary to write zeros when GFP_ZERO is used on
>>>> +allocation.
>
> This one is interesting: enabling it with poisoning means you gain
> back some of the performance hit (since now GFP_ZERO allocations don't
> need to do any work: the space was already freed), but you lose a bit
> of coverage since a write-after-free will not get zeroed at allocation
> time. So I think I would set this as:
>
> CONFIG_PAGE_POISONING_ZERO=y
> at Low
>
> CONFIG_PAGE_POISONING_ZERO=n
> at High (or Medium?)

Oh, I didn't think about this. OK.

>>> [...]
>>>> +CONFIG_STATIC_USERMODEHELPER=y
>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> +
>>>> +**Negative side effects level:** Extreme
>>>
>>> I mean, this SHOULD be Low but no distro has actually implemented a
>>> helper to do this yet.
>>
>> Infact I set it as extreme because I expect very few people to make an
>> use of it.
>> Maybe I could just drop it.
>
> Until it's actually usable, yeah, I'd say drop it.
>
>> [...]
>> Thank you very very much for taking the time to look at this very long patch!
>
> You're welcome! Thanks for _writing_ it. :)
>
> -Kees
>
> --
> Kees Cook
> Pixel Security
