Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D5CECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CD121523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNjLg3xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CD121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbeIUBxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:53:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42019 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbeIUBxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:53:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so9539619ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ka3+l32vHGatNKN4VH5GTtFvXp90QPn5rmFEk1UcsJE=;
        b=bNjLg3xl3ZIMa7jQxSsHvOUqbkFrPIYrsAMXCkTgqH88Kz6eKcUrRe4em28fbKywtb
         xk7BQAbifEQC9cCtqNuj3b2cEwEaBMGTs1SAKQ/FhUz1HwjYeUrLAEviwRjU0fA5romX
         IjwrIyohzaGZFahZ30375+UiSpTpwieSSsLzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ka3+l32vHGatNKN4VH5GTtFvXp90QPn5rmFEk1UcsJE=;
        b=ef9N4T+qLflN4HzlftGSI7Xe3oG0iPMIdck98Zgm9drwGvGfnkYRwgYc856Jrq7LYe
         gDgMwa3mtzZbdfJxVbtJTrYS6ewD/Fc0DOrwcOQlqU/oIPUjxbWdDEBXHoL1KPztglxB
         1k32CbMg9sulq12WvVY8wxjzlMRXUljNy42MLRCowVZcN4Kdyjd7t/c/FdzSltYqNwkh
         pgXachBoGehe27W/DxjsVY3/5wk9897jIP38K8KVAU7cU67b77+nZ+C7g4+jO0flYXqL
         Ufr92AXdTBUImI8WYoz5TKczB7DhMSg6L+yr0YGFU8hbGI4V1TYNwEZOApp8C/FZC6jU
         APqA==
X-Gm-Message-State: APzg51AuvPXRkgkcddM91pmDfbgv9h5r1TuiysAu0DDQmodaJYbVZK+L
        nglzTCsm7ySokRk67lpJc/pSbOtP3plO/6jgR94JSg==
X-Google-Smtp-Source: ANB0VdaJwTMVorcGsR3YiAX3d9+ujpnc0/lQCnoOA0IgE82DZvtxT9z6+FCS5jDfx8MVHuacY6kSqPtNEmtT7Wp5xKA=
X-Received: by 2002:a2e:5419:: with SMTP id i25-v6mr25737653ljb.51.1537474109011;
 Thu, 20 Sep 2018 13:08:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9045:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 13:08:28
 -0700 (PDT)
In-Reply-To: <20180920165847.6xqzeoqzqkyotshx@earth.universe>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180614151435.6471-1-ctatlor97@gmail.com>
 <20180614151435.6471-3-ctatlor97@gmail.com> <20180916121045.aptj6nciwskfg4st@earth.universe>
 <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com> <20180920165847.6xqzeoqzqkyotshx@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 21 Sep 2018 04:08:28 +0800
Message-ID: <CAMz4kuKj1wtUMLLM8kzKSzotA64vHk466f2G7AxRsdWXZVJL_Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Craig <ctatlor97@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 21 September 2018 at 00:58, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> [Dropped a couple of people from CC, added Baolin]
>
> Hi Craig, Baolin and Rob,
>
> On Thu, Sep 20, 2018 at 03:32:29PM +0100, Craig wrote:
>> On 16 September 2018 13:10:45 BST, Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
>> >Sorry for my long delay in reviewing this. I like the binding,
>> >but the "qcom," specific properties should become common properties
>> >in
>> >
>> >Documentation/devicetree/bindings/power/supply/battery.txt
>> >and referenced via monitored-battery.
>
>> Thanks for the review, what bindings for ocv would you prefer? The
>> spreadtrum ones or mine?
>
> Most importantly I want to see only one generic binding supporting
> both use cases. As far as I can see there are two major differences:
>
> 1. Qcom uses legend properties and SC27XX embedds this into data
> 2. Qcom supports temperature based mapping
>
> The second point is easy: Not having temperature information can
> be a subset of the data with temperature info. The main thing to
> discuss are the legend properties. I suppose we have these
> proposals:
>
> Proposal A (from Qcom BMS binding):
>
> ocv-capacity-legend = /bits/ 8 <100 95 90 85 80 75 70 65 60 55 50 45 ...>;
> ocv-temp-legend-celsius = /bits/ 8 <(-10) 0 25 50 65>;
> ocv-lut-microvolt = <43050000 43050000 43030000 42990000
>
> Proposal B (from SC27XX binding):
>
> ocv-cap-table = <4185 100>, <4113 95>, <4066 90>, <4022 85> ...;
>
> I prefer the second binding (with mV -> uV), but I think it becomes
> messy when temperature is added. What do you think about the
> following proposal (derived from pinctrl style):
>
> Proposal C:
>
> ocv-capacity-table-temperatures = <(-10) 0 10>;
> ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
> ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
> ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;

For SC27XX, we have no temperatures consideration, but I think
Proposal C can be compatible with our case.

-- 
Baolin Wang
Best Regards
