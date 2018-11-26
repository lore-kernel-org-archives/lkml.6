Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00147C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1E120817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w+VJVH6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1E120817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeK0Bl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeK0Bl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:41:27 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6922086E;
        Mon, 26 Nov 2018 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543243627;
        bh=nIrW3V6U6j0XfoiuvSQW3NGXggru4XVVLrnuS0xQINI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w+VJVH6B/yv4wL0d/3a/c0Dd0GAS6ukwX4GbJzkuTg9i4IGo31nnzyFvnUm2j2fL6
         EAWt7YMmwSFx9fbVGpuyd7E9EDZPmU8KoJTsVnDPi8sgZ0rELGicX9/ORdI2y08XHY
         P7cFnMkYPYBQGiNC3Eyhh6GxjTE0R2AcyU5Us1vc=
Received: by mail-qt1-f176.google.com with SMTP id d19so17747653qtq.9;
        Mon, 26 Nov 2018 06:47:07 -0800 (PST)
X-Gm-Message-State: AA+aEWbljcG3IvX+Rx1Oq63yyRvwDchs8f1OjuCQEWVZJboWY/n5JIcd
        geH8gcATwD7hCU4QhP9WZOjvBwdKtkbTYIjiiQ==
X-Google-Smtp-Source: AFSGD/VuLeIZaJ48Yj0NwTIa6J2UtwkTf2nCc307RHdqawax6D90wGxR9damnYJ/pD0Da5TYlPRSAzqbQAIHiJKuk4s=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr22617573qtd.257.1543243626404;
 Mon, 26 Nov 2018 06:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20181119110812.15825-1-shawn.guo@linaro.org> <20181119110812.15825-2-shawn.guo@linaro.org>
In-Reply-To: <20181119110812.15825-2-shawn.guo@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Nov 2018 08:46:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyQAvbPVyHNtGFYrW2BYOGwj7uuRehd=c-3gyAcMKWRA@mail.gmail.com>
Message-ID: <CAL_JsqLyQAvbPVyHNtGFYrW2BYOGwj7uuRehd=c-3gyAcMKWRA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 5:08 AM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> From: Sriharsha Allenki <sallenki@codeaurora.org>
>
> It adds bindings for Synopsys 28nm femto phy controller that supports
> LS/FS/HS usb connectivity on Qualcomm chipsets.
>
> Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
> Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt

Reviewed-by: Rob Herring <robh@kernel.org>
