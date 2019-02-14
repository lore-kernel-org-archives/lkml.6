Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EFAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C472229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7YSI7RT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394952AbfBNJQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:16:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36732 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388784AbfBNJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:16:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so5620427wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AChgX3u3Rli6twGz1yDeQumcH7RThDK+xOVT4nhaEk0=;
        b=S7YSI7RT+QeFtmoWOc0H9M+zv+kJMxO0dN/OJefKd/4MAkbxvYwZ2mUHN0/pqOITzO
         /6PJkViy215KipNT9sPTsNr1Fu3jd55tockcdaxQXZ9bC4ctH2zmHNiB4doYUt9AsOrA
         SP9L24p19/ASbgn2eQkFAfn/3H4aUqWlSB7hDuvbDR37M4UNBc5KopNRYBhMErIpWO/H
         pVWgNuuHKEV7Z2NmBCxrhFaaH4WEh0fERz+V/TsXFC4JY9Y0Y34ZobgaMUbUtMqJrNDA
         FPrKfexQsN0bFoqBy4BK4XaDkiZfTPM6J8cJsFapSHoN10/s4YbbTXpeR+KXTvcfh4k0
         16MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AChgX3u3Rli6twGz1yDeQumcH7RThDK+xOVT4nhaEk0=;
        b=ChSTdxDy38Zl+ykP1iA/+tPMVIVaxAkpN/+PXb0GCXOYLpLeXBNQkQ8hzgPQ3nfRn1
         +8lxhcf8iU+rPBfMQzuoElxBNRbJPKvfy/VuAn2FwGKoquiOnaozPQEsCZJLa5GyuOxG
         KtIToLY22FWac9Aa8m8YvXkoSFHPbzVfK8M3aO/bL5/G4wmKwc93vCZVYAiajvXapjii
         Am0sttPr1GGgGZgSgZqe4h5WgiaZ3GnYJtAwReFUn8UJnDdkZaBYN0WrwtM29DR3M/Pp
         PSMTpmpXuY23CVSox+k1rrKdUKxkEVQiC0vpFn7Y3aKzq0BkvpvKZBLaBeM33oHTPoDQ
         oGFg==
X-Gm-Message-State: AHQUAuYapUJ8Rocl9FDmq4cqyu5grmxquS78H7iJZAPmQN/WCFBAVBFl
        aNkc6u6NKlGRCaW/8Ekq5fpjaw==
X-Google-Smtp-Source: AHgI3IYlx/M/oeBxbZiwZg7WFni1Q+g76oFfBJrj8fS3lwhC4EFx9lrwu3PXz7bRyMyHY0vk8Tbtxg==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr2078906wrs.2.1550135780206;
        Thu, 14 Feb 2019 01:16:20 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
        by smtp.gmail.com with ESMTPSA id h1sm2264525wmb.0.2019.02.14.01.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:16:19 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:16:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mfd: mxs-lradc: Mark expected switch fall-through
Message-ID: <20190214091617.GC13737@dell>
References: <20190211224827.GA28902@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211224827.GA28902@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/mfd/mxs-lradc.c: In function ‘mxs_lradc_probe’:
> drivers/mfd/mxs-lradc.c:179:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (lradc->soc == IMX28_LRADC) {
>        ^
> drivers/mfd/mxs-lradc.c:185:3: note: here
>    default:
>    ^~~~~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mfd/mxs-lradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
