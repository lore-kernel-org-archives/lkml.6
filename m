Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B452C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DA22083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HckFtzuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DA22083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbeGKJod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:44:33 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55296 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732628AbeGKJoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:44:32 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so2701186itl.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T74tLX3fExeld/V/O/D5m9jiyqNSKpGgVnttQk58Gnc=;
        b=HckFtzuLtGCZ8dYAm+oQrNPwL5DnNcACnAcWAUGhORaznLe12dx7z5Srcw/ZJGlvym
         /M5tnRE61PscLvGTYO26AhzW+PpbWJ5YpqHC+Ue2k5DHYETp+T8aCAoNbyR7DodBpgQp
         IzUuyj9L+GKokzO6kWGfX/acVhsV8+VOUPjso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T74tLX3fExeld/V/O/D5m9jiyqNSKpGgVnttQk58Gnc=;
        b=h4O+49fp1SF+CvMLtnHRbAdZe67A6CQ6dpU9LEfOJlUzcUhR6mxqmBjRvi2VSHl926
         3PCZzAzr0aeQx/ZLdx/61ujS8ey/k+2ZYsgfvC55f/BfjHyYWE21nS9W4ekx/OAk36UL
         bu30Th7elqBSNS8ROgoDLZEU3KGGgI0PlUmabqaQgB+GKkhfO7s5gGBMGCncPBpUj8v5
         7DD6d5wqra35RKh/br/AKMQmG7XiRKXCYSaF9AvGFyOAb/3NNr4klqFtmk+v+9/PiacQ
         eT0Cpk3sLv13xPIheodmO7pQkV2dWT2uYOQ7urmzU3vy5Tnv13j1ejk29i8CCKPwOhRp
         4tXA==
X-Gm-Message-State: APt69E0/dzjZI3j0sDU1fcegCeGminjcsNuzBoelXG1Se5z82T45J9SI
        +MosHbTVj0H9KGklLNQ79//FiYjwIufuT4xFjMkHYg==
X-Google-Smtp-Source: AAOMgpd3dxcSRg/9nXzSncWcPzzurBmoo3ut8L27uSMW9gWZfbb9NzejRWv67GwgUMxtNU1BdWUY2vAb6XdJCFdLa80=
X-Received: by 2002:a02:570c:: with SMTP id u12-v6mr23637336jaa.142.1531302065394;
 Wed, 11 Jul 2018 02:41:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 02:41:04
 -0700 (PDT)
In-Reply-To: <CAL_Jsq+dcwZHKFGy+BGOyV+Yyz0qgmeq8zoT=DkB+c+DsXdApQ@mail.gmail.com>
References: <20180709154153.15742-1-robh@kernel.org> <20180709154153.15742-7-robh@kernel.org>
 <CAPDyKFoN1=16dGKmkFp6Khgs5zx+BguOs3qOcm+rAZw=b38JVg@mail.gmail.com> <CAL_Jsq+dcwZHKFGy+BGOyV+Yyz0qgmeq8zoT=DkB+c+DsXdApQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Jul 2018 11:41:04 +0200
Message-ID: <CAPDyKFp7qNe6Yp62GyRcfc2TBxqqexMxqQkZ-Hc3YFoy-_7ZLw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] PM / Domains: Stop deferring probe at the end of initcall
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 July 2018 at 16:25, Rob Herring <robh@kernel.org> wrote:
> On Mon, Jul 9, 2018 at 4:49 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 9 July 2018 at 17:41, Rob Herring <robh@kernel.org> wrote:
>> > All PM domain drivers must be built-in (at least those using DT), so
>> > there is no point deferring probe after initcalls are done. Continuing
>> > to defer probe may prevent booting successfully even if managing PM
>> > domains is not required. This can happen if the user failed to enable
>> > the driver or if power-domains are added to a platform's DT, but there
>> > is not yet a driver (e.g. a new DTB with an old kernel).
>> >
>> > Call the driver core function driver_deferred_probe_check_init_done()
>> > instead of just returning -EPROBE_DEFER to stop deferring probe when
>> > initcalls are done.
>> >
>> > Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> > Cc: Kevin Hilman <khilman@kernel.org>
>> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> > Cc: Pavel Machek <pavel@ucw.cz>
>> > Cc: Len Brown <len.brown@intel.com>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: linux-pm@vger.kernel.org
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > ---
>> > v4:
>> >  - Add Rafael's ack
>> >
>> > v3:
>> >   - Update to new function name
>> >
>> >  drivers/base/power/domain.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> > index 4925af5c4cf0..8c12213875c6 100644
>> > --- a/drivers/base/power/domain.c
>> > +++ b/drivers/base/power/domain.c
>> > @@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
>> >                 mutex_unlock(&gpd_list_lock);
>> >                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>> >                         __func__, PTR_ERR(pd));
>> > -               return -EPROBE_DEFER;
>> > +               return driver_deferred_probe_check_state(dev);
>> >         }
>>
>> This isn't the only error path where -EPROBE_DEFER may be returned
>> during attach in genpd.
>
> Yes, but I think this is the only place you can fail to get the PD
> device from DT. The case we care about is properties exist in the DT,
> but no driver exists.

That's correct. Thanks for clarifying!

>
> What would cause deferring in the latter cases?

To power on the PM domain for example, which often is required to be
able to probe the device.

>
> Rob

Kind regards
Uffe
