Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0615C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE9A20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cdedmqF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE9A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeLEJCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:02:16 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41367 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeLEJCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:02:15 -0500
Received: by mail-vs1-f68.google.com with SMTP id t17so11603036vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 01:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KI78R0hXaOeWcuoDkaVQTTSv3meh467bNNdqylZXYJY=;
        b=cdedmqF3C3iDa5yfxJRh+wyQVbt6gmagl/lqYjqpLv7gXu8z0Xn+6gGetKvcrD5gSz
         Ibs/24r9rPiUn8Ie7fYJVEx8vKPyQYX/JWQ4orhEdXmMZdEZWxDAE6WAX7JHSib97hos
         lZ1BPIB62SUWcZcU2/Z72t3x/CJkxhQcOG+Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KI78R0hXaOeWcuoDkaVQTTSv3meh467bNNdqylZXYJY=;
        b=Okr1ChjLuTlixSnpBhx9SAHn/Q/+JhCAUQmu3gH1QGsd1q0iu+lUJ4vOzegT9ebi3O
         NxkqHj9OsyFsOGH/3L0oPzxRDEf5z6AnKLdt+6/sh8MwJN8okPVnRUNGpJxH2CLxdSp9
         OLqeO68kxc8foRmxHxV+/LA1JoUf6WDKOjTXcT3V9ESBAKq348nd61Jkc6cY8nF4qu3F
         DYRyZU44l++/oTyYPfNDabOdYl2gSyz8XeOcbXMLx+dW6R9XexFz4QyQUrzv19ES15Uz
         bncFf/W9dnjKYrkWmp3cOKI3cqRYsBz1kLMhgvjcd4P1tIjGMtBjXjUn8pJRgMaiFCp5
         I5fA==
X-Gm-Message-State: AA+aEWY5LprJEmZuvTPxopwyp1HgAyU2+5yzOQaE80pWbzi+92/j+FsU
        KRFz9zYJviY1LjqSwYTTGO/El64X4gthWkYNynUefQ==
X-Google-Smtp-Source: AFSGD/Xcf911SxrTWiYkylnAA71wKt+utPOAzor1GubuwrEa61cmy+Tms1g+0S77AususxjVkqxm9uCtXtCQE/nHM2o=
X-Received: by 2002:a67:a205:: with SMTP id l5mr10314385vse.9.1544000534267;
 Wed, 05 Dec 2018 01:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20181127120041.90759-1-cychiang@chromium.org> <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell> <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
In-Reply-To: <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 5 Dec 2018 17:01:47 +0800
Message-ID: <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, rohitkr@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

I tried to apply this patch based on
for-mfd-next branch of mfd tree (
git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git )
Then, I tried to compile all modules by

 ARCH=3Dx86_64 make allyesconfig
 ARCH=3Dx86_64 make -j64

There was no error.
Could you please let me know what was the error when you failed to
apply this patch ?

Thanks!





On Tue, Dec 4, 2018 at 9:46 AM Cheng-yi Chiang <cychiang@chromium.org> wrot=
e:
>
> On Mon, Dec 3, 2018 at 7:19 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 28 Nov 2018, Lee Jones wrote:
> >
> > > On Tue, 27 Nov 2018, Cheng-Yi Chiang wrote:
> > >
> > > > Add EC host commands to control codec on EC.
> > > >
> > > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > > ---
> > > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++=
++++
> > > >  1 file changed, 94 insertions(+)
> > >
> > > Applied, thanks.
> >
> > Turns out that this does not actually apply.
> >
> > What is it based on?
>
> Hi Lee,
> I am sorry about that!
> The patch series was based on Mark Brown's tree (
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git )
> for-next branch.
> I will rebase it on upstream master branch in v2 when I address other
> comments in codec driver.
> Thanks!
>
> >
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > Linaro Services Technical Lead
> > Linaro.org =E2=94=82 Open source software for ARM SoCs
> > Follow Linaro: Facebook | Twitter | Blog
