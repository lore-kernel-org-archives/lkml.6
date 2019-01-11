Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13DAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5F02177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547236723;
	bh=nBeYTp7dQS271xjLOg4zHRBx5C7WA3TXsCYhfjru33s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J9N6IsI4tE5RlbVmTmn0cfwsGPyXT7hSGz/cpn4nEprTgfozY+OG6eKAYlIQ2pWES
	 tqsBxxQK6279fYbEYoW0jRwwLooDvKxwwpOE96tqUHV+h3UXFs+c0LRTmShCpspj8+
	 m0XyfeFxfS6Fg9TiyQqyNh4XM1FJjbuo4RZXsg8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390581AbfAKT6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:58:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388913AbfAKT6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:58:42 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846A621872;
        Fri, 11 Jan 2019 19:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547236721;
        bh=nBeYTp7dQS271xjLOg4zHRBx5C7WA3TXsCYhfjru33s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LvAPZ2/bCIDU6i5OnA57YHMb8K/twyXbnZ57WWvmbCNAKSEZhqwDXPGRVlXcss/lp
         ZsNR1UAzwltcwg7cu0jPYm9OlnqeGyeKGkGQ/aK7QJWavzDQZuGqzecnkkIMR3jILe
         7ZtvivxeIGup9oqzqab44NdhmXLqAoIKXrcGnAX0=
Received: by mail-qk1-f179.google.com with SMTP id q8so7264563qke.1;
        Fri, 11 Jan 2019 11:58:41 -0800 (PST)
X-Gm-Message-State: AJcUukcNB0jpkCOcx1JNASWmVk55QwC+DXrkDm6Kk03tMBpobmlUM9g7
        70trGlvz0XnWbiOYNy9r4dzPEHhL98I+JfpGrA==
X-Google-Smtp-Source: ALg8bN5vrHxVjSfsEO3Wlnojw5GV5im2iMA7hUOTPPLyojgwqt++xqMYwvptAGB/PyAr/gZWkWDE/ytldjHhEhG5nWo=
X-Received: by 2002:a37:a483:: with SMTP id n125mr13849823qke.184.1547236720705;
 Fri, 11 Jan 2019 11:58:40 -0800 (PST)
MIME-Version: 1.0
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org> <1547141652-8660-3-git-send-email-john.stultz@linaro.org>
In-Reply-To: <1547141652-8660-3-git-send-email-john.stultz@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Jan 2019 13:58:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+2dYaCzLSr8n4W=ftSjgmKJaUqwQ4S7qv7ZAaR2A-5XQ@mail.gmail.com>
Message-ID: <CAL_Jsq+2dYaCzLSr8n4W=ftSjgmKJaUqwQ4S7qv7ZAaR2A-5XQ@mail.gmail.com>
Subject: Re: [PATCH 2/8 v3] Documentation: bindings: k3dma: Add binding for hisi-dma-avail-chan
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:34 AM John Stultz <john.stultz@linaro.org> wrote:
>
> Some dma channels can be reserved for secure mode or other
> hardware on the SoC, so provide a binding for a bitmask
> listing the available channels for the kernel to use.
>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3: Renamed to hisi-dma-avail-chan
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> index 10a2f15..38825d4 100644
> --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> @@ -14,6 +14,9 @@ Required properties:
>                 have specific request line
>  - clocks: clock required
>
> +Optional properties:
> +- hisi-dma-avail-chan: Bitmask of available physical channels

Not quite right. Should be: hisilicon,dma-avail-chan
