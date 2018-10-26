Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C90C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525C320868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXzqn74p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525C320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJZVRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:17:08 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36607 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeJZVRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:17:07 -0400
Received: by mail-ua1-f65.google.com with SMTP id w19so348304uaj.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apzQIfOMYkBRdFDQicKtJQZxISE1oyAEMzJBC+wIUYw=;
        b=bXzqn74pbWKX3ruLLEWAAmVn9AK0FcrTKzoW5V5IEOhC+xCdiuXnNCdywn0fPQDzBR
         Z0Q52EjUxpeQkM+iLDNX7cxJ9KbQMVWRcBuw7rEEYQToTjbCNmxEJmCK5ohkhqj0ZVaW
         DKAHfLoB4BPPh4FXiTBwXkngM2wy9195vz0zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apzQIfOMYkBRdFDQicKtJQZxISE1oyAEMzJBC+wIUYw=;
        b=L7IHRXXMDXRlt7WzEG88CgYflSzk8KTfnq+Fm2UWvC2aEv5Le9D0XqAg2XxreBsTau
         +EMDFDdICzIUzL0p67+UuKkCGpfe7F2kVvfLBW9GEszlLMEUtSKk0d3P/VV9QXom57Gz
         rSVbz03AUJTMsJXEhHxZKjUL+hayznwV2rUXZj2LMI+17jJXwK6x50TcliBBzRjc/+am
         nYsu1kpauXES92VEBZkrd5Pd1h5BokMy0gto88W9mz9nndBmitU8xrupe4cI0nXplt4N
         Zjka6EsWz0zDk0DNmovT6guZAG6s7F0rP5klIULUiq7rBrUD7yzoSO0M5ZGWluUSLKm2
         yXiQ==
X-Gm-Message-State: AGRZ1gKARHs1hTPbWLbCOuYG0AI7LUwemin75sczpoVMAgjgjfCpDKHq
        7uy7ZyeAb4nE+mxh7v/RDUYhqWeVgNQyfkpsnsAbgg==
X-Google-Smtp-Source: AJdET5ew8YDwYFD2V7Z99xZ186QPvNw6VM0z69FOHP7IGXPuR6OtdZBL1AezDFKdCJyT2FpRF3glpSGRd59VyEl0dPQ=
X-Received: by 2002:a9f:35a2:: with SMTP id t31mr1396288uad.98.1540557609298;
 Fri, 26 Oct 2018 05:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181017155403epcas2p1ed9777e96c6b2c77c2c5b67466be9843@epcas2p1.samsung.com>
 <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
 <1539791563-5959-9-git-send-email-b.zolnierkie@samsung.com> <CAHLCerNsdhG1OjiRiy5s4uSRGB6dUCVe7mvknCqWqMeQzxCb7Q@mail.gmail.com>
In-Reply-To: <CAHLCerNsdhG1OjiRiy5s4uSRGB6dUCVe7mvknCqWqMeQzxCb7Q@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 26 Oct 2018 18:09:58 +0530
Message-ID: <CAHLCerOqgLep=sPvODyEY8sUr=xxkVU+BkWU5ipTX6w_j6dWtQ@mail.gmail.com>
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

On Fri, Oct 26, 2018 at 5:41 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Wed, Oct 17, 2018 at 9:24 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Enable+check sensor after setting tmdev->sensor[i].tzd and calling
> > chipset specific enable operation.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/qcom/tsens.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index dbd2556..01bff96 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -105,13 +105,13 @@ static int tsens_register(struct tsens_device *tmdev)
> >                 if (IS_ERR(tzd))
> >                         continue;
> >
> > -               thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
> > -               thermal_zone_device_check(tzd);
> > -
>
> I don't quite understand why you're making this move explicitly in a
> separate patch for each of the drivers? You added it here in patch 4
> in the first place, why not add it in the correct place there itself?

I think I understand now. You wanted to separate patches causing
functional changes from ones that didn't.

IMHO, it makes the series a bit hard to read but I have no better
suggestion than to squash everything (patches 3-16), but that will
make it harder to collect Acks.

> >                 tmdev->sensor[i].tzd = tzd;
> >
> >                 if (tmdev->ops->enable)
> >                         tmdev->ops->enable(tmdev, i);
> > +
> > +               thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
> > +               thermal_zone_device_check(tzd);
> >
> >         }
> >         return 0;
> >  }
> > --
> > 1.9.1
> >
