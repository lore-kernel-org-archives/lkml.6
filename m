Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E99EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AB720856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/z0Gza6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AB720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJZUsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:48:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42817 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeJZUsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:48:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id e126so539397vsc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C69vTy5yCnmW8KDKcklUcRVhtwRjBrqphYmxYMdm68A=;
        b=Y/z0Gza6b2ZIHP7gk7KhT4Qh/EFEc+2rkN0L9zPjxm2B4GQzbAuipRRqeIKy93GNOA
         CIzRRsVqYBpkqwhXZFR9uopyPAdPiO4DUZP5WfU/9H9inRc0LhPFbBRZRwZ7QuC1xBEB
         fFVJLPtsH/81BjKzKnzHQkz2sKDT96VF+qaWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C69vTy5yCnmW8KDKcklUcRVhtwRjBrqphYmxYMdm68A=;
        b=WCJj79ZGuoj91Y7nRWXx3bQJLIyHhpAvBlf6intnQmctMNUBt1AZMBVfFvp/0poppw
         7Ev9o7A9ZxIRBzOl79OodgHHavzWGpH2aiwhcpwpGlc8p7HC2FLjUV5+Pb8NUPGzCu3E
         ZmsqE21zaOH58v/EpDv/pezNInykEo7vIIY8vdwOfbT/jGFgnAMaq2ttW4yCpMrYymqU
         z/EL4ihGSXvdFBMwnfKzKpFeqkSaAN5mp/oRvtwQcs8/8vMVInFCoDQ7pUqYxDc2W1fp
         KW/9bhPOkoxjeZjcB+7JQ2TPhM4tir52nsqWnGfZ/Z6q2+Od/bP8gfN0/xgj8nJMqKxz
         gE0A==
X-Gm-Message-State: AGRZ1gLDgPfRaH7f4NbAmO5B6Kg1c+pESiJ7Nhuvv2JNm7nO1ktsNN8n
        sMsHcQDdaZK+X8Bub5VMMNJd3C4HebSUfjByBcB1HQ==
X-Google-Smtp-Source: AJdET5cU0MQSzkdTwXTow83a/nONVImmIW2WsdXg2jtqVzOC+JhoxVy53yGtUlNTWjwmb6wX4WnDxAgGCowRFNasHPQ=
X-Received: by 2002:a67:4719:: with SMTP id u25mr1382818vsa.27.1540555879206;
 Fri, 26 Oct 2018 05:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181017155403epcas2p1ed9777e96c6b2c77c2c5b67466be9843@epcas2p1.samsung.com>
 <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com> <1539791563-5959-9-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1539791563-5959-9-git-send-email-b.zolnierkie@samsung.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 26 Oct 2018 17:41:08 +0530
Message-ID: <CAHLCerNsdhG1OjiRiy5s4uSRGB6dUCVe7mvknCqWqMeQzxCb7Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] thermal: qcom: tsens: enable+check sensor after
 its setup is finished
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 9:24 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Enable+check sensor after setting tmdev->sensor[i].tzd and calling
> chipset specific enable operation.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/qcom/tsens.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index dbd2556..01bff96 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -105,13 +105,13 @@ static int tsens_register(struct tsens_device *tmdev)
>                 if (IS_ERR(tzd))
>                         continue;
>
> -               thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
> -               thermal_zone_device_check(tzd);
> -

I don't quite understand why you're making this move explicitly in a
separate patch for each of the drivers? You added it here in patch 4
in the first place, why not add it in the correct place there itself?


>                 tmdev->sensor[i].tzd = tzd;
>
>                 if (tmdev->ops->enable)
>                         tmdev->ops->enable(tmdev, i);
> +
> +               thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
> +               thermal_zone_device_check(tzd);
>
>         }
>         return 0;
>  }
> --
> 1.9.1
>
