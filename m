Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99859C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C89B21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545325761;
	bh=ysmEBpomKgrdUPz2dXuCl0+e6t29CEvzrvBkFlv6Ed0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zkghBnHoJ7GraGS7nQdzfJR8VwfZ423cH48ak2NYg07daxpW0acx+hanJvsezblGv
	 Z4kXBhzSxmA6llp/JIlmj2F0GjaTQgfMAlTbjtWw21dDo+FgbV8Ugmb7yihHXS8rbK
	 LRdUy1uwzMWC4Q8UvDilwak7KHUnNlL9/akSgoHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbeLTRJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:09:20 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33941 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbeLTRJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:09:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id r62so2490024oie.1;
        Thu, 20 Dec 2018 09:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DM1+p5yRQTyLXLHrKvh9pMuq5yjADHIIp09+SDVKodc=;
        b=ZUlQIHh1p7UFDdbAY2FecPHg0UsVL55ZCOR6+546x7XE7kFdsDpl0MPEQZtX6ZYhgv
         fC0It0SR87iWOE+4OWtZYj53LnQ1VHVeqFdlDOk4Wvl2yT3WhjhKz/dvJDMljDiICVGg
         L60U2xaFBmDIiZjiZUmQP75Z27umFwJO7+T7nW1Scuo3Ww9AJvqHVEehRzTvt5SwDdsI
         sHvpI6RuAAGpSlu+EPRSnPXJkNEPEkLcchUarhlwb+GjtNw0dnvkW8fGfu4tHU/VJ3Ha
         vN/Mou50EQaG2lVI96s4fdR05nxY6EmBqi03vpSBpYNhY+Jgi4JhEOzPurkTQRKDdf5G
         8sPQ==
X-Gm-Message-State: AA+aEWaI6Z7DtSEJebaz9qD+CPPLFhnnDk8UyGxa0FkMMbA0GZ9VIKIe
        o/sQEuF2Zp+D/NKgZ7JQ5Q==
X-Google-Smtp-Source: AFSGD/X6wJFJu3PVaX4erYmLaDBfLE+6ffhWR2DWp9gQz+yw+Ntt51/sdS6PT7u5HRXC1vejPNYX5g==
X-Received: by 2002:aca:490c:: with SMTP id w12mr3032411oia.8.1545325759264;
        Thu, 20 Dec 2018 09:09:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u18sm9975547otk.1.2018.12.20.09.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:09:18 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:09:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        simon@lineageos.org
Subject: Re: [PATCH 2/8] Input: dt-bindings: tm2-touchkey: Add support for
 midas touchkey
Message-ID: <20181220170918.GA20379@bogus>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207105811.1831-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207105811.1831-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Dec 2018 11:58:05 +0100, =?UTF-8?q?Pawe=C5=82=20Chmiel?= wrote:
> From: Simon Shields <simon@lineageos.org>
> 
> Document compatible for midas touchkey.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
