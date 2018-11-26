Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C428C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC1D208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC1D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeK0Joc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:44:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36356 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeK0Joc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:44:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so18306522otk.3;
        Mon, 26 Nov 2018 14:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZy2dtfPoYshwbSZ6o3z3QET+L8GuMeMSGzM+RhFCEc=;
        b=M6LOm1jFQBeE1P/kzlppbgtlcM7L0hmEQGl2KzN0Z79SFdnFK8DTFZTKjIPb7xdd2M
         5orlGQ47jzETSIFK0MsPJ7d/GAwdsElqTFSVYks8vqp+qFUgk3BMcaWihyM3nK547lpr
         kOAkzKvYYNMSXZT2PwXyhUU/EUiLglZW8AJCWoFPcq/uOjgeGGSp4pVJw2OU07H7JNCV
         r0fa7OaCytB3EvVtQ3r/NphGCY6+AZPYq4Ng7LkfG4UEugiZT9HqyKoZiROTx2H+h12n
         B//4hmuIjhr32G3fppS6iwK3EPyjg0ZMc0BmLq2BqqZfWe4BG/uh2eEygd2yifS0n5yK
         pGTg==
X-Gm-Message-State: AA+aEWY6a3T+2yC/3sNJ6En29FRd1zzlfzCYj/UOD+NpF8tb4imCelaf
        NqkAVI3xpUeDRwi9IVux/g==
X-Google-Smtp-Source: AFSGD/VIraYEmLb0+gQRC+W96F9MfeaA1I+lenkDbUjFUqujF+Ht7zIt1R33h16GZ9psSpRKvVwhVw==
X-Received: by 2002:a9d:348:: with SMTP id 66mr15617584otv.300.1543272531085;
        Mon, 26 Nov 2018 14:48:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 52sm2421964oti.30.2018.11.26.14.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 14:48:50 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:48:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v4 02/17] dt-bindings: arm: Add new Allwinner ARMv5
 F1C100s SoC
Message-ID: <20181126224849.GA10671@bogus>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <a038c5ba853cc2534a8ee9b51de3cab5539726cd.1543131714.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a038c5ba853cc2534a8ee9b51de3cab5539726cd.1543131714.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018 10:43:05 +0300, Mesih Kilinc wrote:
> Add new Allwinner ARMv5 F1C100s SoC's compatible string
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
