Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA56C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EA6214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWaxPT0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLQVpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:45:40 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38522 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeLQVpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:45:39 -0500
Received: by mail-wm1-f46.google.com with SMTP id m22so713788wml.3;
        Mon, 17 Dec 2018 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PT9zXYd9WD8hA7Hu+LM61uQ2/xgt9WPlTRGUpgRr0u8=;
        b=oWaxPT0vEOfC2DYt5zV9HO9vZKwIxlzlkV/zjs9xjhcRwUR/VfrJEakJE/AaqMsFFt
         ZVDaB8+Ex9jM71WxCD4wR1yGhEDRer7HofIVeWaRxcjuecOR7X2IXm5X7ieWwPMQToRY
         tHFNcGsGxqExAc+4Ufe71y3pdHu6+nW/NIzH1YfSCHd+KerGWMkn15pJzMphqKgnqEs4
         GQIVcODhQpCN4n0qW4az5QfHXZ3+tf0KJVv3CSD7/Gs3cPMJvI2Luvr5oOEIsdQqnz4d
         XDQixxxEqoOnvnQoVZbTBDfhls+QEVE/pYONppjXWGoPrCFwA+d74+RF8UusfXYTN7RN
         QQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PT9zXYd9WD8hA7Hu+LM61uQ2/xgt9WPlTRGUpgRr0u8=;
        b=X50TpV9e0qFuk5TsqjJV3h2E5ZaAzd8Ng/k83byW4/ylJMorFglUFf3yTpcXrVoy94
         Ewswb9Axls8CS3WtO7XmRJVrF5jwm5/FsZ0GFoPHada9z2n820zG539+zCqcZAZSpxqH
         hFZq5SPggCf3ZnQbaTZuXuBncQp3a24a485FIsLUtsDn2BhvD7BQ7Zd+qqZ4/pyDW9NR
         eAFgoIrqPCrm4KT0rprF5189BLzY4dx5o6XDDrujip8k78ZRcOa2Tep0JQ5uIB7LHRRA
         MiyerwikRLnYWEbO87SqogOl69SMIP0uQvv5m1REXxp9wYs4pl5o2TEenrkzH7fvM8Ho
         eGWA==
X-Gm-Message-State: AA+aEWZbrEH35Z9mh7lcrUOAS/PTzkOtYGyu84QmnV9+BSXaQUTSsTH4
        fiP4HvMwTqTLQZeV2UijvsYUSSym
X-Google-Smtp-Source: AFSGD/V1SmQRZiFs5Rwruy9aZvXmtGqeRHbjSEe9Cq8I7FQ+biAXwSn+FbSZrUElVEKfhQUCV/NMvQ==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr667446wmp.19.1545083136322;
        Mon, 17 Dec 2018 13:45:36 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:9098:392c:b017:10bc? (p200300EA8BCFE3009098392CB01710BC.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:9098:392c:b017:10bc])
        by smtp.googlemail.com with ESMTPSA id x20sm682944wme.6.2018.12.17.13.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 13:45:35 -0800 (PST)
Subject: Re: A weird problem of Realtek r8168 after resume from S3
To:     Chris Chiu <chiu@endlessm.com>
Cc:     nic_swsd <nic_swsd@realtek.com>, davem@davemloft.net,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
 <CAB4CAwc4ubdXn7kzPeu2L--ciATgZWYkO350fvFF43-jj180xw@mail.gmail.com>
 <59069da6-befc-2ebe-f2e2-e95a6a714013@gmail.com>
 <CAB4CAweArBEDWBvJwcnME6TBRUHYmOboKDf_4dDMvs81yZU3hw@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <3c0837d1-0e9f-0a4c-ce50-db766c02aa8b@gmail.com>
