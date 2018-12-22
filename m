Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D6C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72862196E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omAcYJBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392749AbeLVTro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:47:44 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34403 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733159AbeLVTrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:47:43 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so3508142ywb.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5FQM3oXAxsG/xm3NM/AAwkVJh1ZxPjZH2dVWAYEvSc=;
        b=omAcYJBkc/SkDslE8K1HdBFCdVxLWCZYHjsmdQG5y8wFQneTuvNvENKJ7G/aF6xuN4
         Leom6LvW3sPF/NRVjmY+s9QTDJJQ2w+SVSz5MYWMY1LfZWrE/g6uoaJmBsl9skk7NCDs
         meL0/HqD70RrnkXmZqAJUdpQvgzYGPMJZnH+1cYUPsXc70Pn5S10uY75g3e2JLxMA5yC
         WtpbKo05hSOKN8b8rPHAnBnTwAeKhl3YW7dh/ryPA/yoJh3P8l/7a8SveeCq0sVmGdQ4
         nCA1BppL54RGOX0BCRRKYA8HocnT9ZS9BuUWNH3W7FIiV3UB6G5pkp8IVgic28MmPbPj
         6QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5FQM3oXAxsG/xm3NM/AAwkVJh1ZxPjZH2dVWAYEvSc=;
        b=hzJnA1wh0mwtebQN0KNI2hqdDiCxecRInsrT+VfbfL1mFcT25gFtbc+YeFSj0EP94r
         sdnd8KzJ74ZETQ9bFOYRx7zDcr85xk7ewQwHGtp0IqnXCpea/4PwmwhVPYsIeAq/1kwH
         kypkqWVO2HRrZ0teGXRcea+j4QWDxypEyuqDk+xW6+BqmIuaWz7X8rXGN6dqOya7nN2g
         FLroCchHbRpqn0Asyy3mlJeOmRWC76O+PDrof0wWJnSs/dqz46IF84Lkfhypw01ef2wZ
         r29E/+Fri1i3ky41bmjUD908F5WCKceoXGqgtDa8Ch/t/8INn96vjNE4TRZti96QsShQ
         ZrcQ==
X-Gm-Message-State: AA+aEWbjaYcNeOVq1rSR/HasYduG45eE6ZPh79/4pLL84HF0IaZLp0Ot
        6uDizlSBymE7aZbN92k2QcmhieNEpnaQTBwmwPq5Fg==
X-Google-Smtp-Source: AFSGD/X7OiAsWQp0dWKwvRMhV/MZdoYvcPNvq/PQvQVU0N0CDwvi3IXodRlPUP9rtZLua9kZPdosXd/z5QyUFRKkoSg=
X-Received: by 2002:a81:4853:: with SMTP id v80mr7602738ywa.266.1545508061940;
 Sat, 22 Dec 2018 11:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20181206040540.84632-1-cychiang@chromium.org> <20181214122156.GT4497@dell>
 <20181214122245.GU4497@dell> <CAFv8Nw+RbzKrjE1tsgxdRntXKWp9XVq8hbP7MZ3mZ=a2rMyG2Q@mail.gmail.com>
 <20181218084307.GH4497@dell>
In-Reply-To: <20181218084307.GH4497@dell>
From:   Guenter Roeck <groeck@google.com>
Date:   Sat, 22 Dec 2018 11:47:30 -0800
Message-ID: <CABXOdTc36qu=oSz3XS07SqwoQM6Dh_CU0o89JariXMe+EBhyBw@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: cros_ec: Add commands to control codec
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Cheng-yi Chiang <cychiang@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Scott <scollyer@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:52 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 18 Dec 2018, Cheng-yi Chiang wrote:
>
> > +Benson, Guenter, Scott
> >
> > On Fri, Dec 14, 2018 at 8:22 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Fri, 14 Dec 2018, Lee Jones wrote:
> > >
> > > > On Thu, 06 Dec 2018, Cheng-Yi Chiang wrote:
> > > >
> > > > > Add EC host commands to control codec on EC.
> > > > >
> > > > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > > > ---
> > > > >  V2 fixed the wrong ancestor issue so the patch can be applied cleanly on mfd tree.
> > > > >  Codec driver that uses these commands will be sent separately.
> > > > >  Thanks!
> > > > >
> > > > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
> > > > >  1 file changed, 94 insertions(+)
> > > >
> > > > Would be good to have this reviewed by some more Chrome people.
> > >
> > > See this for reference:
> > >
> > >   https://lore.kernel.org/patchwork/patch/1024985/
> >
> > Hi Benson and Guenter,
> > Could you please review this patch ?
>
> You haven't sent them the patch.
>
> Please resubmit as a [RESEND] and add them as recipients.
>

I was asked separately from one of our engineers if it would be
acceptable to synchronize cros_ec_commands.h with the version from the
EC source. I think that might make more sense than a piece-by-piece
approach.

Thanks,
Guenter
