Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374CEC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB664214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MXYDuis3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB664214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeLFCgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:36:51 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40912 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFCgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:36:51 -0500
Received: by mail-vs1-f68.google.com with SMTP id z3so13410252vsf.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 18:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yt+5wGPg5pnA4xdSqZYuiZxmxoADg/ITVvP9+CplKfM=;
        b=MXYDuis3PI7fZgTBG51R/S+ep0VNOJZVPrb9Ax68ja+OwxKH2ls2NL/AotgpEepMsm
         Njr2r7tZPm60u9+WpbY3bQ6H023jvgLllwCF0gGTeVV4o9dHpaCL9rktzvNQ2EzoSUgl
         0CDZyVT3W97X7tf9a5fuEVyuv6OWKpKQWN8Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yt+5wGPg5pnA4xdSqZYuiZxmxoADg/ITVvP9+CplKfM=;
        b=qRpRAnbEL2Srz5PrXQuLgYji7vsxpgGZq39m3wacDDCkyEQNbXUEhzqhJpz2DRlM02
         pg3WLp8biLoyqg/K782acWoN+10fOvm6xh5DlnPUv1iNkZxbose+jdhkTca0TDSKnjod
         Hcm0XHhRVEphzg9s7GOqC2vJval0xVyde7CNOBW+kdUDor/IW7UbUYY+SEelRe+4whtg
         EjYpm4BL2Vyk9qmU10rLiGZMl3rGHFJcQAyES5ONC1+ojwkm/wk+LMrGp09LgkUC17Z3
         qmxwabHFM2KEliCkEjy57pHTiXqFQV3oX/VduBSTKvP9LvMBts+X96VS8SulmRxHMAQ2
         MtRQ==
X-Gm-Message-State: AA+aEWbC4uaqFNzWPzYkKZu1u7TwkHXmZb++cpr4iq+uLgbZR+2JJzwD
        5ZqVo4cjfVdCSLSoM1fDPnr4wXOsVZAJoNCAZPkEpg==
X-Google-Smtp-Source: AFSGD/W568uNfQzAj2gIT4aONCg4zahYuiS5Xyl3eHCZTm6ttOjT1SC+LzuNTrvp2olV16nCtPGxu0wiBtBgk65BiEE=
X-Received: by 2002:a67:d20d:: with SMTP id y13mr11775485vsi.163.1544063809463;
 Wed, 05 Dec 2018 18:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20181127120041.90759-1-cychiang@chromium.org> <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell> <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
 <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
 <20181205113045.GD26661@dell> <20181205113406.GE26661@dell>
In-Reply-To: <20181205113406.GE26661@dell>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Thu, 6 Dec 2018 10:36:22 +0800
Message-ID: <CAFv8NwKgspykPHWfdjapzY-wCAp8MmduKq_yhrvWct2r7yFCzA@mail.gmail.com>
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

On Wed, Dec 5, 2018 at 7:34 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 05 Dec 2018, Lee Jones wrote:
>
> > On Wed, 05 Dec 2018, Cheng-yi Chiang wrote:
> >
> > > Hi Lee,
> > >
> > > I tried to apply this patch based on
> > > for-mfd-next branch of mfd tree (
> > > git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git )
> > > Then, I tried to compile all modules by
> > >
> > >  ARCH=3Dx86_64 make allyesconfig
> > >  ARCH=3Dx86_64 make -j64
> > >
> > > There was no error.
> > > Could you please let me know what was the error when you failed to
> > > apply this patch ?
> >
> > Doesn't work for me.
> >
> > lee@host:~/projects/kernel [for-mfd-next]$ formfdnext
> > Applying: mfd: cros_ec: Add commands to control codec
> > error: sha1 information is lacking or useless (include/linux/mfd/cros_e=
c_commands.h).
> > error: could not build fake ancestor
> > Patch failed at 0001 mfd: cros_ec: Add commands to control codec
> > Use 'git am --show-current-patch' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
>
> Not that the following lines (as seen in your patch) are not present
> in the Mainline kernel.
>
> > @@ -4077,6 +4077,100 @@ struct __ec_align1 ec_response_i2c_passthru_pro=
tect {
> >       uint8_t status;         /* Status flags (0: unlocked, 1: locked) =
*/
> >  };
>
> Do you have other patches applied to your tree?

Hi Lee,
Sorry, I see the problem.
I was using git am -3 which solves the conflict by itself.
I will resend a patch based on your for-mfd-next branch so we can keep
the patch clean.
Thanks for your time.

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
