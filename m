Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D1AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47577217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520205;
	bh=uB0Da373/kLOSzh8wNRj4MKeL5PGBzXaQLJJ6/kGMCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S1RWfjvRdRHfB+5F1j7vyO90d8tT9SrUaUPeBxs67Nkj7mZowsXt5S3QewmH5fWrN
	 bumLHnimMn59cKCIzox6LSzbOqbg7UTNbRQzEjt7+xhZGIQjq/8I7CDnTzjFQQvZwi
	 p6/5YDvu0OFjof5L2VlZOM+5yCVy4QbXKliEo6Nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfBRUDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:03:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42378 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:03:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id i5so30298320oto.9;
        Mon, 18 Feb 2019 12:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hj46N4lLRhAd2KB6YBxaLuye8VMMbvGPsHzIDh9P92Y=;
        b=o1IWoEOh6hXmvbGm9kXOR8K0bUHvLZRShaqk4lzanaJoHZVqcRecQcJAj7QA3UFHqw
         y5UubBorbiWIyrk/1sYGLMbPTD6al16X2dwkwP5BbFrfJApThSDT2qzd8RFWdoTdeaiS
         yL0B+RF8jqRphNd9mOu32demDTPalVSTAToGIKwOZGZVviyEP+4LMrPPsViM08SpPyck
         JDsUcuJ4lkjGhVJxfrY//Zt81vPtdq9vUDt3TasuVfyPMi4DVKG31whJel3LjOvNJgqg
         H7ii8nhH8x3QNmEGYZzXwTXV5nPyqr3cM+0fTt0t7w8E709KZo3825ZgHmi7OCO55l0z
         F2QQ==
X-Gm-Message-State: AHQUAub0YKoHG8AwYT0la2yVFTdTRBSrsL0rBU9i8O1fZdyXFV+bt6fS
        J4smRVuWGj/KNLdjB4TOZw==
X-Google-Smtp-Source: AHgI3IY+0bLtSAISDD0SvkVlWhJ6Yrympp5oVxHX1VGsGbXFt23VDrtN8Y0iYcsVidcUhdc+gVrC0A==
X-Received: by 2002:aca:f0c3:: with SMTP id o186mr310262oih.101.1550520202604;
        Mon, 18 Feb 2019 12:03:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x127sm3999521oix.25.2019.02.18.12.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:03:21 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:03:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: hibvt: Add hi3559v100 support
Message-ID: <20190218200321.GA834@bogus>
References: <20190213150508.11499-1-m.othacehe@gmail.com>
 <20190213150508.11499-2-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213150508.11499-2-m.othacehe@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 16:05:07 +0100, Mathieu Othacehe wrote:
> Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
> platforms.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-hibvt.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
