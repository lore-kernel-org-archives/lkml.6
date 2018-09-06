Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06874C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEBC206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMZtOGLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEBC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeIFOfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:35:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38101 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeIFOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:35:37 -0400
Received: by mail-qt0-f193.google.com with SMTP id x7-v6so11528052qtk.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wh+8YnDEoo04B3rlzt4xT71a2v028q4zOps+fl7Qwk=;
        b=TMZtOGLvb57EDNmxiGJr0Sku09YNygyeMc7Cee/MlZBYSzUfS6oViHD21BlY12Vaan
         EuaKgOfcxBb3o5udEtJrZTIjjRB2S7u8OpMYNKFJ7Y+TpCTzKfzzid4Czecl4mJqzROV
         t4CfRzOCwk/6Q+VMEkEHuvQed47gHe7gWx/w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wh+8YnDEoo04B3rlzt4xT71a2v028q4zOps+fl7Qwk=;
        b=pqufpahk1fcpEmxgXsVVtTB9jFomJFgRx5OYYyY5lQjgP/tUhuXPC+9NLqJs0OMYfu
         M955FsZmQeMed1VYNCLjjXVmc4A/7hsJmxGaCoNYDP3Nttb50nQiOcFVJEDd1Ipctcja
         IOxHhmLp9tsMFgGVlV8KF0S9I3vGlTAGRNSHCkUqlCXMN2p1QkkxXCXRACkeNpAKGpF4
         51/NuZMAO8bYA6AyUnz6FERaucd/sCZ/Du9oNsb/fbf5GzQLFS3WPhvZh7R9TvY6GIS6
         R99P8aEu4zFznDaSVQr5ZZGbiwRBNEHd7QfiBEcKOwv95xK0NLJc86dxM6a9coCZ2dNY
         mPYg==
X-Gm-Message-State: APzg51B1+h7MtlgR80asKrqYcx2DQTqjm/6FCpiuYx+Gva2dROOAhou9
        FcpLB/Se94Intf6jC1EdWwQNzrxVDZ0mS3GmvbAOPQ==
X-Google-Smtp-Source: ANB0VdZESFGEokgT+rvVut9VuXKxl9m+Xuie9SukngtQpK/Xh1tKsNhf/10CM1VExptRd4DqaxradSrIIktf+xOS06Y=
X-Received: by 2002:ac8:6989:: with SMTP id o9-v6mr1415266qtq.244.1536228054761;
 Thu, 06 Sep 2018 03:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <35c332750fe1eddfa2eb53750b810256310866bd.1535462942.git.amit.kucheria@linaro.org>
 <CAHLCerPF0U22XZ8kEBkXZYJHkL73K8_RFkArs9gXvc0Qmufr-g@mail.gmail.com> <20180903204855.GB1437@tuxbook-pro>
In-Reply-To: <20180903204855.GB1437@tuxbook-pro>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 6 Sep 2018 15:30:43 +0530
Message-ID: <CAP245DWdePT5LZ1Sk20eea5Nx76ESMSz3Yp9b-UbNajT7fsFvQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] thermal: tsens: Check if the IP is correctly
 enabled by firmware
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 2:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 30 Aug 12:23 PDT 2018, Amit Kucheria wrote:
>
> > On Tue, Aug 28, 2018 at 7:08 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > > The SROT registers are initialised by the secure firmware at boot. We
> > > don't have write access to the registers. Check if the block is enabled
> > > before continuing.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >  drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > > index 0b8a793f15f4..d250b757d1f0 100644
> > > --- a/drivers/thermal/qcom/tsens-common.c
> > > +++ b/drivers/thermal/qcom/tsens-common.c
> > > @@ -12,6 +12,11 @@
> > >  #include <linux/regmap.h>
> > >  #include "tsens.h"
> > >
> > > +/* SROT */
> > > +#define CTRL_OFFSET            0x4
> >
> > This OFFSET is not constant across the TSENS family and breaks atleast
> > one platform in the test below. I have a patch to fix this for all
> > platforms, will post it after a bit more testing.
> >
>
> Afaict the other 10 patches can be merged independently of this patch.
>
> So please make the minor updates and resend them as a separate series,
> with the acks/reviews, to make it easier for Eduardo to just pick them.
>

Will do.
