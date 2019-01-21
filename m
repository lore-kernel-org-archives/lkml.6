Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5425C3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A39120861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbSC4/cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAUWTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:19:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43513 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfAUWTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:19:46 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so25297876qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 14:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w39eLKjc8Fh+HqynLghx8C2xg9PPv384cMHMfitskV4=;
        b=IbSC4/cvTieRSCg/6kd4ELoBnwdDyfv7DBsoK6WwwtdNhuzJM1haWMStO33emirszj
         XueZ8mmRCgM+ACC2EYuqs6ejScRVW6yBXGhkHTfarvTbtAogDVO7vf1lKnMgobMG7OOb
         XiSuwAzeTx9CNeszC+cYtl2TS+x2vV51cHreXdJtXmoXHySjbMHk7zWLL5sttzx7Wg+K
         jXbX+BOebhCWJ3l6MPyNQKHzOLAftnto+pxJlJaM20WQAd6PMEY0Og+LSEByxnJFxgym
         ojbw04nEh6HKg+C3GndX4vUogN00lKD/CWFenzN/bB4iXVWzAMXUnJEZSUUI7qOOzAg8
         1DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w39eLKjc8Fh+HqynLghx8C2xg9PPv384cMHMfitskV4=;
        b=Q4d3PpI1dSUUndmrArxJ4xd6/ETX+EcMGcGXff+1izn77+ZHWp818usU3Cs20Zq/Y/
         YjeJNxGz4Tlo/VRDog/Uzwa9eER+LCYU1FEDg0P6up+XxCzMpjyNjtRd3jcyqnxl8kbn
         0aRXHYLJOS15nZR/E1QJQMoiKQtPNQ0vr/2MO39r5/gBOJidecWYVHT/ptyoWONtbuYX
         DQGfUtBfxyy/70KZRAW9DOeFmPM4KO1E7CkaB4Z79C3x40KVWSixdP516Ephs7WHELoA
         43I+4ZLtRlQ4B51OVXwckJk/9bCjdtKJxdekbQ/Pd/2r1S1QfKbGkSuJ3KHEiovfGD/h
         LRMg==
X-Gm-Message-State: AJcUukeNxNCoXYvjVPLD6NpjzrfnG7tEkFP2O7CXx865BRKO1OFKxGmX
        zpyXp0I0ERhf6+Wv5poGXprGfRBRXmFXkkfOdK4=
X-Google-Smtp-Source: ALg8bN7MIA2dLUnNXTP3lBnjwKBZ4Pv41GvrbvcniKXNE0Fv/ZnL7l7fp2XiJJv0BMjeZDSeVZD8OukmZ0s2bA5WhT0=
X-Received: by 2002:a0c:a8e3:: with SMTP id h35mr26873781qvc.92.1548109185242;
 Mon, 21 Jan 2019 14:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20190110043653.25901-1-mdf@kernel.org> <CAFqH_53Mdh6chEDTkNH_ZGC6scHhXXgp7zdDaSS2Xfd--dfrNQ@mail.gmail.com>
 <20190121184017.GA5761@archbook>
In-Reply-To: <20190121184017.GA5761@archbook>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 21 Jan 2019 23:19:34 +0100
Message-ID: <CAFqH_50fsPx1raFReNt719fT2DmgAb0YHwzzbmfdAy9gYigLiA@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: Add cros_ec_readmem() helpers for
 I2C/SPI based ECs
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Moritz Fischer <moritz@ettus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz,

Missatge de Moritz Fischer <mdf@kernel.org> del dia dl., 21 de gen.
2019 a les 19:40:
>
> Hi Enrico,
>
> On Mon, Jan 21, 2019 at 06:32:48PM +0100, Enric Balletbo Serra wrote:
> > Hi Moritz,
> >
> > Missatge de Moritz Fischer <mdf@kernel.org> del dia dj., 10 de gen.
> > 2019 a les 5:40:
> > >
> > > Add cros_ec_readmem() helpers for I2C/SPI based ECs.
> > > Unlike the LPC based ECs the I2C/SPI based ones cannot just directly
> > > read the mapped region, but have to resort to EC_CMD_READ_MEMMAP.
> > >
> > > This is useful for things like accessing fan speeds or temperatures.
> > >
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > ---
> > >
> > > Hi all,
> > >
> > > This can be used for a hwmon or thermal driver such as [1], but also
> > > alone can be used with 'ectool' via the ioctl() interface.
> > >
> >
> > ooi, did you try this with a Chromebook? Or only with your device?
>
> Nope, mine has a dead battery (and no fans ... :-/)
> >
> > I was a bit worried on the side effects to expose this command to
> > userspace, so I did a quick test, and to be honest I didn't like the
> > result. Issuing the ioctl resulted on a reboot on the Chromebook I
> > tested, which is not good. I didn't investigate more but I can say
> > that this change, at least, will need some rework. I'll try to
> > investigate a bit more on what is happening.
>
> That sounds bad :-/
>
> What chromebook did you run this on (so I can look at the EC code it is
> running and figure out what's the difference). Maybe it has a different
> configuration. It wasn't an x86 chromebook, right?
>

I tried with a Samsung Chromebook Plus (arm64 Chromebook)

> What was the ioctl you ran?
>

The code that I ran is this: https://hastebin.com/cupecuvowi.py
No guarantee :) I'll try to look deeper tomorrow.

Thanks,
  Enric

> Thanks for testing,
> Moritz
