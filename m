Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25004C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C624520854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gaETRTM8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jkgCFQEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C624520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbeGKStw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:49:52 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:38371 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387535AbeGKStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:49:52 -0400
Received: by mail-vk0-f67.google.com with SMTP id b77-v6so14979132vkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=94fXCpSd45c8Fbyjuqut8tXExDuTQIPRyjvQWKlxufI=;
        b=gaETRTM83aQN6gxWum18XROI1gtUc2wlx+DvZsY0shkm7WWSJQvZz9cyTIzY1D92RV
         gQ1avVcPMPHMaSPcP0f/nRyVLT3NZCWmXd/KSWs5qfPvZWuyS2lunq1ybKS3N4TeDMOm
         L+p7I8RQ0oGrUy4w9WfwBlSPtfz+Fy41KduY+w9kiinxs1GnFdoXroF9ne4dwgLRz7o/
         iJZgbSsQDFC1QTv6LdwS2/zIybClY0q1Yiv9FaLJejv7oyBaIy2FKzEuRc/2etvmK3eT
         w3wgKQ+Bhsne4qNB97nTsT0nza2sjEpXfhNPCe3YUbn05avDjej3CRzFKK4pWH2iQKMm
         b9AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=94fXCpSd45c8Fbyjuqut8tXExDuTQIPRyjvQWKlxufI=;
        b=jkgCFQEa9Upw9+MyIbd1KEuaAe1CCKaeiYhFd0S37EdcaRETq+4fDWAaE7oq6Pm/7Q
         BeSAYUSFGQlu9XvmK2WTti+rxXxzUnzYWIOrBgjKC9dLm/iZPCEx8/haHktsSeyRrNur
         LItOQmFUABIMbaUecTplNaOxa364lmPnfgOdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=94fXCpSd45c8Fbyjuqut8tXExDuTQIPRyjvQWKlxufI=;
        b=mZSaUIl7tVdU9hKQaCWKMv2bVLv/rSDfQIk83H2TXoCsjWx4a/oYOv2vi4qvRFzynq
         Y0oikh5X2cSUr13bsFY0U6b6fTYYMLBrp+/mw11MdJmjC8glFabiYbImskvRMwjo52MW
         n1zI9jxaLlWvlcCdyDCWlH9qGL5rwLy6QSFMPIoT2pej3iDB0kSqDLjTruRnYFQASqCl
         ezexnRYGZ02hNi2j4jMU6tvA1zAqzfgLCRUyZD7tkMntbJ91HTZKEQJ1tR+f6RVdcPG3
         c4apPARmF0CxKevB59R7pARdJUbHdefgc/nVu5WqDQdAWO33Sllor0qVIVCqYfM8jPhG
         1RXQ==
X-Gm-Message-State: APt69E2yJCnVFQgVF1yci/sowCrK0Uyfmxo8RECaBIFTlvZi5fu/PafO
        odPOn3WUCGC3+3rK8hYUz1rQRD3GICKR2cceusOvVQ==
X-Google-Smtp-Source: AAOMgpeWWNbBETQJhoP3I/NRzXlI70+S0mcMdQTR8ASH+GPu2/BfCPIUXRJgw0Uo2YK+MAb1LAqXD47V6ivqsh6SsGQ=
X-Received: by 2002:a1f:c014:: with SMTP id q20-v6mr14221242vkf.144.1531334654793;
 Wed, 11 Jul 2018 11:44:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 11:44:13
 -0700 (PDT)
In-Reply-To: <65c39c405076627bd43ec94c211c6998191b9f16.1531136000.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org> <65c39c405076627bd43ec94c211c6998191b9f16.1531136000.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Jul 2018 11:44:13 -0700
X-Google-Sender-Auth: GBd09JCXNS-vrhpA83iLVAtZlzA
Message-ID: <CAD=FV=XpfJyd8hUT45+J=EVY1Bs28Mk7m2TBJy8J=HO63n2_qw@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] arm64: dts: sdm845: Add tsens nodes
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
> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors. It uses version 2 of the TSENS IP, so use the fallback property to
> allow more common code.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb..ba2899c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,22 @@
>                         #interrupt-cells = <2>;
>                 };
>
> +               tsens0: tsens@c263000 {

As per my comments in the bindings, nit that this should probably be
"thermal-sensor" not "tsens", AKA:

tsens0: thermal-sensor@c263000 {

> +                       compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +                       reg = <0xc263000 0x1ff>, /* TM */
> +                             <0xc222000 0x1ff>; /* SROT */
> +                       #qcom,sensors = <13>;

As per my comment in the bindings and the code, I'm confused about the
whole "#qcom,sensors" bit.  It's not documented and doesn't seem
hooked up in the code either.

...but if people have tested this, perhaps I'm confused.  How can
things work if num_sensors is 0???

-Doug
