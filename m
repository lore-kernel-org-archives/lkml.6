Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7DEC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCC420658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0v7a3ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCC420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbeJLAk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:40:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36769 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeJLAk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:40:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so10209097wmf.1;
        Thu, 11 Oct 2018 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wt6XDug3a2Whd2hPfLVPjkQJ6sRHiT5VPmB8S6YbAYo=;
        b=R0v7a3eyWNjbjP/u9UH+98TT0DNwARFtmv35O9JhecM+zrY16rfULjbIZh62EpPF3o
         HSeUlNrU4tpiStH8yjpa/o3kAm0SPODF7qkrkAe/h2mbD9fVWemcG/GT/JyU82Fa9380
         aVxvZeuzyJS2uBbH1wWdsxEv98rnkM0zAlNkuzovdyQcDY3BXb4aq4tXscknD5AlTlE8
         9GdAOT9PKjKpN9cNAziAAqDibcETfDECTwrLGP/EHLBSHDo+JGtT2fPzjwYjn69EtAi6
         otXn4DD0RWzjnQzWDbxrfaQDOjrAYUmpfpQfiLuM1WXOdIYoH5eOZTKfU/AkJqWfARxf
         JPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wt6XDug3a2Whd2hPfLVPjkQJ6sRHiT5VPmB8S6YbAYo=;
        b=CoenzA6sBN95TtzODneKlwd/8hqy6Gy0cx8WQW+29BWXaN2vrxbzBbeOd8P+Z6tiHJ
         5VBgerwF6+F7I20A3bagTXayE+HYmZ1EBUteXZKDy7MTN6Tjf4oRbqlZSuIvk+h02KHb
         jWZsYmKbH015bcZAfNLrj5oDwH8HYck4VHVfpHQtkX0SDaZXb3csYf8PSBHQAhHSkXjS
         I0XGt71WDk3vsUBGt3HBdXrUaWBoWLLmmVcdkhFe0SFPCraMptnU09uRUV2891a68974
         NXU5OFmW2zYIgZ/iLbT6N7pfQm05R5p36P8ljnUTIgHqdsmXNDEZVyKJNL6TYwVfqfXr
         rqGA==
X-Gm-Message-State: ABuFfohNeaCj6yrx0Or73duwAC1lh/EoNzQsSYzmtFhDWawgOTSlQS8P
        FHmATZpQtvCe1q51Po8QERM5YlH5DcA=
X-Google-Smtp-Source: ACcGV60cNETjr8Y81HaTf4ntKmJYmfwrn4gPUI7+29aCSEHTh7+ff4ruIlgdrB1PkK7vfVHr7x4/Ow==
X-Received: by 2002:a1c:be09:: with SMTP id o9-v6mr2493276wmf.109.1539277937296;
        Thu, 11 Oct 2018 10:12:17 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:25fe:afe7:c50d:f0b8? (p200300EA8BD43F0025FEAFE7C50DF0B8.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:25fe:afe7:c50d:f0b8])
        by smtp.googlemail.com with ESMTPSA id e196-v6sm16715522wmf.43.2018.10.11.10.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 10:12:16 -0700 (PDT)
Subject: Re: [PATCH] r8169: set RX_MULTI_EN bit in RxConfig for 8168F-family
 chips
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Clayton <chris2553@googlemail.com>
Cc:     Azat Khuzhin <a3at.mail@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <73ee1d68-2a27-aee9-d8b5-79ba3eda8187@maciej.szmigiero.name>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <b5b99886-0015-c13d-31a7-2901b827f48c@gmail.com>
Date:   Thu, 11 Oct 2018 19:12:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <73ee1d68-2a27-aee9-d8b5-79ba3eda8187@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2018 16:02, Maciej S. Szmigiero wrote:
> It has been reported that since
> commit 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
> at least RTL_GIGA_MAC_VER_38 NICs work erratically after a resume from
> suspend.
> The problem has been traced to a missing RX_MULTI_EN bit in the RxConfig
> register.
> We already set this bit for RTL_GIGA_MAC_VER_35 NICs of the same 8168F
> chip family so let's do it also for its other siblings: RTL_GIGA_MAC_VER_36
> and RTL_GIGA_MAC_VER_38.
> 
> Curiously, the NIC seems to work fine after a system boot without having
> this bit set as long as the system isn't suspended and resumed.
> 
> Fixes: 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
> Reported-by: Chris Clayton <chris2553@googlemail.com>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  drivers/net/ethernet/realtek/r8169.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 7d3f671e1bb3..b68e32186d67 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -4269,8 +4269,8 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>  		RTL_W32(tp, RxConfig, RX_FIFO_THRESH | RX_DMA_BURST);
>  		break;
>  	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
> -	case RTL_GIGA_MAC_VER_34:
> -	case RTL_GIGA_MAC_VER_35:
> +	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_36:
> +	case RTL_GIGA_MAC_VER_38:
>  		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST);
>  		break;
>  	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
> 
Patch should have been flagged as "net". Apart from that:
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
