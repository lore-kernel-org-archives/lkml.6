Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4950C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83621204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8qU9dde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83621204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJIOqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:46:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34924 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJIOqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:46:30 -0400
Received: by mail-it1-f195.google.com with SMTP id p64-v6so1224801itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tg05xcPKVMKnCjAhszuRGmT9CEOkN8JjPwG3NK6qfu4=;
        b=H8qU9dde/YP/2XYNNF6efXjSQlFne1F8X+Wyp6j2ENJvUPsWvdJqqkEIqjZpLXHfT8
         Wqkwyp5aMfr57XGz3ftwf3JFNA5yK1ZOaaiNxpSxzZranVE98Vu7r9D6aL4W7b/BCm+h
         oxAIR7SNaay91b33bhY9gUhaXFGYzn81L4EWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tg05xcPKVMKnCjAhszuRGmT9CEOkN8JjPwG3NK6qfu4=;
        b=gCon5iIgu+TddxVno0yymET7jgm6RqBzHZSpoGz+JsyhRJ4p8oR1fbS192gKJsc4kG
         5AwRmExM2r/7Ho9rCzZYj+i+ue/0MuBbyvZKBOfx37DicXvj0mbCSmSTn1hpWUMMhUN+
         QJbxLrp0ZfWrw6hS//urdqhsmGw46FKYRZoqzxbu9EbSRW3qDYMkQrYA40RwmlYS/M9w
         8lyW0NCfAtOOUNoZ0zc9nyU8vqv0CrElpmKsI/1s9QgsMHvf/LZvXxuaFnvn1zUxaw0r
         GkO0USYb9cizm1yVl9spqgMKjV5P4fu6SsP4tTXKJnFnBhkZYJcMZajnsVaviDKI80KV
         DM2Q==
X-Gm-Message-State: ABuFfogIVME2PJjOvLiHlZ3mlarWPQIzsqMEIg+d5YiRTkATajcZtggr
        Y1tZWwRGSvtAL3+HElsy+Tzqngq0KZEcNfD7fVSkKw==
X-Google-Smtp-Source: ACcGV63FKmGRdOZ3qne0oEoHRvsncF0ptzCIZoG07hoHljBBw1KLMV0V9qaeOhic04dtQPcFhJ5PAbE40stm5Fqqf18=
X-Received: by 2002:a02:2b29:: with SMTP id h41-v6mr16054666jaa.12.1539070256024;
 Tue, 09 Oct 2018 00:30:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Tue, 9 Oct 2018 00:30:15 -0700 (PDT)
In-Reply-To: <20181004111451.9539-4-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-4-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Oct 2018 09:30:15 +0200
Message-ID: <CAPDyKFqBTFAu7M-KBnsUWbLSJYPh5ecLF2md96Pr-jZiNYKs0g@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: mmc: sdhci-of-arasan: Add new compatible
 for AM654 MMC PHY
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 October 2018 at 13:14, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Add a new compatible to use the host controller driver with the
> MMC PHY on TI's AM654 SOCs
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index f6ddba31cb73..e2effe17f05e 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -15,6 +15,7 @@ Required Properties:
>      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> --
> 2.18.0
>
