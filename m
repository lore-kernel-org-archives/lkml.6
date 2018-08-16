Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795E320862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H65XXCgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795E320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeHPWvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:51:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33777 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeHPWvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:51:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id i134-v6so9121803wmf.0;
        Thu, 16 Aug 2018 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e+574BAu05StCaS4w8gzBPRRgfDV4AEw9wrwY0F1KIM=;
        b=H65XXCgNfVK7iZTN1mYyaKfoclqXe/T9APv5RBpTSeu6uea34g9fEH+efkhAaHSnr3
         kXZH5GwNDl/QiYFqGKsc4EMDjEJkR3iTy9ZstnbMbuRj3391PkthdTo90lLj4lodOQzV
         3qoUXDGhawmUT5dvoKx5LQ+Fs15zS26EWXhOiN5KtuhMLRJhGH0qpuOPOtfwVQ1O2933
         EHwGqcAFLvZaZBnhfdBGBOWi6lrL+12MldScCmAZecLXnPUawPXQHecchssl5jDvM7OL
         HpdYU2HE0AqDWjJNjwTm5T7nh/U+aR2TOv+UcFjgBIyEx8pgzaPiTMo1Wivvfy6qdsLh
         dZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e+574BAu05StCaS4w8gzBPRRgfDV4AEw9wrwY0F1KIM=;
        b=HsAQgIgFVnSl1VMjEYQQ9/ixyoQ2t6cSmMOiIY0bZf0r6uEu+7m5/dqkbOJJZ/IwWw
         CkF+Nm4cUjWXym8Fwruy7zs4iWTVFgcH0qU4tIClDlAZgJKjPUclttGzuEER4gBJII6E
         Ca9wHUsEVgFooSOadPyrUSbttPz13f2D4e4aRwrfJJXTwul2iCI6x/ZzlbadslOczs4d
         /2KC5yFIRHH5a6JZS5ubZ6VmoDFmOuFT5UwEXc4PpevTq8cP8OKDwP7Wmdg176esMaMX
         8JA/FgiPbyGNytHLpvAaEFuQPWhz3jPmMIFxDeWt+dxnkpmTK6qMSleF9ECBknPsg3li
         qjFA==
X-Gm-Message-State: AOUpUlHm7+KvE8FQAMeDtX4tuDnVkfWRE25mQeknBWOWu5/X92LVNbIb
        Nn/jeR59pRKzg9/n7GrnzgJfvLdy
X-Google-Smtp-Source: AA+uWPxawCYzPELWz+rUR0JwOhTyeoPBHzKsq9yrCt33538bYyrRhSdcrUBhCfV3Oq9tbvLIAEDSYg==
X-Received: by 2002:a1c:7408:: with SMTP id p8-v6mr2398194wmc.118.1534449056548;
        Thu, 16 Aug 2018 12:50:56 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:fce9:ceca:5c9:a793? (p200300EA8BD4D600FCE9CECA05C9A793.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:fce9:ceca:5c9:a793])
        by smtp.googlemail.com with ESMTPSA id w204-v6sm2793669wmw.5.2018.08.16.12.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 12:50:56 -0700 (PDT)
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
To:     David Miller <davem@davemloft.net>
Cc:     jian-hong@endlessm.com, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
References: <20180815062110.16155-1-jian-hong@endlessm.com>
 <20180816.122131.604270853620318143.davem@davemloft.net>
 <458efbf9-5971-653a-e7cd-8c56ba055648@gmail.com>
 <20180816.123958.750435252621963789.davem@davemloft.net>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
Date:   Thu, 16 Aug 2018 21:50:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816.123958.750435252621963789.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.2018 21:39, David Miller wrote:
> From: Heiner Kallweit <hkallweit1@gmail.com>
> Date: Thu, 16 Aug 2018 21:37:31 +0200
> 
>> On 16.08.2018 21:21, David Miller wrote:
>>> From: <jian-hong@endlessm.com>
>>> Date: Wed, 15 Aug 2018 14:21:10 +0800
>>>
>>>> Found the ethernet network on ASUS X441UAR doesn't come back on resume
>>>> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
>>>
>>> Heiner, please take a look at this.
>>>
>>> You recently disabled MSI-X on RTL8168g for similar reasons.
>>>
>>> Now that we've seen two chips like this, maybe there is some other
>>> problem afoot.
>>>
>> Thanks for the hint. I saw it already and just contacted Realtek
>> whether they are aware of any MSI-X issues with particular chip
>> versions. With the chip versions I have access to MSI-X works fine.
>>
>> There's also the theoretical option that the issues are caused by
>> broken BIOS's. But so far only chip versions have been reported
>> which are very similar, at least with regard to version number
>> (2x VER_40, 1x VER_39). So they may share some buggy component.
>>
>> Let's see whether Realtek can provide some hint.
>> If more chip versions are reported having problems with MSI-X,
>> then we could switch to a whitelist or disable MSI-X in general.
> 
> It could be that we need to reprogram some register(s) on resume,
> which normally might not be needed, and that is what is causing the
> problem with some chips.
> 
Indeed. That's what I'm checking with Realtek.
In the register list in the r8169 driver there's one entry which
seems to indicate that there are MSI-X specific settings.
However this register isn't used, and the r8168 vendor driver
uses only MSI. And there are no public datasheets.
