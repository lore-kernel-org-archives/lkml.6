Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B619C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E37E20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hafIFUU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E37E20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeKITI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:08:59 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33122 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeKITI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:08:59 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so846309lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=to1hMOqdigOqAxQq/0guW+n3PN1sU2TvISsNUqvm2sk=;
        b=hafIFUU48cQusQyylqaExL8QqcG4RHAaQz67j+NvNBAxH6Z9Ynd9MT+gtYwnOPuNk9
         KcPTrDaeB/hYBjl687QMA3kVi6HBHzm0Di1niuHEF6uk8wbrQ+pJq4mU1P+ty86gtzJ3
         aFetgvSDP/SbIZ60B5GaZag/aFErlozBUm/o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=to1hMOqdigOqAxQq/0guW+n3PN1sU2TvISsNUqvm2sk=;
        b=J6JghjNVhY+EpqRwvChzDB7dPEG9NnCzI6+HXBA1AG2ABruflN3F8tKoWd+bHO6QYu
         QVUb+esheIDt8he4acOeWFm60V3l1mbcCfdBT3yT08nRtG3zKWMehyQGb/vulnoUKFJE
         byQzgCSadMohjW9ACWnnJB3j4jhT7OQOaREa4SzOvIsFgUYzL6YEzN9r2shSUP92IfRp
         HbePXNvR/GN+6k3lWEjCJnh9D8cK/V8BSNwsbcQGmbxXCGcfptrG8GQ26e8HVOT2FkuA
         MNV5Ui8YZyFLuSwBsIqRhDIauW+M9n573TbSclwBXf8hNieVMI2ejwc4Er+/lZofLzXc
         ybFg==
X-Gm-Message-State: AGRZ1gLZrAVXuAZlHjX6xHk2UWhWjuZgUsBE+YbdklWwgxtB+PZicIek
        ASBXnqwKZhFGuOiEnR0hbKb6sCFJYXXyGtQHMnkNBw==
X-Google-Smtp-Source: AJdET5ev6wVLDzZrms3+KcD+MCgiQ/sQMpwsS3aOnn950OsUrjnquc6Q4eVd60GVRFsTuNJUs0D5K5WnWoAMVgz61XA=
X-Received: by 2002:a19:4849:: with SMTP id v70mr4818777lfa.62.1541755754960;
 Fri, 09 Nov 2018 01:29:14 -0800 (PST)
MIME-Version: 1.0
References: <20180925061855.19557-1-natechancellor@gmail.com>
 <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com>
 <20180925161459.GA15840@flashbox> <CAKwvOdkh0rqWcw4r7Y=Ki_MNJPoJNnvm3uGp4Q726PaESxZAnQ@mail.gmail.com>
 <20181025210456.GA14792@flashbox> <CACRpkda9LhdQybgci8gYs13L5pHWvDx43_Ftn5s+ERLLFPvLjQ@mail.gmail.com>
 <20181101000338.GA32577@flashbox>
In-Reply-To: <20181101000338.GA32577@flashbox>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 10:29:02 +0100
Message-ID: <CACRpkdYDgV8RWifqzu-MQxD-ZR87UeyQkxXuwB-yuXoUb0Mtbw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 1:03 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> [Me]
> > A slightly lesser evil variant is to add a few PIN_CONFIG_CUSTOM_1
> > PIN_CONFIG_CUSTOM_2 etc at the end of the enum and just
> > #define MY_CONFIG PIN_CONFIG_CUSTOM_1
> > in all drivers that use these.
> >
>
> Some drivers actually just define their pin config params like:
>
> #define VAR (PIN_CONFIG_END + 1)
>
> In fact, more drivers do that than not. I will go ahead and draft some
> patches tonight and send them out tonight to see what driver authors
> think.

This seems to work. Is your kernel compile working without
warnings after this round of patches?

Thanks for driving this BTW.

Yours,
Linus Walleij
