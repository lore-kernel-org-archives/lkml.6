Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0819FC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55CD2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDspKjqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55CD2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeKBCV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:21:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35503 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeKBCV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:21:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id v198-v6so14454533oif.2;
        Thu, 01 Nov 2018 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ja5+SX8X21S23RLr//Uvzp6RIdtLq4GmGo+EW5X8r68=;
        b=KDspKjqx5PU5KvRhQhvJcP/3kYXdeobzESLYFtcrVD8F7sAuXvyQyx5XZiBYxBeh4/
         A3kbOiFw/oNu4LGwmWg1MFF0B3cW9brKBc4xyYX0ZpLDYLXuBSo/8FNp/atx/dYco8C+
         LJXHbW8jIRTpLW1QgsH9kTs6V6QLdag2hmZBphUrXu+0CMXjJ9aVSByKd+McDWux8cEa
         PeWiixBiFYJgrn0yXyOJa718Ht/rKSDxzblZzYExLLCBn3QUbm95bdsiPsI8B/aXFItG
         zT/7A01ZF3m4LXH2d5kKh/BdhlEFTEVcrRqmV56GHb6YjtWnWAhIEmXs7RwVArGhVm14
         jIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ja5+SX8X21S23RLr//Uvzp6RIdtLq4GmGo+EW5X8r68=;
        b=l2uW0jZKh34D+E4OVxyinwPSCuTTS2bjMERoPOATuRXunEmmZSAgPl/ueg6Nt44X18
         I6EK1G75JynLGYyuihLfOJFwJf0qeMCtAVSxtHQQM1Gn8iPlXQdOHSe2F69uy5kRZRos
         LTH9w/Ys3HYxD4y5LqMYQs3n3IAGo5Tde/ivrVA6yiqGE31mAqxLEOhLqMkIPcIl10wn
         FsRIh52+uAuXWI/9EE3eFFmWvylmkUC7dPM3+lMwdTlyTGW75HU+4ByoPLHO9Ym//FR+
         V+cm9SVLHLZJfpTYanlNmr2p91VNxYEMqsjPUHnsC6y+X52IZswMoUYCxTluShMxxrCm
         xAEA==
X-Gm-Message-State: AGRZ1gLc9uX1A3QKQ9h35b/n5wQllgB1CKkheLg3uu3rxzAnHPf1BIOW
        jgg4Uw6BXtc5MaRjiJPtpQ9Nh6+LomHYxZfmWTo=
X-Google-Smtp-Source: AJdET5eY+MgoErwRNeGSHfo823YkMrm3qfHzYOaBUdFyPHxDD+2T+UrR/uJK6isCHw2OWsjVe2tKbDE2bw14QYSlXCY=
X-Received: by 2002:aca:b389:: with SMTP id c131-v6mr4537966oif.330.1541092654127;
 Thu, 01 Nov 2018 10:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181031194425.32132-1-TheSven73@googlemail.com>
 <20181031194425.32132-2-TheSven73@googlemail.com> <CACRpkdai-6iNbz4EGuHNHkQYyR+yhTEJdRXP4G6fUKpA+XApjQ@mail.gmail.com>
In-Reply-To: <CACRpkdai-6iNbz4EGuHNHkQYyR+yhTEJdRXP4G6fUKpA+XApjQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 1 Nov 2018 13:17:22 -0400
Message-ID: <CAGngYiVorxYY+8e75068i4=PJi1gEvnGkgvBfi0+9H+c1qD-oQ@mail.gmail.com>
Subject: Re: [PATCH anybus v2 1/5] misc: support the Arcx anybus bridge.
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> This is fun :)

It sure is ! It's fascinating to see how the kernel abstractions are designed,
and how code is reviewed here.

>> +static DEVICE_ATTR_RO(version);
>
> Do you need this in userspace really?
>
>> +static DEVICE_ATTR_RO(design_number);
>
> And this?

Unfortunately, I do :(
The application software reads these out and displays them in an UI. It's
important to be able to see these on a running device.
Perhaps there is another kernel abstraction I could use?

> This:
>>
>> +       cd->reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
>> +       if (!gpio_is_valid(cd->reset_gpio)) {
>> +               dev_err(dev, "reset-gpios not found\n");
>> +               return -EINVAL;
>> +       }
>> +       devm_gpio_request(dev, cd->reset_gpio, NULL);
>> +       gpio_direction_output(cd->reset_gpio, 0);
>
> Should be:
>
> cd->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> if (IS_ERR(cd->reset_gpiod))
>     return PTR_ERR(cd->reset_gpiod);

That's actually pretty neat !
Now we have nothing that explicitly refers to the devicetree (except the
device binding, of course). I now see the point you made earlier:
resets, gpios, interrupts etc are associated with "struct device" and
not necessarily with the devicetree.

The rest of your suggestions have already gone in.

I hope you'll have some time later to look at the architecture description
in the bus driver. Looking forward to your feedback and to the next iteration !

Cheers,
Sven
