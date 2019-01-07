Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE44C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0422183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546905110;
	bh=p7/lNg83d6aEMP9cI/nh/vkFfRbwBgPEThOtmRFJShQ=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=zgAaGvAyNyYdHPY5lBFyNKqDUGGc2dCZtiwvl0zmcdbE1mdOHY+np0s/Aqh5TXBgG
	 yyIUakQdLOZUJ/1/qKx7slBpDbFql1AVk6ep6hyjJSUVEYU7F9lywX9ORjWWeVKwPU
	 kxK/xF+qPIOC1sAUQmsR0YzZnC3k9Pp1Ewbp8ulI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfAGXvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:51:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGXvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:51:49 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 399F92183E;
        Mon,  7 Jan 2019 23:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546905108;
        bh=p7/lNg83d6aEMP9cI/nh/vkFfRbwBgPEThOtmRFJShQ=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=eLhRKzkxaTfYJXeqfza8Gw53x9iMJF+G8J/UtXkBRamz5/sdnXDZY+l7ANE6G8mD7
         5faRXL38MwIH4WIqphXN3/dU8sIc2oJG5gSuCCTc8xYeS32pZa4tUa2dQa5XVnuZxM
         o4FcQh5c4pZhFtDWd+evBkNJfbeDEWH1pk5uAEsY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/5] ARM: dts: qcom: msm8974: add interrupt controller properties
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
In-Reply-To: <20190107021145.6370-6-masneyb@onstation.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20190107021145.6370-1-masneyb@onstation.org> <20190107021145.6370-6-masneyb@onstation.org>
Message-ID: <154690510733.15366.11047294617451125580@swboyd.mtv.corp.google.com>
Date:   Mon, 07 Jan 2019 15:51:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-06 18:11:45)
> -                                    <0 0xde 0 IRQ_TYPE_NONE>,
> -                                    <0 0xdf 0 IRQ_TYPE_NONE>,
> -                                    <0 0xe0 0 IRQ_TYPE_NONE>,
> -                                    <0 0xe1 0 IRQ_TYPE_NONE>,
> -                                    <0 0xe2 0 IRQ_TYPE_NONE>,
> -                                    <0 0xe3 0 IRQ_TYPE_NONE>;
> +                       interrupt-parent =3D <&spmi_bus>;

If I'm reading of_irq_find_parent() correctly, we don't need to specify
this? It becomes implicit because spmi_bus has the interrupt-cells
property and this is a child node of that.

> +                       interrupt-controller;
> +                       #interrupt-cells =3D <2>;
> =20
>                         boost_bypass_n_pin: boost-bypass {
>                                 pins =3D "gpio21";
