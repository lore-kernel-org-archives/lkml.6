Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0874DC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43F620863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FGqPIK9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43F620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeK3KpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:45:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38532 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeK3KpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:45:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so3497109otl.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQrn+Srwf0zuHQUeLfDQuJmZiLKRQB0d3wk46MwrBnM=;
        b=FGqPIK9U655mw3w98R+fkmqgdVm92JZ3Cngf0mpMXhzOr5nFwhgG3ldP0z7Rzcu6KV
         xtsJa/A0AsM5XjRg9S5hA9naAVqqx+d2wm12LJPRE3QoDNui4eYPZ0k+c1Jqm80wrgHH
         yxQi8lH3o2v3e8/lgVHt83nNJavX9XVHRr+hqQMwRcz01SuRVwcMpf0vxRve8N8iiMS/
         XFpsZ6WWJBuyEMaUeAu8hdSjjxh+bsNA+iI9H81vne8LYhT4OqMMk5FECZ6sR2Fg4GcV
         3/hOg5vJBRnRIU1FtBV04bT2BpEQWh+cdfCasSv0icmDHxJiihXqvG1R97UOo/k3tVhO
         fJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQrn+Srwf0zuHQUeLfDQuJmZiLKRQB0d3wk46MwrBnM=;
        b=sir8/yhOqtToUW6xEwrISFqCUqObIOLlmf0SNdQZ+6zB4ivQApAwviylbtW/vIhNop
         jtITXlihnLlTtcygWDaSJd103POvMit/6jWXArcEoY3Oq/530wMus0uywh45DgUmj6F/
         MZDGLTRnO21A3pBwYHtoldBmNkAZBnIeAfPMF3NWTdwmZJ6EXQbQgG0Gq+IGPHyFKImv
         rNRfQGx4vKf3AYLmoo5bmlA0gbPwTXbOo0zCkHSCkAe0YagivGFmnOny7Uk9MAqF0iWb
         YAkdNZGyo/a34uOqu+bPgFmiwndTEOM3w0gD59ENpWIU8aekeLwJ/6K2prcGs0R+RCUF
         mZOg==
X-Gm-Message-State: AA+aEWbzj5fNTTmlrf/rcdWWsFSJ6aSOxRVwKy+RWAQ835aeVXLvDIuQ
        d0L2f4Qw7XErTrVT8bcDgbVMw3VmV/cT1I6JWJ0=
X-Google-Smtp-Source: AFSGD/VZCGMLGl5XAzDB0sU26vZ7NWPkmJVYRT9VDcH0VRYOUcH7uy2vxfgzXJFjh2GgTJP8qxpGUB6Obnq+PyWTTv4=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr2238865otg.308.1543534679125;
 Thu, 29 Nov 2018 15:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
 <7hh8g0d8tg.fsf@baylibre.com> <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com>
 <7hk1kv79at.fsf@baylibre.com>
In-Reply-To: <7hk1kv79at.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 30 Nov 2018 00:37:48 +0100
Message-ID: <CAFBinCB8r+5tGKxfsPMapayxmDuWOi=WihvvdxS=UxcnpeYqdQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to built-in
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, Nov 30, 2018 at 12:28 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > Hi Kevin,
> >
> > On Thu, Nov 29, 2018 at 1:30 AM Kevin Hilman <khilman@baylibre.com> wrote:
> >>
> >> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> >>
> >> > Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
> >> > voltage supply of the CPU cores (this regulator is typically called
> >> > "VCCK").
> >> > Now that we are preparing support for CPU frequency scaling on Meson8,
> >> > Meson8b and Meson8m2 we should build the pwm-meson driver into the
> >> > kernel so we can configure the CPU voltage early in the boot process.
> >>
> >> Can you explain a little more why the configuration of CPU voltage
> >> cannot wait a bit so this could be properly probed?
> >
> > I was under the impression that cpufreq-dt would still initialize even
> > if the regulator is not ready yet. however (after reading the code
> > again) this is clearly NOT the case.
>
> Hmm, a quick look at cpufreq-dt suggests that it should -EPROBE_DEFER if
> the regulator isn't ready yet.  Why doesn't that work?
sorry for not being clear:
I was under the impression that cpufreq-dt wouldn't handle -EPROBE_DEFER.
I'm not sure why I assumed that. As you already said: deferred probing
of the regulator works fine.

> > there's still a benefit with this change: your Odroid-C1 in your
> > KernelCI lab would also be able to change the CPU frequency (so in
> > case something breaks we could spot it there).
> > will you accept this patch after I updated the description to mention
> > that it's for KernelCI test coverage?
>
> Possibly, but I'd still rather see the dependencies worked out correctly
> so that this can be module, and cpufreq-dt would defer until it's ready.
KernelCI shows multiple "pwm-regulator regulator-vcck: Failed to get
PWM: -517" messages on Odroid-C1.
however, what I failed to notice so far is that there's a
"pwm-regulator: supplied by regulator-dummy" at the end of the boot
process. does this mean that the Odroid-C1 in your KernelCI lab can
load kernel modules? in that case this patch can be ignored.

(I will still send a PWM regulator related patch: that "Failed to get
PWM: -517" message is very noisy and we typically suppress that in
other drivers)


Regards
Martin
