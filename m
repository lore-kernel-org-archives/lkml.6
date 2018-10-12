Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A15C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9BB20645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9BB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeJLWMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:12:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34327 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbeJLWML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:12:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id v69-v6so10045484oif.1;
        Fri, 12 Oct 2018 07:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uCZrRVOoBFtVzi5PgmLB9XlfZd1rs6/vp8TSpIHx4y0=;
        b=LablFCg13ZLlTfyffSxPJqZvnHiXmFp6gQn+CFnFygwiovFg8qWoloBlxYs7n0NUaD
         wlwkUH6XDMs2GK31kiWYPG7tJBlbWy9F/5dYeySqoDavygWHjzVVRAn46HMOBCPPLB89
         Cm6NEpEKEL4ItC3FLXmbcdR9OgzP+4sbX2U9MAB2yGI8d+ZxkJZB4Be6SVbE4A4fiGDE
         2cxaZAHwHyd2nUAgC92uqSrABEHrMX/WMJSzPPeo6QnQuaEc+9fJBrJqszEi1+74sf+E
         jsGj5vO+c+lgQPFerVVLUCsGCk4a0CA/Kfrk4Zj+fIXiBhZccX2iL3NnU/nveM0z+kuZ
         rMvQ==
X-Gm-Message-State: ABuFfohu7y5yBR7Hi7P9Bda+vDAxkst+ufEKsIkrN9WD+Qas7c1kO0pH
        kUKMxkDZIoXcta5p/2OB7w==
X-Google-Smtp-Source: ACcGV60ObJDRfxCPJEQfhsqWIRTzwwf07CzVq33sBepGG8RRYPWbAyC/lTv539c3D91GZ26ri730zQ==
X-Received: by 2002:aca:53c4:: with SMTP id h187-v6mr3176477oib.48.1539355166053;
        Fri, 12 Oct 2018 07:39:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5-v6sm330083oia.54.2018.10.12.07.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:39:25 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:39:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
Message-ID: <20181012143924.GA13208@bogus>
References: <1538048404-9041-1-git-send-email-amelie.delaunay@st.com>
 <1538048404-9041-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538048404-9041-2-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 13:39:58 +0200, Amelie Delaunay wrote:
> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) MFD core.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/stmfx.txt | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
