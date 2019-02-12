Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E918C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8E821773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="O5JcLFgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfBLKwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:52:04 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35766 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfBLKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:52:03 -0500
Received: by mail-yb1-f194.google.com with SMTP id v2so854816ybm.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdLKennIE6eaIjkX381Sh2TI/SFrHy2zpxBXQiK3tMY=;
        b=O5JcLFgpSeFbZ3cdBwHI0kTFGSI1Dy8ACSi25shCBXHqr8gWcVwxlFPoGdy8RuYxrb
         44ILGEuy8y962QD86Qh4JDuaAOVwgsD4/Z6J3axyACtlqCyauAqjTUPF8kBJPGrJ7iAP
         F0ulDLw9i8VmY28tVITpkvKgiZbSbK8khVp1LNJq6a1nWzLLoUSEG8S7Tmbvv82sTZRb
         3u5m/rxadSmdlzXVazO5f4zJ1D5bO1nipCY+K23/qD8UAWKuIbz1xQZjuoI8EYrJpzaX
         9oPlvVj3CpLEiBJULgbisweRkJ1NpNHjKqySPYbeJpECHqzRO/PC9E0FIxmvS2R5SXOi
         8xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdLKennIE6eaIjkX381Sh2TI/SFrHy2zpxBXQiK3tMY=;
        b=tgWm1ZoWBW1Zng6fksfUO1GmfRo/iSpYXf+vdC9vG9yQJ2a6526pCNyR2f8baAQsZr
         30AccaiDzkuD4D/IXhMm2xOW93A3y0obDTU4iH1eEnS6CG2XcMyn1el0T+RIqa/PzVQh
         NbiL1wBvYZB9wluNmyKV2p3MOxA5xl8VKNrKXnP1skcvQ+lsvfwZqnIBKcmxxJdJJMom
         05dz1gw9LmrM6YZEdWj7gXdpTPKhedUwXyZOBkzWTX8zYC6iCEMIuHjfGCuWLcL3MgC1
         JKYDGcN7Q+zLiuMcdJQ2uDILVpsBMsMAF1wzIQpmzgJpWitMzLZ25qFvDeh9IYaebQL5
         J20w==
X-Gm-Message-State: AHQUAuab1Kah3Ah/iaWjrV2dQLZUqU3N/i9fxUoMhVpogw7IsSmxqH6c
        oRdy0ss9wiqQXuph93bTcAqlGiEBWuG3lNFtqpGDTg==
X-Google-Smtp-Source: AHgI3IaNeQSWjspjdoIyoO7rsoIQnE4TsD2A1p846K7tr0xSy7OdIyyKWtl3Tt62HKVEPQikcWu28OJ42PEdHoeWUaA=
X-Received: by 2002:a25:678b:: with SMTP id b133mr2283325ybc.62.1549968722581;
 Tue, 12 Feb 2019 02:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20190212010143.3729-1-virendra.kakade@ni.com> <20190212010143.3729-2-virendra.kakade@ni.com>
In-Reply-To: <20190212010143.3729-2-virendra.kakade@ni.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Tue, 12 Feb 2019 02:51:51 -0800
Message-ID: <CAAtXAHd=-8H7AYpApe1B+WRWCv54GhxJBv1BD4bc-C9rnScU+w@mail.gmail.com>
Subject: Re: [RFC 1/6] mfd: Support for Ettus Research E31x devices PMU
To:     Virendra Kakade <virendra.kakade@ni.com>
Cc:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Virendra,

On Mon, Feb 11, 2019 at 5:02 PM Virendra Kakade <virendra.kakade@ni.com> wrote:
>
> Document bindings for E31x device PMU MFD driver.
>
> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  Documentation/devicetree/bindings/mfd/e31x-pmu.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/e31x-pmu.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> new file mode 100644
> index 000000000000..ebb5625f6c74
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> @@ -0,0 +1,14 @@
> +Ettus Research/National Instruments E31x PMU MFD driver
> +
> +Required properties:
> +- compatible : Must be "ni,e31x-pmu"
> +- regmap     : Must be <&regmapnode>
> +
> +Example:
> +
> +pmu {
> +       compatible = "ni,e31x-pmu";
> +       regmap = <&devctrl>;
> +       status = "okay";

Please drop this.
>
> +};
> +
> --
> 2.17.1
>

Your binding patches should have "dt-bindings: ... " in the commit message.

Please fix that when you resubmit your series.

Cheers,
Moritz
