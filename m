Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E51BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEE020657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvdeQ58/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfAQGir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:38:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39510 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfAQGiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:38:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so4255215pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 22:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oifDLbXUZtnlnTlJhsIk8JZcFU1wGPND6UNf41reewM=;
        b=HvdeQ58/uJZBFpTG8gcQ3Ah18ThBTDw9fD+nNFT5E4ZOveL3M2428f/vyJBejnwuUL
         OHaivXbZdqMbzcxDOHfu8xBEwZTJ/+FlpSSwpKqNeZmOLxHdNS0U4Jz9wF+QYoUpPKKO
         o25dokBerX2RCWJyhEZAkiz4DsvIXa5URZTyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oifDLbXUZtnlnTlJhsIk8JZcFU1wGPND6UNf41reewM=;
        b=rJHgo8eRPC8BUE0jyC80kvgs3e7DAUCjgyG07g67r+bGt3pDMLOZEQiuTndew6sRhW
         e+O9E3BF09CbQKtJ66vHsISwWv+KiOucmfo5n31Cj+gemU+jDVXp9oHBlL4jPZ3EAxsf
         hlUNYZpPXV5Vj/xT8X1zMjoBbVKdx8HXpM07Ef8rvtYVBVMdbpeWxda42ps5u1pglzXj
         ECcKBzobZXvTIG5WC2Bp6QDfOxdmwhL5ZnfnAco512tcC1ATCz7N/asSkJUYrzqRmMG7
         u+UVTwPhIftDKYbiuFxcTPCSvncvDfBn6RgyD9epTJGqlYt2iljrvzoZ4hjDFk0WMk6p
         YBlw==
X-Gm-Message-State: AJcUukd+A0Q1XdZXTuzhVBXoO9pyJaLCaZhlpaAOiT/sAZZdVdip5uiu
        lJoPvwPOkz/+c0q9nulWOTvFaA==
X-Google-Smtp-Source: ALg8bN6KbkCqFrUoDklnyIHTgV8oZJz2xoLXS8H6iLgrPp+fr6e2Yl+Te7RqWdLT+6GGpVqltgNZtw==
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr13810855plt.134.1547707125704;
        Wed, 16 Jan 2019 22:38:45 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 7sm1070676pfm.8.2019.01.16.22.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 22:38:45 -0800 (PST)
Date:   Wed, 16 Jan 2019 22:38:04 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, vkoul@kernel.org, niklas.cassel@linaro.org,
        sibis@codeaurora.org, georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 10/13] arm64: dts: qcom: qcs404: Add HFPLL node
Message-ID: <20190117063804.GJ25498@builder>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154507555157.19322.2712807405425817338@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154507555157.19322.2712807405425817338@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Dec 11:39 PST 2018, Stephen Boyd wrote:

> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:27)
> > The high frequency pll functionality is required to enable CPU
> > frequency scaling operation.
> > 
> > Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > index 4594fea7..ec3f6c7 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > @@ -375,6 +375,15 @@
> >                         #mbox-cells = <1>;
> >                 };
> >  
> > +               apcs_hfpll: clock-controller@0b016000 {
> 
> Drop leading 0 on unit address please.
> 
> > +                       compatible = "qcom,hfpll";
> > +                       reg = <0x0b016000 0x30>;
> 
> Wow that is small!
> 

I double checked and it's actually 0x34, but the last register is
protected.

Regards,
Bjorn

> > +                       #clock-cells = <0>;
> > +                       clock-output-names = "apcs_hfpll";
> > +                       clocks = <&xo_board>;
> > +                       clock-names = "xo";
> > +               };
> > +
