Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C4EC43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAAE213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XY89ZD2o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HKbr3KXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAAE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbeGKWHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:07:21 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44726 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbeGKWHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:07:20 -0400
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so15275514vke.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 15:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5k/k+uPKwa9Palxh0LzQfvkzZ+n3MsPFuH6dwwTGtFw=;
        b=XY89ZD2obVOEaFkS6X9moL061+LkTeIBesfSpmWv00Ya0unEHgFfNnKipOut4VIou2
         OHmMV3vvqOZzO1s/6OL3ODgAXezTGeRAg6OrccJseJmpoL9hwAyhnk1uDIJtyZtiAcdi
         9IQvIq/01y+11NMkkPTYGZdkW/n3NaJLmStD2n/bk+v9Yr6mgii0QJngctDuWu1zepSg
         iZsSbBlrcghTGaRdM7c+mXpdKDjwDKIVB8aFmYcxZvHHGoe+o2pY6RiMjYsELT4YhISg
         xh6eGP+c3LF5nAbbn4GJ6dhUqnlCcDbjwuVEIZmNWbWSy/HT0StmiFdnhc+nE273nNYg
         yyUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5k/k+uPKwa9Palxh0LzQfvkzZ+n3MsPFuH6dwwTGtFw=;
        b=HKbr3KXO1xntrsMSMvUNNkQa568tGEmJRCrjLt7weAmwRS9AsN7smRhe19awGLaGUc
         +za1z2g3baKWSGu/ZqqXvH14CAYd5nXBwciISEqLQ2cP2XaSrremo76A84c9vtjr3Ccv
         jvKvyjDyuA9ynKVgOzhVArjPmbQftoP2dM9Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5k/k+uPKwa9Palxh0LzQfvkzZ+n3MsPFuH6dwwTGtFw=;
        b=rnsENJz/q5JJKONGmbbubfokDPPdGA/YE7kw/WlTXOsSVyL9DIKXVsHpbO54ZJ9ymU
         P86BYUGuKf3qIZy1jxc0h2hdbRvVHDj+IVtmwtY8OdP57vZxCTcZ7OFBFSLtluDRmM6w
         p72F9ksKg35d1rIcMjGOcvkNhFO9CukPpQK26zHnvmSA0j+Kv5lChlC29ww1prLq7/0h
         STfRtW7s3OnzyIksEpySua3+QPFucNRdWYed+ma7+GYxD8u/+GPzUnw3MNKMi8Wzd7e1
         BvM5TSPMI5IBFPhrMq1+Wg+WhYBklskmIimRDVBejXDFUH03PZsAdTrDFYX3QYv406+c
         jUkA==
X-Gm-Message-State: AOUpUlEPaB22ZN1cpIV8XePTr5+Fk5fhdBt+gbs3Vo8TUf+2ZjOHZ+C4
        zz7IEBTYiS9U5pT9yE5hJhGmL2Gz02VoNv1/ADVeOQ==
X-Google-Smtp-Source: AAOMgpcdJmOXTSYIsW9mjiGIZCebGXc+IE0A9y7wlghLStN/9ZfQv5qKR6Cbc6JliuE4TvP1Ve4A0RoIcLN9DTaDDr4=
X-Received: by 2002:a1f:c014:: with SMTP id q20-v6mr276665vkf.144.1531346456488;
 Wed, 11 Jul 2018 15:00:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 15:00:55
 -0700 (PDT)
In-Reply-To: <20180711215129.GT129942@google.com>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <65c39c405076627bd43ec94c211c6998191b9f16.1531136000.git.amit.kucheria@linaro.org>
 <CAD=FV=XpfJyd8hUT45+J=EVY1Bs28Mk7m2TBJy8J=HO63n2_qw@mail.gmail.com> <20180711215129.GT129942@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Jul 2018 15:00:55 -0700
X-Google-Sender-Auth: yHGzjhP7j5I82uF1VPnxrC42L3A
Message-ID: <CAD=FV=VCxpaF1t5Q-5Vv+9VH1igWoER59OMJmXZdEj3V6fOZwQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] arm64: dts: sdm845: Add tsens nodes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Wed, Jul 11, 2018 at 2:51 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Wed, Jul 11, 2018 at 11:44:13AM -0700, Doug Anderson wrote:
>> Hi,
>>
>> On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> > SDM845 has two tsens blocks, one with 13 sensors and the other with 8
>> > sensors. It uses version 2 of the TSENS IP, so use the fallback property to
>> > allow more common code.
>> >
>> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> > ---
>> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>> >  1 file changed, 16 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> > index cdaabeb..ba2899c 100644
>> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> > @@ -221,6 +221,22 @@
>> >                         #interrupt-cells = <2>;
>> >                 };
>> >
>> > +               tsens0: tsens@c263000 {
>>
>> As per my comments in the bindings, nit that this should probably be
>> "thermal-sensor" not "tsens", AKA:
>>
>> tsens0: thermal-sensor@c263000 {
>>
>> > +                       compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>> > +                       reg = <0xc263000 0x1ff>, /* TM */
>> > +                             <0xc222000 0x1ff>; /* SROT */
>> > +                       #qcom,sensors = <13>;
>>
>> As per my comment in the bindings and the code, I'm confused about the
>> whole "#qcom,sensors" bit.  It's not documented and doesn't seem
>> hooked up in the code either.
>>
>> ...but if people have tested this, perhaps I'm confused.  How can
>> things work if num_sensors is 0???
>
> The mystery is resolved by:
>
> commit 6d7c70d1cd6526dc79e3d3b3faae1c40c1681168
> Author: Bjorn Andersson <bjorn.andersson@linaro.org>
> Date:   Mon May 7 16:53:39 2018 -0700
>
>     thermal: qcom: tsens: Allow number of sensors to come from DT
>
>     For platforms that has multiple copies of the TSENS hardware block it's
>     necessary to be able to specify the number of sensors per block in DeviceTree.
>
>     Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>     Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>     Reviewed-by: Rob Herring <robh@kernel.org>
>     Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
>
>
> I bumped into this during testing ;-)

Ah, now it makes sense to me!  Serves me right for assuming it would
be in the same series and not checking if it was something that had
already landed.  Thanks.  Please ignore the parts of my comments
related to the "#qcom,sensors" property.  I guess Rob must have
thought that the "#" in the name was fine and he's the one in charge
not me.

-Doug
