Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACAAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077B320881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgL9DSwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfAaH2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:28:31 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46549 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfAaH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:28:31 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so1354585vso.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 23:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HynF6VtwwwvhJApoFM5TTvGFYEYQrAEpv5N4sdK9j0c=;
        b=KgL9DSwqGHhF+31X7mUX/WsocD+e/+Gz+0yD6ZCl4rIgUCcWUgy7PBz1C2irpf/XAg
         YnMY+byAx6f+eo3XnXo3Cvn5vG3esjdxsbdRP15TNy06qFFWlxIS1ZBcqflqW/FeQAwv
         n2mTX3OcAGf2/72lhycLsg5v2jgTnM5y/4Kg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HynF6VtwwwvhJApoFM5TTvGFYEYQrAEpv5N4sdK9j0c=;
        b=sXqW+OlrPhdo3oMqBeOTGY6GhvP48cSQriQKSX34AIhGcflX04972qB3+JymNg/12a
         ELInH5JOp2u16hfgOybS1/5LP80ivsGJhtJZ5zzoVoEg5tTK4DnboevQ+k/8s8Ttlg6F
         Egzg4HbXJeSDMa7oBoC8sKIRUgGwQsaIGa6bnhASZBWX3jB5/2EZVANn4OHJy1mQcIm6
         Dc4FOOcuMtHbxbDwMiZMZnOPzM8H2aCWPgpuBrHTGaSi3pCJOzlJSswQimE/7IL6zbc6
         vJMluBdgjaqnTtOFjOvz05F4LLpU9JkEETowWY1tLgDTO43jMurg0xqn6T9r+Nxsr/v2
         k14w==
X-Gm-Message-State: AJcUukcUQ4JcoibscBP+JjanZa8xWevkUq49+7Qc4NvpdmhaHK2dvQ1n
        znm1ve9iX7G6g85DpvMXsiVe6L0/vh1HdYJlT28ixw==
X-Google-Smtp-Source: ALg8bN5i+S9tfGmObgjsQO4uBOnwtu7nPoXT3c2qaGGBFq9OjvGg63amn1QvJF4Ze8CKfB10NK1QxgeCmrnBEUl3d0M=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr10658507vsc.34.1548919709978;
 Wed, 30 Jan 2019 23:28:29 -0800 (PST)
MIME-Version: 1.0
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Jan 2019 08:27:53 +0100
Message-ID: <CAPDyKFoX7o8pR7hpVPpnpUDmM4jqdjrg7WKj1zrJ1uXfXoSDTA@mail.gmail.com>
Subject: Re: [PATCH V11 1/4] dt-bindings: mmc: Add supports-cqe property
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 20:30, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Add supports-cqe optional property for MMC hosts.
>
> This property is used to identify the specific host controller
> supporting command queue.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  [V11]: Same as V10
>  [V10]: This patch version moves supports-cqe property from vendor
>         specific MMC property to common MMC property.
>
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index f5a0923b34ca..cdbcfd3a4ff2 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -62,6 +62,8 @@ Optional properties:
>    be referred to mmc-pwrseq-simple.txt. But now it's reused as a tunable delay
>    waiting for I/O signalling and card power supply to be stable, regardless of
>    whether pwrseq-simple is used. Default to 10ms if no available.
> +- supports-cqe : The presence of this property indicates that the corresponding
> +  MMC host controller supports HW command queue feature.
>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> --
> 2.7.4
>
