Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524742791; cv=none;
        d=google.com; s=arc-20160816;
        b=cKzxFI89wSfqoGNlHY14H30sC3Wbi7yThuoUk81s521EZ4G0PLJM9OBU5DtIsyvtn1
         vm1GQ+X9xvxVYf8zJwvaTQMMyZb2ZAZtv7QiCpEPQECPng27tJ3AJ2dQTeln6b8QrIc+
         pbY/rmqYAZqR+kEibCL0BJ+7N8tcc5H+LmtyGDfjsoNIoFG91qWIzk89RhS68pKdgqOw
         UKg5F4VsO+RMuBQsAxGKLFCn8PknoD4YRGgGo2idMNdhdCqJ2+vS6fMd1O8cg5V6kQZX
         ZQ44cKQXDaXl5yL96Q3vq2GSL4r+YqxjZCWYfcIf1bThlu9Or/KXQ7UAxa0/AM3kNq3n
         cOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=uS7+Bo5SDfGUPuYxM7qjce40T5Pf4RFPl5ZCv3nzD7E=;
        b=WNcihsxwT+IwJUtT25Rzi/Yq3UMDBTJwxB0AiS37mJOmXDlLoP548JT/WYM+2sfMWg
         mAqLfOOBqZ6ZpL4nla5nHxqStx2ogh62s/SudW3U0W7+X/F63hc6CttRuLYnULst1UQf
         fCnOy1c3AWFjy/BEaW35GNh6MPa9Oq0tkiYpN/z+OzjipCScLcnan7eVy8939kUn5wBg
         C7ZMILfLIGe3ej2PnMOoa00vCzubuGkAjWimhXGQVfcAHgEa144Mz/CxS2pMVEURryeP
         CoNaq9ebgXzMIRNf+N8WapN+2O6FzHu8opsIiI5g/uq1xorTbTvduYp3WUt0yDYjT/nQ
         tnlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PU85+3OF;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PU85+3OF;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/7s6xpW5OzTWsPGDHsJw1VuV8ZGp8f+qmUAQaFo1IFgDEkl/FAZ8+s4BJ5atXgTneY8cbbfmN/xvlHrsnXcfo=
MIME-Version: 1.0
In-Reply-To: <20180407134712.23131-2-ctatlor97@gmail.com>
References: <20180407134712.23131-1-ctatlor97@gmail.com> <20180407134712.23131-2-ctatlor97@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 13:39:50 +0200
Message-ID: <CACRpkdZ4VO_9eNvJdznoqd0cdV2qCbnFjjhQOtZKgpxFES1-VQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: power: supply: qcom_bms: Add bindings
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095394982255487?=
X-GMAIL-MSGID: =?utf-8?q?1598808697527623617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 7, 2018 at 3:46 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:

This is very interesting bindings!

> Add bindings for the Qualcomm battery measurement system.
>
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Please expand on acronyms as requested by Rob.

> +Required properties:
> +- compatible:               Should contain "qcom,pm8941-bms".
> +- reg:                      Specifies the SPMI address and length of the
> +                           controller's registers.
> +- interrupts:               OCV threshold interrupt.
> +- io-channels:              Should contain IIO channel specifier for the
> +                           ADC channel that reports battery temperature.
> +- io-channel-names:         Should contain "temp".

These are fine (and good) as bindings go.

> +- qcom,fcc-temp-legend:     An array containing the temperature, in degC,
> +                           for each column of the FCC lookup table.
> +- qcom,fcc-lut:             An array of FCC values in mah, one entry for each
> +                           temperature defined in in qcom,fcc-temp-legend.
> +- qcom,ocv-temp-legend:     An array containing the temperature, in degC,
> +                           for each column of the OCV lookup table.
> +- qcom,ocv-capacity-legend: An array containing the capacity for each
> +                           row of the OCV lookup table.
> +- qcom,ocv-lut:             An array of OCV values in mV, one entry for each
> +                           capacity defined in qcom,ocv-capacity-legend.

I wonder if these are really Qualcomm-specific.

Can't we just cut the "qcom,*" prefix from all and simply define
these lookup tables in a way (with units) that makes sense to all
kinds of battery capacities?

Maybe spell them out though and avoid the abbreviations.

Just put those in the already existing
Documentation/devicetree/bindings/power/supply/battery.txt
so others can reuse them from there.

You will see that those bindings does not abbreviate but
spells out the natural sciences definitions to it's a bliss to
read for everyone.

Yours,
Linus Walleij
