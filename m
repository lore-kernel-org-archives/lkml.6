Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4BSCCV7ZGFtiVgAAmS7hNA
	; Thu, 07 Jun 2018 07:07:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9D716607F7; Thu,  7 Jun 2018 07:07:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQ8ZWamU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6711F601B4;
	Thu,  7 Jun 2018 07:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6711F601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeFGHHV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:07:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40307 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeFGHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:07:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so16573189wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 00:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=idhQkjNmGULyH/Uasn1cQFRd32YsOGSResB/BzX8/G8=;
        b=TQ8ZWamUZ64aVtxpztASQNLsfHwlazeXe16BM1SAjlptyU2x/QpHlY+0lI08t2AbQ9
         tDqEzpOY5MFD34Hcy/VItPtD6HaOvQJurz9pwO1CS1d5f0+dxZ2cHpm7XjAEI1IRNwuu
         SIC9jTqVWZHeUNsJggL6LLITRpqORir+nWjQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=idhQkjNmGULyH/Uasn1cQFRd32YsOGSResB/BzX8/G8=;
        b=X8CECZkdI8XfjW/3wyde9cmEUsuE74KGZVi7mgSp0bm+hlkOpMcvLk2e/yoc0IGmdM
         wndHD76SPO60I+8oCCYHnNRqaZscHkW8lgwh+uc9rN67ZuzV5Syn4pBPvVvd0OlSmOy2
         TVqBEHrxAA61oLjYN1C5hrFquoJ7TG7q/rvAAMqkh7yqvA5sSRAuOoz2t9iH5ONBhTU7
         EllRkgmqeOv+854NxEPIMajMx5E6XgcYVyYAGFONxvTtNLbeIC/msa2E/P5r9fJLVZwB
         vlZBxvATVnlDtD78U8Tnk5bRDHHVInjDx1BfEzTxuBeSponepxKT2Hgk3AjZV+8Tx7ZY
         Bqqw==
X-Gm-Message-State: APt69E3qBgObrskBZkcUzsJqMEGCfw61+VCr3QyG9s+nITR4YBVCLxsG
        thS6iVLlpgdYgFTJpV9c5kfbDQ==
X-Google-Smtp-Source: ADUXVKJ7QBUcVnyrDds+JnJzgtiFyIhrWnFzaZc+qgTfiMVTid9vXwR1ZdAe62tQbV03ItIKt6Uw8g==
X-Received: by 2002:a1c:6d5a:: with SMTP id i87-v6mr687249wmc.12.1528355238620;
        Thu, 07 Jun 2018 00:07:18 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id u108-v6sm69275177wrc.40.2018.06.07.00.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 00:07:17 -0700 (PDT)
Date: Thu, 7 Jun 2018 08:07:16 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 02/14] mfd: da9063: Replace mfd_add_devices with devm
 counterpart
Message-ID: <20180607070715.GC22841@dell>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
 <20180606100003.17067-2-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180606100003.17067-2-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Marek Vasut wrote:

> Use devm_mfd_add_devices() instead of plain mfd_add_devices(), which
> removes the need for da9063_device_exit() altogether and also for the
> .remove callback in da9063-i2c.c .
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V5: New patch
> ---
>  drivers/mfd/da9063-core.c       | 11 +++--------
>  drivers/mfd/da9063-i2c.c        | 10 ----------
>  include/linux/mfd/da9063/core.h |  2 --
>  3 files changed, 3 insertions(+), 20 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
