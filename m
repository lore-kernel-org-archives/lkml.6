Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3198C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FBF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsfPrTi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FBF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeKTIGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731165AbeKTIGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:06:09 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EF0C2089F;
        Mon, 19 Nov 2018 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542663632;
        bh=YLHhHKRM5fzwSgwqpY9AOIKII6U30Jo/uG82YQVhTpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BsfPrTi4BL9GnxD7gg+L7z0aFYunNdjG/10gvOPZt7fgGB1ivFHuKKfw3atFfUDhN
         sldAwGnsxcasEedp1VgTGCWMMtVhg0dutG0T9K11KHso62UU9YLlyJMaW214+qMWOz
         UlP+IkfYuwsPjVoXYmF5wv5/gGLjH8hBaXXtFbTs=
Received: by mail-qk1-f180.google.com with SMTP id o89so51268656qko.0;
        Mon, 19 Nov 2018 13:40:32 -0800 (PST)
X-Gm-Message-State: AGRZ1gI1YSSSn/49ilKqeQKCrVG5eO0ZYU1pG8vxquXzIYDXduoh3OwN
        OJKFeX88+54U7fDE5VddjSVzib3YxWri1v/dww==
X-Google-Smtp-Source: AJdET5fdhjHcsTfprduSl8WYmTFp3TY1EUnT3YNSJL67ezgGrKfNeDkm0K966DMrQ78Oh4/pb1fzRZdtYzyz7tgfpaY=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr23526882qvb.218.1542663631450;
 Mon, 19 Nov 2018 13:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20181108225607.7521-1-chris.packham@alliedtelesis.co.nz>
 <20181108225607.7521-2-chris.packham@alliedtelesis.co.nz> <20181117152949.GA31247@bogus>
 <f3a29bc9-dbfc-bfb8-8707-2b67d96c2e04@roeck-us.net>
In-Reply-To: <f3a29bc9-dbfc-bfb8-8707-2b67d96c2e04@roeck-us.net>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Nov 2018 15:40:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgBkR4WN+aTKdHSfCZ8EH39yLCeLwXwmf+nd0_cAy+mw@mail.gmail.com>
Message-ID: <CAL_JsqKgBkR4WN+aTKdHSfCZ8EH39yLCeLwXwmf+nd0_cAy+mw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: add binding documentation for adt7475
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jean Delvare <jdelvare@suse.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 4:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/17/18 7:29 AM, Rob Herring wrote:
> > On Fri, Nov 09, 2018 at 11:56:06AM +1300, Chris Packham wrote:
> >> With the addition of the invert-pwm property the adt7475 needs its own
> >> binding documentation rather being captured under trivial-devices.txt.
> >>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >> ---
> >> Changes in v2:
> >> - use pwm-polarity attiribute to indicate normal or inverted polarity.
> >>
> >>   .../devicetree/bindings/hwmon/adt7475.txt     | 24 +++++++++++++++++++
> >>   .../devicetree/bindings/trivial-devices.txt   |  4 ----
> >>   2 files changed, 24 insertions(+), 4 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.txt b/Documentation/devicetree/bindings/hwmon/adt7475.txt
> >> new file mode 100644
> >> index 000000000000..d9212b5e9036
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.txt
> >> @@ -0,0 +1,24 @@
> >> +*ADT7475 hwmon sensor.
> >> +
> >> +Required properties:
> >> +- compatible: One of
> >> +    "adi,adt7473"
> >> +    "adi,adt7475"
> >> +    "adi,adt7476"
> >> +    "adi,adt7490"
> >> +
> >> +- reg: I2C address
> >> +
> >> +optional properties:
> >> +
> >> +- pwm-polarity: This configures the polarity of the PWM. 0
> >> +            (PWM_POLARITY_NORMAL) uses logic high for 100% duty cycle. 1
> >> +                (PWM_POLARITY_INVERSED) uses logic low for 100% duty cycle.
> >
> > So we're using part of the PWM binding, but none of the rest of it? What
> > is the PWM connection here?
> > The chip has a built-in PWM controller to control fan speeds. PWM frequency
> as well as PWM polarity are configurable. I had suggested to use the terminology
> from Documentation/devicetree/bindings/pwm/pwm.txt. Other than terminology there
> is no connection to a standard pwm controller.

Ah, a fan controller. Please make that clear.

The fan related bindings need a bit of work IMO. We have the start of
something somewhat common with aspeed and npcm bindings, but they
could use a bit more work. We need the fan and controller bindings to
be somewhat separate where a fan node for a given type of fan doesn't
depend on the controller node.

AIUI, all fans are not the same, so does this controller only work
with 1 type of fan and not need any more board level config? Isn't fan
speed not linear with PWM duty cycle and need some sort of map.

> Another option/possibility would be to use a boolean, such as pwm-polarity-inverted.
> We are open to suggestions.
>
> > It sounds like this is common for sensors, so this should be documented
> > somewhere common.
> >
> Sure, no problem. Any suggestion where ?

hwmon/fan.txt (that doesn't exist yet.)

Probably all of bindings/hwmon/ should be split up by class of device.

Rob