Date:   Mon, 17 Dec 2018 22:45:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAB4CAweArBEDWBvJwcnME6TBRUHYmOboKDf_4dDMvs81yZU3hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.2018 14:25, Chris Chiu wrote:
> On Fri, Dec 14, 2018 at 3:37 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 14.12.2018 04:33, Chris Chiu wrote:
>>> On Thu, Dec 13, 2018 at 10:20 AM Chris Chiu <chiu@endlessm.com> wrote:
>>>>
>>>> Hi,
>>>>     We got an acer laptop which has a problem with ethernet networking after
>>>> resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
>>>> follows.
>>>> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>>>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)
>>>>
>> Helpful would be a "dmesg | grep r8169", especially chip name + XID.
>>
> [   22.362774] r8169 0000:02:00.1 (unnamed net_device)
> (uninitialized): mac_version = 0x2b
> [   22.365580] libphy: r8169: probed
> [   22.365958] r8169 0000:02:00.1 eth0: RTL8411, 00:e0:b8:1f:cb:83,
> XID 5c800800, IRQ 38
> [   22.365961] r8169 0000:02:00.1 eth0: jumbo features [frames: 9200
> bytes, tx checksumming: ko]
> 
>>>>     The problem is the ethernet is not accessible after resume. Pinging via
>>>> ethernet always shows the response `Destination Host Unreachable`. However,
>>>> the interesting part is, when I run tcpdump to monitor the problematic ethernet
>>>> interface, the networking is back to alive. But it's dead again after
>>>> I stop tcpdump.
>>>> One more thing, if I ping the problematic machine from others, it achieves the
>>>> same effect as above tcpdump. Maybe it's about the register setting for RX path?
>>>>
>> You could compare the register dumps (ethtool -d) before and after S3 sleep
>> to find out whether there's a difference.
>>
> 
> Actually, I just found I lead the wrong direction. The S3 suspend does
> help to reproduce,
> but it's not necessary. All I need to do is ping around 5 mins and the
> network connection
> fails.  And I also find one thing interesting, disabling the  MSI-X
> interrupt like commit
> [d49c88d7677ba737e9d2759a87db0402d5ab2607] can fix this problem.
> Although I don't
> understand the root cause. Anything I can do to help?
> 
One  more thing: I checked the vendor driver and it uses a different sequence
to initialize the ePHY. Could you please check whether the following patch
makes a difference? I don't have much hope but it's worth a try.

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 8462553e3..7cfb22e05 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5097,11 +5097,16 @@ static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
 static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 {
 	static const struct ephy_info e_info_8411_2[] = {
-		{ 0x00, 0x0000,	0x0008 },
-		{ 0x0c, 0x3df0,	0x0200 },
-		{ 0x0f, 0xffff,	0x5200 },
-		{ 0x19, 0x0020,	0x0000 },
-		{ 0x1e, 0x0000,	0x2000 }
+		{ 0x00, 0x0008,	0x0000 },
+		{ 0x0c, 0x37d0,	0x0820 },
+		{ 0x1e, 0x0000,	0x0001 },
+		{ 0x19, 0x8021,	0x0000 },
+		{ 0x1e, 0x0000,	0x2000 },
+		{ 0x0d, 0x0100,	0x0200 },
+		{ 0x00, 0x0000,	0x0080 },
+		{ 0x06, 0x0000,	0x0010 },
+		{ 0x04, 0x0000,	0x0010 },
+		{ 0x1d, 0x0000,	0x4000 },
 	};
 
 	rtl_hw_start_8168g(tp);
-- 
2.20.0


>>>>     I tried the latest 4.20 rc version but the problem still there. I
>>>> also tried some
>>>> hw_reset or init thing in the resume path but no effect. Any
>>>> suggestion for this?
>>>> Thanks
>>>>
>> Did previous kernel versions work? If it's a regression, a bisect would be
>> appreciated, because with the chip versions I've got I can't reproduce the issue.
>>
>>>> Chris
>>>
>>> Gentle ping. Any additional information required?
>>>
>>> Chris
>>>
>> Heiner
> 

