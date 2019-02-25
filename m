Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA7D21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551137585;
	bh=k7DSjKiJg+qoAEUzyexLzlaJKX1G6akBcP4DEZurMwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bWMaW7hA9/DMcv+Lb1YZ6bjsRVXbhDKpSM86jFsXmnr887VAreIjBytm9v3MOh4oo
	 HPaTBSWwyDOjunQFEcd/IUWIPg0Sg6yzGSwvdbENzOasewn1jXWjC/pYtDfVEYtMNE
	 wghCe7PT8FB8k2/mp673BbllXRqQKSlvb8y5ccas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfBYXdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:33:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42521 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfBYXdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:33:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so9483752oto.9;
        Mon, 25 Feb 2019 15:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mhas2O7WqxcWkIgrao2rHLIS8cG0frp/MOnMjnOJTzA=;
        b=a8uvwT0yrQ6fcFKpn2GzVr0cay3yrAF+WhF8Bq+FuESM0IgEPtu3kn/4oV7QRg9R5R
         N0jb7ulefH3mxowW4Tf6njBWRHtH3wFuh6LpizSnK/H7d9IoxMRGCqKIrwBenwq2qBgt
         /5yuoRis6IjKNiGV+2H7/LpfQ2Ho+VHHdWRIf1/72wUrj2puA1MmKgw1+ajYXIE11Xqw
         5FrPgGUKWpc5L2D91mtu/eP/PtAwMtpdUaZpN7qYxu2njEI+vF5ny3ItYhwxlaK7s//D
         STuMdVlf5aSIK9XXO5W1h2Fpz4e/lL4TktBGxAWZspllSsQnSr4FLhUyNP0PknZbeShE
         xygw==
X-Gm-Message-State: AHQUAuaAb8VIIMFD1vC8j8j2+kvvQYy0BI/PBz+fR78ez5RXzJjOROCp
        S7ivOxcAuj/LJ0tNY5xqww==
X-Google-Smtp-Source: AHgI3IaVF7mDjxMWRMY30ll1EnVc0aPiNkILCLnvf1UGJWihq5Eu+CZ+Wj1P+T0PHRVxuLvZ2iAHRQ==
X-Received: by 2002:a9d:6755:: with SMTP id w21mr12737548otm.87.1551137582792;
        Mon, 25 Feb 2019 15:33:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d18sm4519450oth.9.2019.02.25.15.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:33:02 -0800 (PST)
Date:   Mon, 25 Feb 2019 17:33:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 4/7] dt-bindings: spi: Add Support for Allwinner F1C100s
Message-ID: <20190225233301.GA25780@bogus>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
 <8d62291fa2f98d07e08d81fe4f54e4c49744c24e.1549875778.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d62291fa2f98d07e08d81fe4f54e4c49744c24e.1549875778.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 12:21:10 +0300, Mesih Kilinc wrote:
> Allwinner suniv F1C100s has similar SPI controllers as sun8i H3.
> Add compatible string for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sun6i.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
