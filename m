Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43DDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711D2223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpTTlrq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711D2223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeKOULp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:11:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37356 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeKOULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:11:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so13721104lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfO4O1ejTC8UmFMbmvkD2o/mdOhjPayqR2hMlEl8nsY=;
        b=DpTTlrq3RSIQdlahIRu7/9lMe5b7llJQsP4pU41K+vxytv6AH0CvCJBKsA1xApuppL
         mScMxdG974bThoYx+y0PiT7L2WwY5D4F89+AGn6XFQGho8j7It4B85sS/3t5MI9aJOC4
         29w8no30S6XLRJsXUcIDr48QKwnQFK5a4ixSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfO4O1ejTC8UmFMbmvkD2o/mdOhjPayqR2hMlEl8nsY=;
        b=nQmgLukvnBY2fDo6ZlYXbZCyrRCuJzZB7lv9ehwT5ENXsV05ckU+piXVj9d3Bmq8lU
         XJH64+1/Bn2yzuwpWjgrwiiMVFVGURjijLhvm1hACs73fZJ6D7Cdh8NXnutU7DNoecBV
         1ERjw1cVjOVk/boGhWUIh2YVVgxNuKlh+WjijO/0weN9CUv0qlKFNpOm3caRHbkGI4Z7
         tgmg3ToN2bunZGXK8+MyIMOgBXWIvh/zu1QtL/jeLDefy9Q7zbxaAWdKee2YXucwA8pi
         w1SBsvv68oTtbvpFY/CIkueZqSA2oh77mrLZPiIPv19fZiTjPgfyVVmeCvvQyIXYU7rk
         7GdA==
X-Gm-Message-State: AGRZ1gJ0MMGpekg1Zocdq1TLvMsktOVUGXjBXwQi7ACX5D0fygcyb9hz
        j/XDTJ/S8cPka7c704GZWAkYUqBygW2h2LaiJsNdFg==
X-Google-Smtp-Source: AJdET5dC46ho/LjKD+95DxSCKPxUKc5wjTlK4N4cZbG3+KJHAqnzmZlqxgl8atlN2cwaTPGmcbn30Z4uGD2XSDCHxcc=
X-Received: by 2002:a19:2752:: with SMTP id n79mr3339238lfn.11.1542276274601;
 Thu, 15 Nov 2018 02:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org> <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 11:04:22 +0100
Message-ID: <CACRpkda25cuiPCe9ouvDDSpFwZ2z=Pm8pK=5jC-7OAcYwPSvvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: Add devicetree bindings for
 MT6797 SoC Pinctrl
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     sean.wang@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 6:49 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add devicetree bindings for Mediatek MT6797 SoC Pin Controller.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied.

Yours,
Linus Walleij
