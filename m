Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA69C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D25F218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HKX/Ov5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeLTTbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:31:37 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33553 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbeLTTbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:31:35 -0500
Received: by mail-vk1-f193.google.com with SMTP id d201so645179vka.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tf3aNrAlSeEVgkQHuW8ZV4UrjbkQvk5X7tGGlBbr5NQ=;
        b=HKX/Ov5vQP5dOTxECfftoCs117+K07ZbiOghuTj5ab2les7e6hIsa5zcMYtPdbFPYN
         YjeKweNRNrKRoP6QTSVPAcCnISso6Wh95NfJDzw6liCljGMueZDDlutDpafHuELRe6M6
         m0W1U5GYcUWFq/4OabHvnhgc4EZjy3IGOxBYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tf3aNrAlSeEVgkQHuW8ZV4UrjbkQvk5X7tGGlBbr5NQ=;
        b=WSJTu6bPpKGUyle2qNAjlEM9J0YOJw4josFYt6+oNhtiyTGjymZzc+LEMlLCTOTh8T
         pmeaOdokfKjQ55NrfLl1FHMdvLuca09TFSJa1mJD3bV6tWXyqh9fT0eLLy3CKp/7zx2Q
         Z/BgagShzakAVoKpmql/fJ3r3iMGPr6NrpZdV1qCsjiY3c4OAymXy49WEc/KR/tkhdDq
         D8Abbk3fhcocMbEGdBYJ3IZ78R2h7/5jr5uA3CeF8P8w5hvcgB2hcbxpgpb/dTJStR4c
         FPq8ediQBJY7xWqREV5XMTcI6DCuI8f0XdQtJ/axcqW/vK4B3VhkvKTflraIeB9dJ9KM
         yC3w==
X-Gm-Message-State: AA+aEWYjsZmFdTIuyrByamlV7A2YaqSrR/erwqvcao4syQ1opVxnmXDY
        EZ4YhuCsvieMTKSmtLz8LMEyHlIHroA=
X-Google-Smtp-Source: AFSGD/VxVhZ7QQrCI38KMx3bkCnYdXBUScdLZApJj8iB/VRavFvnNlyfjFZQfTN9yDYe+LqkrAjljA==
X-Received: by 2002:a1f:9c81:: with SMTP id f123mr11518155vke.85.1545334294649;
        Thu, 20 Dec 2018 11:31:34 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 30sm7936706vkq.49.2018.12.20.11.31.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:31:33 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id e7so1807971vsc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:31:32 -0800 (PST)
X-Received: by 2002:a67:f943:: with SMTP id u3mr5661298vsq.149.1545334292549;
 Thu, 20 Dec 2018 11:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20181220173026.3857-1-jcrouse@codeaurora.org> <20181220173026.3857-4-jcrouse@codeaurora.org>
In-Reply-To: <20181220173026.3857-4-jcrouse@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Dec 2018 11:31:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wk8md2QwPJKc4AxT2W+wtAZ6uyFteP+GEAMGwp4-pK=A@mail.gmail.com>
Message-ID: <CAD=FV=Wk8md2QwPJKc4AxT2W+wtAZ6uyFteP+GEAMGwp4-pK=A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: sdm845: Add interconnect for GPU
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 20, 2018 at 9:30 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Define an interconnect port for the GPU to set bus
> capabilities.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

For going through Andy's tree once the bindings land (presumably in
Georgi's tree).

Reviewed-by: Douglas Anderson <dianders@chromium.org>
