Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD0C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D71A24061
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQ2xwWFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D71A24061
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932470AbeGFFNb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:13:31 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40014 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbeGFFN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:13:27 -0400
Received: by mail-qt0-f194.google.com with SMTP id h4-v6so9058756qtj.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 22:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXX8RgrLABXmdtWmEEKmTcBtd/ByOcE9Dh9rkUf7udA=;
        b=WQ2xwWFFiuCTC/q4nLbVRCKioRc671LesrTyxJ3jGN2SAijLTU2TSSdAi8P7TSpkAK
         tMl5/lEhsTCtwTb/2h3fH0k+3zJ3Ia4YwzBjeUra/I/h/VcCEc1lsHNgHSqgBrz8+CV4
         NqcuX0k+Wy6BSGUv2ZBzWqT43WHFpGg16xxA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXX8RgrLABXmdtWmEEKmTcBtd/ByOcE9Dh9rkUf7udA=;
        b=Xk76yDjleGNDfXLcM+MSxBGVKCqyES7Yy0qKtFWtVVYTyllcrZD2CB6pAjEX2cLNU2
         hEq+Ba4ZPoGvv8cKPZS/XYwJHbrxGwsFpBT7LXMl6r76GQkklJfUjqLkXpX9J3cjcUS2
         zLMufP5BMrtjO9KtQacjwBrfpk8LhFTdLQn1iRf07aq9obogTRzQCINTATnkg3fWPsoe
         GUzkEPGClCq2kdEnzH4+8/aP+Bqo+oI0ud3tc0CHr2MIhrbmjKSDP2sVQDhoYL+F1byE
         roH4P2Ks429CcxITKWjMPVc7lhglZUVLMYiUnrZFn1znJf2rW/uJ36er3sR1zdqd9n/l
         I1BQ==
X-Gm-Message-State: APt69E1MNfITQy4jbUOy2Vj/ioNrdUIx7YgaE+1DkRdcU6dFr/An5AGv
        U9BY9DojbHgAKn09tGeDwIzpfumjIEji9xNoPxUWgg==
X-Google-Smtp-Source: AAOMgpd1MGNVWXFF6KzA60zvG1c09+wTVnaNFHDzIeR5Qf6XqJbZWYaUk653+MoBwPPD7S4AXyK+RirQkh4D4HRxET4=
X-Received: by 2002:a0c:becb:: with SMTP id f11-v6mr7562721qvj.217.1530854006210;
 Thu, 05 Jul 2018 22:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
 <20180703162619.GA17238@rob-hp-laptop> <CAHLCerNpifvM9nGXiE63-DQ0okP8+1wdxq52qo-K1TWzoYzjtQ@mail.gmail.com>
 <20180705203712.GA29531@rob-hp-laptop>
In-Reply-To: <20180705203712.GA29531@rob-hp-laptop>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 6 Jul 2018 10:43:14 +0530
Message-ID: <CAP245DVvdswALtZj0XTOsntHC4kz6a63DJ8qxeiry+9N77=CGw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] thermal: tsens: Add support for SDM845
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 2:07 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jul 04, 2018 at 10:56:26PM +0530, Amit Kucheria wrote:
> > On Tue, Jul 3, 2018 at 9:56 PM, Rob Herring <robh@kernel.org> wrote:
> > > On Mon, Jul 02, 2018 at 06:14:07PM +0530, Amit Kucheria wrote:
> > >> SDM845 uses v2.4.0 of the TSENS IP block but the get_temp() function
> > >> appears to be identical across v2.x.y in code seen so far. We use the
> > >> generic get_temp() function.
> > >>
> > >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > >> ---
> > >>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 2 ++
> > >>  drivers/thermal/qcom/tsens-v2.c                          | 6 +++++-
> > >>  drivers/thermal/qcom/tsens.c                             | 6 ++++++
> > >>  drivers/thermal/qcom/tsens.h                             | 5 ++++-
> > >>  4 files changed, 17 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > >> index 06195e8..075182e 100644
> > >> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > >> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > >> @@ -5,6 +5,8 @@ Required properties:
> > >>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> > >>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> > >>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> > >> + - "qcom,tsens-v2.4.0"  : For SDM845 Family of SoCs
> > >> + - "qcom,tsens-v2"      : Generic fallback binding for any Soc using 2.x.y version of the tsens IP
> > >
> > > You need to show what are valid combinations of compatibles. Does v2
> > > apply to 8996? One valid combination per line.
> >
> > I've restructured qcom-tsens.txt to look like this:
> >
> > -----%<-------
> >
> > * QCOM SoC Temperature Sensor (TSENS)
> >
> > Required properties:
> > - compatible: must be one of the following:
> >     - "qcom,msm8916-tsens" (MSM8916)
> >     - "qcom,msm8974-tsens" (MSM8974)
> >     - "qcom,msm8996-tsens" (MSM8996)
> >     - "qcom,tsens-<ip_version>", "qcom,tsens-v2" (TSENS IP version and a
> >        generic v2 property as fallback except for MSM8996)
> >
> >   Examples with ip_version are:
> >     - "qcom,tsens-v2.4.0", "qcom,tsens-v2" (SDM845)
> >     - "qcom,tsens-v2.2.1", "qcom,tsens-v2" (MSM8998)
> >
> > -----%<-------
> >
> > 8996 would end up being something like this if needed, though we're
> > stuck with "qcom,msm8996-tsens":
> > "qcom,msm8996-tsens", "qcom,tsens-v2.1.0", "qcom,tsens-v2" (MSM8996)
>
> 3 versions here for 3 SoCs. I'm not getting that convinced version
> numbers really are better. I would assume that other QCom IP blocks

Yeah, it is a bit unfortunate that the 3-4 SoCs we're focusing on
getting supported upstream have different versions of the TSENS IP.
The other goal of this work was to make the upstream driver
feature-complete so we can make a case to switch to it in the
downstream trees, even on platforms that aren't being active
upstreamed. They'll still need to keep around those SoC-specific
one-liner patches in the downstream trees.

> have versions too, but pretty much *every* *other* binding uses SoC names.
> Why is this one special?

I'm not an expert on all QC IPs, but this one _seems_ to be reused a
lot more than others.

> The other problem with versions is the mapping
> of versions to SoCs most likely can't be validated outside of QCom
> unless there's a version register.

There is in fact a HW version register that I was hoping to add
support for later.

> So, sorry to go in circles, but can you go back to qcom,<soc>-tsens. You
> can keep qcom,tsens-v2 as a fallback.

OK.

> Yes, it's annoying to have to update bindings for new SoCs. But it's
> trivial one line patches. Look at Renesas bindings. Maybe adding new
> ones will be scriptable once we move to json-schema binding docs.

I did look at the Renesas RCar bindings when restructuring the
documentation. They seem to have settled upon a 3-level fallback:
"soc-specific", "generic-no TZ", "generic-TZ". But
drivers/thermal/rcar_thermal.c seems to be compatible with only one
soc-specific property (thermal-r8a77995) and all other SoCs seem to be
just relying the fallbacks.

Anyways, I'll respin.

Thanks.

Regards,
Amit
