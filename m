Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F33C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427AC21A53
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427AC21A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbeHHWXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:23:06 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34388 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbeHHWXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:23:06 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so2460394qkj.1;
        Wed, 08 Aug 2018 13:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPQcEUGBQ06LrRhE1wXyOQJczHqsmH7C0RJ+3HU9y6s=;
        b=Fmx4yXvRwju8EbVmS8eus9xaQXtaOXmO7/GKXsZcZyTfVn0r2c/rALLx3x64/DHO7i
         Zh8osPr+DT2D4R2TNE9mBKn+cJvoDLa2Zykk0CWnh4jJjITCrhlLKM/FVydlpey63+s9
         gOB4TM171mnnudgNKdkB41aHLm1x8lUOCGkzKkBKL3WbaUmRIgXd/mZCdL1IgZuQknIu
         l/gpKE7xhp9iRLi2M5hQ/YM7YmgylNS6LSCIH/mtqFq6BEeeLX/gS/LU317Q7TK2sg1P
         6dgg2CpJkNcwofU7WW9cEJsP+E+2T/EH3ok1jNUleTojp8ohZuznMgaVmO38Apo7iKvW
         suHg==
X-Gm-Message-State: AOUpUlGmzscJM9nicZBNXq0QOfcRdqcYV/kB7W+4J4jwhDOdTQsiIJi4
        DWPN/1IynjzwYjdvf0uE8RNRy6lWQ4S5sJHDTRE=
X-Google-Smtp-Source: AA+uWPyhP3slCFS5BnxRA53qaf/5CKtS/2MyuCqXhXc+aJbrLXzijOeXTAsIhpS8R60ZeGzBjGYb8ppuDiQ5N/qxfCE=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr3746010qkc.291.1533758512500;
 Wed, 08 Aug 2018 13:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180808174735.3114-1-prarit@redhat.com> <20180808195856.GA20912@amd>
In-Reply-To: <20180808195856.GA20912@amd>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 8 Aug 2018 16:01:41 -0400
Message-ID: <CAJvTdKnOTi-iQ9BfMW4KQWkqPU=3JRCM-9Kij+3zB5KFMjve9w@mail.gmail.com>
Subject: Re: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD systems
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think it is sufficient to simply delete the "INTEL" in that string.

In the unlikely event that this "change to a kernel API" breaks
something, we can add it back.

-Len

On Wed, Aug 8, 2018 at 3:59 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-08-08 13:47:35, Prarit Bhargava wrote:
> > commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
> > systems") allows use of FFH for ACPI C1 but tools like cpupower and turbostat
> > display INTEL for the cstate description.
> >
> > Output "AMD" for AMD systems with FFH for ACPI C1.
>
> Um, is it good idea?
>
> First, you are changing kernel API.
>
> > @@ -107,9 +108,14 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
> >                       "Monitor-Mwait will be used to enter C-%d state\n",
> >                       cx->type);
> >       }
> > -     snprintf(cx->desc,
> > -                     ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> > -                     cx->address);
> > +     if (c->x86_vendor == X86_VENDOR_INTEL)
> > +             snprintf(cx->desc,
> > +                      ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> > +                      cx->address);
> > +     else
> > +             snprintf(cx->desc,
> > +                      ACPI_CX_DESC_LEN, "ACPI FFH AMD MWAIT 0x%x",
> > +                      cx->address);
>
> Second, I read it as "Intel MWAIT" instruction is used. Yes, AMD cpu can
> use Intel MWAIT, too...
>
> Third, there are more CPU vendors out there.
>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Len Brown, Intel Open Source Technology Center
