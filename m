Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCAAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA7120656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UUCoup8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfANWaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:30:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42520 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfANWaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:30:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so278009pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=r46LeIrxXpfFDUvsEIEIjdnEANrwzA0c12lEFd4nea4=;
        b=UUCoup8XY1dGOADFTV16xkk2Gwe3Kn8I1bLGXYhDpjcUAUmrY+stGUXbL4C6gWTlL1
         aJMFbKppKGgElb24iAMD96TUuzFGoStnr01PolXZObgGHuZDAbF7NlLsI8Ter2Dq+6ir
         rG6YQMRysqb6m8SRLmQ/0jfst8JlcmQ48JinY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=r46LeIrxXpfFDUvsEIEIjdnEANrwzA0c12lEFd4nea4=;
        b=NW9vLapPhb3gWp6nnoG93TR1gizUOsxqORvuNOr37aX+IYuQ4r55GMUUNf90mrC8E7
         bgMpZmcSmrr4IU7LpgVq8mQ2HBdXWzZ+5TyBjgabMVtqfDJfq7MalrcBPBcq+5JPvIKx
         idf7JKa9v9QPOdYbBxRoLHSGZITmreLjTrx0fHyhK7Ad6OGDKozjdNc18jEhMftyBGbJ
         FpHPbabifSVwUN0mR0Czx4Kg86xrifQ5ViAaNKzfyco45i6Y9OJN/0V6hIpfxteVftFX
         eWv6CUd4lLy3o607tRyvkhYibAada0LUXLdM7pfUNUTsg7yfAvcFH3Px2x5Sj1MaybgX
         8p2w==
X-Gm-Message-State: AJcUuketAyWpRUOUNajF9GMoWllMXLrE3I+5a3uZZIUjV33K4H8FGlOP
        pVhC+hMyAi6E9GEeO6NwVsKpqQ==
X-Google-Smtp-Source: ALg8bN4ElDaIslt8lIMUyKiDUdBhhJdcyQF9DhxyWoMNAsxQt5Wn39PM9J0qTu3wGJJRCpSAZCa5aQ==
X-Received: by 2002:a63:4c5:: with SMTP id 188mr703275pge.391.1547505054475;
        Mon, 14 Jan 2019 14:30:54 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h129sm3221863pfb.110.2019.01.14.14.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:30:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/7] dt-bindings: soc: qcom: Add AOSS QMP binding
User-Agent: alot/0.8
In-Reply-To: <20190106080915.4493-2-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org> <20190106080915.4493-2-bjorn.andersson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154750505285.169631.15400388488161882052@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Mon, 14 Jan 2019 14:30:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-06 00:09:09)
> Add binding for the QMP based side-channel communication mechanism to
> the AOSS, which is used to control resources not exposed through the
> RPMh interface.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

one nit below.

> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt=
 b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> new file mode 100644
> index 000000000000..9b0d9785efe0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> @@ -0,0 +1,57 @@
> +=3D EXAMPLE
> +
> +The following example represents the AOSS side-channel message RAM and t=
he
> +mechanism exposing the power-domains, as found in SDM845.
> +
> +  aoss_qmp: qmp@c300000 {
> +          compatible =3D "qcom,sdm845-aoss-qmp";
> +          reg =3D <0x0c300000 0x100000>;
> +          interrupts =3D <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> +          mboxes =3D <&apss_shared 0>;
> +
> +         #power-domain-cells =3D <1>;

This is weirdly tabbed out.

