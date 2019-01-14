Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE24C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FA920675
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5qmJpOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfANI2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:28:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41040 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfANI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:28:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so18157423ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PK+o5wSfNSAi8nHTgkusBFI+usEcOqlS3NIt5HaMg9A=;
        b=e5qmJpOIJCnTGIJsBcefQF4pczpWTlwUOulFSMHsESeMXkQShuduHIBQny5xjHEEGK
         65rR+/isOJ6hG+1BJieFHbJLww9GMaPs8vHtIH1QelUN8f5efReeRt7CjZe5wRfVmE+Z
         LxbItZC5dXwJ3nwS0Pt1kohi2cX2V5TIP3UaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PK+o5wSfNSAi8nHTgkusBFI+usEcOqlS3NIt5HaMg9A=;
        b=USyXRClH2Eil+3nQZ1jltYbOZTnumX4G5QGc4kcbXXTP+WCGjOq1DyBBj9h3RR3rO9
         n71KEjYcoh6sNnemC13HwFajUle1WRrziyiZXEkAA1r0hgTnGY/AQB0WYWeuqnNsjgsI
         DeXnf6vN9vg/uo5xg/nCAoN/SEo0dG6RsTgv1V3H4g7hhjV45BH45FJPUZS6uDqHYzD6
         mR2PQL9hL3K3PG1Gkihe548fKaU85q/S8o10zQeyGcQwnbEARORXmTnm9mo6BFPZ/P1Q
         l6G/oHFDQ61ujshgo/yEIkCrbbkAw/dC6ugodwJ17I9WprXVTipxjsMdnQ0CpjCtCfx8
         /EeQ==
X-Gm-Message-State: AJcUukdYz8KQTQjhIQMhvHXN/2eaDzPpwnufm1gWhu2zFcLFM3JyA+Oe
        rIAgob71g2gJ5l4E514ggWIAkUqGOUKIlvPlSp9I3g==
X-Google-Smtp-Source: ALg8bN59XwyzwevpO45r4pBAAEA8eEp4i9O/m05r7uvvx8aRYBrHspWiemAZF1S/QP8c0OphilKQdUS8JELRCYvCFbE=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr13711685ljc.97.1547454513248;
 Mon, 14 Jan 2019 00:28:33 -0800 (PST)
MIME-Version: 1.0
References: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1547454274-1674-1-git-send-email-vincent.guittot@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Jan 2019 09:28:21 +0100
Message-ID: <CACRpkdY7c16C+NpoSXUV1QsLkQgNm3vjknOSea0p4aj-LM1xBg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/hisilicon: fix SDcard detection
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Xu Wei <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 9:24 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:

> The SDcard detection of hikey960 is active low so cd-inverted is wrong.
> Instead of adding cd-inverted, we should better set correctly cd-gpios
> to use GPIO_ACTIVE_LOW.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
