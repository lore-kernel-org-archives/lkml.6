Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B851C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12C42083B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZqRkYJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfAYSek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:34:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53775 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:34:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so7716994wmb.3;
        Fri, 25 Jan 2019 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dIDecdtouYzpWpiq8dbSNtKgW3rXROqOp/FyJbgzR5w=;
        b=TZqRkYJ2FSdMj3PlLg51qaaMB53hitOzW+YSWqeG93n3V8hsBDPOONeJLTjR718HLo
         vX3acmX/0/LawA5i+lDF9agKgY6umDzRQcXKaSGWrVe0x7JYdQM3qaKyFhrP971qbgxK
         n0G0bgkYlYzCDqFCiew9KRKrPXm/KoBYDJ8ZmlVnNZcpyOUoV/HlaWQKeulcWoB+pi61
         4F0r5bidWRQNDq79uuP0ezGHF9Ywiu2l1OlzLXfWA1Ces0fz3SbkO7uLJqXVuJc3Dg1q
         tJCJiZAmJQXXtrsUj9qPqcwAOmsssL4xhwLCQVbwzte7TWyw5gPgN+8gwKkDOI/oKob6
         7pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dIDecdtouYzpWpiq8dbSNtKgW3rXROqOp/FyJbgzR5w=;
        b=oxvYSYs0PjvVNz3mTIhbT+/W0RBrZsrz1GQwgM5RYQIukflquoD2Fzbazln8HJaaZp
         dC0/ca0ZwzRlv3jJqdjakTJiCQTElff6USZ6ZSO0i4jdQf0ZXAx8kaPXJ5nsEgQwTFnX
         33HepdgZcwgACE59HWsNYC4VhGOrno3do9edKP1OMsSNCWQl7CoUHz37IJPBmtNwAVOI
         HT0fq5HF/98Yu3T4ODEMgwj3oAt1/Lc8tlh9JmwcBjn3OiLU5Nw/2NYI1++Dj1FsJLCn
         hZOh4SmiMFWa4cV/GZ4n19KEWmWJmsrs9I7k3hEGLlHegbj63pEXLCP8GPATfdB1KIDe
         9l/A==
X-Gm-Message-State: AJcUukdaNmsCnsGL3mZuh/HH322fZmmLUZko6lKhBep0RSnx+intFMF/
        i5PtlJ0Y88c5Z1pMVD8KnsuiDHym
X-Google-Smtp-Source: ALg8bN7R+GZ6CGWoH3hpBC/LHn0L3xJFITVhNa0c2AqofLIsJY6HP6fe763aVf0/mrlvgzafUlcj4Q==
X-Received: by 2002:a1c:4855:: with SMTP id v82mr7940629wma.15.1548441277577;
        Fri, 25 Jan 2019 10:34:37 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:fc07:c732:1a36:65ad? (p200300EA8BF1E200FC07C7321A3665AD.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:fc07:c732:1a36:65ad])
        by smtp.googlemail.com with ESMTPSA id o8sm103574787wrx.15.2019.01.25.10.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:34:37 -0800 (PST)
Subject: Re: [PATCH] r8169: Load MAC address from device tree if present
To:     Thierry Reding <thierry.reding@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190125101814.6262-1-thierry.reding@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <59aa73fd-9cdc-8db8-b58e-ed106b084637@gmail.com>
Date:   Fri, 25 Jan 2019 19:34:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125101814.6262-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.2019 11:18, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> If the system was booted using a device tree and if the device tree
> contains a MAC address, use it instead of reading one from the EEPROM.
> This is useful in situations where the EEPROM isn't properly programmed
> or where the firmware wants to override the existing MAC address.
> 
I rarely see DT-configured boards with RTL8168 network. Do you add this
patch because of a specific board?
And you state "if EEPROM isn't properly programmed": Did you come across
such a case?

In general the patch is fine with me, I just want to understand the
motivation. One further comment see inline.
As of today we already have the option to set a MAC from userspace
via ethtool.

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Based on net-next.
> 
>  drivers/net/ethernet/realtek/r8169.c | 35 +++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index f574b6b557f9..fd9edd643ca5 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -6957,6 +6957,21 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
>  }
>  
[...]
> @@ -7252,20 +7268,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	u64_stats_init(&tp->rx_stats.syncp);
>  	u64_stats_init(&tp->tx_stats.syncp);
>  
> -	/* Get MAC address */
> -	switch (tp->mac_version) {
> -		u8 mac_addr[ETH_ALEN] __aligned(4);
> -	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
> -	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
> -		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
> -		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
> +	/* get MAC address */
> +	if (eth_platform_get_mac_address(&pdev->dev, mac_addr))
> +		rtl_read_mac_address(tp, mac_addr);
> +
> +	if (is_valid_ether_addr(mac_addr))

Here array mac_addr may be uninitialized (if platform defines no MAC
and chip version is not covered by the switch statement).

> +		rtl_rar_set(tp, mac_addr);
>  
> -		if (is_valid_ether_addr(mac_addr))
> -			rtl_rar_set(tp, mac_addr);
> -		break;
> -	default:
> -		break;
> -	}
>  	for (i = 0; i < ETH_ALEN; i++)
>  		dev->dev_addr[i] = RTL_R8(tp, MAC0 + i);
>  
> 

