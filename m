Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A28C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEF3218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338435;
	bh=l3ZloFbSoe2vJ+DjaOhrNVuCevt1rhb0baa9ropRfE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b93aZMJE/00wMRZGHtDZKtIDxCOgkFF2+WJJC6MqqX3eyNeaaKO/s1fnUDS8FL5Va
	 DABiA50XTcHD3AaAJYP0wnqghePxSp8T2EMqO+e5hHoN5vc0LV4R6KUvS6uwbJ0cLG
	 +292uXdH6RhjxPWjaCslR+psRuhUjG+Tt6u/gYvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbeLTUke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:40:34 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41357 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeLTUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:40:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so3007728oii.8;
        Thu, 20 Dec 2018 12:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfhmO1hj2vbXiBo/1OfZ8BZdRsqQpvKXLsJnJyESkBQ=;
        b=eo8xW4kEai1DiuWYpt+cJY+PaWqeuTGTiHPkD2g16m8SavH+AhcBN0EglIjJdEeOmF
         wvBCGSPxwjPyvq1o7wWS3Y5AW/FUI5ayhV/SNASy2u1Nvxu9VFqdB26oa00jp5rMlKbA
         /zHa0zNyug1ZPmSq4IZMECds5FZgLhCE/+lWMUigzDNPfOYlkdxnqGuV8EpmJHqq39n7
         xbC1Y8MeBWSHWR5mXQlrs2x8Uv0CKBNto4oa5InrGxL0sMTBi7QYEhmMvM5MSbU9roIc
         P2zJ84P/EdgQqhMFoFxVhXp63PCx26Dd6n/zKnQrelJEKPGarBh2XAPcYrI7/tfDFyBm
         E9qg==
X-Gm-Message-State: AA+aEWZHoGjA7SpLE2AzG8rQxG4ATkd+DGes0pL29vkR6snUPNqUdMBp
        OCezIZLqpQ++eN8InlWa3g==
X-Google-Smtp-Source: AFSGD/X7mCbEIsEIi/PYR12XUYUEsGj+byfAtJguE6ndsV9owUK1jBvLgWNRHy8kwdoyKv3Zf5PG0A==
X-Received: by 2002:aca:fd4a:: with SMTP id b71mr166634oii.221.1545338432706;
        Thu, 20 Dec 2018 12:40:32 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id z18sm11305873otp.41.2018.12.20.12.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:40:32 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:40:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rcar-gen3-phy-usb2: Add r8a774c0 support
Message-ID: <20181220204030.GA25059@bogus>
References: <1544732481-6775-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732481-6775-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 20:21:21 +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
