Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E5DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20054218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545228284;
	bh=mRoYO4y0UUPxHKtpned6Zr4N7r0hWjgoLhwwk/0aIEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CaRiKiwSinEtdSAeYCvgEUJfob4xomOGy1R+MQxLs/lRPaOtUWkCmjKqRPzCuh29r
	 WxwzqGJFJ0iVPoOZWXp00LXeT2ldBRrDWfl3tQWjuxP98n3PRkbG5dUeCjkAqCT65t
	 3PEt3mHP2WhQbpOq5jxfn4hGli840AUlNg1z0/ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeLSOEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:04:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42458 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbeLSOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:04:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so19169575otk.9;
        Wed, 19 Dec 2018 06:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+1iwZ1k09J4X6V9hU88xagJXDo8YzrEApBpau+WViU=;
        b=XYVF3p+zOPrOAtno3yAiTrNO2BQGMcwNsv2A066q7yhiQvvPqimQj/TYCCuKJrHNOo
         Fumdt2etVDGI6n1lRTd2+1hTukdA/qXlD1vjne4JgljnTHtSXwKwoo1TVtEbKAyrs8il
         IQ3iiMQBsHzmKhRZDOtksWAfTPRJl6vcrtYvn89qLk29niVb9qg/gSERL9g8YE99shWl
         UZ4w8u45JBPIyfWgVGF63G78syjh0NTRBX30gq92a1+hi6NgH1gzcutYyGg9lgtxPF0+
         Iu3sD3nxJFkXEkCkSkTrUZ41wOFCuUoK9VbCkSkoR7tzP7tMVTf966Db4TKocIdEdpfE
         8myA==
X-Gm-Message-State: AA+aEWbQU3nevf+m2Be7WI8E9XzYmdDLTlpDeUINoDSSeZJRZyDzTxah
        Xahj1MjyS7IryCFkomF3Cg==
X-Google-Smtp-Source: AFSGD/WWh6dPcxJsDFkewPSdC4INOdBginIV9yDAw/W/qF6KfgqdRaJNwCFb94ed9d2faE9aByHSjw==
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr15886768otm.170.1545228280726;
        Wed, 19 Dec 2018 06:04:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5sm8586713oth.78.2018.12.19.06.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:04:39 -0800 (PST)
Date:   Wed, 19 Dec 2018 08:04:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH 07/10] dt-bindigs: sound: Add Allwinner suniv F1C100s
 Audio Codec
Message-ID: <20181219140439.GA6820@bogus>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <d0ce4b1f2a89a319d6becb5f88d7ca4184aa5595.1543782328.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ce4b1f2a89a319d6becb5f88d7ca4184aa5595.1543782328.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:23:14AM +0300, Mesih Kilinc wrote:
> Add compatible string for Allwinner suniv F1C100s audio codec.

Typo in the subject. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/sun4i-codec.txt | 5 +++++
>  1 file changed, 5 insertions(+)
