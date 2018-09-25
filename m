Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855E0C46476
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70744206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5/Yo3oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70744206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbeIYWVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:21:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37371 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbeIYWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:21:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id c13-v6so13621226qkm.4;
        Tue, 25 Sep 2018 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLUhuBppXWSIWgJUBzsjbrx2R10aAqr2hMghDO2fOG8=;
        b=d5/Yo3oMr2C9h5FsMwVwK0f/R3nB0O9DAaegGI5MBaMPAVt98Q97LTJ4239kk7/JJO
         vDQeaBFUMrshIorUQ9CgWS0VK8c9LlN1RqbmepTJckeGBWId/7v62edj1LrR776s0Qzl
         K7eVheQq2ff9ilu4pfe6w7SoVgWF3R6QGrvJxhom4bAvus2ErIyKcZfwYv8whOSNyULR
         W6tuG4M2ogbAsNpxmyvzmM1zNZudRBh4a9Y0MvW/q0WVM41eSqz8214h+a5sGq7kmkU+
         h+N7FFF46wjwZIXw1X4dMPJgg45Ki/6ZtyLVltsWZu5Xe8oBwaUOgps2Do/g0BGzDWPB
         rJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gLUhuBppXWSIWgJUBzsjbrx2R10aAqr2hMghDO2fOG8=;
        b=YD4G9q9cRf80oR14G0RNHv5LktEr3r6WHKZb8n40efQzg8f/Atr/QrfnefGNYP4rsi
         DModZJ7fS8BD4VWYvNFRtq8Pf9BFQI9fvLzrljLE34qxtbKK88IRq8HTqrkuZha3i+R/
         bYcBgjfLcNg7wrsbxZ3SeFqfcZ2IVRCKvIYUKMQPTmBA1XLp4zBGoHFQzw6SiAfuIQf9
         uNF0+iJGom5Sz/tnJ8fv/rMjvlTAal8Z5IEeIpRcx0cKDfKmoCEm4z1tsBHSqptg3F48
         yT/P/x5kp7Bqw0wxDCDr1UvomNQLOUPz1DpzDR+C33hawZH09YTlsgsL7jIyvzSIdnMV
         7Y6A==
X-Gm-Message-State: ABuFfojSRrDP9AaxJoRRZQYLtGJt9E46G74skvBj3BBt7zKUFvRjC9iF
        XfSGsunH51zP/0F6OLbzLf4=
X-Google-Smtp-Source: ACcGV62gGY/d/xZpy0AMP19ZpwvuF6YszptP8e37lBtcyW12XACO1YcO3zNZwUhjRjia0JzDWTzJjg==
X-Received: by 2002:a37:1a4a:: with SMTP id a71-v6mr1291285qka.252.1537892000739;
        Tue, 25 Sep 2018 09:13:20 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id c1-v6sm1854001qtk.87.2018.09.25.09.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 09:13:19 -0700 (PDT)
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
References: <20180920191646.18198-1-f.fainelli@gmail.com>
 <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
 <fa91f7eb-3405-4607-9391-f043b73e7af6@ti.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <3d4b406b-4fa4-9248-a0ab-d4eeea808034@gmail.com>
Date:   Tue, 25 Sep 2018 09:12:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fa91f7eb-3405-4607-9391-f043b73e7af6@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 11:19 PM, Kishon Vijay Abraham I wrote:
> 
> 
> On Friday 21 September 2018 12:49 AM, Florian Fainelli wrote:
>> On 09/20/2018 12:16 PM, Florian Fainelli wrote:
>>> Hi Kishon, Tejun,
>>>
>>> This patch series adds support for the SATA AHCI and PHY found on the
>>> ARM-basd BCM63138 DSL SoCs.
>>>
>>> It would probably make sense for patches 1-3 to go through Kishon's
>>> tree, patches 4-7 through Tejun's tree, and I would be merging the last
>>> two patches through the Broadcom ARM-SoC tree.
>>>
>>> Let me know if this is not a workable plan, thank you very much!
>>
>> Looks like I had left patches with the incorrect subject, please
>> disregard the following patches:
>>
>> [PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built for
>> DSL SoCs
>> [PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to be used
>> [PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings
>>
>> since they have incorrect/inconsistent titles, the other patches are
>> fine though. Sorry about that.
> 
> merged the first 3 patches to linux-phy tree.

Thanks a lot Kishon!

> 
> Thanks
> Kishon
> 


-- 
Florian
