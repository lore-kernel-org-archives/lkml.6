Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA25C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D6721533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+CSklXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D6721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbeITVSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbeITVSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:18:48 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9AD21526;
        Thu, 20 Sep 2018 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537457686;
        bh=Y4+kjylGQWZB3RgFiej5Wbk3gU09ega4LDvGVapI7bY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=J+CSklXJ/Do2k45//AlKjWYezKH+CA5OP/AQQBInPBv/indPGU5WN3l4WODPI72rx
         pnHWUib9m27PGN8malw4Co2TtY31Ao8oFGUn2FhYX0wlA7oFK3kBjh0GYOIsg52lsc
         mfvMWU4rMBhOCQ5Zx0yuflZOZrbzNaqEv6lKDLsY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180920013712.2361-4-bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180920013712.2361-1-bjorn.andersson@linaro.org>
 <20180920013712.2361-4-bjorn.andersson@linaro.org>
Message-ID: <153745768521.119890.130144479222793813@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/4] dt-bindings: pinctrl: qcom: Add QCS404 pinctrl binding
Date:   Thu, 20 Sep 2018 08:34:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-09-19 18:37:11)
> +
> +Example:
> +
> +       tlmm: pinctrl@01000000 {

Drop leading 0.

> +               compatible =3D "qcom,qcs404-pinctrl";
> +               reg =3D <0x01000000 0x200000>,
> +                     <0x01300000 0x200000>,
> +                     <0x07b00000 0x200000>;
> +               reg-names =3D "south", "north", "east";
> +               interrupts =3D <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +               gpio-ranges =3D <&tlmm 0 0 120>;
