Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0429FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A150620020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLLYSoYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A150620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966206AbeFNOXF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:23:05 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38266 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965679AbeFNOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:23:02 -0400
Received: by mail-io0-f193.google.com with SMTP id l19-v6so7317640ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UgTUDngR2Nqr7FoWfP0KsVLiZQmcN3HnU8A8odqFSD4=;
        b=PLLYSoYCgnB24QhFiKyNo1QwHeojMbU6n0wixVLRCfuPjKi+uqOROQXNPqCWRiE4n1
         HPpB5dOb7OlnP3zZsiGNaWGLocrGskZZ/uc85xvAD/28jNFZo0XFXwmv/CKSPLgn/neo
         H3WOBUailWsv8EMWsOyylSed3CvA/j9/MFN6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UgTUDngR2Nqr7FoWfP0KsVLiZQmcN3HnU8A8odqFSD4=;
        b=Y1wwuYYuozYbXqZto+oUeMGJ+TysgGscKLGJntmDoFBe8jZuwzqtF4rxqnOmPWyBeW
         KZuOpWAqqGVFUdlADfYzyyY3QwEw6KaHH4otXDvvj0WXa5DQ2WsH7ujT6ZuOUW6T8L0y
         7rj/H/Co1zQmDeSwFVukha/TZBFF/27FIPq/U21uhFxZMpP1O4X3Y5gptRmjvjuwzRZt
         bPD6eMhe2Yscr7XSFcGW3kj7E4dwJxTpSgOPEyu0lUhVImkKEY01nHV7D7n9+Ej+DXDX
         YGzxPfN2ouKdtQZUdjoubQy8QDQ7qRlBkiske8F1pvENN0V0TjCvYtDBerZjlexOkSk+
         8qCw==
X-Gm-Message-State: APt69E3TiNSPp/OSJx6h1Ie140iIo3fStrKzB0pBtooHOG0Dn7o0qXfv
        lEPMq2C1LcevuEfKSOlXXsD000qYrQV2yTy8llXVyA==
X-Google-Smtp-Source: ADUXVKJsFPX6xao/ZkRQV5pBzRuHLB7ym5j6fCeuXm7kjnD13vV/x21BQFw3hwRepkL0pLxVy/s8r3C8UFh54dxwwDU=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr2318236iob.277.1528986181727;
 Thu, 14 Jun 2018 07:23:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:23:00
 -0700 (PDT)
In-Reply-To: <20180612230604.137880-1-swboyd@chromium.org>
References: <20180612230604.137880-1-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 16:23:00 +0200
Message-ID: <CACRpkdYS1LQ-gfOAsG21=E_hJ1eMW54oK6bZ-rJ48J7M6FGB7g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: Add pm8998 and pm8005 to binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 1:06 AM, Stephen Boyd <swboyd@chromium.org> wrote:

> Update the binding for two more PMICs supported by the same driver.
> While we're here, remove the duplicate pmi8994 lines because that
> support got merged twice.
>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Patch applied with the tags.

Yours,
Linus Walleij
