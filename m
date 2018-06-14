Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D4E4FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B3F208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jt+YbNNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B3F208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964922AbeFNOGx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:06:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40228 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964880AbeFNOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:43 -0400
Received: by mail-io0-f193.google.com with SMTP id g22-v6so7256523iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rYmnSteIlyFhBRO2GapxR6Ol6tYl0elNjYQE7XrEhzo=;
        b=jt+YbNNhbbTATsXCWrZ/EdneR68Rn+c/HWO1dfpnCTlUM6gcNy9ak0lPD7HLQSD++9
         7Ns5gt/zaJYHQxScvi8pdMhNHrUFLxQyJqY1nEEBfYXg9on/4p4iWaOl5Av60w9VtGLU
         +8931c23i4DhMsH8GmQndGC29Cfx9q+UHRbV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rYmnSteIlyFhBRO2GapxR6Ol6tYl0elNjYQE7XrEhzo=;
        b=qO0aoYBhMrLjPjf33qXmnIXhoywEk2IS5qIxLtWhOIApyPvNsNIShF+puG5gfM1wuc
         hBfyyWXXQvbG+wFVKh7fhz8k9DL/zHeS06d+R8YVXgfIuZ1Pw87/GniiMtcEMT/TyU/b
         HP2IjpyHzCfLIKOqcqwvEZSibxAAcg5A9wwDjkGSNdcDRz92wtpPDAdR3B8JhpUIqoIf
         P58AvV2mU9coBjYkpqL1HjI/CssPxcvrNFKdkgmrrqiTUloABUxkQAS6w6AhjMTf1DJW
         AsZA4jayyGhEQyzeIdydOggyxUTQ8/5PbFO2RxWuXpbaxvIuRxLxqGf3UB4EumHwGF3F
         9YdQ==
X-Gm-Message-State: APt69E3l50/uAzAcL55/uhOfbJeMD+CSiLh7y9lMFu0u1wfNc6QIFMsE
        kKzeiXkzlmrMqPaHJHChapN0SX8d4GFZ7lXmt7wJoQ==
X-Google-Smtp-Source: ADUXVKKSq3qYICTBXmiEloXicKgDmsAY9/qChiEc/JV7Lxn2GfLY1ExWhqPgifIB361Orgn+Ps2hFQRk3fQK61kMF9I=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr2263137iob.277.1528985202533;
 Thu, 14 Jun 2018 07:06:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:06:40
 -0700 (PDT)
In-Reply-To: <20180613160643.12638-2-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180613160643.12638-1-ctatlor97@gmail.com>
 <20180613160643.12638-2-ctatlor97@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 16:06:40 +0200
Message-ID: <CACRpkdYzCN1cFBDwznO6p-US1B94+kbBcWmH-o-qxvXdvCCsiw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] power: supply: Add support for the Qualcomm
 Battery Monitoring System
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 6:06 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:

> This patch adds a driver for the BMS (Battery Monitoring System)
> block of the PM8941 PMIC, it uses a lookup table defined in the
> device tree to generate a capacity from the BMS supplied OCV, it
> then amends the coulomb counter to that to increase the accuracy
> of the estimated capacity.
>
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
>
> * Changes from v5:
>   Uses select for REGMAP_SPMI.

Looks very nice to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
