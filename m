Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF358C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F947217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520159;
	bh=orUSa6PtfbVB3NxbIsqyOnIwtXZDXYvHEYrLUny6tKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x3U7KDioByD8ugWCJB4pavRVqZy9nwsQYmZpnlEnZBZlhCrFt+HnQvL9u0EzosB0D
	 tshfyWymqkFnzjTXQSxnEAMWK9+jK8aoLzywhMS1hDCluZcntDLHzYONly/fpipA7C
	 gA5ET+vBL5efqN4WuuVOdy6mMVJwPGVpZNTzP4OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfBRUCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:02:38 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38280 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:02:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id m1so30358867otf.5;
        Mon, 18 Feb 2019 12:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9sN1PzQyGZWC4Lda8UzrAJ1dy21aR/IgJKNfZHpWfdU=;
        b=pNYewGs8JbBd/ODZuGdpsbpbQpb/6u0CNhquw7ETVfxfJIGMYzc0yPud4LdR0Ag2Lb
         TFMSk5IiY+jst8h85jHet8vlJj3+ZwtLh4Xmv3nzZNxPuijqIsT9kZUwL1ISE346NCNV
         L1grRa5iLGoXYFxgN2fZr9Cv5xvNhNZsNeJHDEZt8Kh3Tf23GLAmwuntXETLHumS6aqk
         a243Hho7RqViCiAqPqJZ/HIok4LHIybMFkcZEGF14EtbJ4Jr01yEobEeAkM2OUS8Esk6
         9LA66eUNKw1kmN1iMHlxcGltX546CjfoUFb2jkdsD4YtQWaXjOjC77omHdrJGp5KvAsX
         MsBg==
X-Gm-Message-State: AHQUAuYzRNLECwX0b4DBv2xKeMuiBGfRW6R0HcEpqNiG9T4aokobfa3Q
        fuuYO5nnlpwyqD/JpCqneDDKx7M=
X-Google-Smtp-Source: AHgI3IbiyoqNf9hEcB4xNlZl6uUdFBC5ktBT4xQpgX4YFbENVetrJTXfqm7T4B8RQy43rLSHx7AWLw==
X-Received: by 2002:aca:c7c2:: with SMTP id x185mr329197oif.25.1550520155890;
        Mon, 18 Feb 2019 12:02:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm2680085otl.69.2019.02.18.12.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:02:35 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:02:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clk: add G12A AO Clock and Reset
 Bindings
Message-ID: <20190218200234.GA31723@bogus>
References: <20190212162859.20743-1-narmstrong@baylibre.com>
 <20190212162859.20743-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212162859.20743-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 17:28:58 +0100, Neil Armstrong wrote:
> Add bindings for the Amlogic G12A AO Clock and Reset controllers.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt    |  1 +
>  include/dt-bindings/clock/g12a-aoclkc.h       | 34 +++++++++++++++++++
>  include/dt-bindings/reset/g12a-aoclkc.h       | 18 ++++++++++
>  3 files changed, 53 insertions(+)
>  create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
