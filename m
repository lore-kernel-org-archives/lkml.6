Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E17DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A94020869
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQgLVrzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbeLUOwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:52:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50787 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbeLUOwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:52:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so5578613wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h7oPD4QRGURIfXCPY6d4YwKeIawezyIYFatQq00CU3Y=;
        b=gQgLVrzS6Lfd1vlXlJxE+U1SWqNktqoUn5yGuavAtvzU36/hY1Fs10VyUGgwWGqPwP
         HIJ50NdpnPGfgqm+pKYXehBry0QlwspAk4rOp9KC47G8WhPdb1JVCeUEMxnJH+UcMqR6
         kRfRSKMl4eEGnKp0M86ZdC8zOnvy1pz3Yavxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h7oPD4QRGURIfXCPY6d4YwKeIawezyIYFatQq00CU3Y=;
        b=XVeQRRIwHebv7B5XwaA7pHRB/+t8ktxPP8/8STQ23ZKrEOyGlg+dA0TutOrpw3Lkf/
         WdnB8rF6NeFghVFAlfAk0vLsxxEMkYXkrYy+7jW1rFwKglquYYyeDwsoGrbgfMl5Ujjz
         yCCau1V7HhNCANNqzrSjoe4TzWXy18pUUMMT7Bx2X9LPhArWn+ZWtJ/6GU7xdkGWE3vf
         Wb1B5+r0TqPwGJH9l/IWt65GJWJ7rIJKi74Ttt1TqKm69+8zYvKlPo382hmDp+oug+l4
         MDTV15zeurJ0eVRbXAj8+ijD448Ju+MvI9yUokH4Q25ebic0A5LhZ69IvloKRasj+P1m
         3YTg==
X-Gm-Message-State: AJcUukcxgNtHi26wxPyfA7sVQAOEJ/zlDMD1R6fmfN03tr3qN8BKHHVJ
        GqqA1eLvEJSjCIDkssYUTUij9Q==
X-Google-Smtp-Source: AFSGD/WOPa3kPTdjNFXtm33D9WKPYAotX/JerR+F9FpTCSsDkdUaAklWOIX1QzZH/ZNEX6/RgpN9Ew==
X-Received: by 2002:a1c:6489:: with SMTP id y131mr3131488wmb.34.1545403932685;
        Fri, 21 Dec 2018 06:52:12 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id 200sm11661342wmw.31.2018.12.21.06.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 06:52:11 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:52:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: mc13xxx: fix a missing check of a register-read
 failure
Message-ID: <20181221145210.GT13248@dell>
References: <20181220211211.32608-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181220211211.32608-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018, Kangjie Lu wrote:

> When mc13xxx_reg_read() fails, "old_adc0" is uninitialized and will
> contain random value. Further execution uses "old_adc0" even when
> mc13xxx_reg_read() fails.
> The fix checks the return value of mc13xxx_reg_read(), and exits
> the execution when it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/mfd/mc13xxx-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
