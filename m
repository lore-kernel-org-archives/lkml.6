Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A710FC07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A39F20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A39F20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933947AbeFMC71 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 22:59:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51857 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933611AbeFMC7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 22:59:25 -0400
Received: from mail-pg0-f71.google.com ([74.125.83.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fSw0K-0004I2-Kl
        for linux-kernel@vger.kernel.org; Wed, 13 Jun 2018 02:59:24 +0000
Received: by mail-pg0-f71.google.com with SMTP id o19-v6so355707pgn.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 19:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lvy+GqFzPAD6sTQbAm5Ck/FzBvFoeVnRQmoMyyb04Bs=;
        b=Bx8b+EQ7+5lW7X0/wKsxwBOOatek7Wj9fxx2e0EyJ2ieg5HOdhvHpnC3jWNzwKNPO8
         OwXzZiojYtNKClYvI1GUdkjgjTZ0rlw638ZAXSQ/K2TnTDG1s1HudjNo9rD9wSb4vpqo
         E8XIIJM0o9lzqEFWSs/vijAYPdr3eWSQ0L9RIZcZFH0MM1Z7vmciiPUeLEjpF1YLjE/a
         rPfZPgb9XIl1tRw0yxqm7Hw/Zna5FSh25vihQ1hGmQ9w45CRJRcSvs6itaIgj1BZFrw0
         /Ukg5CMK2rEi0ASK+Ko52/Y2Q65y31A/Lb5V7djqPf1ohCLBtrKgxGWYD5u6jsaTzzEE
         CD2g==
X-Gm-Message-State: APt69E3wX51PVzCjRkJEZIwc6N/TRe2U3MAUkVMyOZeM0qn45sgUebLo
        6KqpleajsGoxqBUQNE7d4Hic2uST1wUINOUpiUiOS8imjs/G9xBBVyQhWMxRKH8uqzB4jfEGZxk
        xZA2kEfsibXqXhsBK/CMUHkQOb6f8YEzQ7OtxDmw6Zg==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5-v6mr3235360plb.30.1528858762984;
        Tue, 12 Jun 2018 19:59:22 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKIZgcm6pU8g9Oq+CAQOeRTjTlh4KALJY3ElEJq2r1Q1BWHL0MKj8TuJBczS2+tAtSu/qpSexg==
X-Received: by 2002:a17:902:8b85:: with SMTP id ay5-v6mr3235341plb.30.1528858762739;
        Tue, 12 Jun 2018 19:59:22 -0700 (PDT)
Received: from [10.101.46.95] ([175.41.48.77])
        by smtp.gmail.com with ESMTPSA id l71-v6sm1830744pge.8.2018.06.12.19.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 19:59:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH 2/2] r8169: Reinstate ASPM Support
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <30b033ec-2ac3-6470-be43-06044f87b81d@gmail.com>
Date:   Wed, 13 Jun 2018 10:59:17 +0800
Cc:     davem@davemloft.net, ryankao@realtek.com, hayeswang@realtek.com,
        hau@realtek.com, romieu@fr.zoreil.com, bhelgaas@google.com,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A4FEE5F1-9548-44B9-BE11-4D3A6A463959@canonical.com>
References: <20180612095759.6828-1-kai.heng.feng@canonical.com>
 <20180612095759.6828-2-kai.heng.feng@canonical.com>
 <30b033ec-2ac3-6470-be43-06044f87b81d@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

> On Jun 13, 2018, at 3:35 AM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 12.06.2018 11:57, Kai-Heng Feng wrote:
>> On newer Intel platforms, ASPM support in r8169 is the last missing
>> puzzle to let Package C-State achieves PC8. Without ASPM support, the
>> deepest Package C-State can hit is PC3.
>> PC8 can save additional ~3W in comparison with PC3 on my testing
>> platform.
> Maybe we should replace PC8 with "beyond PC3". My system
> (Haswell 2961Y) reaches 50% PC7 + 5% PC9 + 45% PC10 now.
> It never seems to use PC8.

My original wording are really mouthful. I'll update them in next version.

The platform in question is Coffee Lake. This patch should make systems  
newer than Skylake to hit > PC3. Older systems may not see significant  
change.
I'll also state these info in the next version.

>
>> The original patch is from Realtek.
> Please add a link to this original patch.

Realtek sent me the patch privately. Is it okay to upload the patch to  
pastebin or gist?

Kai-Heng

>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - Remove module parameter.
>> - Remove pci_disable_link_state().
>>
>>  drivers/net/ethernet/realtek/r8169.c | 41 +++++++++++++++++++---------
>>  1 file changed, 28 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169.c  
>> b/drivers/net/ethernet/realtek/r8169.c
>> index 9b55ce513a36..85f4e746b040 100644
>> --- a/drivers/net/ethernet/realtek/r8169.c
>> +++ b/drivers/net/ethernet/realtek/r8169.c
>> @@ -5289,6 +5289,18 @@ static void rtl_pcie_state_l2l3_enable(struct  
>> rtl8169_private *tp, bool enable)
>>  	RTL_W8(tp, Config3, data);
>>  }
>>
>> +static void rtl_hw_internal_aspm_clkreq_enable(struct rtl8169_private  
>> *tp,
>> +					       bool enable)
>
> Do we need this hw_internal in the function name?
>
>> +{
>> +	if (enable) {
>> +		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
>> +		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
>> +	} else {
>> +		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
>> +		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
>> +	}
>> +}
>> +
>>  static void rtl_hw_start_8168bb(struct rtl8169_private *tp)
>>  {
>>  	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
>> @@ -5645,9 +5657,9 @@ static void rtl_hw_start_8168g_1(struct  
>> rtl8169_private *tp)
>>  	rtl_hw_start_8168g(tp);
>>
>>  	/* disable aspm and clock request before access ephy */
>> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
>> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>>  	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>>  }
>>
>>  static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
>> @@ -5680,9 +5692,9 @@ static void rtl_hw_start_8411_2(struct  
>> rtl8169_private *tp)
>>  	rtl_hw_start_8168g(tp);
>>
>>  	/* disable aspm and clock request before access ephy */
>> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
>> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>>  	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>>  }
>>
>>  static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>> @@ -5699,8 +5711,7 @@ static void rtl_hw_start_8168h_1(struct  
>> rtl8169_private *tp)
>>  	};
>>
>>  	/* disable aspm and clock request before access ephy */
>> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
>> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>>  	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
>>
>>  	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
>> @@ -5779,6 +5790,8 @@ static void rtl_hw_start_8168h_1(struct  
>> rtl8169_private *tp)
>>  	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
>>  	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
>>  	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
>> +
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>>  }
>>
>>  static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
>> @@ -5830,11 +5843,12 @@ static void rtl_hw_start_8168ep_1(struct  
>> rtl8169_private *tp)
>>  	};
>>
>>  	/* disable aspm and clock request before access ephy */
>> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
>> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>>  	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
>>
>>  	rtl_hw_start_8168ep(tp);
>> +
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>>  }
>>
>>  static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
>> @@ -5846,14 +5860,15 @@ static void rtl_hw_start_8168ep_2(struct  
>> rtl8169_private *tp)
>>  	};
>>
>>  	/* disable aspm and clock request before access ephy */
>> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
>> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>>  	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
>>
>>  	rtl_hw_start_8168ep(tp);
>>
>>  	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
>>  	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
>> +
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>>  }
>>
>>  static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>> @@ -5867,8 +5882,7 @@ static void rtl_hw_start_8168ep_3(struct  
>> rtl8169_private *tp)
>>  	};
>>
>>  	/* disable aspm and clock request before access ephy */
>> -	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
>> -	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, false);
>>  	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
>>
>>  	rtl_hw_start_8168ep(tp);
>> @@ -5888,6 +5902,8 @@ static void rtl_hw_start_8168ep_3(struct  
>> rtl8169_private *tp)
>>  	data = r8168_mac_ocp_read(tp, 0xe860);
>>  	data |= 0x0080;
>>  	r8168_mac_ocp_write(tp, 0xe860, data);
>> +
>> +	rtl_hw_internal_aspm_clkreq_enable(tp, true);
>>  }
>>
>>  static void rtl_hw_start_8168(struct rtl8169_private *tp)
>> @@ -7646,7 +7662,6 @@ static int rtl_init_one(struct pci_dev *pdev,  
>> const struct pci_device_id *ent)
>>  	mii->reg_num_mask = 0x1f;
>>  	mii->supports_gmii = cfg->has_gmii;
>>
>> -
>>  	/* enable device (incl. PCI PM wakeup and hotplug setup) */
>>  	rc = pcim_enable_device(pdev);
>>  	if (rc < 0) {
