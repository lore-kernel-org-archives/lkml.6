Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1775C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6E820843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Sbf6GePx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6E820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeIDOh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:37:56 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:49057 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbeIDOhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U7Ubq8/Jyh1ey1rrtfl3/wN13GdA6sB1I92Q3y2e5rc=; b=Sbf6GePx8iqOUUD2LGL8qvFNQj
        E7eroxIT1jMNFyRrnU/kWHMQ3gELnxW0BzO4VMJG0n9ZRhN7vLAqK8yx+/hPbKUcrNv8xb7+DZQfb
        uW7CR08dKesA0O0uziLj5gJXac5zErxVNv0nY8UnXxuWSOE7J7vVtTEKwDuvsqVwnID6BoeuajXQ4
        dic/t1rdQ6WCRrGRtnGh6c4O752A44A1eEcdOh7jwO9Rb5ua0IEPqqy5w/INIfiaDOKF/FMSw2Qcd
        hKGPBgsEN4err+ZbS1n5++Je6xHTfcO8NZXML6Y4ofyNhKV8KfWTeWEgoLPc1sb+2rkZJhPTXxTE8
        65PSZrGg==;
Received: from [2001:708:30:1450:fc8b:6ffb:95c6:39ee] (helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <aapo.vienamo@iki.fi>)
        id 1fx8Kt-0002bl-IH; Tue, 04 Sep 2018 13:13:27 +0300
Date:   Tue, 4 Sep 2018 13:13:27 +0300
From:   Aapo Vienamo <aapo.vienamo@iki.fi>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] mmc: tegra: fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20180904131327.1cb5b7b5@iki.fi>
In-Reply-To: <20180904025909.13700-1-yuehaibing@huawei.com>
References: <20180904025909.13700-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:708:30:1450:fc8b:6ffb:95c6:39ee
X-SA-Exim-Mail-From: aapo.vienamo@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 10:59:09 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> Fix inconsistent IS_ERR and PTR_ERR in tegra_sdhci_init_pinctrl_info,
> the proper pointer to be passed as argument is 'pinctrl_state_1v8'
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Aapo Vienamo <aapo.vienamo@iki.fi>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e80716c..c789158 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -724,7 +724,7 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
>  		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
>  	if (IS_ERR(tegra_host->pinctrl_state_1v8)) {
>  		dev_warn(dev, "Missing 1.8V pad state, err: %ld\n",
> -			 PTR_ERR(tegra_host->pinctrl_state_3v3));
> +			 PTR_ERR(tegra_host->pinctrl_state_1v8));
>  		return -1;
>  	}
>  

