Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEEFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7949621A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jRooP8wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeLVRB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42523 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLVRBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so4035935pfr.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:message-id:references
         :subject:cc:from:user-agent:in-reply-to:date;
        bh=8U4lLFEzgmOyVZW/eMybTSK3OpgJqkaV07U4d2bmYAs=;
        b=jRooP8wpoyzrPuXd4kYUQUtadB0A/1LRE9uRE4hCBfNw9M7MRPx3KF+ZrW/xLkP1ht
         XJZ85aM+ZTvq89puLMXtvcJRnZKkPUYApN2jZvXkJfOASCaw32wHYJPxzFbdrYto9y0g
         BkkObGj00M2Pm3W4JRgCaoQ3qM9xv/hbXrZEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :message-id:references:subject:cc:from:user-agent:in-reply-to:date;
        bh=8U4lLFEzgmOyVZW/eMybTSK3OpgJqkaV07U4d2bmYAs=;
        b=CEmst5Vk6OIV6Hcl19lirkKbf+/aUm+5l+tJ5ONWzBu0+vaY19a8epE5DsPUyMAuOC
         rQhXSA0mFzuzAu0PQI5Jz00p4DCarOJ1AQOTCPX2+unzv3bmQLC0HV23S+9qZHQ0MHSP
         xosPinyvF9F7NClnnKdPPEiKtc0ZIshFbcGXcq69UNbyADptOtX9cvtn5W+FhvZmJnaq
         y5+qOSvh2OlcaEJ3CAouGuiyJS1ANqFKmyceKQORRNKMxulxRRGqJODVVwTczUfmlztD
         1y/5Wb5yHITLdj3ynrCjp9tbxEeaK7yo9tNeTcFEdG5p1aPdxrjcQGLyUD1O0dHEzK4n
         bslg==
X-Gm-Message-State: AA+aEWZtKi14DoTPtTkm4u/5WVJ8tkhY/MNHebxNW8VmSbwzsg22gX0B
        ce/y9Uq6oR63ocRbDypCUytfxA==
X-Google-Smtp-Source: AFSGD/XUaT3jSUirkqEsm3pflHoobUs8BPizdEH1YSTUykHOX5hMlpgH3ZL3MUF85H98QIPbt7xtIQ==
X-Received: by 2002:a62:5c41:: with SMTP id q62mr5696061pfb.171.1545464391207;
        Fri, 21 Dec 2018 23:39:51 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m3sm42102531pff.173.2018.12.21.23.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 23:39:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Message-ID: <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
References: <20181221115946.10095-1-rplsssn@codeaurora.org> <20181221115946.10095-4-rplsssn@codeaurora.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm SoCs
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        devicetree@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
In-Reply-To: <20181221115946.10095-4-rplsssn@codeaurora.org>
Date:   Fri, 21 Dec 2018 23:39:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Raju P.L.S.S.S.N (2018-12-21 03:59:44)
> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Do=
cumentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> index 9b86d1eff219..f24afb45d0d9 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> @@ -30,6 +30,12 @@ will be an aggregate of the sleep votes from each of t=
hose subsystems. Clients
>  may request a sleep value for their shared resources in addition to the =
active
>  mode requests.
> =20
> +When the processor enters deepest low power mode, the next wake-up timer=
 value
> +needs to be programmed to PDC (Power Domain Controller) through RSC regi=
sters
> +dedicated for this purpose. PDC timer is specified as child node of RSC =
with
> +register offets to program timer match value.

That's great info, but I have no idea why it's in the DT binding
document.

> +
> +
>  Properties:
> =20
>  - compatible:
> @@ -86,6 +92,20 @@ Properties:
>  Drivers that want to use the RSC to communicate with RPMH must specify t=
heir
>  bindings as child nodes of the RSC controllers they wish to communicate =
with.
> =20
> +If an RSC needs to program next wake-up in the PDC timer, it must specif=
y the
> +binding as child node with the following properties:
> +
> +Properties:
> +- compatible:
> +    Usage: required
> +       Value type: <string>
> +       Definition: must be "qcom,pdc-timer".
> +
> +- reg:
> +    Usage: required
> +       Value type: <prop-encoded-array>
> +       Definition: Specifies the offset of the control register.
> +
>  Example 1:
> =20
>  For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of =
2, the
> @@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
>                       <0x179d0000 0x10000>,
>                       <0x179e0000 0x10000>;
>                 reg-names =3D "drv-0", "drv-1", "drv-2";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges;
>                 interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> @@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
>                                   <SLEEP_TCS   3>,
>                                   <WAKE_TCS    3>,
>                                   <CONTROL_TCS 1>;
> +
> +               pdc_timer@38 {
> +                       compatible =3D "qcom,pdc-timer";
> +                       reg =3D <0x38 0x1>,
> +                             <0x40 0x1>;

I don't understand this whole binding. Why can't the pdc timer be
programmed within the rpmh driver? This looks like a node is being added
as a child just to make a platform driver and device match up in the
linux kernel. And that in turn causes a regmap to need to be created?
Sorry, it just looks really bad.

At least for the regulators we have a semi-good reason to have a subnode
because of the pmic-id property that we need to match up to the right
pmic. The argument for the rpmh clock node is unclear to me so we should
probably get rid of that node entirely. I can't figure out why that
wasn't just a #clock-cells at the toplevel rsc node. The same goes for
the interconnect and rpmhpd bindings. It's all sub-nodes to placate
linux device driver model.

And now that I've had to look at the rpmh binding again I'm disappointed
that we have SoC data stored in there with the qcom,tcs-offset and
qcom,tcs-config properties. Just make an SoC compatible like
qcom,rpmh-rsc-sdm845" and figure these things out that way. And please
tell hardware folks to stop moving the register regions around in the
future so that there doesn't have to be so many variants in the driver
and compatible string space.

