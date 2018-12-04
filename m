Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA79C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A277B206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hs6mcaN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A277B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeLDTeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:34:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38360 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDTeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:34:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id p86so12872602lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nD/XFtR4UmMT9lKfdvocO5nslzuqWh3QvhkIFnNL0z8=;
        b=Hs6mcaN1DnoMeSm1wWgWpvwPANZhvqle8Lh8124W5YsMM42yp/70vVXQbw6hWHC5Sv
         10Wue/CktDau6Ol9HerhltDd4Kr0Qhfxu1W5lB+DVWtEPsma+vBcBCY1GIKMZp2AnBlc
         01OhQjB57/+2LlHLFy6znABseQ3VtR0peR7GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nD/XFtR4UmMT9lKfdvocO5nslzuqWh3QvhkIFnNL0z8=;
        b=Fmd2/LytYAuiDoF0qjsuB/ECIgCQDafLnrj3tMl1S220UbJOUwpdcM5ky5Ei5A+iX3
         yIgn4Byw90Qel19Orohib/ak4bWcTYHH5Dlog8wrqXTbe93qeGUBxidkjsp4LkSEohMy
         jBCnjzPhzII80qZBgHEVrIc7Be0fS5Rl5mxu6vZGUn4uazxFJzFBOgLtiE7cd0biXYxL
         rq07UK2LB+EvCJh+HTH8sOHaAVBn5fPPribesbd1rUbc91W774aUwV/ui0UieYiO7MZP
         3eHN5nQj14DtkpjTuMMwSh4cokETXnuZP1DdFU44kNuCkjj5pkwicvM9xmXKdJZlqd7j
         WFcA==
X-Gm-Message-State: AA+aEWZU+wOuj42xeHtkOBaQ9SKoaq62YnSxRKs+3h7gjOqUsB6rRsmA
        wk7Ni3RBbYkA2k5M3LibjTDoN9eqwEo=
X-Google-Smtp-Source: AFSGD/U5tSczQw8/J2J0iQ4UOS7xwcX/sTdFPJbXR+L7uZNPWXoqC9Of6o7pBMTuW1UhwROZnWe5jg==
X-Received: by 2002:a19:2755:: with SMTP id n82mr4964819lfn.94.1543952044780;
        Tue, 04 Dec 2018 11:34:04 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c203sm3137674lfe.95.2018.12.04.11.34.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:34:03 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id p6so12874640lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:34:03 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr13277279lfc.124.1543952042971;
 Tue, 04 Dec 2018 11:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20181203123857.GS31738@dhcp22.suse.cz> <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz> <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz> <20181204090228.GC73770@gmail.com>
 <20181204091020.GD1286@dhcp22.suse.cz> <20181204093310.GE73770@gmail.com>
 <20181204095802.GF1286@dhcp22.suse.cz> <CAHk-=wgaEw566btStrWE+NOgPJLn1whS-Yw1-=K2Qr6MDvSZ+A@mail.gmail.com>
 <20181204181714.GR1286@dhcp22.suse.cz>
In-Reply-To: <20181204181714.GR1286@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Dec 2018 11:33:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh128U4GxVeHa+z_5sB52ZVXhzt0__LQq4asZgh8VtvBw@mail.gmail.com>
Message-ID: <CAHk-=wh128U4GxVeHa+z_5sB52ZVXhzt0__LQq4asZgh8VtvBw@mail.gmail.com>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux 4.20-rc4)
To:     mhocko@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, pavel@ucw.cz,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, chanho.min@lge.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 10:17 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> > How about something like we set PF_NOFREEZE when we set PF_EXITING? At
> > that point we've pretty much turned into a kernel thread, no?
>
> Hmm, that doesn't sound like a bad idea but I am not sure it will
> help because those threads we are waiting for might be block way before
> they reached PF_EXITING.

Yeah, looks that way. We've got the whole "zap_other_threads() ->
actually starting the exit" window, which is probably much bigger than
the "start the exit -> release_task" window.

So we'd have to mark things non-freezable at zap time, not at exit
time, and that's a lot more questionable.

Looking at this, I'm agreeing that ot would be better to just try to
narrow down the cred_guard_mutex use a lot.

Oleg, if you had patch that got push-back for that, maybe this problem
is now the impetus for people to say "yeah, that's not nice but we
clearly need to do it".

I'm not finding any old emails on this, but considering I redid my
email setup recently, that doesn't necessarily mean much.

                   Linus
