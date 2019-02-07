Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CDAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC322081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3xZHURi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfBGUqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:46:23 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:41319 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBGUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:46:23 -0500
Received: by mail-lf1-f53.google.com with SMTP id e27so922355lfj.8;
        Thu, 07 Feb 2019 12:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8XqTDdy1nyL1cjqyV8sGNfLGR/fB83nxBQQQVGEOfw=;
        b=j3xZHURiaXCHWCXP8UwGHMOiEegL90kbZDN6AgeZlybsHQY+28jBL1iAcKzHAELIgw
         Y4tt7zQKE+pzW0Qq6PYEtKzbTuFyGd8tFyUJ5z/2V4zDNYcvVnJ7UxC0IAm6RQjeUqpK
         tftoyFMmBD/8sABEyNzu+ZNmh7JFC3NEuhLTsJoKcj79b+mHQ4tAZBio91pVovONQL/W
         oh0F0EkYN9XmWqLgmUEIUUEh6CwrwNaIZHFuSTt62661jD/xqXfmmNxDmysHLNYc4l8S
         sUghVSQKPIkK1svkMKSuZPeUuTrhuqi8jCK1yqELsDlbEC7CFxsxUmPnxDMEqVnpV/HR
         8qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8XqTDdy1nyL1cjqyV8sGNfLGR/fB83nxBQQQVGEOfw=;
        b=fPUUfEtC+P6isqMsPbnMl5ExGAvDyAly+r/PWoPJ6MSvQ3KZjBPgKTIEGH/92wMPnM
         JBZ97SoP5dWtV831YuTEQbxUGDz2tcyjdGyc1z5km4AsaDhJNZ7Sk54/uZyZTGOOJw0Q
         mk9ghia/e2onqUqXkip2Caa/XTCOGXsbgRCDbINca+mb8/5M2G7kbrehF2jaShYYLUty
         c7jitdubr7Y5Km7vbUcJae3i1FAJZd3uBF6inPjoVS+Djh8nh4tVnDDABiOKiv03uBH8
         pbuGad3TPBdA7EoH/QGKvYyDCUv7oahFQDfTQxp1q3iSPLgQyASKjR/VLXbQE6xX2NHT
         Vwfw==
X-Gm-Message-State: AHQUAuYnZTNXHw7feGqRpPB+vrpzj5AGknN2NOBXPswXjuuQzAzlcWc0
        mmZi65IZd/X1P9CJkeno19l6sj4I
X-Google-Smtp-Source: AHgI3IYLphtpcPn9XMxdKvRFmQNXUqQh27jHe0TN4MfBdk1JioFHbKOkCHKbUj/HNLjNIBlYEK5s9w==
X-Received: by 2002:a19:5901:: with SMTP id n1mr11252537lfb.125.1549572380298;
        Thu, 07 Feb 2019 12:46:20 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id 18-v6sm4428277ljg.83.2019.02.07.12.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 12:46:19 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <59f39ee7-c7da-52ea-cc67-52c5af879c35@gmail.com>
Date:   Thu, 7 Feb 2019 23:46:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 22:16, Sowjanya Komatineni пишет:
> +	if (!i2c_dev->msg_read) {
> +		if (dma) {
> +			memcpy(buffer, msg->buf, msg->len);
> +			dma_sync_single_for_device(i2c_dev->dev,
> +						   i2c_dev->dma_phys,
> +						   xfer_size,
> +						   DMA_TO_DEVICE);
> +			err = tegra_i2c_dma_submit(i2c_dev, xfer_size);
> +			if (err < 0) {
> +				dev_err(i2c_dev->dev,
> +					"starting TX DMA failed, err %d\n",
> +					err);
> +				goto unlock;
> +			}
> +

This newline is not really needed here.

> +		} else {
> +			tegra_i2c_fill_tx_fifo(i2c_dev);
> +		}
> +	}

That's my last comment for v14. Looking forward for v15!
