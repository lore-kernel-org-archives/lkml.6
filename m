Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B263CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8004221906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVk5GHCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbeLUJ1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:27:51 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40774 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeLUJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:27:51 -0500
Received: by mail-wr1-f48.google.com with SMTP id p4so4481131wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OimeRyiZm22nYIz6sAlZ0iDArgQfzAM04mHyqm9LWH8=;
        b=DVk5GHCzVbhJPIwxm7o9f4gWYSJa174fPgTsxRps6718D+hPdOuLH1medehg+VGhlj
         yEqDISGGD/QwLpjFunS2wD/CUoxRq8YhyFkkLrsLzU72gjBTKhYMX+alTSf7yc6NBgb2
         fo83y5nyTVgwWIKpNvN/YFAJ+PBvsR64Jp/r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OimeRyiZm22nYIz6sAlZ0iDArgQfzAM04mHyqm9LWH8=;
        b=IfWW1SafKz4tI4aNo4l+4KCc9a4DejAoWFeCH49YsjtVkEiDpx3BOVH3XPXV288GoK
         kFzKtfTVjbhh8FBAoLUsSgQ2acZxx6Wwa4x1u4jYSIIKy8KNKYTrpX9AZELCwcbm8WaJ
         DCcNk73lbJWvU7Y2bxOWIfGNzvYJ4OuRvoYMqVE+YNmAEV/wqkrxEV694Rce3L9X1ySW
         JUTivcCyLg7wItLBPCLZe7ZBhnupxxdaciyx5t+zr1N0mecvlHtTwxvY14qsU5+s4+J0
         ZFl3PqGTRc7KQFbCjVvWhNaaQoNTAFQbK4fjuFt6sWXr9u4HlDchSWtiSY46Pn8J0zah
         C91Q==
X-Gm-Message-State: AJcUukfi4N298bmgLSwPPC+w7nmYBB9iQIv8VYYCDTQNgYnjtYsVFDnz
        xxeoFGnFNDkLNABNifCYhCDpvsD16us=
X-Google-Smtp-Source: ALg8bN4Sui4JHvYc95/I2xB3Na0tHcaHSH7XPoaMKTvGzg65Bl+umVqfSj/RK+1vl7/sfHiRarb8gA==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr1718579wrq.265.1545384469241;
        Fri, 21 Dec 2018 01:27:49 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id h127sm13110940wmd.31.2018.12.21.01.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:27:48 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:27:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RESEND] mfd: rave-sp: fix typo in rave_sp_checksum comment
Message-ID: <20181221092747.GD13248@dell>
References: <20181215082918.26613-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181215082918.26613-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2018, Yangtao Li wrote:

> Caculated -> Calculated
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
