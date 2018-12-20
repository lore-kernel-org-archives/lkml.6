Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD04DC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A512070D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545341861;
	bh=uWsfD69ShqNdIisYZcoz5fd75sMgAUuIyEQXiDXb2yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0llaR0mtD9xlEVBItwnITMszlkH53OcrWM1i0S1JKwdoD0RCS5BsbckeVezxh/sIp
	 rfaq8FRArRmdUwff0oQVLdujGppi8LM5oXDbGaNeG748p9yPgaYc6327Wdm3rm6ipD
	 x2TxjFrG8W/BiKqRT7iLdQVDw7pIlmOuakcmYe3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbeLTVhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:37:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38500 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeLTVhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:37:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so3146283oii.5;
        Thu, 20 Dec 2018 13:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gbvNThyT64pYn4IIm/cn4nFNr9QjP3ZU05gDPrkLym0=;
        b=tFTUhFnOBkZTgMVm5TzkjHxeQf73Jd3Im1tNwWA56wrsKJ/GkH6F9DmEDtTUN2AksA
         bbhM9aPnXr4D+SO12FNG8YdUdEJzFvT2CKGxZIzJcagiEt/OauU+8/tCSf6mGYJ6ONWu
         jw74hSpkxAbUb/mVkz6weGiJxCeJK2vE/zMD3ArfFZTQzt+tqi1m/WfIW22N0HX+DmUW
         P1rlyF+cQT0Zo2q5iwQQo8o8EfEBjf+kdto4QpFqcifRu0Atq+YCZrq+kPv2F0oN//tq
         EjhgMQrTwIsknDg0AWUmElS6BSGt4S35tMR00R17sBEIM7tYyOxR1VbYuISgT1a0RTVO
         3qAw==
X-Gm-Message-State: AA+aEWaKp9wyptBn99Z9K50MhS3RR7W2DtTghE3qUc+mdTV60hLyFDEo
        8HvW20AKsl506Mj1SAJ82w==
X-Google-Smtp-Source: AFSGD/Uwn7+frecMmY+aLrX0P+YMRhbZnL9LwE0udLaXT3qWXnrtdD/VWdR/eAF19NHPXf4MItwhVw==
X-Received: by 2002:aca:ac3:: with SMTP id k64mr286268oiy.78.1545341858244;
        Thu, 20 Dec 2018 13:37:38 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id m3sm10405386ote.64.2018.12.20.13.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:37:37 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:37:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 01/15] clk: rockchip: add clock ids for dphy rx and tx
 channels on rk3368
Message-ID: <20181220213735.GA9546@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-2-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 13:36:36 +0100, Heiko Stuebner wrote:
> Add the clock ids so that they can be exported from the clock driver
> and referenced in the rk3368 devicetree.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  include/dt-bindings/clock/rk3368-cru.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
