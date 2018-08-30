Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C19C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A726220661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UD+DP1Aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A726220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeH3HOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:14:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44734 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbeH3HOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:14:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so3188150plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yDpeLkytk1pMHYv9th5+K5+biDhzg5IMa4lVHvivIxI=;
        b=UD+DP1Aw3wE2Vlky60nHgxRoq5fY1tu1vMtKv93zEQx8EijI3KN4TxC5sPOvbZpYH8
         AGP8iV9SE1ICN1cY/tLl8VJ92E8Jm42SiA2dgRHKD3NxAHdrbT47Q4dopqeucQuL9KML
         7rJMGzmaWfx4alan90JM3Gp7hzG9PGOzdRnmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yDpeLkytk1pMHYv9th5+K5+biDhzg5IMa4lVHvivIxI=;
        b=na+BNgaKSmOJ6qi/0CeEMlGPil3lqemOrpuikWBZ2NwuNjemFFla6CtiqxZH2IsH0/
         HUhRgcOJeAaxQdMD1iWLLNWZHyLzcOTz4FI6wnG1Ti47IJG9c92yfHO0CVTiD45Q+37j
         xO6yaNxHuCXimr7BSYeEhYPdNoM7B5KY0/cEyCttLejsst774vre5CFcUGLUsnmD53CA
         ixRu0c9keM1U86Mw8ysagOneTNwoVjKWM9TFOluSBawnqDf8T1llL4CWZ+euzhmR0QfF
         T2xvwUDnNTAaXRuZez+SfVM67LJiGvlWbPgURRp+unWb/VVfagSO3lT3a4Go/GjNTEgW
         Ds+g==
X-Gm-Message-State: APzg51ADvF6TqGvQgbXK5UKXnGv27qwsfzmeE1iHzAFtYcBiukBmN94N
        MsNNwJA9hnQpKE+Oa12y4iCo
X-Google-Smtp-Source: ANB0VdbQKSSEJmuKTpr6/0T/8aFTdkvOlSmzaWK80lpmiInFi6DUq99f0IJ1HR+qnfGbeZbgXRAmDw==
X-Received: by 2002:a17:902:4081:: with SMTP id c1-v6mr8397671pld.169.1535598897008;
        Wed, 29 Aug 2018 20:14:57 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:7305:2604:758a:c93a:b490:179f])
        by smtp.gmail.com with ESMTPSA id m26-v6sm18507989pfi.102.2018.08.29.20.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 20:14:56 -0700 (PDT)
Date:   Thu, 30 Aug 2018 08:44:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org, guodong.xu@linaro.org
Subject: Re: [PATCH 0/4] Add HiSilicon Hi3670 SoC and HiKey970 board
Message-ID: <20180830031449.GC8565@Mani-XPS-13-9360>
References: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:23:35PM +0530, Manivannan Sadhasivam wrote:
> This patchset adds support for Hi3670 SoC and HiKey970 board. Hi3670 SoC
> is very similar to the Hi3660 SoC with additional NPU support. For now,
> only UART6 has been enabled which is configured by the bootloader for
> console support.
> 
> HiKey970 board is one of the 96Boards Consumer Edition and AI platform
> based on the Hi3670 SoC.
> 
> With this patchset, the Hikey970 board is able to boot into ramdisk with
> 8 cores.
>

Hi Wei,

Any update on this patchset?

Thanks,
Mani

> Thanks,
> Mani
> 
> Manivannan Sadhasivam (4):
>   dt-bindings: arm: hisilicon: Add binding for Hi3670 SoC
>   arm64: dts: Add devicetree for Hisilicon Hi3670 SoC
>   dt-bindings: arm: hisilicon: Add binding for HiKey970 board
>   arm64: dts: Add devicetree support for HiKey970 board
> 
>  .../bindings/arm/hisilicon/hisilicon.txt      |   8 +
>  arch/arm64/boot/dts/hisilicon/Makefile        |   1 +
>  .../boot/dts/hisilicon/hi3670-hikey970.dts    |  35 ++++
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 162 ++++++++++++++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> 
> -- 
> 2.17.1
> 
