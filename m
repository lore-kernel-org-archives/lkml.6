Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B67C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7697620842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjDhoKbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7697620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbeG1AJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:09:10 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42408 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbeG1AJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:09:10 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so11762354oib.9;
        Fri, 27 Jul 2018 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F5sixhVtl0iCjYlqvQtkLECe8ci5X0TpXFjUAMYKI4U=;
        b=gjDhoKbJ91K0DFHc1Sb50f3H2KMbZ3GaUqNL/ewaQHKzGz15IGkM8Ge/ybNQe0ciZz
         E5Nr/AkXzfyHitJ4a54hP7usqQlt98mHVEXk0FDoP8pPGGr5XgTPjJmBc1ti8ZD5Ec0y
         JbLrhZBQVsuDDPyFMD1WHVNyKM9RooSBzqurrJ/0X/pEl4802dvJAbTGemR6tPZvXQZ8
         UXY5yRiF82Cot0E5KP5CTVdXIJSzVVaKqJo5pLr08g5wNMBFosvkA9dj/ipcL3thyh3E
         oQl+WM9GGO+gHUwtaeXpTyQDuILVWoyA5e/e+JyHpDXpgkNLNJEX/cyK6sFXpWxTkuU1
         E9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F5sixhVtl0iCjYlqvQtkLECe8ci5X0TpXFjUAMYKI4U=;
        b=ittyBD/Xbqfsdaed//yDLQI+Q6cojtSZO342ppNLTcgsrWOl9TrvBiPMGtJYWVwecP
         c0EwNKGDd/3Hjl+ZuqEWMgrthGBhz8LZJ0V+Yr3AZpdkqb6zEMODRodxOb0zYbXVAj8J
         mJoCymMJXDk47Rp9X4P11jAiRDHzAbjtzf9KcJ7ES03VFx6ZsvuUMsm7pdfbhwpqYxFl
         Y4PyMBMs3aF9H3oFEarIVHgU9YwQH8tAOkkoDOyYVSzPAUbLsiW+8b6ZygG6elo5Px/b
         Cnm9dFxk2OBAx7DfaDvAejeesoNJdHCUERZqg8oR6ciXX1yR7K0Ah9rBBJc8HNXWkvo3
         2kYw==
X-Gm-Message-State: AOUpUlFLGC8Tc0FqKhSe59HIqlxbx3Ij0BMNT6NrT9XLBFaIJdjUVPQr
        oCHGGTBT/s1doReAKtTsCl8=
X-Google-Smtp-Source: AAOMgped1HwvbRWZ1yc0DPzcdCllkaUgkbw/z9ZRvmD/OkNwBUgv7fqL7xCHy6tz6TCW8jmz3tzbaA==
X-Received: by 2002:aca:544e:: with SMTP id i75-v6mr3466974oib.73.1532731509297;
        Fri, 27 Jul 2018 15:45:09 -0700 (PDT)
Received: from localhost.localdomain ([12.251.228.178])
        by smtp.gmail.com with ESMTPSA id p15-v6sm3157211oip.6.2018.07.27.15.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 15:45:08 -0700 (PDT)
Date:   Fri, 27 Jul 2018 15:45:06 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 1/3] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
Message-ID: <20180727224505.GD4450@localhost.localdomain>
References: <20180724234636.57137-1-mka@chromium.org>
 <CAD=FV=VODGOE=qvJVeLGBs8xXQvbHZu7S9rqSpMY4AetUjd3fQ@mail.gmail.com>
 <20180726011228.GV129942@google.com>
 <20180727224050.GC4450@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180727224050.GC4450@localhost.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:40:52PM -0700, Eduardo Valentin wrote:
