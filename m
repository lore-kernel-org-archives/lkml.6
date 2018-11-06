Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD774C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A0C2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m55SlYDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A0C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbeKGGCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:02:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42851 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbeKGGCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:02:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6-v6so6749048plo.9;
        Tue, 06 Nov 2018 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bY2o52TAYUV8ug6X2YaKXi0UjDfdrQ75KYQUWQ2zbS4=;
        b=m55SlYDPdO3ZNQ7CxWjMsGcA4+Oc20zEphmJMlv2SoVpIXrZB2tUnJf3yyCXiOGEu2
         u3n95py8IZRnIhTYHiw8ni/aXplQN/ZDeVPF0wBx3C0y69Kv+tNE115AYYrpUx1gEtcI
         6MGeTYiMtrBnjhrcmqRxBMTnRUqhRmdEu+gRB/m9wdaA8YORT7UWi66de1u+bR+t9LWE
         aAnQ+5XcahWaDTQvcsp1HN84Z/tRIOEgMWsAklXECvmd8ScWcIjMEIjEMuZ9Kjns1S8f
         hC+Spwrh8UrUYOGQ2YDic/zvJCHS9b8Ic3Ygh7pmEYt2dmeZktrh9o12rQl1SAGu9VI7
         ysgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bY2o52TAYUV8ug6X2YaKXi0UjDfdrQ75KYQUWQ2zbS4=;
        b=t2KJqKstqD/vRp6Ee89wRvdY/9NugI1Scr4GL1n4XwUCeCiEhf0rINgP5BmmdJ+5PN
         fpP1L5PpYImyO9y1jehsG67W+5cXuo/lfHbP/gG3crOrXyZbyTko/a6xwP2YLVNhM2bT
         6wlPEwHrfGps1bQpdNDW1Vt7BpCcABwk1wMCtNuxp9yJZCpm2jviSDq22H3oUslT7gFj
         w77+iIo9gYqKPMUnhdBgo1T0g2/8gJpg6BIVwnleIEcXXsix+BD4KT0CZYQFQworfAzY
         TpwSRYgcuTUiei41uKYCP0I+cOy8eYCqgGw7rffqoDD9EAomitUylqsXUCbQJ/yXNPFI
         9Upg==
X-Gm-Message-State: AGRZ1gJi/pGHvwNtASDAZSyCsLZvI+MDxg8MlQFkyIJOJSEdjA+GmmfM
        20z58wYqBArLGJ9zDbJtDG6Fw2kgMby2GYrWpTY=
X-Google-Smtp-Source: AJdET5eQoQ1q6WtUFNXZIZxA0A+XAdURBh/OQLkBY6fzoPF+cZ7dUAaeZX2ITNIW1eGyvClTEo+5anwma0BWcVyANSw=
X-Received: by 2002:a17:902:b83:: with SMTP id 3-v6mr28735487plr.202.1541536501874;
 Tue, 06 Nov 2018 12:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20181103065732.12134-1-jprvita@endlessm.com> <20181105091917.GD4439@amd>
In-Reply-To: <20181105091917.GD4439@amd>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Tue, 6 Nov 2018 12:34:25 -0800
Message-ID: <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2018-11-02 23:57:32, Jo=C3=A3o Paulo Rechi Vita wrote:
> > Commit 19fffc8450d4378580a8f019b195c4617083176f fixed reporting
> > "Discharging" on some machines when AC was connected but the battery wa=
s
> > not charging. But now on these machines the battery status is reported
> > as "Not charging" even when the battery is fully charged.
> >
> > This commit takes the battery capacity into consideration when checking
> > if "Not charging" should be returned and "Full" is returned when the
> > capacity is 100%.
> >
> > Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>
>
> We have people trying to modify this and it caused regressions in
> MATE, IIRC.
>

Do you have any pointers for further information?

> Plus, I don't think "100% charge" is right test for "battery full". At
> least on thinkpads, there's configuration option, and it is common
> _not_ to charge batterry above 95% or so (to increase its lifetime).
>

This will only affect machines where the firmware wrongly reports the
battery state as discharging, which the commit mentioned on this
commit message fixed so we now report it as not charging. From your
comment it does not sound like thinkpads are in this category. In any
case deciding to report battery full for any percentage other than
100% is a policy decision, which is normally left out of the kernel.

>
>
> >        * was plugged in and the device thus did not start a new charge =
cycle.
> >        */
> >       if ((battery_ac_is_broken || power_supply_is_system_supplied()) &=
&
> > -         battery->rate_now =3D=3D 0)
> > +         battery->rate_now =3D=3D 0) {
> > +             if (battery->capacity_now && battery->full_charge_capacit=
y &&
> > +                 battery->capacity_now / battery->full_charge_capacity=
 =3D=3D 1)
> > +                     return POWER_SUPPLY_STATUS_FULL;
>
> Division? Really?
>

If you look further down in acpi_battery_get_property, that is how the
capacity property is calculated. Do you have a better suggestion?

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
