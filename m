Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDD8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DA72190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545416615;
	bh=TU/RoM1AoZ5l1VdigYgAU5HDX6Iv+NXPe3eqHjsIOlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i/xkAbWn+0POeeWa3FTW9XTnCpNAHa5M8fHDxD91Kc0kxpiqjGzM2JJoNEC87rUPu
	 UaYphEm7yi934YUpIxtHkgYJWYbz7FDEaW5zuQfOpLYUdtouCSkFA6U2P/f1m8iNsm
	 LLy/pFHMKtIflbf63IRNy+5qLWdZgaTx1BOrACNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391376AbeLUSXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:23:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44593 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeLUSXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:23:33 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so5900695otl.11;
        Fri, 21 Dec 2018 10:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JA2rZwpKRghhAE4r5apXuDvLr8PrAzse9lI7Ni35z0o=;
        b=TYeQrpaLr4G+WuaiAMvlhdzqGCZ1KFEKINGQwkk8J+h5U/AFvsKrMe8V/tlEDQ2Uwm
         AozyCchehRJHR/xHnNpz4n8/K1b0jis7+AkHNy8cYDnbU8GWAEtLV5zzb1OZHUxDFlJL
         N9MMmeO3wuS95YBNWu4G2rnd/omttLvr6s4POXJ6S2OPrOppt4jVxSUlFTc4uH+xWkcc
         x2+lTWmLTsBNUziV97LMfyKNFqxAgRYmxMxMbjVeusnuk4zSbDjdOE08ReqRUkuagwBR
         gOSuAa4HHJY47vNlCPAakfP5EgUVfjYOLR5dYrYlZNyXYnUhQEx2YE7ARAQamDvtdoHQ
         OA/Q==
X-Gm-Message-State: AJcUukc0BzRpRajkSkfjWAp1UZkBznenfGE1txNEBOLwYoppnXXYHdEY
        0XXqdpGxpx7ErLvPu3U0VQ==
X-Google-Smtp-Source: ALg8bN6eFfYUfyym7c2Y5Cir7ulZDAjtsmt2lt4dB90cY222B+eHGT6uL1oXLylUVz8SS+83TEdJ/A==
X-Received: by 2002:a9d:7ac6:: with SMTP id m6mr2419927otn.62.1545416612825;
        Fri, 21 Dec 2018 10:23:32 -0800 (PST)
Received: from localhost (ip-70-12-27-227.kscymo.spcsdns.net. [70.12.27.227])
        by smtp.gmail.com with ESMTPSA id m89sm13391147otc.35.2018.12.21.10.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 10:23:32 -0800 (PST)
Date:   Fri, 21 Dec 2018 12:23:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        digetx@gmail.com, lee.jones@linaro.org, coquelin.stm32@gmail.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
Message-ID: <20181221182329.GA5726@bogus>
References: <20181221134638.20600-1-dev@pschenker.ch>
 <20181221134638.20600-2-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221134638.20600-2-dev@pschenker.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 14:46:30 +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This patch reformats the parameter list for stmpe device in a
> table-style so it is more clear to read.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> ---
> 
> Changes in v5:
>  - Made a one column list
>  - Added lee's Acked-for-MFD
>  - Changed author of commit to use correct email.
> 
> Changes in v4:
>  - New separate precursor patch for holding reformatting
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../bindings/input/touchscreen/stmpe.txt      | 64 +++++++++++++------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++--
>  2 files changed, 53 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
