Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D9C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B17D20894
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XoE/qzaf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bJCCKZV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B17D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbeGYTOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:14:35 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38112 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbeGYTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:14:34 -0400
Received: by mail-yb0-f194.google.com with SMTP id i9-v6so3330382ybo.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fwR1XnrNrE05jj+kaIvmoHGONzrLMLUSe2XCu49/tSU=;
        b=XoE/qzafc9enyyuoE9/oDxiSAHmn0IfTU4sYveYkZpXEy77WIwM+dTVULfI5DCdkui
         3eeZmOovw/qYQot1xQurFAKyd6lfrBiY5B6ySS9Sd3nXrBiS4JOeEx5wTRBWNWy3mBjE
         nH3zcn23b5xK/yGFk0HJXRQpeaVle9XhkkYH3xs/GmFurs21TgDMPLcqnWZYbhI8ONEs
         08CZIwQ/USOFGlc2UJ/lV7HQ3FxRzwFLtj7eBlzLnYTvAlb5fWxaRHy+Uerr3IxJdsyn
         lctsnq0ihhK+oOIUBz6X84v3OdYmxGcyLJRXtQlcZSPmrOXihqnaSGgemv0PjNbyUWVL
         RBIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fwR1XnrNrE05jj+kaIvmoHGONzrLMLUSe2XCu49/tSU=;
        b=bJCCKZV7doU6vrsXi/q7oCCK4xX2oIJxv+ozw0KprS/l2hz5usWrx/gYBcd1cpd2Zw
         KBN+LlDaFDLHU0ZPNPJz1tBFa+JrQKxV9EQzg54gpYDalkVexuGu+yAOROy08fLL8XdB
         5tHaQWbeTmk7hEUjB6WsVq8fQ86bnhNLhLHjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fwR1XnrNrE05jj+kaIvmoHGONzrLMLUSe2XCu49/tSU=;
        b=q0QL7xM/yVhvm3+//6D7kScd+AL3hG5FyTfaoPq3jIwzVTwmjegBigZcf4yaoPrjDV
         QWcr+gDnVMbWg6Mk/VdGEeBSbqLgqUlb+CGIrUdq/MNKcQPfO7FcJLgh/UyvQ8UCIqKv
         eptVtuwM5W5I92wVD1ArjEogGsISkcQTIAU/orNsKlSbMN5y991bnVOzeQ9OjLFXKE6W
         MAG2PmQuiNh1CRQBfwOIpgY4aEXTpy/2NghoLOlFpqsbRTGi5Wu23x1wGrvK/Dt/roMP
         HysJebeWqeLkx2UUFOord5XTGosKo3/nHqhENM2AS5vpwHfBuNBm2OqrRvxew9XjQFZc
         9TBQ==
X-Gm-Message-State: AOUpUlFtbzFVwOSRn4iyHDODR0AdkPADVDnD9+m0vcaRBk7DqeQuzNRh
        rS5qMiu0CbkPvAjZ2hLnaWG4wx2K1RkfJdRWoU3b5A==
X-Google-Smtp-Source: AAOMgpfy2Ewai5yZ1ixV/KUibmh/RU0tAbkEmdYKvk6CTBoDlAHJuNskFZ5TQbokDOb5OxKPHu98+D0tGNLnwj0zwLs=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr11877726ybe.118.1532541707948;
 Wed, 25 Jul 2018 11:01:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 11:01:47
 -0700 (PDT)
In-Reply-To: <CAJZ5v0gVDotjufLKUW0YuQu2vA4fmU_gqia=ZA4DocW4XHxx0w@mail.gmail.com>
References: <20180724164936.37477-1-keescook@chromium.org> <20180724164936.37477-11-keescook@chromium.org>
 <CAJZ5v0gVDotjufLKUW0YuQu2vA4fmU_gqia=ZA4DocW4XHxx0w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 25 Jul 2018 11:01:47 -0700
X-Google-Sender-Auth: 3JWb0S7OUNBTdxQSmmr9a9nCs_0
Message-ID: <CAGXu5j+NPCc2hq5x7JUwgKYvY6zKN28YdtHbHVapnpgC3GwCsg@mail.gmail.com>
Subject: Re: [PATCH v6 10/18] x86/power/64: Remove VLA usage
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>, qat-linux@intel.com,
        linux-ppp@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-afs@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 4:32 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jul 24, 2018 at 6:49 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> removes the discouraged use of AHASH_REQUEST_ON_STACK by switching to
>> shash directly and allocating the descriptor in heap memory (which should
>> be fine: the tfm has already been allocated there too).
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> I think I can queue this up if there are no objections from others.
>
> Do you want me to do that?

Sure thing. It looks like the other stand-alone patches like this one
are getting taken into the non-crypto trees, so that's fine.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
