Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C0DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296C4204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4c37Lrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296C4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbeJ3FMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:12:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42683 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbeJ3FMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:12:06 -0400
Received: by mail-io1-f67.google.com with SMTP id n18-v6so5832472ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VGpz0pPFr/WjkfyRARlME8X0Ya2Wf3uXpp6ohQfnPM=;
        b=W4c37LrjNvPQCgQYilDFzG0O8oLm+JNHQCGNUf8pQKD6BP+6x7Qi7GyK454ucjv/Nk
         qywsNQFrgkrWMESCt6lboRCNRNKkmS1Z8cJrZTbFJd+OHwGWPj3SJiLJUcZS0sqrtegH
         yAgQMXwkbhnPlwSP/gJIb8p6ShXmNux73yYHBSc/bstl3lSU6SNeqHmxv1b1xUMFC0HR
         igHFSyQOZ4VfFfjwnCI57ctWiNvRFqHVSElsBzwvZUtdCThRlRq8mozuPBucNFZ89RYp
         hcExpb3r2wwEnvpj0EPpyuFlyD7Z4GrDDYP22dnP6keOSECo56cpt4oMxP2RppBzDzbf
         ttfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VGpz0pPFr/WjkfyRARlME8X0Ya2Wf3uXpp6ohQfnPM=;
        b=k4fWOqSFZDbF/tuxmwwDqtj3wGfIdFtGj/edppqJrGt6oIJW3Krvodek85MGkaLKEm
         65vGh8i29wBtsO1ehzu+Ju3Pmudl4Lo37WtLbha5YTYMa25AuOqbH9zP8EKC9Es7kVIr
         J2YgmafU0WHJFF1kGBDUyiBCi7TL7a4XYOE54fDUQcm8XdZloj2LgtumDA0iepYIlp1i
         QJ/zZ2iXLmOlFHvFNH38vTcz5ZGfHDOGdN9mxGvkTotE+5m9uB0+wVdRFHitmoeDcmc9
         TsLR2ZHsGZqEmb9dxEga1sp2ICLk84aJ5I+2kToPZInADS1Gqw/TEykxwvEqM9hQMJzl
         FnCQ==
X-Gm-Message-State: AGRZ1gK8RSGw2GEf0Ll6v6CyEkcMjFkX2KgBA3INOo91Cget4K4c9MPv
        gOlRFECvG+Ha8ETUCJLtov8VvxhXmXLMX/gwfQi+lQ==
X-Google-Smtp-Source: AJdET5fUXEC2NmSa+EcduL0FzfgvXi28Ovm2vpn0cRzfozolMgWdXTpv3GiqN89phwMbZ6lt08qQKPACTtn5Rb9kVjU=
X-Received: by 2002:a6b:9046:: with SMTP id s67-v6mr8927335iod.295.1540844509710;
 Mon, 29 Oct 2018 13:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181017222639.254434-1-kunyi@google.com> <20181027172833.GA25052@roeck-us.net>
In-Reply-To: <20181027172833.GA25052@roeck-us.net>
From:   Kun Yi <kunyi@google.com>
Date:   Mon, 29 Oct 2018 13:21:23 -0700
Message-ID: <CAGMNF6Xg28hm05wPXtq9bqssoNmgrzFGQiG4P+vLyXKvzvdJCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hwmon: (adm1275): Allow setting shunt reg value
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>, jdelvare@suse.com,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 10:28 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Oct 17, 2018 at 03:26:39PM -0700, Kun Yi wrote:
> > The ADM series of hotswap controllers support extending
> > the current measurement range by using a sensing resistor
> > value other than the typical 1 mOhm. For example, using a 0.5 mOhm
> > sensing resistor doubles the maximal current can be measured.
> >
> > Current driver assumes a shunt resistor value of 1 mOhm in calculation,
> > meaning for other resistor values, hwmon will report scaled
> > current/power measurements. This patch parses device tree parameter
> > "shunt-resistor-micro-ohms", if there is one.
> >
> > Signed-off-by: Kun Yi <kunyi@google.com>
>
> Applied to hwmon-next.
>
> Thanks,
> Guenter
>
> > ---
> > Changes in v3:
> > - splitted hwmon and device tree binding patches
> >
> >  Documentation/hwmon/adm1275   |  3 +++
> >  drivers/hwmon/pmbus/adm1275.c | 15 +++++++++++++--
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
> > index 39033538eb03..5e277b0d91ce 100644
> > --- a/Documentation/hwmon/adm1275
> > +++ b/Documentation/hwmon/adm1275
> > @@ -58,6 +58,9 @@ The ADM1075, unlike many other PMBus devices, does not support internal voltage
> >  or current scaling. Reported voltages, currents, and power are raw measurements,
> >  and will typically have to be scaled.
> >
> > +The shunt value in micro-ohms can be set via device tree at compile-time. Please
> > +refer to the Documentation/devicetree/bindings/hwmon/adm1275.txt for bindings
> > +if the device tree is used.
> >
> >  Platform data support
> >  ---------------------
> > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > index 13600fa79e7f..f569372c9204 100644
> > --- a/drivers/hwmon/pmbus/adm1275.c
> > +++ b/drivers/hwmon/pmbus/adm1275.c
> > @@ -373,6 +373,7 @@ static int adm1275_probe(struct i2c_client *client,
> >       const struct coefficients *coefficients;
> >       int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
> >       int tindex = -1;
> > +     u32 shunt;
> >
> >       if (!i2c_check_functionality(client->adapter,
> >                                    I2C_FUNC_SMBUS_READ_BYTE_DATA
> > @@ -421,6 +422,13 @@ static int adm1275_probe(struct i2c_client *client,
> >       if (!data)
> >               return -ENOMEM;
> >
> > +     if (of_property_read_u32(client->dev.of_node,
> > +                              "shunt-resistor-micro-ohms", &shunt))
> > +             shunt = 1000; /* 1 mOhm if not set via DT */
> > +
> > +     if (shunt == 0)
> > +             return -EINVAL;
> > +
> >       data->id = mid->driver_data;
> >
> >       info = &data->info;
> > @@ -654,12 +662,15 @@ static int adm1275_probe(struct i2c_client *client,
> >               info->R[PSC_VOLTAGE_OUT] = coefficients[voindex].R;
> >       }
> >       if (cindex >= 0) {
> > -             info->m[PSC_CURRENT_OUT] = coefficients[cindex].m;
> > +             /* Scale current with sense resistor value */
> > +             info->m[PSC_CURRENT_OUT] =
> > +                     coefficients[cindex].m * shunt / 1000;
> >               info->b[PSC_CURRENT_OUT] = coefficients[cindex].b;
> >               info->R[PSC_CURRENT_OUT] = coefficients[cindex].R;
> >       }
> >       if (pindex >= 0) {
> > -             info->m[PSC_POWER] = coefficients[pindex].m;
> > +             info->m[PSC_POWER] =
> > +                     coefficients[pindex].m * shunt / 1000;
> >               info->b[PSC_POWER] = coefficients[pindex].b;
> >               info->R[PSC_POWER] = coefficients[pindex].R;
> >       }

Thanks!

-- 
Regards,
Kun
