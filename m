Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF8BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD412085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD412085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJKPgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:36:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35568 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeJKPgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:36:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id y19-v6so7398231edd.2;
        Thu, 11 Oct 2018 01:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pF5PfaZAt9DgH2rjFHJoIxF4m7/+Sxp53PdzsV2Tt0U=;
        b=ZmL7/NoIKxVatoiecUZHj6D7nWw3+vFV6blXIFmk5I1iPo+9n+YZYW3R0TAiOAHFpF
         uY8UPQOwtyqNSrAklySDb0oTro3BH/76xwNbdJBbuBv4/BTI5rqR7y+0TMe+HaEtgw1l
         sBETSKmaNM+opiEY+gROcO4ulTDccYqe4d/qmE/kpCmNgTfRKhHhpZmwl2D1JGPsVysn
         8Y4QPcgz3AmmcQ3gvkmFV1xs5uW6XHktqjVG4p/wywWp3H5gMNCVVkc7N8AHFEQc8a52
         HJY9Kd8/71OHzCsErHa++1LrtZKr/6Nbzx5M89ZB/z+Sj4HIdfP0C+qqTMTUmKjfsDjd
         aU5w==
X-Gm-Message-State: ABuFfogY/axstDPAJt6P9NuqamPUwu67V8dpYSfMc2/Nus4CtEhWTeis
        BcG8ieF8jqOIYuVTIyee3udlUtMqvbk=
X-Google-Smtp-Source: ACcGV629C9JEV/o7cfGbalZ5AnGcwHx1Wm3dehw473uS7pa/qH9kp77JF0bsOzcRiPZGqUdbvIkG8g==
X-Received: by 2002:a17:906:234f:: with SMTP id m15-v6mr1056718eja.78.1539245426170;
        Thu, 11 Oct 2018 01:10:26 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id br14-v6sm1149702ejb.17.2018.10.11.01.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 01:10:25 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id z25-v6so15163556wmf.1;
        Thu, 11 Oct 2018 01:10:25 -0700 (PDT)
X-Received: by 2002:a1c:a8c2:: with SMTP id r185-v6mr740704wme.8.1539245425087;
 Thu, 11 Oct 2018 01:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181008181908.9456-1-oskari@lemmela.net> <20181008181908.9456-8-oskari@lemmela.net>
In-Reply-To: <20181008181908.9456-8-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 11 Oct 2018 16:10:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v64i4a_yBkJE5pTmx_tKOVGKJNGvqAY0Hnw=Wr17VDSTfQ@mail.gmail.com>
Message-ID: <CAGb2v64i4a_yBkJE5pTmx_tKOVGKJNGvqAY0Hnw=Wr17VDSTfQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] mfd: axp20x: Add supported cells for AXP803
To:     oskari@lemmela.net
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 2:20 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 is compatible with AXP813.
> Adding cells for GPIO, ADC, AC and battery power supplies.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  drivers/mfd/axp20x.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 1508d9113126..4befe474b165 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] = {
>                 .name                   = "axp221-pek",
>                 .num_resources          = ARRAY_SIZE(axp803_pek_resources),
>                 .resources              = axp803_pek_resources,
> +       }, {
> +               .name                   = "axp20x-regulator",

Please keep this as one line as before. This was requested by the MFD
maintainer.

> +       }, {
> +               .name                   = "axp20x-gpio",
> +               .of_compatible          = "x-powers,axp813-gpio",

You might want to put the GPIO cell near the top of the list, so any other
users, such as the ADC and regulator cells, will probe after it.

> +       }, {
> +               .name                   = "axp813-adc",
> +               .of_compatible          = "x-powers,axp813-adc",
> +       }, {
> +               .name           = "axp20x-battery-power-supply",
> +               .of_compatible  = "x-powers,axp813-battery-power-supply",
> +       }, {
> +               .name           = "axp20x-ac-power-supply",
> +               .of_compatible  = "x-powers,axp813-ac-power-supply",
> +               .num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +               .resources      = axp20x_ac_power_supply_resources,

Please use the same indentation.

Regards
ChenYu

>         },
> -       {       .name                   = "axp20x-regulator" },
>  };
>
>  static const struct mfd_cell axp806_self_working_cells[] = {
> --
> 2.17.1
>
