Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A88C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B515020880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlgERkO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B515020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeIZDNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:13:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35500 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZDNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:13:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id o16so11457348wrx.2;
        Tue, 25 Sep 2018 14:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C23dZ4xgoBfWAE190endL96azTkCcUaUXZQuWQ7hXYg=;
        b=VlgERkO4o+u+Uo6N1kUTDY+9afeFMRtKNrvv6Zykd7cQ7xdkRoViyP//m8eQqULPFU
         A7tMQFnujnX/sGrwNiD/jvw3yqAIOtTflnckIZNZ4wnrywltLX0aIk/+7bYciLmoBZXl
         1J3WndcDOBOXqRFZ219rp+VYw1R08DGTP5uPxhTuhlgS+QbmZIxuuuXqLG9wXEt3WVHG
         6V2xtiU0IzqLtufXZ8VpQtsGjhtzzxaDQCfyzAPJz94VQj0KO0cE45Pzk+eTNh9lY6vh
         TDWLA8BoTA+PtTCz46AGcw0WNUuyvuRbpJYXBvsZi1tOZSpuB6JOVSYiIgqATqq1MYT5
         uaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C23dZ4xgoBfWAE190endL96azTkCcUaUXZQuWQ7hXYg=;
        b=Tg4jf73ug+deJRxr3GCKg45pghlLhqswVhbR/d9vORyUDGmHcF9YiUliAYxm1Rziv3
         OgdCmYH39HyJmyUQaVumSL8GZYZcsWQOWfGUSTP8ybSr+UZPOx6XIPgV1/Q+sKRbdmEU
         uxujbV/tYnYqm/+dFrQTDZMpvUVCLalH9i/8UkO8rQnceV0R7DQE7nemt3ILzKmMercH
         /bOIhtRTWV1EoTd2NMCxYPdaLP2F6mt77iFIWKEOQltVOkfAp0KBMQu8TURrkod8oMEt
         dLHBCWP5OxqH/1WMic3w587rFl66/iYe0VpQq1AMj+0imnEDlXlK2a2wluSQVLlHjE8v
         UMlA==
X-Gm-Message-State: ABuFfogqfUpNVjPKhhXOw3Fh4X0iBao0FMvNWtusB7i0z3tZq6+8v8DZ
        1vydL7X/y/NfvwcieyXOjushVF2k+zo=
X-Google-Smtp-Source: ACcGV60GutlvYgWp2bttzlObxv8BMfMeJUBkari0iZB0HrnsWEeJx7muLlV4oXnIMmV8JaGERvXx3w==
X-Received: by 2002:adf:9c93:: with SMTP id d19-v6mr2542557wre.11.1537909425571;
        Tue, 25 Sep 2018 14:03:45 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bc0:ba00:4d53:63c8:9c2e:523a? (p200300EA8BC0BA004D5363C89C2E523A.dip0.t-ipconnect.de. [2003:ea:8bc0:ba00:4d53:63c8:9c2e:523a])
        by smtp.googlemail.com with ESMTPSA id v21-v6sm6904419wrd.4.2018.09.25.14.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 14:03:44 -0700 (PDT)
Subject: Re: kernel 4.18.5 Realtek 8111G network adapter stops responding
 under high system load
To:     David Arendt <admin@prnet.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Gabriel C <nix.or.die@gmail.com>,
        =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <odi@odi.ch>
Cc:     linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        netdev@vger.kernel.org
References: <20180918102349.Horde.yHctatUod-_SC696oYKmySa@cloud.luxmemories.lu>
 <039cc66f-13b0-e745-b6ec-68f4580e90ef@maciej.szmigiero.name>
 <0e865e74-e587-61b7-d319-9afe0a5e8828@prnet.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <968f03ee-a271-242b-d90a-5c70ea72ce3b@gmail.com>
