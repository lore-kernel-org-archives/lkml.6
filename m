Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31E7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB59220C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXrRUSVK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vkp97IJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB59220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbeGKSpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:45:33 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:44541 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeGKSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:45:33 -0400
Received: by mail-ua0-f195.google.com with SMTP id k25-v6so7888743uao.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ly5UeIMmbBAWL4anmPaLeDPYCXhfwXSmsgADmnHUP+U=;
        b=ZXrRUSVK8zKg8W+gOuoQp01SBf1ic5/oouFyE+NtSqFXydiR+7shfqCan6U+k0iWSw
         Fgktx3LpCEQS0sj4FrGaHvJgb3R15H36osooxbAU3y/P3HK+/y4G7IiUHWvqw4S41DZx
         CYgMJPLaiKrKX0H5OTJvhL0PKlZYaEiJvI5bHAwocok0sX0IPOzK3r4/MqHLlA5y5kpd
         0SEUN7+X4aLwSwQQbfDNARDj+wpyLCbitrW9Y7qmeaR6g5PglaDX7/riJy0D4bL5nHEO
         15JqZvC/b9yhpIBOhjOgnPdfyzPIyQqtcTVR+LMzN0lvmAETRS0fNYOoh42o1qPeQVEa
         nVTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ly5UeIMmbBAWL4anmPaLeDPYCXhfwXSmsgADmnHUP+U=;
        b=Vkp97IJCF4mKdScALYUegysTTsk/sLUtWRKxgRpRA/uxYiuLXKASM3o9PLpg5vLanw
         qq0HA/EKINzxvjZWkXUG4JbVjSOi89pcJkXcRtk7RNz2FdJgnS4lgp6sLlex0KIN0FbQ
         so6krHPY47EEqA/znRrzifE4gdJvHJmGLERzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ly5UeIMmbBAWL4anmPaLeDPYCXhfwXSmsgADmnHUP+U=;
        b=YyVdND5uUkRtfl4J+KqcaP1IoOrbzYnu5KpSrWI3lT7oc5wuZZlhZSgJzYJDmXXvfp
         bpfQhiPlauIgmn/KaR11Ax3bQUrTvYsoljpt2fc4uTHK6GYawTaGnOHiyri/eA1WeyN9
         Bdr0irxR2pS804zMYtYRtG4sFnbLyDc6YbqJhQJr+SCGCpXTFK8AogMt9eb9HWDb9hZc
         5y9xkuku3eS1gXw1966d9pwd4JL3slGLNzfcDmxNLjvQEPu5yRB21pSFK2cdiDa5nG6c
         xv9k2sS1gVF6UBXJjIveqdFijzPkLf+vXIZBn7KdhOWqqpTngVvgOjshaoQz1EUT05SD
         HJQA==
X-Gm-Message-State: APt69E28u+uAtkcjgv04Kuc1AogpSIIeRYxGoZOxqxZGTkjtCVnW1KEq
        MSRCgi+Yk5jwK3WmKBQSDXlfByG6ULlcXp3oK32yZM16DI8=
X-Google-Smtp-Source: AAOMgpeariJbuxlUEb0YK062H2KsCUAyyLMyM6+xUR0RxczrnOHsbdRGJkpvyY4Xmb+7d0K9KboU7H8QzYqMdu8OedI=
X-Received: by 2002:ab0:1163:: with SMTP id g35-v6mr18979732uac.135.1531334396615;
 Wed, 11 Jul 2018 11:39:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 11:39:23
 -0700 (PDT)
In-Reply-To: <ee06e59ae84a9b9013480c58bd4678e44d201a42.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org> <ee06e59ae84a9b9013480c58bd4678e44d201a42.1531135999.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Jul 2018 11:39:23 -0700
X-Google-Sender-Auth: 03KLdnzSjN1a92BRg_mfBv1v8U4
Message-ID: <CAD=FV=X3B3wKv3jNLM8f9YvdRNkp6CNF1JmE+bMTBnR4CMvyww@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] dt: qcom: 8996: thermal: Move to DT initialisation
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

Hi,

On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> We also split up the regmap address space into two, one for the TM
> registers, the other for the SROT registers. This was required to deal with
> different address offsets for the TM and SROT registers across different
> SoC families.

The splitting into two regions is actually optional and that should
probably be mentioned in the commit message.


> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT). This is OK since the code
> doesn't really use the SROT functionality yet.

Nowhere in the commit message does this say you're also adding a 2nd
block of thermal sensors.  It seems like you should say that
somewhere.

...and it should also be obvious in ${SUBJECT}.


> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 8c7f9ca..6c8a857 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -461,7 +461,17 @@
>
>                 tsens0: thermal-sensor@4a8000 {
>                         compatible = "qcom,msm8996-tsens";
> -                       reg = <0x4a8000 0x2000>;
> +                       reg = <0x4a9000 0x1000>, /* TM */
> +                             <0x4a8000 0x1000>; /* SROT */

Note that the unit address is supposed to match the first "reg"
address, so either these should be reversed or you should update your
node name.  AKA your node name should be this now:

tsens0: thermal-sensor@4a9000


> +                       #qcom,sensors = <13>;

As per my responses to other patches, " #qcom,sensors" is undocumented
and doesn't appear to be read by the driver.
