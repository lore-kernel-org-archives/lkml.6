Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A682075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJTB35mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A682075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964947AbeFRTeS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:34:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46556 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964895AbeFRTeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:34:15 -0400
Received: by mail-wr0-f194.google.com with SMTP id v13-v6so18004917wrp.13;
        Mon, 18 Jun 2018 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t8SBAEFTWStrhmgkliod39nbJV0gGJeaPe9Ar8SJhsE=;
        b=EJTB35mLRzoB9yNrglMTjTUAAP6YfNKtyXvoZ33sYDolHw89B6v/TBiEi8psUblC26
         LX7CNVwi50x2b2TXK+l9T/IQTi0soeC6235gIdtygxWC3JDj4FyVTgiFln/Thl4B7XAh
         UieYvXa8XAUegp9vrv2oirj8DBCEsg9JBUzmfgEBsl5AKT/5d7wR87lxzJHn2DLwR4ZV
         k9ZdfEuLXpSMlaGWzSKr6q7DWrbWr3JU3aJPXb4IN2h4iA3aj2LgVDwFv5CuNzqiojwM
         3BtjsP1IrgI+2WtiC5+uwlufU3U2rWGDRHTPKM3w8X+zU3A8vAEhtYtgOJZQkhSnH3CQ
         NHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t8SBAEFTWStrhmgkliod39nbJV0gGJeaPe9Ar8SJhsE=;
        b=crlJItl5nZB2qY+WS53BK/VBenzLVS7QyHvNKkPtfOiP/jG7xov05jQ48bq6TRlwsI
         zablzG2cCW7MzT6uxBqA65f1xAs/2+THjHqAmQVb2mQ1XSQYPTQeB4coPTGTtyjA4QFc
         x2OMOgKUeJJo1Jyz5VCbxv9f1op2Sroyrvscoe823PBsw8hc76D+i1pLRsuRcL3kRFCl
         PxmKyCODYb9R9JEJOmc/efFn2J/qYZYaonNUFk7u9CrdS8ZhGobyXufAU4JlulOzPgmA
         VW8mzlc5Db/XQOZE2ATkjPZoBV7IIxcP4HXjvti0bzcJw8WLul4uS+m58H7JYLBeB4E1
         mAvA==
X-Gm-Message-State: APt69E1RfrpYuQfFdg5AQBAc7c0V2WAov5Cjy+MvNIVv5IQQLdYRb9rs
        Bh5UIBQKTD9/ZjHkSFrp9m7m5w==
X-Google-Smtp-Source: ADUXVKKjcjaatPI56BLVSHMYRl0ij/F53ZG3mM0L/wwR6ZdyhWg12MtRuUnKhCfdGQ/UG6EnFA5CiA==
X-Received: by 2002:adf:c907:: with SMTP id m7-v6mr12228640wrh.6.1529350453880;
        Mon, 18 Jun 2018 12:34:13 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:34c6:68cd:c855:dfee? (p200300EA8BD4D60034C668CDC855DFEE.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:34c6:68cd:c855:dfee])
        by smtp.googlemail.com with ESMTPSA id g11-v6sm15768455wrr.46.2018.06.18.12.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 12:34:12 -0700 (PDT)
Subject: Re: [PATCH net-next v3 2/2] r8169: Reinstate ASPM Support
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, davem@davemloft.net
Cc:     ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        romieu@fr.zoreil.com, bhelgaas@google.com,
        acelan.kao@canonical.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180615053219.14053-1-kai.heng.feng@canonical.com>
 <20180615053219.14053-2-kai.heng.feng@canonical.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <68ff8bbd-538a-e461-7862-2bf26dabc288@gmail.com>
Date:   Mon, 18 Jun 2018 21:33:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615053219.14053-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2018 07:32, Kai-Heng Feng wrote:
> On Intel Coffe Lake platforms, ASPM support in r8169 is the last missing
> puzzle to let CPU's Package C-State reaches PC8.
> Without ASPM support, the CPU cannot reach beyond PC3. PC8 can save
> additional ~3W in comparison with PC3 on my testing platform, Dell G3
> 3779.
> 
The patch itself looks good to me.
Still I think the commit message should be improved. Currently it sounds
like the patch affects Coffee Lake systems only. But disabled ASPM
prevents the system from reaching PC states beyond PC3 on more than
one platform. You just tested on Coffee Lake only.

And it would be good if you mention the RTL8168 chip version of
the system you tested on.

Finally one smaller remark below.

> This is based on the work from Chunhao Lin <hau@realtek.com>.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
> - Change commit message wording.
> - Rename the function to rtl_hw_aspm_clkreq_enable().
> 
> v2:
> - Remove module parameter.
> - Remove pci_disable_link_state().
> 
>  drivers/net/ethernet/realtek/r8169.c | 40 +++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 9b55ce513a36..269ac7561368 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -5289,6 +5289,17 @@ static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
>  	RTL_W8(tp, Config3, data);
>  }
>  
> +static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
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
> @@ -5645,9 +5656,9 @@ static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
>  	rtl_hw_start_8168g(tp);
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
> @@ -5680,9 +5691,9 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>  	rtl_hw_start_8168g(tp);
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
> @@ -5699,8 +5710,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
>  
>  	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
> @@ -5779,6 +5789,8 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
> +
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
> @@ -5830,11 +5842,12 @@ static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
>  
>  	rtl_hw_start_8168ep(tp);
> +
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
> @@ -5846,14 +5859,15 @@ static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
>  
>  	rtl_hw_start_8168ep(tp);
>  
>  	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
>  	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
> +
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
> @@ -5867,8 +5881,7 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>  	};
>  
>  	/* disable aspm and clock request before access ephy */
> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> +	rtl_hw_aspm_clkreq_enable(tp, false);
>  	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
>  
>  	rtl_hw_start_8168ep(tp);
> @@ -5888,6 +5901,8 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>  	data = r8168_mac_ocp_read(tp, 0xe860);
>  	data |= 0x0080;
>  	r8168_mac_ocp_write(tp, 0xe860, data);
> +
> +	rtl_hw_aspm_clkreq_enable(tp, true);
>  }
>  
>  static void rtl_hw_start_8168(struct rtl8169_private *tp)
> @@ -7646,7 +7661,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	mii->reg_num_mask = 0x1f;
>  	mii->supports_gmii = cfg->has_gmii;
>  
> -

This should go to patch 1.

>  	/* enable device (incl. PCI PM wakeup and hotplug setup) */
>  	rc = pcim_enable_device(pdev);
>  	if (rc < 0) {
> 

