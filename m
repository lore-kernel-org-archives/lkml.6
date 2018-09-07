Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F6AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC2D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTZV5JNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC2D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeIGV3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:29:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35118 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeIGV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:29:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7-v6so7283897pgf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Zcw7h74TEmUiVi34KaQtuJuhSGWP774pgj+PuL3Wl0=;
        b=DTZV5JNwA9sIweofvVQe5vbG99OWt0I3Tj+FOHESPvG4hV9u+N58gQOnJdTT3u3SAx
         4b2NtFmItVZe5DY9Yyhs+CZPwny6KWaxbLjn/mXJAzvGQzg7RHq+2QP+sLKFDGRStDzx
         KdtPV9Ss7ESgwH9HkmtP+S4z9plqv/aYG8uPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Zcw7h74TEmUiVi34KaQtuJuhSGWP774pgj+PuL3Wl0=;
        b=C9958uKliGIyczQp5IVkJ2KYl7ZpObU1PGyU1Q8nPzhblnUkGAMWKV25N4MzulRmLp
         ukleIFk6QSj2lh5S7nxY+5kE9zX4JGIh9VioI3rUQGJux324u3Lc4950p7xETe2z1SLZ
         z3sXeJdYiHSf3xOuUPaRVCNPeJhawNaN+cTifWnb4+1WBovp0TmesZ/sFGIBEeiHQG+J
         jic62TnM3nYbGa1/B2p6Z1lNYZOeWhfb0ZSseXS4icsxSqIp9+XCG39YOjFl1V1MvEDm
         hHb47L+1/vEjvrWUF5j1gosz1ubFnO+w6lE1VbaCzKbr52HTXQAoAWyJRHPpor6+qCYu
         A8MA==
X-Gm-Message-State: APzg51ApFBk+5zR16QRhdUmiQiKWP0iY7eYO2xPzhdUHOH1S2u9TR67X
        qcZY32fcslM4sP5TvDB9ija33tVqUH0=
X-Google-Smtp-Source: ANB0VdYE7SmR9ckank+hKLbqot4GXANZB2eRM8uGLvrQDhKpbMkzgjj6hYQv38b0kCfmCvOtHoFPbA==
X-Received: by 2002:a62:fd06:: with SMTP id p6-v6mr9490947pfh.167.1536338843746;
        Fri, 07 Sep 2018 09:47:23 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 16-v6sm17497918pfp.6.2018.09.07.09.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 09:47:23 -0700 (PDT)
Date:   Fri, 7 Sep 2018 09:51:19 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     frowand.list@gmail.com
Cc:     Andy Gross <andy.gross@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: qcom_defconfig: Enable MAILBOX
Message-ID: <20180907165119.GD3286@tuxbook-pro>
References: <1536295488-12296-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536295488-12296-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Sep 21:44 PDT 2018, frowand.list@gmail.com wrote:

> From: Frank Rowand <frank.rowand@sony.com>
> 
> Problem:
> ab460a2e72da ("rpmsg: qcom_smd: Access APCS through mailbox framework"
> added a "depends on MAILBOX") to RPMSG_QCOM_SMD, thus RPMSG_QCOM_SMD
> becomes unset since MAILBOX was not enabled in qcom_defconfig and is
> not otherwise selected for the dragonboard.  When the resulting
> kernel is booted the mmc device which contains the root file system
> is not available.
> 
> Fix:
> add CONFIG_MAILBOX to qcom_defconfig
> 
> Fixes: ab460a2e72da ("rpmsg: qcom_smd: Access APCS through mailbox framework"
> added a "depends on MAILBOX")
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> Bjorn suggested that multi_v7_defconfig might need this same fix
> but I don't have a target to test on so I have not included that
> change in this patch
> 

multi_v7_defconfig should boot on 8974 as well, but I would not be a
surprise if there are other things missing there.

Regards,
Bjorn

> Tested on Qualcomm APQ8074 Dragonboard
> 
>  arch/arm/configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index 6aa7046fb91f..bd6440f23493 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -207,6 +207,7 @@ CONFIG_MSM_MMCC_8974=y
>  CONFIG_MSM_IOMMU=y
>  CONFIG_HWSPINLOCK=y
>  CONFIG_HWSPINLOCK_QCOM=y
> +CONFIG_MAILBOX=y
>  CONFIG_REMOTEPROC=y
>  CONFIG_QCOM_ADSP_PIL=y
>  CONFIG_QCOM_Q6V5_PIL=y
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
