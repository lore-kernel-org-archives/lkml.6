Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD32C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5228D208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRtYdJ82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5228D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbeKPP7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:59:43 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55619 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeKPP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:59:43 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so23930529itg.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 21:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwraZUM4OL+E2yRUtArEqwjPmdyNCofVUclcs8Wm+Hc=;
        b=RRtYdJ82OT8JMKehGtFUlwAxqzp/MS/KOKUtYRpiESkPWze1tCEfWPfyLWGfrOAO1f
         wmzP6BWPhFwyWVzyw/wS1LXwG+XAqWFhZInxRedfnVqPj4YslFJLP4kPuKAmZYdJRvC2
         r5BTPryG8AYzFgLhnKaTsG1qHWUzDDjzVHqss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwraZUM4OL+E2yRUtArEqwjPmdyNCofVUclcs8Wm+Hc=;
        b=cG8AfY590iFRnY5xALO2PoIyzMonZ/9qLd3dg//d8RnZr96zqyAyqQ7A3NcQ2nthAi
         OHBVztM2Dbt15sx2VVM3zSYPXePignOJJvbt+o7pucL2PbUvsWK35t4tZfQkhOspMOTM
         lg4Ma9cUIMIwjmtI9I0EKvw3v5SmHpxwZSJZ8Bl8U11/H+Yr7qNMC7rzTDkL3jupfdLY
         Lm++crCswV+gtI5Oe+I4O+sq7ZPv3yAQkytXgSzQM44OlP7woXvlnKYAxY76DLB93FGY
         CxrwL8POSWQXYGZVk7AZHZhJouu7Od4vGnMMYl3J4S9dRWkNGl/smGOPLXsoGRwjqOZw
         637g==
X-Gm-Message-State: AGRZ1gKncDInoNgR9diQPB+g3XdAGPf9cqicMFv3qNNb22MEpT3kd7lY
        eDjQgFn8yl3tm/Gd/a9jylpMHvszH3mV9q9VwYv25Q==
X-Google-Smtp-Source: AJdET5c8ZlbkU4d5FVPkoOUxw5pJ3LRFDt56zuWYWAxqaDZlsAjenjDZRUJ14/g/MzKX10TUhupvARowx7cbCJ5GDkA=
X-Received: by 2002:a05:660c:a1a:: with SMTP id e26mr4329412itk.83.1542347326518;
 Thu, 15 Nov 2018 21:48:46 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
 <1542104370-22831-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJGWgJrsg858nwO_845HQOSMNm4AxEqjEjVsSMZMG1Gzw@mail.gmail.com>
 <CALxhOnhBN3ibNku5z4ZwnRjnWEtSrsbyVQUDzJkT6U65Ek0H+g@mail.gmail.com> <CAMo8BfKM0M-f9UNmz0o9qZb9srJn7yxkYVYjqGc84c0eO5jnmg@mail.gmail.com>
In-Reply-To: <CAMo8BfKM0M-f9UNmz0o9qZb9srJn7yxkYVYjqGc84c0eO5jnmg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 16 Nov 2018 11:18:35 +0530
Message-ID: <CALxhOngbgaqmcNPJ3xiBLrk35UWQ4ThJ-rApbd1z+9772yGpyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] xtensa: add __NR_syscalls along with __NR_syscall_count
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Fri, 16 Nov 2018 at 01:15, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Nov 15, 2018 at 2:05 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Wed, 14 Nov 2018 at 05:19, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > If we remove __NR_syscall_count from the uapi header I'd
> > > suggest dropping it completely and switching its two current
> > > users to __NR_syscalls.
> >
> > I'm not removing the __NR_syscall_count macro; just place it
> > in asm/unistd.h file for the above reason.
>
> Ok, I'll apply this series to the xtensa tree and make my cleanups
> on top of it.
>
> > FYI, I made sure that the kernel will build with my patch. I would
> > appreciate if you can perform the boot test on the actual platform.
>
> I did a simple boot testing on a range of configurations, it works.
> I'll also run LTP a bit later.

Great, thanks!

Firoz
>
> --
> Thanks.
> -- Max
