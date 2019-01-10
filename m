Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD37214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIW2DCjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfAJN0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:26:03 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46520 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfAJN0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:26:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so9217205oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 05:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohYVSf1fMbgvNKdeTvE1yHp/DGUKv0oXC+hX6SOxMkA=;
        b=IIW2DCjVNVZuslGTFaSmM0zrd5AQVQs9KDp2KFRXSbCQoxYyw+94e92qDGBqTyYj9f
         rTjqASpKAt6Xb8tRKhvwmEL28Vqwml66hb0v5SEzBEhnYj39EnFmpVUHCBEttJ7OqDKw
         vCUsXhvqdH5rZYw4Bqk3Z72b/G35JUNQffeNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohYVSf1fMbgvNKdeTvE1yHp/DGUKv0oXC+hX6SOxMkA=;
        b=JJunUZL6d2foHshutTyyix2QleJcHgmkGPqvWXzGQ8ln8hhKOcqkpr0PaxyEiWnBBD
         EA/EC1AJebQ/YnkkT2DfKs8WJGvaiL4YzVXCUQXwdKPs/20RgGTcjxsNUZgRLcd0HKFo
         hRE1B9xsZ/qf45dFQ6/6hA6tyJtN4363Jm5Nnozq4UAyyH313+abzLTSk1uhM/jnGgOl
         ISbIe+cFmJ5rfKVG44SKJ5e0u7239JLYuR/aso0Chgpv+VrsttychjQek1LgoFPI3m6o
         8MJtPrJrLtAtw7yBfJ8RArJlSg77hUcEQ8IGBJ7EeNxcp584sZtLwNPAOjH5ow3SYvI+
         1s/Q==
X-Gm-Message-State: AJcUuke1AiPrs1o9DjZaY0J66seck/8KoEjwpMX9ntcNG9hS+CxrfL7X
        xQEqiVSSTPFFU+d6hsOnu+3QoEHYQVDRIbRzW7wy1g==
X-Google-Smtp-Source: ALg8bN49WlrOP/5pP+J9WCkIOY3Be/esAAQ74dx3rIvjYOkGKZN7SQXT3HNWI3fx/CND/XZqQSOlAUbc8eKcpIYbbg4=
X-Received: by 2002:aca:2dc9:: with SMTP id t192mr6774360oit.325.1547126761553;
 Thu, 10 Jan 2019 05:26:01 -0800 (PST)
MIME-Version: 1.0
References: <0184EA26B2509940AA629AE1405DD7F201FFC21E@dggema523-mbx.china.huawei.com>
 <c01e3ed0-f66c-f7df-295a-70b44bad49ff@arm.com> <CAFEAcA8No4tti6o9oErdfGKyHqRTfXebO4fuEOhBApFAxw=LOg@mail.gmail.com>
 <1d73ec5a-b58d-1e00-b681-53cd80cba999@arm.com> <63a1ad58-b4db-c266-1077-0a3d0a3975d0@huawei.com>
In-Reply-To: <63a1ad58-b4db-c266-1077-0a3d0a3975d0@huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 10 Jan 2019 13:25:50 +0000
Message-ID: <CAFEAcA9nGHFCuocGv+XLTStOZMONNK1SFYZ=uxhVN+KRU6BG2w@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To:     gengdongjiu <gengdongjiu@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvm-devel <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 12:09, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Peter, I summarize James's main idea, James think QEMU does not needs
> to check *something* if Qemu support firmware-first.
> What do we do for your comments?

Unless I'm missing something, the code in your most recent patchset
attempts to update an ACPI table when it gets the SIGBUS from the
host kernel without doing anything to check whether it has ever
created the ACPI table (and set up the QEMU global variable that
tells the code where it is in the guest memory) in the first place.
I don't see how that can work.

> >> I think one question here which it would be good to answer is:
> >> if we are modelling a guest and we haven't specifically provided
> >> it an ACPI table to tell it about memory errors, what do we do
> >> when we get a sigbus from the host? We have basically two choices:
> >>  (1) send the guest an SError (aka asynchronous external abort)
> >>      anyway (with no further info about what the memory error is)
> >
> > For an AR signal an external abort is valid. Its up to the implementation
> > whether these are synchronous or asynchronous. Qemu can only take a signal for
> > something that was synchronous, so you can choose between the two.
> > Synchronous external abort is marginally better as an unaware OS knows its
> > affects this thread, and may be able to kill it.
> > SError with an imp-def ESR is indistinguishable from 'part of the soc fell out',
> > and should always result in a panic().
> >
> >
> >>  (2) just stop QEMU (as we would for a memory error in QEMU's
> >>      own memory)
> >
> > This is also valid. A machine may take external-abort to EL3 and then
> > reboot/crash/burn.

We should decide which of these we want to do, and have a comment
explaining what we're doing. If I'm reading your current patchset
correctly, it does neither -- if it can't record the fault in the
ACPI table it just ignores it without either stopping QEMU or
delivering an SError.

I think I favour option (2) here.

thanks
-- PMM
