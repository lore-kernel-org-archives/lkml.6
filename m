Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958DBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6235320882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l5Q6HuKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfA1HRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:17:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46324 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1HRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:17:00 -0500
Received: by mail-io1-f66.google.com with SMTP id s8so12550293iob.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ng6nuhkBLy+wUW3Z6m/MasHkhFKoXpIuQ3mfaKj7hes=;
        b=l5Q6HuKNncZr9Ph4BaRcsiAP6adwBB40w394HuqTAbx5x6mX/Ssyf7sy6g+rio4vSP
         B8abx15fv3aboNAYGEkM5gVIlpUAi1ZOJvHpTOfgrHlB+T6ts9pAyLoux5eUOU/3p7as
         upFOv65/TF9RjEBv2PdSVPaHeGAi04FffGBhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng6nuhkBLy+wUW3Z6m/MasHkhFKoXpIuQ3mfaKj7hes=;
        b=W5lA/QC6pXT+3lkyr7zn2LlfGgxaFaxmQN4cWLb3cQWX5xM1WM9PJNP/NVX/8ffhCE
         Ihivudt+r3nWMrZWI5cLuW0lVqZ+KYRTn9W10w87wG+CbecL9H62v8/+Q1sPmBJS7/h3
         kbNTge469gSYQmrxov+Xkrj3dx7cXAJ9vtDyF0QYYjRlw2sSKHcvSuEGFBPvzfnXs5xy
         Wq9dOZYXinbJXWpg6ECLSP+1rjb7IqeaHspu53trZrZmeTX1cBtcHJytNepaTveKOtNg
         j8yg5iMAnE0VEIbgXoXL4Hhvf0m9F8XDeOIdnbAhWNzaJOjGMRE7MMAvEHr+QVXXaEbO
         RUuA==
X-Gm-Message-State: AHQUAuZBGPg88+WJ1ZgcF1Neq/uoCbXj5EkxrqkCMsWrY+jNryoQlEIt
        0dUvSEASEEIRAVXVEIjgulv9DEJyJ03S4Vndj8H8yQ==
X-Google-Smtp-Source: AHgI3IZUZI8bxhU5JvXUAFKvoHEPws/K6Cf0r2ykzUwEUXISU1nn23BIycmiFOCYykKw62EOHt12uECd0WvdAJwNgPU=
X-Received: by 2002:a6b:1411:: with SMTP id 17mr12254209iou.252.1548659819187;
 Sun, 27 Jan 2019 23:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20190124175254.27650-1-jagan@amarulasolutions.com> <20190125084004.fsbxtpcesb5yaiod@flea>
In-Reply-To: <20190125084004.fsbxtpcesb5yaiod@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 28 Jan 2019 12:46:48 +0530
Message-ID: <CAMty3ZBmHpsTRXARnT5nf1VcnCmz0QpZ5B8caHONLV0UZdXS9Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64-amarula-relic: Add STLM75 sensor
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 2:10 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Jan 24, 2019 at 11:22:54PM +0530, Jagan Teki wrote:
> > Amarula A64 Relic has STLM75 sensor for digital temperature
> > and thermal watchdog.
> >
> > Add support for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Note: the respective driver change is already in mainline
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2e9a41bbc1079776dabe42ed8113b086b99ae56c
> >
> >  .../dts/allwinner/sun50i-a64-amarula-relic.dts    | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > index 6cb2b7f0c817..5d942543d978 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > @@ -34,6 +34,21 @@
> >       status = "okay";
> >  };
> >
> > +&i2c0 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&i2c0_pins>;
> > +     status = "okay";
> > +
> > +     temp@48 {
>
> That would be sensor@48
>
> > +             compatible = "st,stlm75";
>
> That compatible isn't documented.

True, but none of the compatible strings used on the driver doesn't
documented in binding instead there are documented in
Documentation/hwmon/lm75.

Don't know the exact reason, do we need to document this in binding as well?
