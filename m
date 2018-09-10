Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B39C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D10220645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CybI40Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D10220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeIJVhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:37:55 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41478 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbeIJVhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:37:54 -0400
Received: by mail-qt0-f195.google.com with SMTP id t39-v6so24883061qtc.8;
        Mon, 10 Sep 2018 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Irgma4mhRutaPYixkC3ayZlQJ8MAawtyfsn5Pt8jS8E=;
        b=CybI40Js4EguIn+MPJYX0if5aItzw+QXCm2thpHCQWHVYTiE3QYCMFtdtGdLGt7wfQ
         sWj2IuAvDkT6PV69AclgQtf6B9mXl3k38rGKh6b6FSy1DHOilaVGjxHdA1vU4Zq/JfGy
         0OvEBxPYeXcJc7ut7/nbBAkZ+G3gZARf6oilR5DDYM3A4/DUhjQb1w33YiQcEGdoWXXJ
         4876FlFGxFW69vejynUVWB/+IS9cO/TiVzAtHPqOWnsNZX3DE+CcYKLA9ZcIgUNgWmHH
         Te3wWuWEOghdnHsnw5AY3n6XWOXJUNxUYcBVcYaLNK/772U+1I0Ny0RgyJi3OfgMeEyo
         F6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Irgma4mhRutaPYixkC3ayZlQJ8MAawtyfsn5Pt8jS8E=;
        b=FI7QmqP84GOuDaoCvpwJS0dltTGYP9uM09CrBQOIlCIaG12u52AtBu6789VRndTBJq
         RhmWdmk1mRrAgFKoop2KhgSCN16Yp8D7P6T57pN8mfU6rMeOt9y/Gipgosj75VSqnjIv
         RQrvFL6zxR1xMETB9S7FTkscIiMbqQqQngZ3XhPzygmwCiG2jTjkRf9kPXKKOrzA3uFX
         yVXZFy9oltTT4bX9cTDIjMgDmaKYkPz4/OVTyddv0ze+NJDPPnKHV0MNsnP0HJsvIH6Z
         ugPnn7rd9dj5hqXMVuiOMoNEHGlhHmYQ7FhVX2/53ZHB2uluTOUk2yFFHGhRO+snuzwe
         vDXw==
X-Gm-Message-State: APzg51AhLGDx2aAZz1ndKB47X5QhZSHUG8M/u3OvG1C4wdk5XhCzGPua
        ssnZeEXr0/JdeDKdWUNGuQM=
X-Google-Smtp-Source: ANB0Vdb3nFes/lCCiNtoxBOkcc6/evmTS4WCmRebPE2qLWLl/6VOdG0jLLW1aYMITcECwjLc3oX4Kg==
X-Received: by 2002:a0c:d647:: with SMTP id e7-v6mr14791273qvj.238.1536597777500;
        Mon, 10 Sep 2018 09:42:57 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id g10-v6sm10737582qtk.86.2018.09.10.09.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 09:42:56 -0700 (PDT)
Subject: Re: [PATCH] r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing
 RTL_FLAG_TASK_ENABLED
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, nic_swsd@realtek.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20180910063436.2326-1-kai.heng.feng@canonical.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <9deed542-bfe7-1b4e-097e-a9f96a036a3c@gmail.com>
Date:   Mon, 10 Sep 2018 09:42:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910063436.2326-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 11:34 PM, Kai-Heng Feng wrote:
> After system suspend, sometimes the r8169 doesn't work when ethernet
> cable gets pluggued.
> 
> This issue happens because rtl_reset_work() doesn't get called from
> rtl8169_runtime_resume(), after system suspend.
> 
> In rtl_task(), RTL_FLAG_TASK_* only gets cleared if this condition is
> met:
> if (!netif_running(dev) ||
>     !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
>     ...
> 
> If RTL_FLAG_TASK_ENABLED was cleared during system suspend while
> RTL_FLAG_TASK_RESET_PENDING was set, the next rtl_schedule_task() won't
> schedule task as the flag is still there.
> 
> So in addition to clearing RTL_FLAG_TASK_ENABLED, also clears other
> flags.
> 
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/realtek/r8169.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index b08d51bf7a20..20593245ef53 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -6648,6 +6648,7 @@ static int rtl8169_close(struct net_device *dev)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  	struct pci_dev *pdev = tp->pci_dev;
> +	int i;
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  
> @@ -6655,7 +6656,9 @@ static int rtl8169_close(struct net_device *dev)
>  	rtl8169_update_counters(tp);
>  
>  	rtl_lock_work(tp);
> -	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
> +	/* Clear all task flags */
> +	for (i = 0; i < RTL_FLAG_MAX; i++)
> +		clear_bit(i, tp->wk.flags);

bitmap_zero(&tp->wk.,flagsm RTL_FLAG_MAX)

>  
>  	rtl8169_down(dev);
>  	rtl_unlock_work(tp);
> @@ -6828,6 +6831,7 @@ rtl8169_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>  static void rtl8169_net_suspend(struct net_device *dev)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
> +	int i;
>  
>  	if (!netif_running(dev))
>  		return;
> @@ -6838,7 +6842,10 @@ static void rtl8169_net_suspend(struct net_device *dev)
>  
>  	rtl_lock_work(tp);
>  	napi_disable(&tp->napi);
> -	clear_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags);
> +	/* Clear all task flags */
> +	for (i = 0; i < RTL_FLAG_MAX; i++)
> +		clear_bit(i, tp->wk.flags);

Likewise.

> +
>  	rtl_unlock_work(tp);
>  
>  	rtl_pll_power_down(tp);
> 


-- 
Florian
