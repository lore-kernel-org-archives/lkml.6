Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C038C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3B920700
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fClHDp+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392966AbfBMRYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:24:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47089 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbfBMRYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:24:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id f2so2594422edy.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tg0wqevx6W7ZMY5x/CJFj4fx8BvWdWVk8GTaSGdDvUo=;
        b=fClHDp+cbtYqOrK0V2124KYyZ9jWZe6mo5OYSmfna7+tHXmVdeCiACPAJ4FL2f5aM6
         vUCma7VeYu9p3cbtU2qSphoDUUo6tv5wo+Nh2cIU0i2kli/Y852og7aHQO1YjjeNygZj
         bhHeUz1POl76F4FoONi1V2rUJfa7D0zPDhIGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tg0wqevx6W7ZMY5x/CJFj4fx8BvWdWVk8GTaSGdDvUo=;
        b=SqOdudTdeKO/BwJytk2oWMh7gWKKD5h5xrRiNV1S845VksJVnYsxLEi5YtgRMFhn58
         CNwmMArDHl6Tp0l4sMtOsek3b6JxbDWNMBx0sdUy/2MSsJd10uM1pq0LdzSMQ7/WAgq5
         uNaT2fxP2APk+5K/fIK7vJACIkbQWxbc2J4gFMK8GF/TYoszjKrXMGwwUoddR9wizGKd
         7ePaNbS7hgfQGFApfbz0NrotdHWBJa3hGtm9E1LMh9m6EaAVU2+HZyMfjJE2K83lUszg
         0StDN7MtX6LU9COEwKsECel/qUcdg2/wl0S9Cb4/FfmMorugdshpDsa3A8nUqMBw6Hfg
         eIhA==
X-Gm-Message-State: AHQUAuYhe4FOvTbi7yQ6qeQl9RYnkbYAP30sWEk4BDile9DW/wZ2LlvL
        Mw9maomb4raLgjuJuOV8FitfL2CgdouLLZyG4CEGp5tFs31cWN+A56EHocjD3VJo2bqQO0USR7v
        AVIDEfGo2O/LdeYypIymMjjJjErYv05jlomhcdqvwdXfgMKHbrDcJP2Yf9XLu7vF+K/aSUl6xiA
        noHml7rDkK9Q==
X-Google-Smtp-Source: AHgI3IbUyRBFiezO7SAYRILH00mDXNYDKba0+lB7zbPliimW1AVoBzoNvQ+zBB8QANToFgFMAbfRHg==
X-Received: by 2002:a17:906:4344:: with SMTP id z4mr1144782ejm.27.1550078672263;
        Wed, 13 Feb 2019 09:24:32 -0800 (PST)
Received: from [10.67.48.220] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k13-v6sm3887600ejk.50.2019.02.13.09.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 09:24:31 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Change Ethernet switch management
 port
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190213042600.27729-1-f.fainelli@gmail.com>
 <43f75739-b592-35d3-e711-13f05218133d@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Openpgp: preference=signencrypt
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQIArgUCW382iBcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjjAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoFYGB/9qN5VL6f/88+qtDaDhUKvwBgF8
 koryGCH/gw6FBW5h5hwW0m6946WnsBnqKnZ8OYr8qsCgeJewCh0BEN9rIg8SC5oU7WdcmNg5
 KTv4/V1CmBo6dQaSHA8yQoeHsrw0gQ9HK4EYjhAU60RYXxX7/LFAy0rJMLf0qGKdWW2f5EkN
 dS5GwWOrTp477WL2g+R0khhP57qpejxlMN+Mtvin52UjbAcr1PAx8Zt2rXpFIZsXVWADpZDd
 qIb6PZPdcP/lD1v5it4sTN7D27FgjvbvAgj/D3NmyOjIUsbN9ZDJDfgv431RsJ9LOd6ySaNr
 yuje7L0dbiYrcOi3CN6S+zE1UJsLuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <56eae00a-0090-0b57-8615-0a331bc1c984@broadcom.com>
Date:   Wed, 13 Feb 2019 09:24:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <43f75739-b592-35d3-e711-13f05218133d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 12:07 AM, Rafał Miłecki wrote:
> On 13.02.2019 05:25, Florian Fainelli wrote:
>> BCM5301X has 3 Ethernet controllers: GMAC0, 1, 2 which map to ports 5, 7
>> and 8 respectively of the internal switch. Future changes will turn on
>> management mode in the Ethernet switch driver (b53) which will require
>> us to use port 8.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
>> b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
>> index 3fced3b7f1a8..affa9cc7422d 100644
>> --- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
>> +++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
>> @@ -150,10 +150,15 @@
>>               label = "wan";
>>           };
>>   -        port@5 {
>> -            reg = <5>;
>> +        port@8 {
>> +            reg = <8>;
>>               label = "cpu";
>> -            ethernet = <&gmac0>;
>> +            ethernet = <&gmac2>;
>> +
>> +            fixed-link {
>> +                speed = <1000>;
>> +                full-duplex;
>> +            };
>>           };
>>       };
>>   };
> 
> I'm not exactly sure how Linux switch driver works, but from DT
> perspective I think we should rather have *hardware* described instead
> of a common Linux case.
> 
> If I'm right, we should rather have all 3 switch ports described (5, 7,
> 8) and have Linux just use the one it needs.

Yes, let's do that.
-- 
Florian
