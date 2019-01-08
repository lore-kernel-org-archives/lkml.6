Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC901C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93692087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBEh0Pdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfAHQV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:21:26 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42271 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfAHQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:21:26 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so4947196qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=07BzCdpckXQqtk9KgXjEnM5LyJCw7Na2QsPG1DGciJQ=;
        b=uBEh0Pdx9atTEhwbfv3jz6u6ix5dq8fjrq+x0m6CkzFu5N4bacu+mZH/7tN2c4yLEs
         9Y2B4x00iAu7MafB4YN6NrLKSPvRXnzbSRcuoaH2OuZ2eoi87yiw7lbII1+QpSeA0XGS
         sncdATfgFOAwhsnvRDVYP/tvnzpg3my9yghOGj12upApyUt679BPtXrz7yegBE47bP5G
         lU4lkwzjJ75VctGrIWh9cJIFLn6OChVw5ennwutvyheXmsQYMTJ5zJgvgyojPTkj47qo
         +3Ve6ZOtTgJZdJCi4y7Cv36b9NlK7CmD/jexOIBhm/l+FnqEUgvKCuGvwzT2g/93MtPg
         4QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=07BzCdpckXQqtk9KgXjEnM5LyJCw7Na2QsPG1DGciJQ=;
        b=pwhi1QDy9q6ZdZOOD4991QVUknKboV1alugEC7D17N5QE8IDDJUCGOcqqs55JEJng9
         Fxwjrkq0COkcqJF4NbiCManu04hV0ua5oKX6Qvsr7UexzPhaRUCbpm8IXvTBeVhzorFm
         HtkmZqWwyC2trVb8XFqBsHGAMMU6Ejyn2TEY2bC9cbotPHgv/9hGhVrqJ+6aXcctGpXE
         tPXmRr/gTuthAFWIOM6pMTOES7TGYEdPKMVodAbz6iZ2EWb7jU/NBKtntGw/W2AE6zx5
         xT/c8Klccd5hTLef0lNu708Z+XK6RHjPdiQKweVJwG68rkFgkN80DvkZ2lWIq84iD49v
         A9FA==
X-Gm-Message-State: AJcUukf4nuPa8osOyDGwzYK9z5PPPnUumjqIJaRXMFnN2NJUH/cX5tJJ
        volcBEV9d55MHsi84bR3VC5C2mkuvT7imnQ2eRk=
X-Google-Smtp-Source: ALg8bN55WaHJOK2rTGQZxTuOwLpimQjtio/s+BS6YJLpdWN7gKOVZ7g3FgFqm9XOsAEyFrQV6fjM5M+AlnGP9HFa++c=
X-Received: by 2002:a0c:9a4a:: with SMTP id q10mr2280267qvd.150.1546964484715;
 Tue, 08 Jan 2019 08:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20181212173402.27086-1-enric.balletbo@collabora.com> <20181221091001.GA13248@dell>
In-Reply-To: <20181221091001.GA13248@dell>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 8 Jan 2019 17:21:13 +0100
Message-ID: <CAFqH_51mrsb=cBOeBL0avyYGogZ-MtMUpKUS7avXGT9Q2JmWHw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] mfd / platform: cros_ec: move cros_ec sysfs
 attributes to its own drivers.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Missatge de Lee Jones <lee.jones@linaro.org> del dia dv., 21 de des.
2018 a les 16:39:
>
> On Wed, 12 Dec 2018, Enric Balletbo i Serra wrote:
>
> > Hi,
> >
> > This is another patchset to try to cleanup a bit more the crossed
> > references for cros-ec driver between the MFD and the platform/chrome
> > subsystems.
> >
> > The purpose of these patches is get rid of the different cros-ec attrib=
utes
> > from mfd/cros_ec_dev to its own sub-driver in platform/chrome. cros_ec_=
dev
> > continues instantiating the sub-devices but the sysfs attributes are ow=
ned
> > by the platform driver.E.g. The lightbar driver should own his sysfs
> > attributes and be instantiated only if the Embedded Controller has a
> > lightbar.
> >
> > The patchset also adds the documentation of the sysfs attributes.
> >
> > Most of the patches touches mfd subsystem and platform/chrome so I'd
> > suggest go all using and inmutable branch.
>
> That's fine.
>
> What else needs to happen with this set?
>

I think the patchset is ready to be queued. Note that to apply cleanly
it depends on [1] which is already merged in your for-next branch.
What do you prefer, go through your repo or go through the
chrome-platform repo? Do you want Benson or I create an immutable
branch? I'm fine with whenever you decide.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=
=3Dfor-mfd-next&id=3D18e294ddafaeb80a1e2e10c9bd750a6cb8388d5b

> Any more Acks required?
>

I think that you, Guenter, Benson and I are fine with it, so not more
acks needed.

Thanks,
 Enric

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
