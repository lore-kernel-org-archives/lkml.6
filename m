Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2842176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaGTN4xD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfBDSow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:44:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40254 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:44:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so970181wrt.7;
        Mon, 04 Feb 2019 10:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FHak4wYpOotsdst7BzOTo/udPkYFuXbz/Gx7k0NxduA=;
        b=RaGTN4xDxoqsORZ4BBwngBjLymljrq4ZW8dtOx+2GnkPl+BPuZ7lMJyfGGQ8Bk0xL5
         hJtLfLuVZvWuOCyYnfVkyB6jqN1F7LcduxR+MmAjNHsR2gNt+NGUMpC1hq2lxd/2OvBx
         dW2XYpCgRoduih481jPgSZKjwuqbspGgEsYXRNUtoVuVpFUohTVeetpWBETwWv/Dvi+7
         KuQaU+7ow1o5E51s1YS7enCFREFaFpKXVI7SY1HqgiS7emamFD2lof2oriJVpTtljxfh
         k3XBx9uU85MWL1pRYW3/fqI+OD910DXGU0posMutt3WcFwbQINQDGOlxbQPRvysOTyK9
         TNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FHak4wYpOotsdst7BzOTo/udPkYFuXbz/Gx7k0NxduA=;
        b=aLMq0pnWf0QDGwaCgDdsbn9mnkE14BcWawCOXWv+7h27pGzIPy3PWOY5ZQ5BEDJG3F
         /yvJuWkCWxZEZV87ftHJ9406N8nJxm5hbtBhfcdGYwg9OVLL9WFmW8rtAHpg/PIt4xuK
         vOGXnvNZjPch39E7IUQXlPzEbAK3O+blWM502bgqKsRrcmnoMnp3ZSg5n9Hma9CxbJBH
         5vngddlDJXdvIzJrxRddXP1QjCwyeZ2tlGtUapAf/3r2eQHeX0dFK9R8ULJ2yFFEW4o5
         VhYVvGHR2oi17c41LOfmpXhski01uNPmYALElfmcyPXrWe9kWRZs36ulqUGoq7EdmRaP
         59Ew==
X-Gm-Message-State: AHQUAuZWa5ZwDtaWokNH0JIGrQxZIhFwUUxsEk/6JgHRzbMu6mC4cn+K
        TPvHQi9n9T34zyie+byXjfBgWMqO
X-Google-Smtp-Source: AHgI3Iakpi5o8krZQrtau4pzlXCwe5G5e536tUr88CQhweQrcGuTCTnJjnaQmSVyk6dOFdfGeSakyg==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr591511wru.226.1549305889023;
        Mon, 04 Feb 2019 10:44:49 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:79d1:9f16:256f:82a8? (p200300EA8BF1E20079D19F16256F82A8.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:79d1:9f16:256f:82a8])
        by smtp.googlemail.com with ESMTPSA id h9sm4226347wrm.49.2019.02.04.10.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 10:44:48 -0800 (PST)
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
To:     Thierry Reding <thierry.reding@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190204164213.30727-1-thierry.reding@gmail.com>
 <20190204164213.30727-2-thierry.reding@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <80984ff5-b359-14ed-f617-2b92556c6e5a@gmail.com>
Date:   Mon, 4 Feb 2019 19:44:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204164213.30727-2-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.2019 17:42, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Read MAC address 32-bit at a time and manually extract the individual
> bytes. This avoids pointer aliasing and gives the compiler a better
> chance of optimizing the operation.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Applies to net-next.
> 
> I tested this on a Jetson TX2 with an add-in Realtek ethernet card that
> has a properly programmed OTP to verify that I got the endianess right.
> Seems like everything works and the device behaves the same with or
> without this patch.
> 
>  drivers/net/ethernet/realtek/r8169.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 501891be7c56..192fbb36bc9f 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -7113,12 +7113,21 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  static void rtl_read_mac_address(struct rtl8169_private *tp,
>  				 u8 mac_addr[ETH_ALEN])
>  {
> +	u32 value;
> +
>  	/* Get MAC address */
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_35 ... RTL_GIGA_MAC_VER_38:
>  	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
> -		*(u32 *)&mac_addr[0] = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
> -		*(u16 *)&mac_addr[4] = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
> +		value = rtl_eri_read(tp, 0xe0, ERIAR_EXGMAC);
> +		mac_addr[0] = (value >>  0) & 0xff;
> +		mac_addr[1] = (value >>  8) & 0xff;
> +		mac_addr[2] = (value >> 16) & 0xff;
> +		mac_addr[3] = (value >> 24) & 0xff;
> +
> +		value = rtl_eri_read(tp, 0xe4, ERIAR_EXGMAC);
> +		mac_addr[4] = (value >>  0) & 0xff;
> +		mac_addr[5] = (value >>  8) & 0xff;
>  		break;
>  	default:
>  		break;
> @@ -7316,7 +7325,7 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
> -	u8 mac_addr[ETH_ALEN] __aligned(4) = {};
> +	u8 mac_addr[ETH_ALEN] = {};
>  	struct rtl8169_private *tp;
>  	struct net_device *dev;
>  	int chipset, region, i;
> 
I just have one concern / question:

After this there's a call to is_valid_ether_addr(mac_addr) and kernel-doc of
is_valid_ether_addr() states that argument must be u16-aligned.
AFAIK that's not guaranteed for a byte array.

Heiner
