Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111ACC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC6B21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545325834;
	bh=1BzKAz/DW4liteCDQyQxSIyO1B/flRWTeiXfIQ+MWWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0VRoMOH2Hl0k9ovqb/quKsidO8PiE4VfNv9MS09+KtD+ygekzzY6ipzfCxzWa/o64
	 pEJ4ZWXP03lIl+l/BpxJgHFTRRWAQtXTAVBPTiRibX+i2d6mHSFVS0pABov5ukkVYV
	 8hfGzfApAVGy3xq/fKfSVhA76rl6OuFLRtnY3jes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbeLTRKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:10:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34044 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbeLTRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:10:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id r62so2493492oie.1;
        Thu, 20 Dec 2018 09:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HYVqL1rnX5i6LFYIvmfDM81/LxERgYeHROl1Ao7LIto=;
        b=F+uBWeuXSl094YFVtv1s96O1F3GXiH0qFcs5CB0+uU9d2UKgbWui+gSeNa1KHS2jpu
         yi4G6tS5TGuE27e+Ep9z+uRufvvRfyMGAKriW7cRkn0hn0PAVVwnnvfnH452SJt8dcvA
         Mtis159gmy2T2YxzPp58FC4ZNinmETqss8bndq/qrv1sRVMXh6caYQSfLlFoK1oWFFeH
         PfA1URquPW3+EbRv7DpJu5oRzh8uuJbxx2WfB6fc5PdSZSFskdwRf//lo+yZPRpTEXoj
         4lgfWdA0OHAeoRXNlzRIC0j57+Oy+G9gogMNFe3AmOYpK17P0xrfZ6FSVarfXVfm0Wmo
         Pj4Q==
X-Gm-Message-State: AA+aEWbum460woS3jr62VSllnPPAGHiKwyR8XjZ8dtD230hcAp5H18Da
        2xs19q23+kIBDd/xUyKEEg==
X-Google-Smtp-Source: AFSGD/V0kjNEIh7KLoHA1uu3OnhckpRLLRzE0UjUVzQpP8bYzMPH4kGzt/ZHxURqnuoFdJwCu7Ng8g==
X-Received: by 2002:aca:5406:: with SMTP id i6mr3040242oib.344.1545325832642;
        Thu, 20 Dec 2018 09:10:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a201sm13399002oii.27.2018.12.20.09.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:10:32 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:10:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        simon@lineageos.org
Subject: Re: [PATCH 8/8] Input: dt-bindings: tm2-touchkey: Add support for
 aries touchkey
Message-ID: <20181220171031.GA22292@bogus>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207105811.1831-9-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207105811.1831-9-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Dec 2018 11:58:11 +0100, =?UTF-8?q?Pawe=C5=82=20Chmiel?= wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Document compatible for aries touchkey.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