> On Wed, Jul 25, 2018 at 06:12:28PM -0700, Matthias Kaehlcke wrote:
> > Hi Doug,
> > 
> > On Wed, Jul 25, 2018 at 04:19:56PM -0700, Doug Anderson wrote:
> > 
> > > On Tue, Jul 24, 2018 at 4:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > +static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
> > > > +                                            int temp)
> > > > +{
> > > > +       u8 reg;
> > > > +       bool disable_s2_shutdown = false;
> > > > +       int ret;
> > > > +
> > > > +       WARN_ON(!mutex_is_locked(&chip->lock));
> > > > +
> > > > +       /*
> > > > +        * Default: S2 and S3 shutdown enabled, thresholds at
> > > > +        * 105C/125C/145C, monitoring at 25Hz
> > > > +        */
> > > > +       reg = SHUTDOWN_CTRL1_RATE_25HZ;
> > > > +
> > > > +       if ((temp == THERMAL_TEMP_INVALID) ||
> > > > +           (temp < STAGE2_THRESHOLD_MIN)) {
> > > > +               chip->thresh = THRESH_MIN;
> > > > +               goto skip;
> > > > +       }
> > > > +
> > > > +       if (temp <= STAGE2_THRESHOLD_MAX) {
> > > > +               chip->thresh = THRESH_MAX -
> > > > +                       ((STAGE2_THRESHOLD_MAX - temp) /
> > > > +                        TEMP_THRESH_STEP);
> > > > +               disable_s2_shutdown = true;
> > > > +       } else {
> > > > +               chip->thresh = THRESH_MAX;
> > > > +
> > > > +               if (!IS_ERR(chip->adc))
> > > > +                       disable_s2_shutdown = true;
> > > > +               else
> > > > +                       dev_warn(chip->dev,
> > > > +                                "No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140°C! Configuring stage 2 shutdown at 140°C.\n");
> > > 
> > > Putting a non-ASCII character (the degree symbol) in your commit
> > > message is one thing, but are you sure it's wise to put it in the
> > > kernel logs?
> > 
> > A few other drivers also do this
> > (drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c,
> > drivers/macintosh/windfarm_pm121.c), however that doesn't mean it's a
> > good idea. Will change to degC or C.
> > 
> > > > +       }
> > > > +
> > > > +skip:
> > > > +       reg |= chip->thresh;
> > > > +       if (disable_s2_shutdown)
> > > > +               reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
> > > > +
> > > > +       ret = qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> > > > +       if (ret < 0)
> > > > +               return ret;
> > > > +
> > > > +       return ret;
> > > 
> > > Simplify the above lines to:
> > > 
> > > return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> > 
> > Ouch, my code is indeed dumb ...
> > 
> > > > @@ -313,12 +441,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
> > > >         if (ret < 0)
> > > >                 return ret;
> > > >
> > > > -       chip->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
> > > > -                                                       &qpnp_tm_sensor_ops);
> > > > -       if (IS_ERR(chip->tz_dev)) {
> > > > -               dev_err(&pdev->dev, "failed to register sensor\n");
> > > > -               return PTR_ERR(chip->tz_dev);
> > > > -       }
> > > > +       chip->initialized = true;
> > > 
> > > Should we add "thermal_zone_device_update(chip->tz_dev,
> > > THERMAL_EVENT_UNSPECIFIED);" here
> > 
> > Seems reasonable, will do.
> > 
> > > ...also: do we care about any type of locking for chip->initialized?
> > > Technically we can be running on weakly ordered memory so if
> > > qpnp_tm_update_temp_no_adc() is running on a different processor then
> > > possibly it could still keep returning the default temperature for a
> > > little while.  We could try to analyze whether there's some sort of
> > > implicit barrier or we could add manual memory barriers, but generally
> > > I try to avoid that and just do the simple locking...  What about just
> > > setting chip-Initialized = true at the end of qpnp_tm_init() while the
> > > mutex is still held?
> > 
> > Thanks for pointing that out. I agree that we should keep things
> > simple, chip->initialized to true at the end of qpnp_tm_init() sounds
> > good to me.
> > 
> > > I'd also love to hear from someone with more thermal framework
> > > experience to make sure it's legit to return a default value if
> > > someone calls us while we're initting.  It seems sane to me but nice
> > > to confirm it's OK.
> > 
> > An alternative could be to return THERMAL_TEMP_INVALID, however I
> > don't see this handled outside of thermal_core.c, not sure if it could
> > throw some other code off.
> > 
> > Comments from thermal folks on either approach (or alternatives) are
> > definitely welcome :)
> > 
> > > Overall I like the idea of this patch so hopefully others do too.
> > > Thanks for sending it out!
> > 
> 
> minor ask for next version
> 
> 
> WARNING: line over 80 characters
> #159: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:65:
> +#define STAGE2_THRESHOLD_MIN		125000	/* Stage 2 Threshold
> Min: 125 C */
> 
> WARNING: line over 80 characters
> #160: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:66:
> +#define STAGE2_THRESHOLD_MAX		140000	/* Stage 2 Threshold
> Max: 140 C */
> 
> ERROR: trailing statements should be on next line
> #201: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:186:
> +	if (!chip->adc)) {
> 
> CHECK: Unnecessary parentheses around 'temp == THERMAL_TEMP_INVALID'
> #227: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:220:
> +	if ((temp == THERMAL_TEMP_INVALID) ||
> +	    (temp < STAGE2_THRESHOLD_MIN)) {
> 
> CHECK: Unnecessary parentheses around 'temp < STAGE2_THRESHOLD_MIN'
> #227: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:220:
> +	if ((temp == THERMAL_TEMP_INVALID) ||
> +	    (temp < STAGE2_THRESHOLD_MIN)) {
> 
> CHECK: Unnecessary parentheses around 'trips[i].type ==
> THERMAL_TRIP_CRITICAL'
> #305: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:302:
> +		if (of_thermal_is_trip_valid(chip->tz_dev, i) &&
> +		    (trips[i].type == THERMAL_TRIP_CRITICAL))
> 
> CHECK: Alignment should match open parenthesis
> #386: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:427:
> +	chip->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev,
> 0, chip,
> +
> &qpnp_tm_sensor_ops);


And it would be great if you could combine these two in your a single
series, say when you fix this patch and send a new version of this
series, please include these too:
https://patchwork.kernel.org/patch/10543335/
https://patchwork.kernel.org/patch/10543333/

> 
> > Thanks for the review!
> > 
> > Matthias
