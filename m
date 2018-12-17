Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80867C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382AF21783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545083235;
	bh=BQlG4idcvk74DJiaP400xmDfEV9KnuUeWxe2oYh5iQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FHBsmr7kLgp0GYQHYpP0qVFFpLMtQI1OXFVdZYQ0dgKEpVrd3s6GbltVoDeaaLa+O
	 9gKWGhryLDlVECS9l7fK1kn3e9p/t+r03ocT/cOVLcd1caOHC4R4v8M0SM0f6H5FaL
	 UgWl6pt7TctzTgTvHQTPHbLNBMUyg94eb/vzOqOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeLQVrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:47:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44763 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeLQVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:47:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so13640694otl.11;
        Mon, 17 Dec 2018 13:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ib9qiHNhZL9AeXkM3+47AftCyQ5QiM6o6bLEOe7SC6Y=;
        b=PE57MaKkwqhGyIMPhFcu0ZtiRvXufqsWget+aIzoUG2Ax7N3iEl0ykAELfzF5jv3pd
         jd/QBfiBvCRBWj0gO7RPMOdLQTewnLZXdykljFV8bERjD/nRNGAcs6iWlYTw7qTN0bbl
         2g8J6kUIs3NHNh4x8HekxB7PcoLJQszS7PzWEnIrjyolDBOcqu6DTa5xOiTRPgivvBg4
         9xjYMNPiWwCWStXCrZSsRkKF6l0WJbhYAXDi+L5Fc2jyeqU7q33s5Ma0sT8yzFbM+zdP
         QTXWIt7IDTbmwcDo5o+VmxSqB7nO5iHjYiNFHLpGGqbbEfcH1zXT7LZGNpT140xD3ybZ
         TpLA==
X-Gm-Message-State: AA+aEWZz7LA+1/zaytrAuwmGluKGc7dwcfddOcItsXgUGJbVjvl2UCK3
        FnSof700Hf+svqmdP33TWA==
X-Google-Smtp-Source: AFSGD/VSSHVNFPvYb3nHbZj3A0zHIRDNgl2S+GZMhIwl1cIXoaAiXbJ9g/01zqto6WIAMXoevkCSgw==
X-Received: by 2002:a9d:2da2:: with SMTP id g31mr11024456otb.310.1545083230873;
        Mon, 17 Dec 2018 13:47:10 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id c9sm6511548otp.24.2018.12.17.13.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:47:10 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:47:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        mark.rutland@arm.com, Ludovic.Desroches@microchip.com,
        Cristian.Birsan@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andrei.Stefanescu@microchip.com
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: atmel: describe SECUMOD usage
 as a  GPIO controller
Message-ID: <20181217214709.GA24782@bogus>
References: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544615784-29331-2-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544615784-29331-2-git-send-email-andrei.stefanescu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 11:57:11 +0000, <Andrei.Stefanescu@microchip.com> wrote:
> This patch describes the Security Module's usage as a GPIO
> controller for its PIOBU pins. These pins have the special
> property of maintaining their voltage during suspend-to-mem.
> 
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
