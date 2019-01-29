Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F29A2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZZN6Wad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfA2MaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:30:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39874 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbfA2MaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:30:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so17526063wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oE8Qm9PdZluCUZkLGWY+ZFIppoNu/D2qntGj/3XiAXQ=;
        b=LZZN6Wadr4cjXRY+8dG1EeZk5m/TdVcTfpOsZ5V3GC5hu0tCP6jbbMPBh03ne5P1zy
         ghlKYErOvpXI91DIeGX1ODR8VvIyaDe5KPQSfDOG6AzBpYuhi+79EKFNQFSSbLM68h6D
         95Z/d7mkgz/UENS2zkiIHBphbNV6BRLo8vu6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oE8Qm9PdZluCUZkLGWY+ZFIppoNu/D2qntGj/3XiAXQ=;
        b=KJ0zkhvbfRM0y23KRLWk2aMITmtAWBqvpqM91iWkRc6eKKXIsZUwspb997VQIGQ/vY
         FaYK2jOGherisdxVguC6mxdVHfdrsAYu5qGOUaao3PZ5fKJZPqFGm7DYolmMaA0+nIBC
         sN+R7OYKdfc2HUA449kCKK2RztPuG5fELklNdAC1xTI7k4mrWtpRNY3B6oOEBSnsv/vT
         8Fz7ltoD+dSbhzv6JlKauJ45TAEkvnackzZc7QBbyuF45dnIKlVKJMw1mH2HSM7qw/vX
         c6U9vr/Ldy/yCtqnnqcmD1DHqRPovnKjyVLiutkEZ/e7nhzYfGBRUZT9iimslCSgNXtP
         Eo2A==
X-Gm-Message-State: AJcUukfHGnxz3iPrXwwCOXp7ZIpecOC/U6Hg2CP9h2jpGky/2GsBO3w2
        5ZOVFFPHBffQMuGQ6xoTlonhzQ==
X-Google-Smtp-Source: ALg8bN6Dv5bto48uf2VZhK8Y3t2maUaWJp3mSF942fyW3hxN7qnMGNqU1ppDG+NKI3dclarAXzygsA==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr21799557wme.6.1548765010759;
        Tue, 29 Jan 2019 04:30:10 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id l19sm2852142wme.21.2019.01.29.04.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 04:30:09 -0800 (PST)
Date:   Tue, 29 Jan 2019 12:30:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v2] dt-bindings: aspeed-lpc: Make parameter optional
Message-ID: <20190129123008.GC24070@dell>
References: <20190118201547.640173-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118201547.640173-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Vijay Khemka wrote:

> Memory-region and flash phandle is not a required parameter, it is
> optional to describe in device tree and needed only use basis.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 34dd89087cff..d28c4e117611 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -135,6 +135,9 @@ Required properties:
>  - clocks:	contains a phandle to the syscon node describing the clocks.
>  		There should then be one cell representing the clock to use
>  
> +Optional properties:
> +These below properties are optional to define.

This line is superfluous.  Please remove it.

> +
>  - memory-region: A phandle to a reserved_memory region to be used for the LPC
>  		to AHB mapping
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
