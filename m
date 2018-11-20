Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383FAC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0EC2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="W0/RuJp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0EC2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbeKUBJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:09:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37299 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbeKUBJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:09:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so2132994edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJvguae8/zSWNzN62GtP6wCB76mFiHCg+yTBcnm0vsg=;
        b=W0/RuJp3JRfidfnjeq5Sm2yBYURpnZBVOLxZvB4aY8apcHJnDnYRb5y/zyQlvkP7Ys
         THJd5OrTmbTN3/auIP0AwrDmaQxJ/b9rCy2HlO1a9kqIEgd5tJ9RMKYaBsJ9372t974v
         Zf10/Qe113uSdWjqOWkHslYHobQJlTS4LsSLsHKjm3GjPhFVicjuLk57U/W1bafQ/arg
         C7ZUYUrFQMWzrY31xG+Yu/xOXGo1VSZdx9k3fC5xFaKdE3NUGZb7qwk2EA4O6l/UdNCU
         5cN4y/SUBrSAOywQsK85epveSIFGEp18vsJKRiI7zD+x28gsgMJq+nN51j7wRune+n5O
         PX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJvguae8/zSWNzN62GtP6wCB76mFiHCg+yTBcnm0vsg=;
        b=lwIqJVUO7cN8Ng4qTV9M7hkF5fWUtWAZ4CzTvAf+zy9LuQElQF+XvJvdiXyCjHvXmz
         xBhtzxm05UwJk1Nooht4wPnF+kjRKEhMuBQyrVRtJvy5749vNz+xgzOYlqNLf8+Aisfd
         YATToJyS/xj/AEzQcS8PRIY0tyx1hmZbLdSwLeafDVsQK8pHyZgUxBC9xY9i+0aaRaG8
         6tFw8RowbqvpAxCRI2qmUIJiS1OF/muTpmlujTrwiodye67F6lveF03fxevcKzprqfOY
         HbPjzOkahw+Yq7Elq8MrJuGlqD9xh2OlYKZ1o4XEw5fog96SCYd0Z/VqDUt4dJYFfTl2
         rorg==
X-Gm-Message-State: AA+aEWbZz6LwUDzgd/gdEIHQG4e11lLqgd9fEUzpwK+cQg/sr+OmntWD
        clrkfrVsbfJDxL60g3lj8njG/KLwVVA9C7o5FFFQTw==
X-Google-Smtp-Source: AFSGD/VUpFcQ9l90TeU7tXDRRCjnhWauql308K+JZ7SfguEC1eufaw+HsxgDzhkLHsvldF5q/WytuUjIj/lqkIgIu/U=
X-Received: by 2002:a50:f19b:: with SMTP id x27mr2537367edl.140.1542724821770;
 Tue, 20 Nov 2018 06:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20181119214443.25175-1-pasha.tatashin@soleen.com>
 <20181119214443.25175-2-pasha.tatashin@soleen.com> <d66a60d9-6772-a951-9da4-c07443b48aad@arm.com>
In-Reply-To: <d66a60d9-6772-a951-9da4-c07443b48aad@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 20 Nov 2018 09:40:10 -0500
Message-ID: <CA+CK2bAKcdZRRMwhcQ0QnBJ3_6bg=zhaeM7v74f+QFwkw9h17A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] arm64: Early boot time stamps
To:     marc.zyngier@arm.com
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        rppt@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        andrew.murray@arm.com, james.morse@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static __init void sched_clock_early_init(void)
> > +{
> > +     u64 freq = arch_timer_get_cntfrq();
> > +     u64 (*read_time)(void) = arch_counter_get_cntvct;
>
> We already have arch_timer_read_counter which is exposed from
> arm_arch_timer.h.

OK

>
> > +
> > +     /* Early clock is available only on platforms with known freqs */
>
> This comment is misleading. It should read something like:
>
>         /*
>          * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
>          * the timer frequency. To avoid breakage on misconfigured
>          * systems, do not register the early sched_clock if the
>          * programmed value if zero. Other random values will just
>          * result in random output.
>          */
>

OK

> > +     if (!freq)
> > +             return;
> > +
> > +     sched_clock_register(read_time, BITS_PER_LONG, freq);
>
> This doesn't seem right. The counter has an architected minimum of 56
> bits, and you can't assume that it is going to be more than that.

Yeah, I saw 56 is used in arm_arch_timer.c, but I could not find where
this minimum is defined in aarch64 specs. I will change it to 56.

I will send v2 soon.

Thank you,
Pasha
