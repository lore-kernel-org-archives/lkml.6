Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7233AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118BC216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMvcAYZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118BC216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeHTX6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:58:07 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37083 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeHTX6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:58:07 -0400
Received: by mail-qk0-f193.google.com with SMTP id f17-v6so4557876qkh.4;
        Mon, 20 Aug 2018 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CIahhygVRZGkTQaBQkFAup6Gwbt2hyskKWqlYscjHUk=;
        b=rMvcAYZK6q8SYTBD+XC0HaB6peMOZLDi39c7U29pQtrKik4tHDqrzrKq0WYn5hU4q2
         HiGkqFP/jwnDuJxliM/a9r9u/wY2Tp89N0j322XqorfuRNO/6PnTxlXLrCvH37EfKx+1
         pG0MMPBoHAoP9LF49jKjErKS0kEB4csILfnE+Z5TfMbLpFjh6/p6CAvihEhSsBxlDBZb
         2AkT94FiKcjIOBr/WJpbVzW7b1Fz42vre+zi9pS3lHafujaMW2i3Gx4CJlFFneJmAUuE
         7TKllyqn+m8F2/IFd+COaYM9eJIIADNUEws/VdFRmfEBpGMbwtPHuP4cmf72RMow5cGr
         0kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CIahhygVRZGkTQaBQkFAup6Gwbt2hyskKWqlYscjHUk=;
        b=SbdGh40FkfvOw9jDKDjpuQKCYCaCV5PAWLfXHQm0/CY397HUakROOkpMe6AAh4WAEQ
         HZ8/VFISKWEQDLNiqV37NIcW2PEhXB53paM3AM1rK/qLx3kB/uRCA63+8rcG6w6WFkjn
         8hczZVKzyeeiO2SQJ5dBF0qsIcNZeqttj+6A0f4XhKU8CqNNtS2uHtAGNFDbcfMultnM
         haM/pjpVuunhNhkwt0Ps5quwppUCOIvVQa0F+xvztMxIbaMuiPillACtkLxocxc5OiZc
         XqGHJbqx8Djy82zj2xub0qXyrDEPaebO969qC8cGEb57Q8YJBiPqii7GtYahThWsaZ6g
         hJSw==
X-Gm-Message-State: APzg51AUZOCc8kGQL3Vp16UQELDg3bDQLcz3xRSbOo9uOAGMwmDfLMjP
        oe/fWBkcXC8w9JHp/P770bksDCQX
X-Google-Smtp-Source: ANB0Vdbr4X8aYmqbVMIp9783aOlaY3ajWaDDfyV9Qe7A/OlCEXr7lYxHutAZjY3uWbLCKFyxgTkRqg==
X-Received: by 2002:a37:a70b:: with SMTP id q11-v6mr6012760qke.92.1534797660655;
        Mon, 20 Aug 2018 13:41:00 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id k3-v6sm726580qtm.12.2018.08.20.13.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 13:40:59 -0700 (PDT)
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>
Cc:     jian-hong@endlessm.com, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
References: <20180815062110.16155-1-jian-hong@endlessm.com>
 <20180816.122131.604270853620318143.davem@davemloft.net>
 <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
 <20180816.123958.750435252621963789.davem@davemloft.net>
 <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <4bf216ab-69ea-c09e-dcd8-f033a13627c0@gmail.com>
Date:   Mon, 20 Aug 2018 13:40:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 12:50 PM, Heiner Kallweit wrote:
> On 16.08.2018 21:39, David Miller wrote:
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>> Date: Thu, 16 Aug 2018 21:37:31 +0200
>>
>>> On 16.08.2018 21:21, David Miller wrote:
>>>> From: <jian-hong@endlessm.com>
>>>> Date: Wed, 15 Aug 2018 14:21:10 +0800
>>>>
>>>>> Found the ethernet network on ASUS X441UAR doesn't come back on resume
>>>>> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
>>>>
>>>> Heiner, please take a look at this.
>>>>
>>>> You recently disabled MSI-X on RTL8168g for similar reasons.
>>>>
>>>> Now that we've seen two chips like this, maybe there is some other
>>>> problem afoot.
>>>>
>>> Thanks for the hint. I saw it already and just contacted Realtek
>>> whether they are aware of any MSI-X issues with particular chip
>>> versions. With the chip versions I have access to MSI-X works fine.
>>>
>>> There's also the theoretical option that the issues are caused by
>>> broken BIOS's. But so far only chip versions have been reported
>>> which are very similar, at least with regard to version number
>>> (2x VER_40, 1x VER_39). So they may share some buggy component.
>>>
>>> Let's see whether Realtek can provide some hint.
>>> If more chip versions are reported having problems with MSI-X,
>>> then we could switch to a whitelist or disable MSI-X in general.
>>
>> It could be that we need to reprogram some register(s) on resume,
>> which normally might not be needed, and that is what is causing the
>> problem with some chips.
>>
> Indeed. That's what I'm checking with Realtek.
> In the register list in the r8169 driver there's one entry which
> seems to indicate that there are MSI-X specific settings.
> However this register isn't used, and the r8168 vendor driver
> uses only MSI. And there are no public datasheets.

Stupid question, but should not we be asking the reporter to try again with:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfdd19ad80f203f42f05fd32a31c678c9c524ef9

applied? The original report shows the Generic PHY being used, not the
Realtek PHY driver being used, is this possibly contributing to the problem?
-- 
Florian
