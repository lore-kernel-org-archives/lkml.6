Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF82FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952FD20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iD8y8ins";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="POvHaYM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952FD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbeGZAdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:33:54 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36471 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbeGZAdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:33:54 -0400
Received: by mail-ua0-f194.google.com with SMTP id c12-v6so5804630uan.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=h9XasVh1/u4FHey7iDzy44Qal65mH4KHcfpPW1ebtAQ=;
        b=iD8y8ins8NX48vrZMfdhL3wTwDDNMubcB9agx6V4cxYWOd8RcBj+Qp1R94Ee3wr3J3
         T603uhzCSUCyKkJUg0/7r+UbdoDdKcEsL6xuZgNzqpzMunZcK9yv1a5rGlL3WEynW8Fy
         tzD2gJmHoIU2NR59kyZNTXUAwLKRtzNhh0xQom6Si/kQqq+p/GAjesXDa/QVSmFOwTab
         Qcun/HTG3rE/o31YBZ5jJYceMrwa1BeRNVsRkitd9lQnY39TLgD4d9VTK6Rpc5YNLEEQ
         pX/1xbGqmkFsPO8My7AnjdVMshC2bhYPwCuJ2WjPjmi1IdTf4I6eAy+aeCudv/JG8ptS
         xtNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=h9XasVh1/u4FHey7iDzy44Qal65mH4KHcfpPW1ebtAQ=;
        b=POvHaYM8gC6qUWbS1OhF4ynA6Kg9V1i/YsjV2uxO8eg1kiBacgClzVaZOEna5+7EsL
         XkJJkZUDH7z5vteGIr4mK9b4DwE+wn78RLnNIjs37oCOq3JzGs9RfXiF9wI59HmQRIT+
         +4onvS350y8kzSy5xs1QTbl8im93JXkCRbURk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=h9XasVh1/u4FHey7iDzy44Qal65mH4KHcfpPW1ebtAQ=;
        b=jaU6tifNGTJQewN8RHwcxrwmoXaXNg9c6evoaUZf5ad4coDxXo3JhUHoSj9Tc38f3s
         KVLCqKQLAaJ82Ch5XN/Chgv1L1Yezl6122OeGKwCYV/HSKTZC8DRa+wqhMGIvA97gszH
         XZXsEH7hZAAR5vZHerto21NBJ7rX20rqVky3FtrS0g8v3agDm9ZlPHspk57RO1+iBdc+
         TQPak+to4zx+OAbe1rCCRD3lf1GlMChXpklGH2b2rXuVEDUAQR1BqUJYE0JBkcPsAUfv
         Uk09krATmVyS/vax/CFjuzuaU7VYYz1rtaXfugOOIZVafVOW34/YWQPE8U3SChLZqjVm
         UpCw==
X-Gm-Message-State: AOUpUlF8Yr72xz4aeD52uMpEYAwggYpy1kseYDJptnneafUxPWA2vx2L
        evCJ17Ur8YZiGsDuRgxPC0Dk9kK7iFS+if5moxP6/w==
X-Google-Smtp-Source: AAOMgpfHmIfluzvc/k15HsGOOkhc7pp6fEpCyZqfoTV0qACs7qzJj4OHACzn17OxfzkOqccsGGPwbC3sq/WPOFFm5Lc=
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr16114410uac.191.1532560796965;
 Wed, 25 Jul 2018 16:19:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 16:19:56 -0700 (PDT)
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
References: <20180724234636.57137-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 Jul 2018 16:19:56 -0700
X-Google-Sender-Auth: xnWkvGIk8jW6FCkFFgQwWkfDpCY
Message-ID: <CAD=FV=VODGOE=qvJVeLGBs8xXQvbHZu7S9rqSpMY4AetUjd3fQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 4:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote=
:
> +static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
> +                                            int temp)
> +{
> +       u8 reg;
> +       bool disable_s2_shutdown =3D false;
> +       int ret;
> +
> +       WARN_ON(!mutex_is_locked(&chip->lock));
> +
> +       /*
> +        * Default: S2 and S3 shutdown enabled, thresholds at
> +        * 105C/125C/145C, monitoring at 25Hz
> +        */
> +       reg =3D SHUTDOWN_CTRL1_RATE_25HZ;
> +
> +       if ((temp =3D=3D THERMAL_TEMP_INVALID) ||
> +           (temp < STAGE2_THRESHOLD_MIN)) {
> +               chip->thresh =3D THRESH_MIN;
> +               goto skip;
> +       }
> +
> +       if (temp <=3D STAGE2_THRESHOLD_MAX) {
> +               chip->thresh =3D THRESH_MAX -
> +                       ((STAGE2_THRESHOLD_MAX - temp) /
> +                        TEMP_THRESH_STEP);
> +               disable_s2_shutdown =3D true;
> +       } else {
> +               chip->thresh =3D THRESH_MAX;
> +
> +               if (!IS_ERR(chip->adc))
> +                       disable_s2_shutdown =3D true;
> +               else
> +                       dev_warn(chip->dev,
> +                                "No ADC is configured and critical tempe=
rature is above the maximum stage 2 threshold of 140=C2=B0C! Configuring st=
age 2 shutdown at 140=C2=B0C.\n");

Putting a non-ASCII character (the degree symbol) in your commit
message is one thing, but are you sure it's wise to put it in the
kernel logs?


> +       }
> +
> +skip:
> +       reg |=3D chip->thresh;
> +       if (disable_s2_shutdown)
> +               reg |=3D SHUTDOWN_CTRL1_OVERRIDE_S2;
> +
> +       ret =3D qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> +       if (ret < 0)
> +               return ret;
> +
> +       return ret;

Simplify the above lines to:

return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);


> @@ -313,12 +441,7 @@ static int qpnp_tm_probe(struct platform_device *pde=
v)
>         if (ret < 0)
>                 return ret;
>
> -       chip->tz_dev =3D devm_thermal_zone_of_sensor_register(&pdev->dev,=
 0, chip,
> -                                                       &qpnp_tm_sensor_o=
ps);
> -       if (IS_ERR(chip->tz_dev)) {
> -               dev_err(&pdev->dev, "failed to register sensor\n");
> -               return PTR_ERR(chip->tz_dev);
> -       }
> +       chip->initialized =3D true;

Should we add "thermal_zone_device_update(chip->tz_dev,
THERMAL_EVENT_UNSPECIFIED);" here

...also: do we care about any type of locking for chip->initialized?
Technically we can be running on weakly ordered memory so if
qpnp_tm_update_temp_no_adc() is running on a different processor then
possibly it could still keep returning the default temperature for a
little while.  We could try to analyze whether there's some sort of
implicit barrier or we could add manual memory barriers, but generally
I try to avoid that and just do the simple locking...  What about just
setting chip-Initialized =3D true at the end of qpnp_tm_init() while the
mutex is still held?


I'd also love to hear from someone with more thermal framework
experience to make sure it's legit to return a default value if
someone calls us while we're initting.  It seems sane to me but nice
to confirm it's OK.


Overall I like the idea of this patch so hopefully others do too.
Thanks for sending it out!


-Doug
