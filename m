Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47837C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7AD20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547242462;
	bh=jLhWXAzEEm6YLDQfb0ZYN8ilTWGfi61ZyyGgPLuCqIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WhHE604HtXrpUm5oedfVoLj/x68RSdk91xh1WzmcEnOdlBcW2D81t2YXM5wY4TXIJ
	 ug97mxBeyVS2tcz3ir4RRRirdgE55mKpCQaScqCQad+ZMDdPuOyPyTQc8vlnDBV0zH
	 1BeZD/KE+WTkmbGi2TamixgCwR4Ohcjh2XNfMY0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfAKVeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:34:21 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34104 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAKVeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:34:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id r62so13425003oie.1;
        Fri, 11 Jan 2019 13:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fStD3fX73PRegT02xKt7fnKpQ4WfsTB4mU/UU+dUJUc=;
        b=cyn+NCSC9rZqu0PrRvd7NtJzDbHLdXDtSBsWEJh2oCcCnvoLYsG4pEls4MfkGOM0IJ
         /wyldl1K27oRzk09IZ0m8Hf5zR+3BUNCtXJ6upWqGWlCdNwFnui4R7ZCGvCbXTzgGDy2
         dYQt3tNnthjVne0izJ3C0cOdvR7xRhubeThK7QBzFmxZzxfEVsodTlYcrVVNLtSJHsD6
         xrETCuwxbNPGABipHnzuSUcDSwnIuii3KPxYNfRFluwR49bAroq/j2Ku3pTssYlPuW9o
         STpCglaeGf8i1mVKTMVC8YEInsUC8W7JOoVvv2C8RRfarWldU7n2knsiBZLUUgZGBiF/
         XZDQ==
X-Gm-Message-State: AJcUukfTQJJr0uaeAkYguitPCyRuWAfnN939NnaG8hsxYOcWuf87ymDF
        ZHBeXFu34DN6Yre/r4Xf5Ea36RobnA==
X-Google-Smtp-Source: ALg8bN67A0L2zted3UmarUHxXisYL4fWuDOkLdgP14TTM7Ps2nF4hV1uK+JZv3KbNRNAg5QiXMC1jQ==
X-Received: by 2002:aca:dec1:: with SMTP id v184mr9679876oig.217.1547242459073;
        Fri, 11 Jan 2019 13:34:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p203sm55414222oic.49.2019.01.11.13.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 13:34:18 -0800 (PST)
Date:   Fri, 11 Jan 2019 15:34:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ina3221: Add ti,single-shot
 property
Message-ID: <20190111213417.GA23016@bogus>
References: <20190105030636.533-1-nicoleotsuka@gmail.com>
 <20190105030636.533-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105030636.533-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Jan 2019 19:06:35 -0800, Nicolin Chen wrote:
> By default, ina3221, as a hardware monitor, continuously measures
> the inputs and generates corresponding data. However, for battery
> powered devices, this mode might be power consuming.
> 
> This patch adds a "ti,single-shot" property to allow changing the
> default continuous mode to single-shot operating mode.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/ina3221.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
