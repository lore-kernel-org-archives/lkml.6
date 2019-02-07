Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E29C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7161218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHYt7e++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBGHsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:48:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34842 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBGHsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:48:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so5576539wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 23:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NTdGonK744BlVpHfJkByCKbXq8IBZylaPXj5tnPuUxY=;
        b=zHYt7e++rFoBLVbdSTZYUfceoYPP6XWpRAgkGAUAcxf4eGQhHwM6/jg8m0A/jK+pIA
         9TiXqQKfBnCXeNdAP9QEQiwU31k0jetNrd/JCEeuTJ1JB3sBUpfnFv7KyGkn122N3JRt
         tzBr5ZVSTPKVDEXbx4Im4bT0lW0f1Jrt8EnXMJHNJu5St6U3OffipiVmevtY1fjewD/z
         780sB1NIhfILmZt1kpgC6n4iL/jrd5xvsYUhtyAwszKEEb1OZszAR5imAw5kmrXAuw/H
         C+2LyU3hpQUEzA2L9gi3fDXrUi+aSKyIrl85QBZ4AnJoGNlNpod/W/RSdcHQs08oiVxk
         Ob9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NTdGonK744BlVpHfJkByCKbXq8IBZylaPXj5tnPuUxY=;
        b=dms6XnNVm1i74JOK//AZChu7M9T909fdCThJRLYvkyLsMqkhfs1Ah5UH9O6eHoUEyr
         Ho1tJEGciCEPdCxj93ix3n6O9xnSVpKs1vmeYb39+k6uxVEB7o5PE0X0jqUHL4MgmLMI
         uisHezElXoXFs41/ycinMHudgEJ1Y7ZstANcj1i3MhESnW2DGK8pwlmC6xlZPU3w/P50
         PMTB4lm2ZYbCcE0H3ohY6NCyc/c6L3Wg+ECrCJZnAx7+CcF02XtZGBKJvc0G07P6JL2j
         kXgYH0G9i+Db+/H0/pR9Q0fwV3msF99Mk8m2UOPOJBLJX270tVbKJg9fNHJb5CDp9z0/
         NVHQ==
X-Gm-Message-State: AHQUAuaZhOPDiEMC+JAyrDZqPeZRhhdHJSGIkPVJAMPhSruLD3setdct
        Z4zn+SiKUl+pLJyvoq/9Bdb9YA==
X-Google-Smtp-Source: AHgI3Ib61/0rKoFEbhN4qPnZvjLR+p9OgAfjOHNnoPy8Yxc/nofF36J3kFM2jFsvlzEWtjucRAeu8w==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr5837602wme.11.1549525680239;
        Wed, 06 Feb 2019 23:48:00 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id r14sm5727736wrr.65.2019.02.06.23.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 23:47:59 -0800 (PST)
Date:   Thu, 7 Feb 2019 07:47:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v3] dt-bindings: aspeed-lpc: Make parameter optional
Message-ID: <20190207074757.GA4672@dell>
References: <20190129230538.1044378-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129230538.1044378-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Vijay Khemka wrote:

> Memory-region and flash phandle is not a required parameter, it is
> optional to describe in device tree and needed only use basis.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
