Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D221C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394EF21907
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545945093;
	bh=8IRq20wouNZ1BsWajklRSoJFI7k10QDFHL8ponN98SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b+MJCrvFbMkzRftIqy9xFV5CnoExBRtArLgWRPJPgHMMukKZ7IwAQCrIYzqIaDheS
	 2xWtkhxw/QI2ULjNjJOR8aI9tNHm0xgLM5dRsWuxWnZWkpno5wPdGxX5oz78MBsjDv
	 prjBvjgtBsGVyzTps07hfd3qvB88eDpqQBVIzxvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeL0VLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:11:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54610 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbeL0VLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:11:31 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so26045398ita.4;
        Thu, 27 Dec 2018 13:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0C5cFFdd9ST3OZCDsfLCrMSaUPayJWdAvnN8vaUCc6k=;
        b=freyMMsu20XxFslkscWZZMHYTQJN5mYqawN16wychw+kDj6arpL0MykD0EGrAbabmO
         5lLhymKRwVKpGs5MmIvtgZ7oxBCB8GkJI2gSU2hSJEUK54U+LXaBbP9dblZ1MosIO9jQ
         3z42wnlXiNdc1LwNR7SaY0sYEXFLcsMKrApjdaKrmJ7sazvQnoufJ6NNWMJDtC8j2g0l
         uHtIsNfxAyHfx/r+uShm2ass/JdFVgakrkZ23AoZBjxlzoRZ8op4Oscm3Z74GhpSRxGZ
         nBYXBKEbasi5aHB6Hm1tbV1AlRryxOF9dc+qIk/4SVa1FTth67HpfHj5OY++8//D93Qh
         Nw/A==
X-Gm-Message-State: AA+aEWZiP+Pg2tCGXqXbH1OuU5PUk5ldepxpGEVkKdyWQ3sWJAeTiQSg
        bg0oQvmehUBxzIceZHj6Cw==
X-Google-Smtp-Source: AFSGD/VVXzPQjRd2au3de0HN9ClKCKKGpfSpf3KHyQZtNjNqb/bbzgQHvoeaK0vIo4sRB4BhcpRiCQ==
X-Received: by 2002:a02:89dd:: with SMTP id e29mr17355502jak.21.1545945090871;
        Thu, 27 Dec 2018 13:11:30 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id h140sm14296932itb.23.2018.12.27.13.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:11:30 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:11:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH v3 7/8] dt-bindings: remoteproc: qcom: Add power-domain
 bindings for Q6V5
Message-ID: <20181227211129.GA27911@bogus>
References: <20181226125229.20149-1-sibis@codeaurora.org>
 <20181226125229.20149-7-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226125229.20149-7-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 06:22:28PM +0530, Sibi Sankar wrote:
> Add power-domain bindings for Q6V5 MSS on MSM8996 and SDM845 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> v3:
>   * Fixup dt-binding documentation as suggested by Doug
>   * Dropping Rob's Reviewed-by due to documentation style
>     change
> 
> v2:
>   * Add load_state power-domain
>   * List cx and mx power-domains for MSM8996
> 
>  .../bindings/remoteproc/qcom,q6v5.txt         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
