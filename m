Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA6BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2B72083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkQAPM2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2B72083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeIAHwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 03:52:33 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41114 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeIAHwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 03:52:33 -0400
Received: by mail-ua1-f67.google.com with SMTP id h1-v6so9641678uao.8;
        Fri, 31 Aug 2018 20:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wnEG1m0w1HiIwuoawvbRJ+U76DGKb8Fx/P2wXviQSw=;
        b=RkQAPM2qfgh/Um5A0gE+ZKfEPsNg6bZy8uQdKLIGIF/VklSOXHR4S+eQfmByPz8hFX
         PdHQW90Oy/pEWEGrzd06iISICdo7D98EvzMkdMN6aS6Cz1Gw9Sv4V+GVBMNxHwkt+Xvj
         dTzb/FHEnxaDK3NXbNyUkWyvKn2/+D0utrk51cugmoxf+hTZryEC1Bvpds0kgVsriDP8
         WKisr/meKI/F1kIPfwsXmYKSiilOZoZgeBNSdUj/7U3iOiuQan3Ae9NF3Geq/gnT2Nap
         Jwos2bm2FsqrAtdCBmZmIqMPaw0t7yAA13RpNUugNXdhIglbDPECfWOSQMjHdOgrlHdw
         Z/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wnEG1m0w1HiIwuoawvbRJ+U76DGKb8Fx/P2wXviQSw=;
        b=cjU0ys0SdA3GHvgIKPJ/YwFzCQP6oEnDaroUQ9xYwyNyiHbX2EhxByvJD98aXCnpR7
         yJdNnUAH/2rH/lftkv5tYT7/EzmNyRbzOfU4ERtMg5lM8EaDMHO4O184qVjbkm+SfIVM
         KDeKFusjeGAbgA+q+iIfuQtUCvJnh2l6/i++ZwvTs9r1XLuQANVLGeZZQ8u8C5g94OU/
         2CX3sbcAXR7ybsp0JuYCZkAtcH4qQf86ufV2OX46B9HKLbk50HUs+NA4oTF/kqvpLBxy
         9rPge4m0zYX1gSiMbi6TYp8x428tOgLM5Q0xwAluXcWvCkgN2jIjbTpVKGuVWmLojksz
         VuCA==
X-Gm-Message-State: APzg51A916FGwf3KZO2r10APTGd+RO+/KsT0LE+EvfXINKAitkANpT5o
        ec5GfViTSh4VgEc33dzmh/Pgd+AX9JfUNPzwPI4=
X-Google-Smtp-Source: ANB0VdaAcKoMZTzFr1w7Fazra1XJ4AUtriGh+l9BuPqgrhRnQzNL64kFSI7TB2073Xeg/5NxORB6ig7QBbO2+U1rNfQ=
X-Received: by 2002:a9f:3e87:: with SMTP id x7-v6mr11395922uai.53.1535773326077;
 Fri, 31 Aug 2018 20:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180831111325.16984-1-yuehaibing@huawei.com>
In-Reply-To: <20180831111325.16984-1-yuehaibing@huawei.com>
From:   Siva Rebbagondla <siva8118@gmail.com>
Date:   Sat, 1 Sep 2018 09:11:53 +0530
Message-ID: <CANGSkXTDOa-TCz2wbNh7=C9px4_T7besT6jBPzfs70kVoK+PtA@mail.gmail.com>
Subject: Re: [PATCH v2] rsi: remove set but not used variable 'header_size'
To:     yuehaibing@huawei.com
Cc:     Kalle Valo <kvalo@codeaurora.org>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Amit karwar <amit.karwar@redpinesignals.com>,
        pavani.muthyala@redpinesignals.com, keescook@chromium.org,
        Linux Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 4:45 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/net/wireless/rsi/rsi_91x_hal.c: In function 'rsi_send_data_pkt':
> drivers/net/wireless/rsi/rsi_91x_hal.c:288:5: warning:
>  variable 'header_size' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: remove unused 'tx_params'
> ---
>  drivers/net/wireless/rsi/rsi_91x_hal.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
> index 01edf96..182b066 100644
> --- a/drivers/net/wireless/rsi/rsi_91x_hal.c
> +++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
> @@ -282,10 +282,8 @@ int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
>         struct rsi_hw *adapter = common->priv;
>         struct ieee80211_vif *vif;
>         struct ieee80211_tx_info *info;
> -       struct skb_info *tx_params;
>         struct ieee80211_bss_conf *bss;
>         int status = -EINVAL;
> -       u8 header_size;
>
>         if (!skb)
>                 return 0;
> @@ -297,8 +295,6 @@ int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
>                 goto err;
>         vif = info->control.vif;
>         bss = &vif->bss_conf;
> -       tx_params = (struct skb_info *)info->driver_data;
> -       header_size = tx_params->internal_hdr_size;
Yes, These redundant variables shall be removed.
>
>         if (((vif->type == NL80211_IFTYPE_STATION) ||
>              (vif->type == NL80211_IFTYPE_P2P_CLIENT)) &&
> --
> 2.7.0
>
>
Also, Patch title also can be changed to "[v2] rsi: remove unused variables"

Thanks,
Siva Rebbagondla
