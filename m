Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055ECC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B7120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B7120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeJaLew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:34:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45828 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbeJaLev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:34:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id t10-v6so12301828eds.12;
        Tue, 30 Oct 2018 19:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IMcG8sHTVraRWT5cYuHESDAek/L2JBRngJurAfiMjE=;
        b=EL2ohL8WYfkKiTLKI+/11ooumOqRRQoeoVEHaRq9yZ/cN2GdTbgO3eHRNFvVxWtIx5
         4evCVKf2ZiuMTjy1kWJbgqjoWCZVzFYlLiZVDRgop57isCIKFPVoVd1oZQlU/ldLNX1u
         NrhW9qT/ub6GZJa6Nzb1ZYvNRg87VqagXtqmDB2pfewPuFr0/oQ9lsbxY6m29mCMc0kc
         b0EiCfMBwgg5AaGvRULRThd2oHNOBSNV+5UwPwPWqUPuHReYGmUNc0jwvopXxZafjZN2
         eyksnf0tHAaWjueGn7Up33ntoSWxMjEwEOWf02V5jaQ62X4accyravT7riht82mE+bWD
         ThJw==
X-Gm-Message-State: AGRZ1gIXpNXv1KmuKHg2MxJUCRqHfSu/rncphoxAZRbF8x3/SCgYEMsW
        8H5Cuzc+r/LCwOh6NxSdsTiPsSbD+vU=
X-Google-Smtp-Source: AJdET5cltyHEZ02gLl6ImPoOM6C6Zue1ZaWlO3+f3YEvZjcCkQydrK9x2UqqqNTokL7XuU2iOuHUpA==
X-Received: by 2002:aa7:d1d2:: with SMTP id g18-v6mr401715edp.163.1540953528531;
        Tue, 30 Oct 2018 19:38:48 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id o2-v6sm1789279edd.13.2018.10.30.19.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 19:38:47 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id 74-v6so6541189wrb.13;
        Tue, 30 Oct 2018 19:38:47 -0700 (PDT)
X-Received: by 2002:a5d:4844:: with SMTP id n4-v6mr1039991wrs.28.1540953526780;
 Tue, 30 Oct 2018 19:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-3-oskari@lemmela.net>
In-Reply-To: <20181023185330.10472-3-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 10:38:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v67WiDke1nrD_6b9DwG1O_AD=GSLV2kiVNrfH8MHHfdmDQ@mail.gmail.com>
Message-ID: <CAGb2v67WiDke1nrD_6b9DwG1O_AD=GSLV2kiVNrfH8MHHfdmDQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] dt-bindings: power: supply: axp20x: add AXP803
 power bindings
To:     oskari@lemmela.net
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:54 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> The AXP803 power supplies are compatible with AXP813, but
> add specific compatibles for them.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt         | 1 +
>  .../devicetree/bindings/power/supply/axp20x_battery.txt          | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> index 7a1fb532abe5..acdeb4b8f4cc 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> @@ -4,6 +4,7 @@ Required Properties:
>   - compatible: One of:
>                         "x-powers,axp202-ac-power-supply"
>                         "x-powers,axp221-ac-power-supply"
> +                       "x-powers,axp803-ac-power-supply"
>                         "x-powers,axp813-ac-power-supply"
>
>  This node is a subnode of the axp20x PMIC.
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> index 41916f69902c..780ebd7e3b84 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -4,6 +4,7 @@ Required Properties:
>   - compatible, one of:
>                         "x-powers,axp209-battery-power-supply"
>                         "x-powers,axp221-battery-power-supply"
> +                       "x-powers,axp803-battery-power-supply"
>                         "x-powers,axp813-battery-power-supply"
>
>  This node is a subnode of its respective PMIC DT node.

As mentioned in my reply to the cover letter, this patch isn't needed.

We ask people to add model-specific compatibles in the device tree
in case the hardware turns out not to be so compatible with the old
hardware we thought it was compatible with. With the model-specific
compatible in place, we have a way out. Without it, we'd have to ask
everyone to update their device trees, which annoys some people who'd
like to have some sort of backward compatibility.

If the model-specific + fallback compatibles combination was to be
listed, the line would include both compatibles. But we're not doing
that for Allwinner stuff. As mentioned it is there just in case. The
best outcome is we don't care and don't need to use them.

ChenYu
