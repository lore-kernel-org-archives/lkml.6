Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC93C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C890420870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvM7FjSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C890420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeKTAcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:32:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34068 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbeKTAcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:32:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so26246718ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nu5nr26bjY/1dHgvzWPldKHYw5Qfj36ninisOy4PWlE=;
        b=XvM7FjSc4iWtgAecR1eb0voL/3nwRBNSS1UlvBajN7aoVvUUi8+LfRgTdnp6AHBiRj
         NeslHHD7CNG9omRIbQ/kgyIB/r1Sl5QFre0rqDzRTUapPby0RlhY+fctsRMEq3ES0EuV
         6leJhFPhQcb+dDPIrpFs92+wwCS37yak1P0JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nu5nr26bjY/1dHgvzWPldKHYw5Qfj36ninisOy4PWlE=;
        b=K4z/I2v2kC3jFCT7WHjO4QMrYTN6ofsD0mVQgpSI0m7GN1oZBOR8wa5CusM0FHeQyn
         4BriuqpkZhRNFFbofSyq0mTyWURJMPX4GITQM5FfTTi7gwqtVTuGkM9PyJ0TKvquMh2I
         mES2RtZK43AOREdakKevEW7jwO1wDhnBxHiv4PRNBb164VXC0RNTLtsOQOVlIhjtFAg0
         ceG4C91DzuxDLtUAKxUSDmLHVpgahVY2lzC1spAYhDAl5W00OdobhgueGioP6OLuxnE8
         IVQuHlRV7fcDK0poMiXhfxg2n1kkIB197EG8LJlvxjOkGH+XT648Ogv8IALTN3s6Q8qk
         j/wA==
X-Gm-Message-State: AGRZ1gKN/N25SQA8w+mUU2d3eY/DNRLE3V6cmek3C2GROwsTk3IlelZc
        n7WCdnv+FboXtAZPbF3fOuD8Fw1vg3BdczOR0NZAGg==
X-Google-Smtp-Source: AJdET5fFeyRT545NVLnlceH6KF+L8P62KPkk/erXqfHQi0bGqIKpdqPg0dZNUU8qJrsxdVdbWjs/zpwFr2UMgv1KJog=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr9996268ljj.120.1542636500244;
 Mon, 19 Nov 2018 06:08:20 -0800 (PST)
MIME-Version: 1.0
References: <5d63d26156d2972b7e9f55c9743b66d7c6dac2ec.1541986223.git.ryder.lee@mediatek.com>
 <46ee25bb5ac7a7aa0245e2b02e9a0e870ff09551.1541986223.git.ryder.lee@mediatek.com>
In-Reply-To: <46ee25bb5ac7a7aa0245e2b02e9a0e870ff09551.1541986223.git.ryder.lee@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 15:08:06 +0100
Message-ID: <CACRpkdbtN3=KM+iDN7wCuHn0WWwedzq=WEyO_dT25uC47V-XXw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: pinctrl: update bindings for MT7629 SoC
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     sean.wang@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        weijie.gao@mediatek.com, cheng-hao.luo@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 2:45 AM Ryder Lee <ryder.lee@mediatek.com> wrote:

> This updates bindings for MT7629 pinctrl driver.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Patch applied with Sean's and Rob's ACKs.

Yours,
Linus Walleij
