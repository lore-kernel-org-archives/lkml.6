Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BA3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1B42124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3odP/st";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KtqNQLql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1B42124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbeGLUB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:01:58 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41122 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeGLUB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:01:58 -0400
Received: by mail-yw0-f194.google.com with SMTP id q129-v6so8101498ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dOOIdq7UF6lzdiqQpEdA6TJxIqcMxk1QBRLVJ0JrYOA=;
        b=Q3odP/stOt/9xZ40M4r6Sbfns63yAN/2LkwzBQOo9QB37vcBFo9eX2TqqmSucymORR
         5Dsrl1kH0nxRMY4BGQpMf3UNFVs18TU2URVhTleTog0af1n0YxAY3JyWgHrZngSx8eu6
         ejAnPQ1V0p0KrHV8vpToqZdvmUApai0cOvxdVhQmPBG54x56jtYEehnB0BYrsiGTbyQO
         Se1TCxSQEbRwwcvsOigGZ6y8ZwBOkrf63Hrqz/RDDCMQSrYB+YO1mQVrEw21bLu/J+6R
         GGhFKryR/kpQKceiYLD5cF2RIMX9koZIIwwFoEJ7UNP7JSPs01PatYLZxxSA2E+mcanM
         AsCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dOOIdq7UF6lzdiqQpEdA6TJxIqcMxk1QBRLVJ0JrYOA=;
        b=KtqNQLqle1bXMgL3bojywL9iCZDJqaMUejFaQZuD16BTCQ6t5IwDx0ycU6RpdzfTiK
         jhTrvEgBEcZDxAe/uzZJ2GsgrGsd8G8lB3/79bI13DoTUUI8867sBR/vkRlLd1gBWdxL
         0+WitKXhCOXp86sGvRzsGGV7i6Q5nEBrGb4O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dOOIdq7UF6lzdiqQpEdA6TJxIqcMxk1QBRLVJ0JrYOA=;
        b=pHR6ocSY1kpjSE/K65jFw9ylqk+AQROpn/sn5fzrBQgnwtKNK7JP5rkjyRAztx4gs2
         rcwH9I+hhhTOvOBalqYC8V08LeHRRfS/F+T2Q8b6n5u+kpfuuqF0ODHMFeCOEyMa6xVv
         1haCZwOWA0lGNvU9CdScA5CPzCZytfYlnF8/qwDozLQf2q0jSyyuKMXD926kfcLxeDE4
         g15Tsn1/KpbMoY50ROefxBnlToE3XO3TOKHUQcwfYd6jtefiNPUJ8goT3+DqmPyW+4hZ
         ljO/q+dvK+5d9Z7/m5mmuAItYUcE61qG26cNUSiFy3dQuHpTcAoc4/nGPjCvYzXe3Xvr
         mYNw==
X-Gm-Message-State: AOUpUlEWdF7/bdTaXPHPkNHk7bIMI1Z3TdCTOXnqEw7iNKkMp12HwNh0
        9rS4nFe6NffDlYzKzIgY/J2wm84lbuiM4APAA2UhAw==
X-Google-Smtp-Source: AAOMgpdTX0V8Z+5xIaA2ldrDKysyKfAYF0VYNwneN3DUjVVZNmYsXCkRYG6MEipzi5ScsSjpdaIRMY4c1jO1XgIHB/I=
X-Received: by 2002:a81:8742:: with SMTP id x63-v6mr1862979ywf.129.1531425055419;
 Thu, 12 Jul 2018 12:50:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 12:50:54
 -0700 (PDT)
In-Reply-To: <20180712170124.GD26935@arm.com>
References: <20180711093607.1644-1-mark.rutland@arm.com> <20180712170124.GD26935@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 12:50:54 -0700
X-Google-Sender-Auth: 4SFdpsRy7LijYoWgo_1NKaqmR88
Message-ID: <CAGXu5j+hfVmB_+wPn=-hx3w+sNoKQBRLAbf2M0WrNY3Y+tYCQQ@mail.gmail.com>
Subject: Re: [PATCHv2] refcount: always allow checked forms
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:01 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jul 11, 2018 at 10:36:07AM +0100, Mark Rutland wrote:
>> In many cases, it would be useful to be able to use the full
>> sanity-checked refcount helpers regardless of CONFIG_REFCOUNT_FULL, as
>> this would help to avoid duplicate warnings where callers try to
>> sanity-check refcount manipulation.
>>
>> This patch refactors things such that the full refcount helpers were
>> always built, as refcount_${op}_checked(), such that they can be used
>> regardless of CONFIG_REFCOUNT_FULL. This will allow code which *always*
>> wants a checked refcount to opt-in, avoiding the need to duplicate the
>> logic for warnings.
>>
>> There should be no functional change as a result of this patch.
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Acked-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: David Sterba <dsterba@suse.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  include/linux/refcount.h | 27 +++++++++++++++++-------
>>  lib/refcount.c           | 53 +++++++++++++++++++++++-------------------------
>>  2 files changed, 45 insertions(+), 35 deletions(-)
>
> Looks good to me:
>
> Acked-by: Will Deacon <will.deacon@arm.com>

Peter, Ingo, can this go via the atomics tree? That's been the
traditional location for the refcount patches.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
