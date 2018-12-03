Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986DEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AD4214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvhyiJnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AD4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeLCLMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:12:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCLMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:12:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so11680163wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 03:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ktUki5kKJlm/XmPAGAnl3nsGbYvkH58XDa+bCIEGDSA=;
        b=dvhyiJnN79G36fOq8Jbr9jStyIkajdH+3jAxBehMDVZU2+6pAqozBohllEpwzpKkQE
         Xcgv+aVroch6dZkRG1pP0WUw07IZf49+bW2sHeLdDLRxyXcAOeeu80PkVZrkexY7Iyg8
         W8DlKRxVnmJEyGw6xr2I/RULiEViEQ6lqTxb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ktUki5kKJlm/XmPAGAnl3nsGbYvkH58XDa+bCIEGDSA=;
        b=Q3s0+oaXV4/M/o0CsO8uWEFNzEEn4QUueID5tl3HHH/vOVxWLvA4HPdVJswBC9nAE8
         zc9hPPTvM3PpAc6LHitF39RMoyeTOrKzjT7K6snCDOkd0VDaxwijo4cDqS/VFxGS6+yT
         FluNUfSYNPRtp12hNiM48Zn+UsvPLIJYRRjqzJtxWxYfe1G2utLQ5u2YtFQY/wBZxCNq
         YHfSHWTtOTfYjj+Fw7KQqXZGx0Vad6TId+UFe5H00CIDMShmTt2FW2/EGUZOxfASEusu
         9sStMn5IX7aRJj+k2Xt43IhjFI8nAde3FiXAcCbQqQRPlYr28Yvac95HjvHLGiwedKeL
         fwzQ==
X-Gm-Message-State: AA+aEWb8inLbjLz+rBDlewe16H3xfyJru2SWC/ZS4kltGC8bjgzWzWDS
        oldiErvNOZDcE4saul5CJnMrdg==
X-Google-Smtp-Source: AFSGD/UQgtjzPoIMAI5ke2+cdHd+peu67uwYD12+PDWb12nZdTkxGE29XUpFNaNaK2hNLZUAONzDiQ==
X-Received: by 2002:adf:b190:: with SMTP id q16mr13751325wra.95.1543835518902;
        Mon, 03 Dec 2018 03:11:58 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id 14sm14448771wmv.36.2018.12.03.03.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 03:11:58 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:11:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181203111156.GJ26661@dell>
References: <20181202021710.9307-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181202021710.9307-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Dec 2018, Yangtao Li wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/mfd/ab3100-core.c | 15 ++-------------
>  drivers/mfd/ab3100-otp.c  | 16 +++-------------
>  drivers/mfd/tps65010.c    | 14 ++------------
>  3 files changed, 7 insertions(+), 38 deletions(-)

Looks okay to me:

  For my own reference:
    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Linus,

  Anything to add?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
