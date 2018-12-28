Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB0CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4F0218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546037184;
	bh=j1PO5m+lQy8gozX/vuFdKaxzDhZRQiaOwh4dsNhZbDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mJUCcYFeJ7FJac457J5J3p1kgQxeW68F+uat9ByPjKpm2dMx1hUG5yxuWFEo3QGEV
	 prJL4wBIgGrrwwEYulTulrBfcHPxT5OkD0i9ZLo0DutcmF3/JTKDHEBHx9tBN2EqCP
	 zxgPu7yPRWaKCGlofF9veiYOEN40qZElKpMZj0N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeL1WqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:46:23 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40768 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeL1WqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:46:23 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so28532066ita.5;
        Fri, 28 Dec 2018 14:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bia1DSQJOJtVsO3fjOIR2z0ks7WB4P2eqHofdaYMR8Y=;
        b=DnlKRDxpBurvQG9n8NYWfK4Gr2jPcBiklxFdc7Ob5zXgsrpKJm9ZbN1T+wThAga/Y/
         JmDL0SS2tKgfvey7VReYuF1pT9f1pJ3npG3y7CidlioQJB2hrbg4H7BBpNWiVCbQoqEV
         Lbwj3UT32+86/KV2UHCLPxKxi4I1xpaD3YJPcVLwLEY+dyBvQe0rwYk6hKEAbo7J+wo2
         tLtmJ20CMMECNfX/4eMF+IJa+9d61w2Mz6jeua1AJHkN2rcoiJ6BAEPPiU92NWT8Jl+O
         DPAOyg34gk+IHeb9Y5gS2FlXkSQT8ycmWqJfu6R+QrLlRC8Ld0ifv2yEvYHq3BL7UyG7
         GEOQ==
X-Gm-Message-State: AA+aEWbpN5mE+eR0xOkIsQnJcU2fS+BRaKxlOkjMSdeKjstPISQ9LpDL
        Y5efmOILGHt5nzxDG61Qgw==
X-Google-Smtp-Source: AFSGD/Vc6uu/sxiqUaz5m02XBHlOfHdh3n8LA/AbXPeLvsuLFQh8jTX5SOqyObWvP8JdGhK+1WFz1Q==
X-Received: by 2002:a02:49c9:: with SMTP id p70mr19366347jad.40.1546037182185;
        Fri, 28 Dec 2018 14:46:22 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id i201sm19802030ioa.1.2018.12.28.14.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 14:46:21 -0800 (PST)
Date:   Fri, 28 Dec 2018 16:46:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     inki.dae@samsung.com, krzk@kernel.org, airlied@linux.ie,
        jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: gpu: samsung-rotator: Document
 s5pv210 support
Message-ID: <20181228224620.GA5490@bogus>
References: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181228151904.12079-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 16:19:03 +0100, =?UTF-8?q?Pawe=C5=82=20Chmiel?= wrote:
> This commit documents new compatible for s5pv210 soc,
> which will be also supported by this driver.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Removed list enumeration
>   - Placed s5pv210 at beginning of list (it's the oldest chipset)
> ---
>  Documentation/devicetree/bindings/gpu/samsung-rotator.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
