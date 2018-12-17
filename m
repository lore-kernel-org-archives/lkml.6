Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FDF20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545085070;
	bh=7SvNFp62SLDigOjcw6JPhbZug552cAfWHfBRsUoACng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bs8qnfEvWc86EdD/aFyqCjCZDrxIn5K2fuslOVZOI1MWi4xneALO81OoYlo1DlK7n
	 5g0a5Qj0CEGm4YIobP8wByELXZg6bxaAMaLkH4fOF2jjvZtzSmLi6AiKJRdyy7kCmO
	 YlNe9NUnuwDGsi7zEj2tCivqVj2ZYvuHpSYrtMS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeLQWRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:17:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32975 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeLQWRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:17:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so13790169otl.0;
        Mon, 17 Dec 2018 14:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WdG2f+Px2LiQ52oY4wJmoWNSNC++xrWevzS1ytlkc6o=;
        b=SKkyEs6Q3WvYB0ilIjvvCwAtTmM4S3dUAfZ3XX+bvnzTjJYoRfOxzSiSccR7iEvZL1
         kv/Pu2CbLchYQ/RpKmegyxlY0ELLt5Bn0nPyeXm1cjvak8JkEWaLrg8ayZbh369H5nQU
         V/p99L30DhBuEz06/5JpcGHDQWQUHl5nDcs6jnEEfaNPZZAwjlb7Gb1DlUqrHvJqwzj9
         B9nla2R2LEP3kZ+2iUxkC6JpZpy2+v6wt7R2+SnvoQS/L3CtqaZ+aVJyjl0cDF8OxNUK
         JDDPQyAEVjbnJebeRnq82ITIrgLdUAu6kflpLathvSVmCqENDTl8r65a3qN/aaLbGXtZ
         Z1IA==
X-Gm-Message-State: AA+aEWaCK7SFG7Rzdi6ZTCItpoQ9jfmoPe6jhViAUtYEQpT9SPMcWJWn
        nw68Tm+XHPzSRrL9L3XQ7g==
X-Google-Smtp-Source: AFSGD/UwDLTGEhMD3EvUcf7gPTYetAM6f5a2hQcKlfnGe4hWm+gxZlxejA9Zl2Y1PdBB5mWuoy4qZQ==
X-Received: by 2002:a9d:4682:: with SMTP id z2mr10506153ote.104.1545085067864;
        Mon, 17 Dec 2018 14:17:47 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id a201sm7881864oii.27.2018.12.17.14.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:17:47 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:17:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@cubietech.com, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v3 1/4] dt-bindings: i2c: Add S700 support for Actions
 Semi Soc's
Message-ID: <20181217221746.GA15941@bogus>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-2-pn@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 09:04:45 +0100, Parthiban Nallathambi wrote:
> Add s700 compatible string to Actions Semi SoC dt-bindings.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-owl.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
