Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373BAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A7D27EE7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMl0AFmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A7D27EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755439AbeF2M2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:28:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54673 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeF2M2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:28:22 -0400
Received: by mail-it0-f65.google.com with SMTP id 76-v6so2578155itx.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZXIzxLHY+PxFtvIxwDDBdxl9u2SOq1gwXmLqtCUh0c=;
        b=ZMl0AFmEMT5DLNsPG571x7IFpqjWNE2+dzP52e9hHUWOFvCm4hoSl+64t642kHaW4h
         gBSz5p5pkOgDNlz3aUt7t2ewBRSmiPFeHnkGVyvqpzJ/+HMmfXVJkSwo6O6uwC89eZLA
         GQfed8Hhqja900f2THTTdz9isAZYwIMysT+ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZXIzxLHY+PxFtvIxwDDBdxl9u2SOq1gwXmLqtCUh0c=;
        b=D2sJAWU1+37UTdZnyQosfq2RX63HfEjsrdfwkGYHyk01bHoBKvcbmKPm/7/pi57P1t
         qwvdHo2zYOdekevGlvoZJm/uosBUYyl8sT4BYhJPfekLYRWF6gfYjfxm9awxEqZEv9kZ
         pEafKfkBJcxnWAvooaPuSAP7InPV4WVlN14GEAX2khCZW0i8Pbx05nw5T89S2XoMa8ZO
         fdu/brVALA59zrr+oe3b+HECgCTKUS78ckZ5eUBsajEFeYl7NNwYr65DHW7DrINuopLJ
         bVjNF+37z+EzLk3d+Gt1MIapbwvqzCBZpP5/OMGk1GS8Y8m+QkCOVsDv+/hVxkQRaFju
         LNow==
X-Gm-Message-State: APt69E2GYsrrRoFQkKchOUljrtlOr+AeX4wrmaYyNYhbFxxSSZ7eoeAG
        OeYvxk0Mx67AR71IA0La6OZ2P/tCW+Cl9G75Hu4PMg==
X-Google-Smtp-Source: AAOMgpezcHzc6pvKgedHj4NMQvJ4ucHP0rd+OXsnVtwlj2OzTe3WAFGGeAzA4iqShHokgoR9lAesxQnu7qXsXKAUv4M=
X-Received: by 2002:a24:79c3:: with SMTP id z186-v6mr1245793itc.38.1530275301896;
 Fri, 29 Jun 2018 05:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org> <20180623045954.6729-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20180623045954.6729-3-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:28:10 +0200
Message-ID: <CACRpkdaedj9bgadowSK3Qa2_76wFpsLAv1BdmzvLFcfsNF0HBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: actions: Add interrupt properties to
 pinctrl node for S900
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 7:00 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add interrupt properties to pinctrl node for Actions Semi S900 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please take this through the ARM SoC tree.

Yours,
Linus Walleij
