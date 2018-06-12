Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5E5A8C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9E62089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9E62089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934795AbeFLU6N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:58:13 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34642 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933173AbeFLU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:58:08 -0400
Received: by mail-yb0-f194.google.com with SMTP id n23-v6so142525ybg.1;
        Tue, 12 Jun 2018 13:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1+w1+Ro5Un8Sol94a6hdaugMUEUOSnTYpGt5pcIpAGs=;
        b=GoiKZvAnk/heV1H90NsmkNld/EORtCQn/brqJfykg/db1WC7+UTWJAPwJ5elvk9s3G
         U+bC3lr6PJd2ww4p6kGjF2MEyMScjibEBR9qCygZcsyTAzOQ4Emth3PvW+FS7YNUxpO6
         Kvxc1L2Qo62fsPVGm7YfVAOvrBKoG2SMJxVP4pgVyHekVvreGPqPf1AXzq/Vg5I9naI0
         NmJriqjZhpqQM7ZRrRU4LD5r2k2/4pBOjyQRjZ75xjmGns83uCVyerue3JgrKyI5DO0V
         k1RIlDTN0E2MZxEy5HdzT4p8PEBcvjNJgFTTKcKex2OBBcDpalrd+CX8sZrhuyAyKySt
         GA7g==
X-Gm-Message-State: APt69E2Gk63bRreaRqnW5KoO5t7e+nJ5AXBlsQQ0uakOcMOCgaM4akgW
        3En3dJrOVB/xHpahO3fW6g==
X-Google-Smtp-Source: ADUXVKKA2BoORUkPMW7QDFPl44W3OHNTHKZ6LmbzxqXrwimkY2bxCGkL9LiEyPBjfTRTJkRKHnh48Q==
X-Received: by 2002:a25:b6c2:: with SMTP id f2-v6mr1014533ybm.329.1528837088260;
        Tue, 12 Jun 2018 13:58:08 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l14-v6sm429924ywi.35.2018.06.12.13.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:58:07 -0700 (PDT)
Date:   Tue, 12 Jun 2018 14:58:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linus.walleij@linaro.org, afaerber@suse.de,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: Add gpio interrupt bindings
 for Actions S900 SoC
Message-ID: <20180612205806.GA11511@rob-hp-laptop>
References: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
 <20180602165415.30956-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602165415.30956-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2018 at 10:24:13PM +0530, Manivannan Sadhasivam wrote:
> Add gpio interrupt bindings for Actions Semi S900 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/pinctrl/actions,s900-pinctrl.txt          | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
