Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADB9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6792083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcPeRZzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6792083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965848AbeFSIlS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:41:18 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37113 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965166AbeFSIlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:41:13 -0400
Received: by mail-qk0-f193.google.com with SMTP id j12-v6so10926080qkk.4;
        Tue, 19 Jun 2018 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r42MAAdmoVCgWpB3I4sR+tuJVyC8aMxoYkjbNz+4eCI=;
        b=TcPeRZzQCIqZfb0VVtxr7kf1d9MXtg5Oj0tsQlxb8tdHBp28pFPZT1EaOW5wQgNv5o
         R7naYLwEFn4lNKLPLxt6fSbAUp2k9DtpItAGoGHwNec6A+F0PeT9/U6DgmPyl7wVrnf4
         WnqtooHcyjdoTNY6BCFal49SvmY9yx2Pcz6DA8ETNuz8tpJ5nYZ3JEWw56PzCYmVUgCF
         oTsgG7aFrtK/0aVJya/yuJz3TKfS5DtPHDL+lNapDo/JlfSgw8mYeBORGSlKxyXMLLA6
         /qM7fHH7MOEY7vAyhPeVRAma//ZtDSv9Rn4M85yd9LtoD2SoxrbGqR6+eGSo8Ev18HUT
         3d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r42MAAdmoVCgWpB3I4sR+tuJVyC8aMxoYkjbNz+4eCI=;
        b=GBuK8qZ+SIh/a6MEU53z4E0/oOXou/KZlCS0rmjm5wq3ZaRCEbI1zP0Gp/qkm9g8JA
         vYd8ZclIzrfnvnMKwIDEKWyZE7Akxbrjnumu4+89udeF0UaR4DTcVnyskZOcE8cl017/
         Vph6ixTfGBm6DEWQSQh2wxy8tYD8AJSp12fVV24ktmoL5KxfGyk0A+EOd+JHKb2kZLck
         EoNUUCk5PTDPObVWvYJjPY8XcLOz6bqgp/qO7ql0xLcW9BPHT/YbRulTRtSOEQdFHjdp
         V2bB1AmdOqmxIH3HDntGULk0TPStdMu42Z4X6S/GkMpA4I9cSsEU96bxZQI0Np3QnMkf
         vXxg==
X-Gm-Message-State: APt69E2Us0Jj8XMJdBjq0Iq0oHtrwygxdOHIxLm749oqymiibZwVfzOG
        yaLfACWFOcNIhijaLDq5MpkTcxpc7XqVeHiiG0I=
X-Google-Smtp-Source: ADUXVKJah1i+0ouXYUc2HnbUY0VUsyF9fKnuUl0mEjRVwU2v69/xV1LILrpkR/3zMPEAKtBR7bFAX8XnfVoca60hcoY=
X-Received: by 2002:a37:ba47:: with SMTP id k68-v6mr13069297qkf.105.1529397673033;
 Tue, 19 Jun 2018 01:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180614194712.102134-1-mka@chromium.org> <20180614194712.102134-13-mka@chromium.org>
 <20180618232109.GB154056@rodete-desktop-imager.corp.google.com>
In-Reply-To: <20180618232109.GB154056@rodete-desktop-imager.corp.google.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 19 Jun 2018 10:41:01 +0200
Message-ID: <CAFqH_520Z4nAkXsnKeO9ZGqSSfPg_7f7pjJs=t=ryQTBExfwoA@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] mfd: cros_ec: Add throttler sub-device
To:     Brian Norris <briannorris@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

I am also interested on the answer of Brian comments :). One small comment.

Missatge de Brian Norris <briannorris@chromium.org> del dia dt., 19 de
juny 2018 a les 1:22:
>
> Hi,
>
> On Thu, Jun 14, 2018 at 12:47:12PM -0700, Matthias Kaehlcke wrote:
> > Instantiate the CrOS EC throttler if it is enabled in the kernel
> > configuration.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v3:
> > - patch added to series
> >
> >  drivers/mfd/cros_ec.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > index 36156a41499c..5f52b6e2c21a 100644
> > --- a/drivers/mfd/cros_ec.c
> > +++ b/drivers/mfd/cros_ec.c
> > @@ -91,6 +91,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >       return cros_ec_cmd_xfer(ec_dev, &buf.msg);
> >  }
> >
> > +static const struct mfd_cell ec_throttler_cell = {
> > +     { .name = "cros-ec-throttler" }
> > +};
> > +

As Brian said I think that this should go in cros_ec_dev?

Even when only there is one cell we tend to use the array format (see
i.e the cros-ec-rtc and the others in cros_ec_dev).

+static const struct mfd_cell ec_throttler_cells[] = {
+     { .name = "cros-ec-throttler" }
+};

> >  int cros_ec_register(struct cros_ec_device *ec_dev)
> >  {
> >       struct device *dev = ec_dev->dev;
> > @@ -153,6 +157,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >               }
> >       }
> >
> > +     if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER)) {
> > +             err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
> > +                                   &ec_throttler_cell, 1, NULL, ec_dev->irq,

ARRAY_SIZE(ec_throttler_cells)

> > +                                   NULL);
>
> Most of this similar sub-device registration seems to have moved to
> cros_ec_dev.c, in ec_device_probe(). Should this do the same?
>
> And on a similar note: is there a way to determine EC support for this
> feature (e.g., EC_FEATURE_*)? Or do we just have to listen for
> appropriate throttling events that may never come?
>
> Also, is this very useful on non-DT systems? Does this fail gracefully?
>
> Brian
>
> > +             if (err) {
> > +                     dev_err(dev,
> > +                             "Failed to register throttler subdevice %d\n",
> > +                             err);
> > +                     return err;
> > +             }
> > +     }
> > +
> >       if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
> >               err = devm_of_platform_populate(dev);
> >               if (err) {
> > --
> > 2.18.0.rc1.242.g61856ae69a-goog
> >

Cheers,
 Enric
