Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E90C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A06120881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExTizZ8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A06120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeGIOF4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:05:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52111 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeGIOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:05:54 -0400
Received: by mail-it0-f65.google.com with SMTP id g4-v6so9500706iti.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSFdWu7M7D3//TYQfvaAf69Tbw4ZKWJ93y0M4Vcdbd4=;
        b=ExTizZ8PIn6pADHfKx0gnfpulBGWQ2zk5knLvi+nOVaFA9xIJkNbvm3TcOzmd5eTdL
         MRRm+dCjXI3SX/j22oKM5RA2TStBXr60h+sj5ktX/NQ2y7a0O6CXq0lHvZ1RYI/ZogKc
         O1c3pYfoN1oP8uwgiXWmrO1vYTzCuVvNJ2bBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSFdWu7M7D3//TYQfvaAf69Tbw4ZKWJ93y0M4Vcdbd4=;
        b=X/VuTWIJUunV7bCmIxTjH+SfZl4lQH5DkcTeFnPuw0DBKeaN1ZIy1fKzJlv/BmLu/I
         S4tptCZjiYXX/yTEVMyL1b/g1h8u9JnRLr/bCJEtdVOIhwElqUyv89MFqekGXo0ks+tm
         E678qlr8dnzdOyIURPeMBskdshJ0Q4woL50v/+xHL+YseSYKAjSYEu2li3pTOag7LC33
         foAQ/01JExddaTs0dFR++ooFK7AbILQTQVe2FwLmMtFJgw67AgbhsOh2qdmgvMrp93Jw
         maiLgWuUe6zgwgbCs8tIUgegf/OAE0xkk5swtCitzZeq9N8F8elUEpKIevEn9Bl1FPxv
         tRfQ==
X-Gm-Message-State: APt69E3BRql4e3XEtu5BCIgfXDohahQstP78naD79wECYHuT917XfiAR
        R/RbbQ/uYGxSMx2ptRQQdDnLKHWLGtECYWhfNGU4Pw==
X-Google-Smtp-Source: AAOMgpeFqUqa60WcEfuU8e/izHvQpYPFzLPnLd/9TiRfKpZdCgaRZDyiW5pVpnDj7FW400P4AiL3QaYvhBchJaYkvTQ=
X-Received: by 2002:a02:9d03:: with SMTP id n3-v6mr13156905jak.113.1531145153510;
 Mon, 09 Jul 2018 07:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <1530532746-619-1-git-send-email-abel.vesa@nxp.com> <1530532746-619-3-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1530532746-619-3-git-send-email-abel.vesa@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 16:05:42 +0200
Message-ID: <CACRpkdZKrv3Et=T7gdr3pTAt4yam2kbF7WqMh+8bq=RF2DOsZA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pinctrl: imx: add driver for i.MX8MQ
To:     abel.vesa@nxp.com
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        abelvesa@linux.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 1:59 PM Abel Vesa <abel.vesa@nxp.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
>
> The i.MX8MQ pincontrol works in a similar way to the earlier i.MX SoCs.
> This driver builds on top of the imx specific pinconf handling.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

Yours,
Linus Walleij