Date:   Tue, 25 Sep 2018 23:03:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0e865e74-e587-61b7-d319-9afe0a5e8828@prnet.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.2018 06:12, David Arendt wrote:
> Hi,
> 
> Thanks for the patch.
> 
> I just applied it and the TxConfig register now contains 0x4f000f80.
> The next day will show if it really solves the problem.
> 
> Thanks in advance,
> David Arendt
> 
> On 9/19/18 12:30 AM, Maciej S. Szmigiero wrote:
>> Hi,
>>
>> On 18.09.2018 12:23, David Arendt wrote:
>>> Hi,
>>>
>>> Today I had the network adapter problems again.
>>> So the patch doesn't seem to change anything regarding this problem.
>>> This week my time is unfortunately very limited, but I will try to
>>> find some time next weekend to look a bit more into the issue.
>> If the problem is caused by missing TXCFG_AUTO_FIFO bit in TxConfig,
>> as the register difference would suggest, then you can try applying
>> the following patch (hack) on top of 4.18.8 that is already patched
>> with commit f74dd480cf4e:
>> --- a/drivers/net/ethernet/realtek/r8169.c
>> +++ b/drivers/net/ethernet/realtek/r8169.c
>> @@ -5043,7 +5043,8 @@
>>  {
>>  	/* Set DMA burst size and Interframe Gap Time */
>>  	RTL_W32(tp, TxConfig, (TX_DMA_BURST << TxDMAShift) |
>> -		(InterFrameGap << TxInterFrameGapShift));
>> +		(InterFrameGap << TxInterFrameGapShift)
>> +		| TXCFG_AUTO_FIFO);
>>  }
>>  
>>  static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>>
>> This hack will probably only work properly on RTL_GIGA_MAC_VER_40 or
>> later NICs.
>>
>> Before running any tests please verify with "ethtool -d enp3s0" that
>> TxConfig register now contains 0x4f000f80, as it did in the old,
>> working driver version.
>>
>> If this does not help then a bisection will most likely be needed.
>>
>>> Thanks in advance,
>>> David Arendt
>> Maciej
> 
> 
> 
@Gabriel:
Thanks for the hint, I wasn't fully aware of this thread.
@Maciej:
Thanks for the analysis.

It seems that all chip versions from 34 (= RTL8168E-VL) with the
exception of version 39 (= RTL8106E, first sub-version) need
bit TXCFG_AUTO_FIFO.

And indeed, due to reordering of calls this bit is overwritten.
Following patch moves setting the bit from the chip-specific
hw_start function to rtl_set_tx_config_registers().

Whoever is hit by the issue and has the option to build a kernel,
could you please test whether the patch fixes the issue for you?

Thanks, Heiner

---
 drivers/net/ethernet/realtek/r8169.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index f882be49f..ae8abe900 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4514,9 +4514,14 @@ static void rtl8169_hw_reset(struct rtl8169_private *tp)
 
 static void rtl_set_tx_config_registers(struct rtl8169_private *tp)
 {
-	/* Set DMA burst size and Interframe Gap Time */
-	RTL_W32(tp, TxConfig, (TX_DMA_BURST << TxDMAShift) |
-		(InterFrameGap << TxInterFrameGapShift));
+	u32 val = TX_DMA_BURST << TxDMAShift |
+		  InterFrameGap << TxInterFrameGapShift;
+
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
+	    tp->mac_version != RTL_GIGA_MAC_VER_39)
+		val |= TXCFG_AUTO_FIFO;
+
+	RTL_W32(tp, TxConfig, val);
 }
 
 static void rtl_set_rx_max_size(struct rtl8169_private *tp)
@@ -5011,7 +5016,6 @@ static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
 
 	rtl_disable_clock_request(tp);
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
 	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
 
 	/* Adjust EEE LED frequency */
@@ -5045,7 +5049,6 @@ static void rtl_hw_start_8168f(struct rtl8169_private *tp)
 
 	rtl_disable_clock_request(tp);
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
 	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
 	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
@@ -5090,8 +5093,6 @@ static void rtl_hw_start_8411(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8168g(struct rtl8169_private *tp)
 {
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
-
 	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x080002, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
@@ -5189,8 +5190,6 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 	rtl_hw_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
-
 	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
@@ -5273,8 +5272,6 @@ static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
 {
 	rtl8168ep_stop_cmac(tp);
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
-
 	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x2f, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x5f, ERIAR_EXGMAC);
@@ -5596,7 +5593,6 @@ static void rtl_hw_start_8402(struct rtl8169_private *tp)
 	/* Force LAN exit from ASPM if Rx/Tx are not idle */
 	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
 	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
 
 	rtl_ephy_init(tp, e_info_8402, ARRAY_SIZE(e_info_8402));
-- 
2.19.0


