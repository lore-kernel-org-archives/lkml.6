Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA48C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DC020652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n7Kh9un+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfAQRrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:47:45 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42982 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfAQRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:47:44 -0500
Received: by mail-vs1-f68.google.com with SMTP id b74so6735308vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bfolpDOyZxp4KlTvybxx7l473gLDDQ4AeEXm8Q3XDk=;
        b=n7Kh9un+bQ8rX2NmqPcrItWOr/mvGfQe1TbvvIMCShJoUp4SsR3OXY+v3GuxJeyjY7
         t7vwcppXv2RLif1yVd9+XTjT5enRINGml9hHY1CogLXdGaRFff9xXCQR6qzhJ2r3ugWz
         m1ZxKpIE1NvsYGZ5ka+M1ZuhODgv7O7iNJgfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bfolpDOyZxp4KlTvybxx7l473gLDDQ4AeEXm8Q3XDk=;
        b=INSTxjEzt5VNUo1Sm1t49GV8CQU1mBH5RP9lJSVoK2hAio8x0pkn2/NzF7w4AnTTgY
         Hjqu0XHJ/tJ1hAz0qp0IEyIwXpXJ5LUmEob5fb1hiP3Q4/LnHjqUcsImpzEeAasexIXj
         DtvKYW3wKz8hvjUmN7RMz5YbKl0S/6Ek4/obDO3auyZqBynrljnW4NTKwGzZDMzBdrOe
         E7l9QTw2KNGC5Zx0PGeGBiAR9XwKdiHmYp4L+POlMxgBgz7o0cqF3k3nbG85cOYN54M9
         9BRkKVnCJcGPYHHmAN3RgJ1TcVMd3xjg5iIVmxvmzd/a/KF1WCJjhLyFkkd4nmgkwD86
         JIAw==
X-Gm-Message-State: AJcUukf6qv9xZv1Qi2rPDmyjEr4c0bi0U60O9w4C/pvEfDCRzo+vB/gn
        bdV5hxMgtH6r1jb0h7x5HGAceWO7IAc=
X-Google-Smtp-Source: ALg8bN73YyFRbR5GNwJ2WAmhvlNLWk0MqxgbyWkMCcooKdF2mliky48jn79XA6hMRGIPAwb9js7c3A==
X-Received: by 2002:a67:7446:: with SMTP id p67mr6273410vsc.2.1547747263042;
        Thu, 17 Jan 2019 09:47:43 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id l197sm72902650vke.18.2019.01.17.09.47.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 09:47:41 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id b18so2470392vke.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:47:41 -0800 (PST)
X-Received: by 2002:a1f:1e09:: with SMTP id e9mr6077331vke.18.1547747261016;
 Thu, 17 Jan 2019 09:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20190117042940.25487-1-bjorn.andersson@linaro.org> <20190117042940.25487-3-bjorn.andersson@linaro.org>
In-Reply-To: <20190117042940.25487-3-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Jan 2019 09:47:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VMBBT0E-7F=F+inThL+hjC8pZCf3707mJaQ0NEKQ_P7Q@mail.gmail.com>
Message-ID: <CAD=FV=VMBBT0E-7F=F+inThL+hjC8pZCf3707mJaQ0NEKQ_P7Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sdm845: Extend ranges and
 describe DMA space
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 16, 2019 at 8:30 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> For devices attached to an IOMMU, translation between IOVA and physical
> addresses is no longer 1:1 and dma-ranges should be specified to
> describe the available IOVA address space.
>
> On SDM845 the busses are implemented with 36 address bits, so dma-ranges
> must be defined to reduce the size of the IOVA address space from the 48
> bits supported by the SMMU. Without this DMA allocations may end up with
> IOVAs outside the valid range, that gets truncated by the bus between
> the device and its translation unit.
>
> Also extend ranges to describe the available address space.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v3:
> - Split this out from patch 1.
> - Rewrote commit message from scratch
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
