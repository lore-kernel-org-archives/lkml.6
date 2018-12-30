Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DA6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E2621019
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 11:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGwD/NKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeL3LHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 06:07:16 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33955 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeL3LHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 06:07:15 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so33267055itd.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 03:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lgP/UprBW1s6ALayPxXb+efhKUeteJhzopQLqYk5dbU=;
        b=IGwD/NKxwXPc+tVo974Tl/JCqE6Nkp4exCiRNW7qiI3QTKLtIwm1lLFh7Qfviw1Oqf
         LvBu2LX+o+PQveyBZXCaBGaDyD5SL1feMPcM7thBPOIBegEFE3b7jE+DSdkwkhfEvT/o
         Bi5OzhQ1YlJN8buFxhwoALC0Vuv3kJzT2nmtnBuV0R96QJCEc9Zkt1SF4pDoeAneNSu5
         TEA/Pc8QmZJWD2UevGFFVLIgdtK1q7bBtMNncuthEQ9QJi4h6yLf+Htuxz9qsngK0MA/
         e92YWlIqZqYtdYvinrrWbKuTb4F/AgMOpbTOpItonH6b/suyhvNhWM2cYHoqKQaT0wSP
         iL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lgP/UprBW1s6ALayPxXb+efhKUeteJhzopQLqYk5dbU=;
        b=s/NedCYiA13COoykF7gDQzLo3IgwN690uXjZNznYPvIvBzjEADq/tGvC1AmcgMTi9i
         99ZDvXgSXK7RQaCrrtAExw3ADr0Tf33s4cMTpu9JObTnAIxsxXCzTFAwoo2S0Nali4YF
         uCsuKjAI6pYnJ6gdkejnKxKcupOlsCVIyc7uNpmRD2dPb2A8plM8V6l3g0LeCaTO44Zw
         uwnSzwJWqHAcJM6dG6AO36SW7tqq+l5yk09OjTXOstzi6ZuIWWX44bPsypJPMAk8/dxa
         Tflk877XwQvIGmnmsnqi7j809W322gpw5gDeAtU4Pdy0ZHGEoQjRrt8GiSP/f33Urk4P
         blNg==
X-Gm-Message-State: AA+aEWaL/QUQ46V//PsVoCjBRYFB39lUvMVw3Xu5Aj5KY/XMdmXWKiPB
        aqu8i5gx+iVYRkPPCVPuntAY+HGGd2RJcur6sBELyQ==
X-Google-Smtp-Source: ALg8bN7hL5mTiZWxpibixTKTbX+5S4L0eTLXOLy1bUsHgfwfVcp8XhdVdOZXJH0N5q1wfF5ipjSIimxXLU8IbRuwro0=
X-Received: by 2002:a05:660c:781:: with SMTP id h1mr17721309itk.52.1546168033708;
 Sun, 30 Dec 2018 03:07:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:6f53:0:0:0:0:0 with HTTP; Sun, 30 Dec 2018 03:07:13
 -0800 (PST)
In-Reply-To: <20181228153759.3132-1-ubizjak@gmail.com>
References: <20181228153759.3132-1-ubizjak@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 30 Dec 2018 12:07:13 +0100
Message-ID: <CAFULd4apcgrNMNhkX-NsdRSi3KyHg+z+eZtdbeXAj6RYPeM7Zg@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Use CC_SET/CC_OUT in percpu_cmpxchg16b_double
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/18, Uros Bizjak <ubizjak@gmail.com> wrote:
> Use CC_SET(z)/CC_OUT(z) instead of explicit setz instruction.
> Using these two defines, the compiler that supports generation of
> condition code outputs from inline assembly flags generates one
> conditional jump instruction, e.g:

Unfortunatelly, the 0day kernel test robot reports:

[    1.569154] DEBUG_LOCKS_WARN_ON(unlikely(early_boot_irqs_disabled))
[    1.569287] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:2803
lockdep_hardirqs_on+0xc5/0x19e

presumably due to unconditional interrupt enable in
this_cpu_cmpxchg16b_emu. I have to somehow disable X86_FATURE_CX16 and
thoroughly test the library path.

Uros.
