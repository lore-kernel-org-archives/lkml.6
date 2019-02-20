Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD916C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0231206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ0v47rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfBTLYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:24:52 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35567 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfBTLYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:24:52 -0500
Received: by mail-it1-f194.google.com with SMTP id v72so14622645itc.0;
        Wed, 20 Feb 2019 03:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pej40aTzZudntREJijTOj+YRqKj+1YHrS16H3FeI+r8=;
        b=BJ0v47rpp3ckMeIuXkx5NOU1uoboEA17K9GolsCpwuiEAUzNsZ30UMQwLymaUmtqpx
         aTvntCNMuLPZp534rx+gVP894yvpq3XKBCpxT5EypAnI373n476zOdq8bU2gjihaNJzc
         f+UnGeQO0zvX4wrYjs+r81R16AxRSC8AFjHb67DPKZgEaNDvNn82ufEPoSomOvqlDkxH
         4AzbL4mGBdrz8FPNNVM6AK4MfmezkKQD8v4Nm736TFk1tFwhwbx27Lcok8lVSFdv5uHx
         T+I15HeXvKshy0LuPhnHvkF0sffbDZl8M9BGzb9JNxPlulA5NSvdOK/SFhDlXBanNhKg
         Kekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pej40aTzZudntREJijTOj+YRqKj+1YHrS16H3FeI+r8=;
        b=SFBL99MkhhqtDkdF8vDvvsfWaZr6zKD6YGV7Sjk8AWEBXF5+T1DNtd3cW5Nn3Nal0j
         w98p0O3eOnRupZLOYSDcQ+OXWJa9ZHAHF1ZqT1XzLoCCjFGqbHMvP3gDKpPcLvF2rsNF
         ikXqyHRh+VsF69CaDkv8L4mKbX+tpPGDcWpjQZ2ytUUtAThAM80a4AZjOf4YenlW0OeI
         MjBOr3RHT7mrJDZbKddORxIb268Inlfpkj1ZqQWPkKzLH5SecDzKt1sJlMIS0KbUqjfe
         f4gi1hK953gtm+134RukapSly+iqPAaE8bnXRlxA3TADsKQBs00w2gI/FSoks9mE+5oG
         M/6A==
X-Gm-Message-State: AHQUAuYPGHkS3RU8NJDX3w94C8wGVh+tgfioKMAdVzC7PGw61pGnVU56
        5qgnSFHugLFwiZVOg7eXD5Em8YqthJxe7L3tg0Y=
X-Google-Smtp-Source: AHgI3IbADwUQoo5uAayarY9IB14Zs0CD4qdrsBDaJ+oRavNTaPaoIm7P7y74ILTJYTTT0jB99C8Au8VFrdRc9Bt+ZUU=
X-Received: by 2002:a24:ee8c:: with SMTP id b134mr5711190iti.162.1550661890717;
 Wed, 20 Feb 2019 03:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20190220101017.19587-1-e.velu@criteo.com> <CAJZ5v0i5BVFRKsCVxDwG90vBAuS3QYB=-GkC0pbGLy5DWDXuMg@mail.gmail.com>
 <1d9ff7a8-5f05-6554-d019-9665536aea84@criteo.com> <CAJZ5v0iHh2VC1b90G+bXP0WpBmJ__Ba=yAjjCifkMRmd5xrmuw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHh2VC1b90G+bXP0WpBmJ__Ba=yAjjCifkMRmd5xrmuw@mail.gmail.com>
From:   Erwan Velu <erwanaliasr1@gmail.com>
Date:   Wed, 20 Feb 2019 12:24:38 +0100
Message-ID: <CAL2JzuyyFeX6rE3vTASV2gikXp8xB-WtnSo4YazccaxfcE_nQg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Report if CPU doesn't report boost technologies
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Erwan Velu <e.velu@criteo.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to put the message in a way to stay neutral, not saying if its
a real error or not.
Just reporting we were not able to find any boost cap on it.
Erwan,

Le mer. 20 f=C3=A9vr. 2019 =C3=A0 12:16, Rafael J. Wysocki <rafael@kernel.o=
rg> a =C3=A9crit :
>
> On Wed, Feb 20, 2019 at 11:52 AM Erwan Velu <e.velu@criteo.com> wrote:
> >
> >
> > Le 20/02/2019 =C3=A0 11:41, Rafael J. Wysocki a =C3=A9crit :
> > > On Wed, Feb 20, 2019 at 11:11 AM Erwan Velu <erwanaliasr1@gmail.com> =
wrote:
> > >> There is some rare cases where CPB (and possibly IDA) are missing on=
 processors.
> > >> This is the case fixed by commit f7f3dc00f612 ("x86/cpu/AMD: Fix err=
atum 1076 (CPB bit)") and following.
> > >>
> > >> In such context, the boost status isn't reported by /sys/devices/sys=
tem/cpu/cpufreq/boost.
> > > So I'm not really sure why the extra message is needed.  It looks lik=
e
> > > this message will always be printed (with debug output enabled) if th=
e
> > > current cpufreq driver is acpi-cpufreq and the boost attribute is not
> > > present in sysfs, which only is the case if CPB/IDA aren't there.
> > >
> > > Does it provide any additional information, then?
> >
> > When you know and read the code, yes this patch is too obvious.
> >
> > As a user when I was troubleshooting why the boost entry was _not_
> > populated on one CPU and was populated on another.
> >
> > Running acpi-cpufreq with dyndbg, I would have found useful to get that
> > hint.
> >
> > So that could helps users that never read that part of the code and
> > which are tricked into that configuration.
>
> OK, I see your point.
>
> I'll queue up the patch, but I guess I'll change the message.
