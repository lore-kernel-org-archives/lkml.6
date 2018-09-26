Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A67C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D2020684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8qJR9wX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D2020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIZUje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbeIZUjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:39:33 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B9320684
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537971980;
        bh=CSFAOyzQZdc//1f1sSD2y/QDh7Dec8zSWJjeCLdNh80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m8qJR9wXoe7GS6P6b+I6mrQd8YYDD8cfhOZXPZbSFdheHAZf/mcsWfWSvJNTD4I/d
         4jcKSzKDGwtJ6F4kFYkmo3l51AKONj1n9+FL+97Cokqec+7bfrVPm3IrkGiw2YIPLw
         BzxPZSXp76VrZMbauqC0uTT2+ORbKw35K8nxGXNM=
Received: by mail-wm1-f47.google.com with SMTP id y13-v6so2581923wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:26:20 -0700 (PDT)
X-Gm-Message-State: ABuFfog9vl6oejEUHlcGjQBRcAs6Rc/YyKBCktXXFg5I3YVqGa29NcJ5
        5emqWCfZwUGH8f+Zru2nZgktrY3VRK/dvRcB5PJLBw==
X-Google-Smtp-Source: ACcGV62PswDQIxMv55S5/VFP7vATuc2Mvmeqms9hAOWMMyHlLUAG+Sq4b0zrr53rmQgnzIBstMIpk3w7lzzFILCyUsM=
X-Received: by 2002:a1c:b20b:: with SMTP id b11-v6mr4615502wmf.64.1537971978936;
 Wed, 26 Sep 2018 07:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com> <20180925203701.13605-2-dangtranhieu2012@gmail.com>
In-Reply-To: <20180925203701.13605-2-dangtranhieu2012@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Sep 2018 09:26:08 -0500
X-Gmail-Original-Message-ID: <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
Message-ID: <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
To:     dangtranhieu2012@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, pandy.gao@nxp.com,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings should be sent to DT list.

On Tue, Sep 25, 2018 at 3:37 PM Hieu Tran Dang
<dangtranhieu2012@gmail.com> wrote:
>
> This patch add fsl,allow-stalling property documentation for fsl-lpspi
>
> Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> index 4af132606b37..2b012b8cb05e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
> @@ -6,6 +6,8 @@ Required properties:
>  - reg : address and length of the lpspi master registers
>  - interrupts : lpspi interrupt
>  - clocks : lpspi clock specifier
> +- fsl,allow-stall : allow stalling of transfers when the transmit FIFO is empty
> +  or when the receive FIFO is full

This seems odd. That seems like what normal behavior should be.

Rob
