Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FB6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95D621903
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545335355;
	bh=kfsGS1YJc7JaES+SQKQZc8NWs4GpbIIPtkM8zvefwt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QheCC2lJN7jsjhgurJwWpK5Yqp9+hLV8CYKMTEzZWOIeobgVBAYJ7rqjPRWl2/0zx
	 l1diDRTM3bAS0AwQbRj+DQhs+uJiMmlmftFbKJiTM/YNvAM0vlcll/FdPCWnzQrDOV
	 AI2oqDEuuinc0pmNtudjU0Ml33pW0GLZ00C6NX/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389524AbeLTTtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:49:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44111 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbeLTTtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:49:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so3017695otl.11;
        Thu, 20 Dec 2018 11:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mpin4rmY1KHiXB2yLRM1gONu7AeF2ezjMMA9danRL7s=;
        b=gX5sCMFA/U4HL6Lx7kuA6NkBx1+ByTKNCk2iLox78P+06rHjWkbXXMb5o1HbmewAJ0
         XwHfJrMqmBJt/+qthuq9lijA53KI9b6S/yne9NHk5e8A8BE+JcUUDmzwI8y97sIpdbZ4
         3oh4jmm+nuLhSFgYawxrE9cPnSBxfp5jFqJdMiPifjWlujapSQ/PYXtZ/JpS8oA99IRj
         yS4z2b4eVA8AtRRm70ABd3AFgEfjNi4PbU5+JSHYmfku+wKPKz6FtSyMqW4c/uD6rfl/
         Qhc8FEEFBJCGxjTewdw9JRPbqVuEvsfQZi+Rdvy6roq7RhM3ihbFHKZ+Zb8hNsuLVg14
         DfRg==
X-Gm-Message-State: AA+aEWa/6l2CdsL23Y3w3P9LkF43gJZSqvu8Nfyma+VfijvXR7D8bLAi
        EAWNyMdOBdh9Lacex3iiyA==
X-Google-Smtp-Source: AFSGD/UmB/VXwQMTBz+ZpWV6GMPqXR5Mpfw5Zk5BFr+klOY+NIMe33FWpYrh9JdRvBJgB2go4ge5zQ==
X-Received: by 2002:a9d:128b:: with SMTP id g11mr18776880otg.130.1545335352988;
        Thu, 20 Dec 2018 11:49:12 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id j5sm22008741otc.54.2018.12.20.11.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 11:49:12 -0800 (PST)
Date:   Thu, 20 Dec 2018 13:49:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     cezary.gapinski@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: Re: [PATCH 5/5] spi: stm32: add description about STM32F4 bindings
Message-ID: <20181220194911.GA17409@bogus>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
 <1544363636-12161-6-git-send-email-cezary.gapinski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544363636-12161-6-git-send-email-cezary.gapinski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  9 Dec 2018 14:53:56 +0100, cezary.gapinski@gmail.com wrote:
> From: Cezary Gapinski <cezary.gapinski@gmail.com>
> 
> Add description that STM32F4 can be used in compatible property.
> Master Inter-Data Idleness optional property cannot be used in STM32F4.
> 
> Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-stm32.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
