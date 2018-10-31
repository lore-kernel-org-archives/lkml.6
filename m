Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114A5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD7720685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJiUxUMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD7720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeJaSkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:40:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38534 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJaSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:40:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id p86so8909351lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p78zBwnYL4GrL60VvL2qsENAKsSSxnMcMy+xEmvl7yo=;
        b=bJiUxUMdmUYs7MSjhTtxiAvQhazuHAnBCr0UJwXKausWKWOb9si4U+CR8km0EEjyyT
         jCTkiA4CIXdFmSx3hDzSIEACp2ilVEwOhlOZiv9THT8xB8DS/2+iUwV7YHSxr/wlqK5q
         x41Gw85GzEE7038xQYUyrpVq4CgBinMPtK+VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p78zBwnYL4GrL60VvL2qsENAKsSSxnMcMy+xEmvl7yo=;
        b=csn3LxcNbq0eyYssHq6lyM2WTrUQeEThCQ4blYszK9hJT/aJ15KYAGL9Z3kR8St9op
         zikjPOacx4MZF8hOGBkBd2DFji1Fqt2/wGvg+JkR05zjoQYPpByoeW1otDRf5erZ8T6s
         FrS1cNMMe337V1u0M/n9V/9ZFJjbl6lEaMC7GJ8Gao26rJsWim6fteMY17DZrqauL/ud
         cpDOSLLH2Qt2JuXJHF8bAi3+lMRQAi/3sLV8Oc+xJeEUIaKZatRzqHuOU1Du4aBqJ6Rt
         63ivMMnsvCWGpGO1uc84vO8yFL7aYis+Mw7ESMmmKLJTrjT7u+Tuj5d5I3R0XHBeca3k
         FKvg==
X-Gm-Message-State: AGRZ1gJPRXKoyuAyEJ/yIjHCpuN7b+9BmZaSu6WTc35QTGvnAZaYriv8
        uoWVLg0Uc0Fy3AD0ZKGtU0wuj8Asf7q8kqArGs6ryQ==
X-Google-Smtp-Source: AJdET5crKjdh83yMt1h3yZZpT90dqqdQPChLimg9VtELppF2gijyNMd1ltjzCrSBpErxX2MIefFascDH+K8fnKiEvWw=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr1285546lfd.149.1540978991144;
 Wed, 31 Oct 2018 02:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 10:43:00 +0100
Message-ID: <CACRpkdbMSYt5aH9fwRijtO=VG1nLAnfxTsfxGza+_Z2iGj2+-A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add Pinctrl and GPIO support for HI3670 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Xu Wei <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 9:07 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> This patchset adds Pinctrl and GPIO support for HI3670 SoC from HiSilicon
> found in the HiKey970 developement board. Also, the remaining UARTs are
> enabled and GPIO line names are added based on the Schematics and the
> 96Boards Consumer Edition spec.
>
> Note: These patches are based on the below common clk patches pushed
> earlier:
>
> arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
> arm64: dts: hisilicon: Source SoC clock for UART6

All looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>
for the series.

Yours,
Linus Walleij
