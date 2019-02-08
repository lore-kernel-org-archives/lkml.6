Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4876BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F4C21919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549623173;
	bh=klCbsfpMHNFcsyMTTbCCCssHSbItEI00WZA7nu9V+OU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CcgOhyLeLeHLD0UwNHYvw68tsgZE8422h2MiAz3Dr89PRoSL1ZZUn6VfbpWURUv9c
	 9EXpaI1ahWgLRdJ65wDY9QzzzJVfV+DnfHoZbUIq5LNd2fB3Y5mUf0HHf2X6nl/Duu
	 ybexv0yI0w2/Lg9lTKT9FqXoPeDGx8gnYGqFK/wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfBHKwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:52:51 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43779 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:52:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so5069728otr.10;
        Fri, 08 Feb 2019 02:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaqXY24CoPBcisgxoA2Xzo8Hq8vVjMfrseZDD3ry7d4=;
        b=jwaxjSxZzKahSheVo+vuS5bhefUAoMRmNgd7/1bFIM2m7d1e+Zz9V9GNmPpFne7vVY
         fzNoXRK8yjv6LTcvlkwcciWUmf7qt0MHg4kMsQYJOBavUtJDNJNsgQpDZgMfuSuztM3U
         9ZB6HKsiYVN5Dp49n8AXDxtXOVArEz0TiAAhwXDDmBEUtngqYzFA3peysXh5+dovcQz4
         zxo7bN39kuh1UDaXh8yYSrb0cgbqEEmRs+tqAC47HKuUxkelSwyNjIf2FkOlfTbmrWZO
         7SapN7lkMTPyK/5joyzJ083DEDT+md2wIfJyBvq7HhKUgqFL1rj4YURINYyjhXaNfboB
         5n8w==
X-Gm-Message-State: AHQUAuZ4JH3Cf3OsTeSe9RD6VuuCi+T0jHqhzuoNLbXCRWjrMO6QqbGl
        WlbbZ7SdgMGqR5Dv77E29vWi/Y9c4TT1x32e8yw=
X-Google-Smtp-Source: AHgI3IZhIpjUh7Dw0Nx+aum8zHYQBye3aUdVSQEiS2y2A5OI+7zhVpY4xiuj/I9qPMSmMhRhuwz2K16F/jpL8j7+Ctw=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr12680524oti.258.1549623169842;
 Fri, 08 Feb 2019 02:52:49 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com> <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
 <20190208103133.ysvaroyniuc3k4i5@vireshk-i7> <CAJZ5v0ghQ6bTV8atd6dtq8=ZBDUpDRVsCiAhwQVtfoMH-JhH9A@mail.gmail.com>
In-Reply-To: <CAJZ5v0ghQ6bTV8atd6dtq8=ZBDUpDRVsCiAhwQVtfoMH-JhH9A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 11:52:38 +0100
Message-ID: <CAJZ5v0ih+CgYtt5FFb0thCEkCMpXfQHFaLugCOf_FAikCHgK6w@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 11:42 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Feb 8, 2019 at 11:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 08-02-19, 11:22, Rafael J. Wysocki wrote:
> > > There are cpufreq driver suspend and resume callbacks, maybe use them?
> > >
> > > The driver could do the I2C transactions in its suspend/resume
> > > callbacks and do nothing in online/offline if those are part of
> > > system-wide suspend/resume.
> >
> > These are per-policy things that we need to do, not sure if driver
> > suspend/resume is a good place for that. It is more for a case where
> > CPU 0-3 are in one policy and 4-7 in another. Now 1-7 are
> > hot-unplugged during system suspend and hotplugged later on. This is
> > more like complete removal/addition of devices instead of
> > suspend/resume.
>
> No, it isn't.  We don't remove devices on offline.  We migrate stuff
> away from them and (opportunistically) power them down.
>
> If this is system suspend, the driver kind of knows that offline will
> take place, so it can prepare for it.  Likewise, when online takes
> place during system-wide resume, it generally is known that this is
> system-wide resume (there is a flag to indicate that in CPU hotplug),
> it can be "smart" and avoid accessing suspended devices.  Deferring
> the frequency set up until the driver resume time should do the trick
> I suppose.

BTW, do transitions to idle states involve I2C transactions on the
systems in question?
