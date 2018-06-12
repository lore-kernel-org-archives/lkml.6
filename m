Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E27DBC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F03E2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNcLNbG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F03E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933700AbeFLTgJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:36:09 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43841 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933029AbeFLTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:35:59 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so145502wrm.10;
        Tue, 12 Jun 2018 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gJVtxyrqGdLlBUhqwqeBF+lmhfgz7+sbowKGMmxIhIg=;
        b=GNcLNbG2jKKuyT2AxAacr7XDCuKaII/h/bb+GYodzk5GTSQOINwNyffc7zK2cfM3qK
         ZBasZzwgtrdsgFZOuNqRnkjMfGp6DCmiTyYTEAxUjNXzarQ5EjO9BHJrIhBbnNBanda8
         X7F6uFEdtLlOu97A6NDz0VI827hgeEcQVY9WWqvXJ9AzCY3qRHK4c+yrfufzXrecCnPP
         HkdTJtveDzl9HtfUbsMVOz4pRs8bgHuooLozrjfvJbDm+8pep4YFAjEtn/o2O8uOuCpF
         L0c3ODVi1j6bzA4AyBvxRNGzxPKJorLWjek88E2JoQqnbHRnQ92WivCKxKNaZ+m63K7o
         5n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gJVtxyrqGdLlBUhqwqeBF+lmhfgz7+sbowKGMmxIhIg=;
        b=cd04w/jRi9nL+7Vjvk3/tTbHg6725rhfcid44u5yO2oxurjmJDVNkI6wY1pWTktldY
         2ieVeyqRNV/XJK+DTADP1dhiuy0F3XQJUdFQR5LoyTNCH12SO4kS0u0V7HeHz0ts5MMM
         3iu26SkcM5pJk0RsL8d0EJm//ZiassEFDoKUzyHERJ56JQ7s1SjHtZUY+kBGHOntDYq6
         bdvBorDnk8PEQCN2xTdxePqTmQJjD7BU76QAKug+6CIL7P9+astIKDT6MJtvkq1tr+5T
         lK74DzMqu8hmfxWBAvC2+uV690chW/PIdOpjS6zsFX2DTD0AGqM0fmHGQlagxcg2kcET
         /Rrw==
X-Gm-Message-State: APt69E371uosHIem1FUOai+/zpEj4HCuwZoME4DopGkpZWa4d4/dS9OP
        OoaPSmhcYub8K4V2AKHnrd0u7A==
X-Google-Smtp-Source: ADUXVKLy6QfvkpIGXwJTeQeRXkXzZ2JRUNtd1udGfCYkKVl8OksGXsq4ZQxLQeHYNT++advzjbXF7Q==
X-Received: by 2002:a5d:4503:: with SMTP id s3-v6mr1588716wrq.191.1528832157543;
        Tue, 12 Jun 2018 12:35:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:bd18:6b21:eca7:82b0? (p200300EA8BD4D600BD186B21ECA782B0.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:bd18:6b21:eca7:82b0])
        by smtp.googlemail.com with ESMTPSA id u11-v6sm755558wrq.68.2018.06.12.12.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 12:35:56 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/2] r8169: Reinstate ASPM Support
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, davem@davemloft.net
Cc:     ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        romieu@fr.zoreil.com, bhelgaas@google.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180612095759.6828-1-kai.heng.feng@canonical.com>
 <20180612095759.6828-2-kai.heng.feng@canonical.com>
Message-ID: <30b033ec-2ac3-6470-be43-06044f87b81d@gmail.com>
Date:   Tue, 12 Jun 2018 21:35:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612095759.6828-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.2018 11:57, Kai-Heng Feng wrote:
> On newer Intel platforms, ASPM support in r8169 is the last missing
> puzzle to let Package C-State achieves PC8. Without ASPM support, the
> deepest Package C-State can hit is PC3.
> PC8 can save additional ~3W in comparison with PC3 on my testing
> platform.
> 
Maybe we should replace PC8 with "beyond PC3". My system
(Haswell 2961Y) reaches 50% PC7 + 5% PC9 + 45% PC10 now.
It never seems to use PC8.

> The original patch is from Realtek.
> 
Please add a link to this original patch.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Remove module parameter.
> - Remove pci_disable_link_state().
> 
>  drivers/net/ethernet/realtek/r8169.c | 41 +++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 9b55ce513a36..85f4e746b040 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -5289,6 +5289,18 @@ static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
>  	RTL_W8(tp, Config3, data);
>  }
>  
> +static void rtl_hw_internal_aspm_clkreq_enable(struct rtl8169_private *tp,
> +					       bool enable)

Do we need this hw_internal in the function name?

> +{
> +	if (enable) {
> +		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
> +		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
> +	} else {
> +		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> +		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	}
> +}
> +
>  static void rtl_hw_start_8168bb(struct rtl8169_private *tp)
>  {
>  	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
> @@ -5645,9 +5657,9 @@ static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
>  	rtl_hw_start_8168g(tp);
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
> @@ -5680,9 +5692,9 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>  	rtl_hw_start_8168g(tp);
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
> @@ -5699,8 +5711,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
>  
>  	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
> @@ -5779,6 +5790,8 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
> +
> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
> @@ -5830,11 +5843,12 @@ static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
>  
>  	rtl_hw_start_8168ep(tp);
> +
> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
> @@ -5846,14 +5860,15 @@ static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
>  
>  	rtl_hw_start_8168ep(tp);
>  
>  	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
>  	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
> +
> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
> @@ -5867,8 +5882,7 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
>  
>  	rtl_hw_start_8168ep(tp);
> @@ -5888,6 +5902,8 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>  	data = r8168_mac_ocp_read(tp, 0xe860);
>  	data |= 0x0080;
>  	r8168_mac_ocp_write(tp, 0xe860, data);
> +
> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168(struct rtl8169_private *tp)
> @@ -7646,7 +7662,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	mii->reg_num_mask = 0x1f;
>  	mii->supports_gmii = cfg->has_gmii;
>  
> -
>  	/* enable device (incl. PCI PM wakeup and hotplug setup) */
>  	rc = pcim_enable_device(pdev);
>  	if (rc < 0) {
> 

