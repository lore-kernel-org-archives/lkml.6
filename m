Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91956C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D0D2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC/E7ArI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D0D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeHUANe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:13:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36748 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeHUANe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:13:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so846143wmc.1;
        Mon, 20 Aug 2018 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fpL1x4Sv0XEvqor8FkWIK0sEPMli5bUn8QT1mq+FpgY=;
        b=FC/E7ArI579ekBgMmivEkYGH92ZV73Ql8lhkI2L0a7kfJ02t9TdEWuHu4E6mOmsuCa
         BsseYoJUd19N085gU/ZwfjeyLulRSW3yl6vPOOEcJczeycLZHWJUZAcKlkGozWdwtnSC
         ZYadgQUL2Y7XRPueb4U2+gQMwhVJkPEXHpFMjqHa97iwmHBdaIdItZvdpdD3YYbmIKgS
         vRkNFiSZvkW85b1Kb9E5KTRIlqpyGhg3MNKQmlLuR2ggQ2P7p0QQmbnDr/ug5212CpjO
         qrvwc3ccNUd8HnsGruR8MOtt6CeDYtHEek0tM37tq97che2phdlF46hE7wsW6Sc0AhA/
         2vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fpL1x4Sv0XEvqor8FkWIK0sEPMli5bUn8QT1mq+FpgY=;
        b=IvyPH4GugCXgjwZY2tQD7SIohXH792yjT0Ii+fXITptBgKJAwzmkDno90tba8GW8qD
         9PTOPh7ydGA8RmAschTRJTZaqgb+0zK1rpsf7vy9UPtC9zT9kP4Wrg761bT25hnPw9sa
         LDwlXb9VYH4eSiRxk0ldTwgqJkyEEAwj1eMuRUBOQBT0k3aSEdeiYfUP6Ymiqz4LUqLR
         T9cRN4s0CuBlcdQXCCA3qr+f+sq1fDU20shYW3LyKVuvTq7zvPbgASR6mAIk2/7EUM4m
         b9BPX8Iv3ldEmqXLlOmFF1tweMviIe1FL77m87XbFYvEV43rCuJOi3nncvAZZ8K2xuWb
         6G7w==
X-Gm-Message-State: AOUpUlH0Sn1kaTxaYZmtzRmiio/CmeNZgN5TY/t856wHOIbehAoVlivy
        01Vkw3bFMHhXbHXxCsGnbt875T32
X-Google-Smtp-Source: AA+uWPyoRCX4VeN79CcAkr8ITEs0gK8k7jfdo1CBPvCEYwMuIzOUztrBLIg2tNK+88H8fpcTECz1Uw==
X-Received: by 2002:a1c:9f86:: with SMTP id i128-v6mr24653823wme.156.1534798583909;
        Mon, 20 Aug 2018 13:56:23 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:ec45:ed0e:85c9:7076? (p200300EA8BD4D600EC45ED0E85C97076.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:ec45:ed0e:85c9:7076])
        by smtp.googlemail.com with ESMTPSA id e5-v6sm404076wmh.29.2018.08.20.13.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 13:56:23 -0700 (PDT)
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>
Cc:     jian-hong@endlessm.com, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
References: <20180815062110.16155-1-jian-hong@endlessm.com>
 <20180816.122131.604270853620318143.davem@davemloft.net>
 <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
 <20180816.123958.750435252621963789.davem@davemloft.net>
 <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
 <4bf216ab-69ea-c09e-dcd8-f033a13627c0@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <e804d5e2-8ee4-0e6b-4d53-323d05173ea6@gmail.com>
Date:   Mon, 20 Aug 2018 22:56:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4bf216ab-69ea-c09e-dcd8-f033a13627c0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2018 22:40, Florian Fainelli wrote:
> On 08/16/2018 12:50 PM, Heiner Kallweit wrote:
>> On 16.08.2018 21:39, David Miller wrote:
>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>> Date: Thu, 16 Aug 2018 21:37:31 +0200
>>>
>>>> On 16.08.2018 21:21, David Miller wrote:
>>>>> From: <jian-hong@endlessm.com>
>>>>> Date: Wed, 15 Aug 2018 14:21:10 +0800
>>>>>
>>>>>> Found the ethernet network on ASUS X441UAR doesn't come back on resume
>>>>>> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
>>>>>
>>>>> Heiner, please take a look at this.
>>>>>
>>>>> You recently disabled MSI-X on RTL8168g for similar reasons.
>>>>>
>>>>> Now that we've seen two chips like this, maybe there is some other
>>>>> problem afoot.
>>>>>
>>>> Thanks for the hint. I saw it already and just contacted Realtek
>>>> whether they are aware of any MSI-X issues with particular chip
>>>> versions. With the chip versions I have access to MSI-X works fine.
>>>>
>>>> There's also the theoretical option that the issues are caused by
>>>> broken BIOS's. But so far only chip versions have been reported
>>>> which are very similar, at least with regard to version number
>>>> (2x VER_40, 1x VER_39). So they may share some buggy component.
>>>>
>>>> Let's see whether Realtek can provide some hint.
>>>> If more chip versions are reported having problems with MSI-X,
>>>> then we could switch to a whitelist or disable MSI-X in general.
>>>
>>> It could be that we need to reprogram some register(s) on resume,
>>> which normally might not be needed, and that is what is causing the
>>> problem with some chips.
>>>
>> Indeed. That's what I'm checking with Realtek.
>> In the register list in the r8169 driver there's one entry which
>> seems to indicate that there are MSI-X specific settings.
>> However this register isn't used, and the r8168 vendor driver
>> uses only MSI. And there are no public datasheets.
> 
> Stupid question, but should not we be asking the reporter to try again with:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfdd19ad80f203f42f05fd32a31c678c9c524ef9
> 
> applied? The original report shows the Generic PHY being used, not the
> Realtek PHY driver being used, is this possibly contributing to the problem?
> 
I don't think it's related, because falling back to MSI fixes the issue for
the reporter. And some chip versions report a generic Realtek PHY ID which
isn't covered by any Realtek PHY driver. These chip versions seem to work
fine with the generic PHY driver. So he may have Realtek PHY drivers enabled
or not. But indeed, would be good to have this info to get the full picture.

See also the mail I wrote few minutes ago, there it's described what we know
about the reason of the MSI-X issue so far.
