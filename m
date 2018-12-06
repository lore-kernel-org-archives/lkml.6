Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185BFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6B220850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZBSBaHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6B220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeLFJ7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:59:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40669 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:59:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so21454092oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7LEJEujb6GyN4xuQXSs5pit1CSJln1G0tHvlP+Qf5bQ=;
        b=QZBSBaHVk34qUZcwtGyiNKBHH+Bzfw/R2PXy0SA3dcHRSY0HYhA8ii1chnpUP+nCVC
         jS9ZTzrKvgqrw6MWvMJcrmoE/T8MYX4H+FcLyOikzyY6lZ9TueGHak0xMzY1LF3R5EY1
         fiCT42iLgw/WpLx4MZUsHN3Z6DyiQybWyyMgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7LEJEujb6GyN4xuQXSs5pit1CSJln1G0tHvlP+Qf5bQ=;
        b=gyM6adgx8Ev7FewQLAunVeHeh5f5ezdrPKmKj4IW/cnWBztuZokdCS1YrvfWKdCu1A
         1mCilTt0VIeTlK5YEQe9n4qLWLKAWuSaxkAUtFVnrxXuBxRMamGhAkOm2FAGoRVjGOlm
         +IFRt96mgTx2XIZqqw4+LZWambSmGbJriBw8GdRLf+3uy46ndAj1cr+/P1K3H0jkFt27
         vAb6k089ftpEN3NufoKxaz5XKt7th1pLq8q5CiwFo8vliH1ck4WB75sFREENW9gZbrFc
         j7oAGRAr0NwFB2PoqdNg6/QDXoClx6sNudRHD9nzyDc0yPpxq60/ARMuc17n7y6H9Okp
         e4hw==
X-Gm-Message-State: AA+aEWb6YfAHEIii/zy8rCnmuIE/kCxrdefMglvxHI5nTT6zeT6Ezuva
        KhOF3Ack+YjV2pegV5sbAbUIfcvyYBYILXNTeZOGkw==
X-Google-Smtp-Source: AFSGD/UYBU+Lx580vsBsUV31//DE6lTVtGrexolu87rXO2viopjNqlRDplZ2HAsNKjClsh+OhM2h8DtyEDll29BiyvU=
X-Received: by 2002:a9d:72e:: with SMTP id 43mr18299579ote.207.1544090376005;
 Thu, 06 Dec 2018 01:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org> <20181114090027.7580-4-benjamin.gaignard@linaro.org>
In-Reply-To: <20181114090027.7580-4-benjamin.gaignard@linaro.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 6 Dec 2018 10:59:25 +0100
Message-ID: <CA+M3ks6Qk9rjnBHUkPRT8KNnBaG-wBAMOQek0Du39OhYYoDUfg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ARM: dts: stm32: Add hwspinlock node for
 stm32mp157 SoC
To:     Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 14 nov. 2018 =C3=A0 10:00, Benjamin Gaignard
<benjamin.gaignard@linaro.org> a =C3=A9crit :
>
> From: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> Declare hwspinlock device for stm32mp157 SoC

I abandon this patch and I will send a one that fixes the issues.

>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>  arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32=
mp157c.dtsi
> index 185541a5b69f..98f824d8b0f0 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -803,6 +803,15 @@
>                         status =3D "disabled";
>                 };
>
> +               hsem: hwspinlock@4c000000 {
> +                       compatible =3D "st,stm32-hwspinlock";
> +                       #hwlock-cells =3D <1>;
> +                       reg =3D <0x4c000000 0x400>;
> +                       clocks =3D <&rcc HSEM>;
> +                       clock-names =3D "hwsem";
> +                       status =3D "disabled";
> +               };
> +
>                 rcc: rcc@50000000 {
>                         compatible =3D "st,stm32mp1-rcc", "syscon";
>                         reg =3D <0x50000000 0x1000>;
> --
> 2.15.0
>


--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
