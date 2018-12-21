Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A18C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4E621906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUmZvrYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbeLUJ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:28:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35634 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeLUJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:28:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so4949984wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qcv3hGekMrrz1HMShgZB7Giu9Ho0A86gysP8ygrJWYU=;
        b=kUmZvrYa3EVmifeNfcdAtX7HrDwStfauCVkduRBTmXjiYDsxAF2RwcKrDzadAUBfTp
         Apicf/gkAhH+v5s+Nzmkf4t4x7fozk/DaVsF82I2cwLGFz6lFuBdPquOIABDJUK4vfgw
         +EBxE+9Zpl8SWWYaIZ5xlSqy2O9GTTYc3CiQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qcv3hGekMrrz1HMShgZB7Giu9Ho0A86gysP8ygrJWYU=;
        b=PjsKkWjerjMDDcPcxfghSPewjM3cDecgqYw/OV3THO4QFtJlgnV6qwr3OIQeR8WkAr
         W6KThwqBUFxK2LTHPTISWJrCRQgqbdvy0HJIt+vKapUJwj1GqfdPPq8CNk8CHo4EVbUe
         71Kl+3yz1bgZg4yw+CDPJVvKYW2ahwyyJCNKLBl7bs2N3yHN1uOkfCz2jNfs3fdGT/5j
         BN/7nax7uMA3NpOW3p0owEWcQMOtvHspSiwmxXXlYd6xsSIVUPbvWNp89Jzza+rUUBn4
         DOubqOKY500gzjgR63ntcsEGaZfWoR7ni8u5tL/I0d0mwQ/tNnP8hOaOs2rNk+g+YstL
         mwaw==
X-Gm-Message-State: AJcUukc9ybBi70VTSCHtp9B0/IAOJZ005amwS0pgNfiW1vndVtw8lJ7d
        DXFou/v+1TOZpguuhJpqrsXQTg==
X-Google-Smtp-Source: AFSGD/XK/jV0Hl5+QL0jxYQ9gQD2ETIyI6Xab0dk9tjWTaYvqBsh3pV9wDvcZ8s55TGHyBNTytlrag==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr1891110wmd.151.1545384491226;
        Fri, 21 Dec 2018 01:28:11 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id g188sm8663497wmf.32.2018.12.21.01.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:28:10 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:28:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ingenic-tcu: Fix bit field description in header
Message-ID: <20181221092809.GE13248@dell>
References: <20181216141044.14465-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181216141044.14465-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018, Paul Cercueil wrote:

> The description of the bit was inverted.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  include/linux/mfd/ingenic-tcu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
