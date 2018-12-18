Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5D5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262DE21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545145137;
	bh=LzA4gMhwEMdrUhebXPC/uZpveuZW5dC7Gx19V467VqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cpJroNLupklqc48hN6TVNqt16QNHQ06pYbhQEwNrNYNy4wOyi1noGBXSR6QzKBATp
	 +PQseclFPUrXgEypBvS33D4dL7cgMIvewfspEG/b5m9yAQB34VUxzZmmp0yksi41gx
	 mFglbIwZicaIFOiNVePiiIaIg73N033fH5r48sls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeLRO64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:58:56 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44379 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLRO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:58:55 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so2125374oig.11;
        Tue, 18 Dec 2018 06:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xMKIC/TFpjstl7gS63RAHtvskE1SAito/HGCHDVeMWU=;
        b=pEKuwvwpJx9l+GYaAJuS9daGQuXc6Hq7CGYiZ5aURRHJLSGtTGmSImzwBzB9Ns5f4f
         2KoMdzdyQeuWxGYqJrg3r4bfRmMKJMFxSohZsjcqXwCVWjOHVxepwceY880H6edknkJH
         rWmXcRuBFcAChTruKMG4VnB9acWMeUJ0GKtRgC/8Fnrx1c91Toonf02pgG+gnbVMS3ZC
         4C6+CENCRK+xfgYwGy2zDSn6YtTaubrtDTi8pSUp4hbd0UJwrQtv95bEBAQNaOL74Zmg
         QDVlPyYG0NoY3CpCLvBeUKinKBN1cjIcZ1VUgRp8RdUPAD/dUrZ9H6dh91FOHlp6tTpJ
         JyGw==
X-Gm-Message-State: AA+aEWaHNoDOxem3R4d0GbFcGweoPEyDBBagEXk+l5ABnx1kyX45K8iB
        +Fj7SyDxyJAz93KqhMmoiQ==
X-Google-Smtp-Source: AFSGD/XGP+JU60it0YNWQdTGPfnr50QxT8/W8wmBFXDK3hJLi5oo0qCbNqbBKaefLOB/XZ85CxyEpw==
X-Received: by 2002:aca:d905:: with SMTP id q5mr8365041oig.0.1545145134920;
        Tue, 18 Dec 2018 06:58:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r17sm7234955otn.0.2018.12.18.06.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:58:54 -0800 (PST)
Date:   Tue, 18 Dec 2018 08:58:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v3 01/15] dt-bindings: net: broadcom-bluetooth: Fix
 external clock names
Message-ID: <20181218145853.GA15352@bogus>
References: <20181217040449.31437-1-wens@csie.org>
 <20181217040449.31437-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217040449.31437-2-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 12:04:35 +0800, Chen-Yu Tsai wrote:
> The Broadcom Bluetooth controllers can take up to two external clocks:
> an external frequency reference, substituting the main crystal, and a
> LPO clock at 32.768 kHz substituting the internal LPO clock.
> 
> In particular, the external LPO clock must be used when the controller
> does not have NVRAM connected, and the main reference frequency is not
> the default 20 MHz. This is described in detail in the datasheet.
> 
> The original "extclk" clock name is ambiguous as to which of these it
> refers to, and some designs might even require both.
> 
> This patch deprecates the existing name, and adds "txco" and "lpo".
> 
> Tested-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
