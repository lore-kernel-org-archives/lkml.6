Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D7E31C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F101208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4DSf5pT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F101208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935950AbeFMXdz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:33:55 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46654 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935724AbeFMXdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:33:53 -0400
Received: by mail-qt0-f195.google.com with SMTP id h5-v6so4122309qtm.13;
        Wed, 13 Jun 2018 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k0VioK+bVXIsvf+jGr5iWkba1DaAfBcRq3SjrZIc+p0=;
        b=D4DSf5pT3Sh33f3ROcPTKyEOD5kruUm+45anQjcA+zdDUck2XTGHb5hEPkNgimRl6C
         rNuXQAzf1tGkxcu93Xcd6Ebw8UHGhp/WF2C621xdzyuOl6umoM6fZjC74p2TpB5TMy0n
         RjYXX1HAQtGiBRivM/Ou4ljl8DQBSs1fMmyovqkkU01k5RRMnF64/G+2/Farby4gF725
         HAWVtebK6lzfraNNIugvE2vkOYqIt2JswcirA9v3TcqgsAVMVBQbEFgC6RwW+76+iELL
         K/WmnlhSDAdVRHSldfbceimbA5r7nHh+SQDBQCbgGS2fswIRXszCkHkZnRrD1b16Twq0
         Jgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k0VioK+bVXIsvf+jGr5iWkba1DaAfBcRq3SjrZIc+p0=;
        b=pyeVaQZoa/YCKqsgpayN4+GXMy4JiMVKb3Mkt5FXDcCdgmvsDcLWAm+f+kJm1y+mze
         3Pf5QU3RpZbNu9GEWYfCELA6Gthxas2Uaq1oyGf//v5FkIljTXv7JtfW3Vvp4mWzjvjw
         FbB9BV7QXON4O4jWams6xGxnbUj3cgFNW4nIXV1B2QWJIAbKNQtmIhGw/pwOEWcm164j
         NZIGphBCZtEpulTK4XyWH+ZtN4EXogk8dKkCLrcpRbcwpQShMJ8tQuJcJH4YMC8Fsibs
         vez/g3eNVWJoYHzdJ5+fy6E2XArVwo2rCTBruYM8b1Ds5nZyLPNCZMMnBi9+v00yHkw2
         iWAw==
X-Gm-Message-State: APt69E038NJIN1rSlammutR6doF078LPRRc/EVIqF7qCwPyzrOJAIQB5
        FgZKz0chkqRHZDVW6Iodg1M=
X-Google-Smtp-Source: ADUXVKI0ZcKK7jqg2eKQH4IlKGAbiFeGVOdFASPUIkG66KzMTG9fPltTaUYjHHpmCmcX+C72WXStEQ==
X-Received: by 2002:aed:3b7a:: with SMTP id q55-v6mr180837qte.309.1528932832168;
        Wed, 13 Jun 2018 16:33:52 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id w6-v6sm3200498qtj.71.2018.06.13.16.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 16:33:50 -0700 (PDT)
Subject: Re: [PATCH 1/5] ARM: dts: cygnus: Fix I2C controller interrupt type
To:     Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
 <8c368dbc-f654-ec52-0786-1f318156b8b5@gmail.com>
 <21124af0-f867-56a9-753d-cadfce7d1cf2@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <fcb1d93a-3e1a-7020-a104-acc9360855e2@gmail.com>
Date:   Wed, 13 Jun 2018 16:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <21124af0-f867-56a9-753d-cadfce7d1cf2@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 04:32 PM, Ray Jui wrote:
> 
> 
> On 6/13/2018 12:49 PM, Florian Fainelli wrote:
>> On 06/12/2018 01:21 PM, Ray Jui wrote:
>>> Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
>>> Cygnus SoC
>>>
>>> Fixes: b51c05a331ff ("ARM: dts: add I2C device nodes for Broadcom
>>> Cygnus")
>>
>> This appears to be the only one that is truly needed here, the two
>> others below probably just moved things around but the offending commit
>> was already introduced in the above commit.
>>
> 
> Okay thanks. Will remove the other two "Fixes" below.

I can take care of that while applying the patches, no need for you to
resubmit, for the whole series I mean.

> 
>>> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi
>>> bus")
>>> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
>>>
>>
>> There is no need for an extra line between the last Fixes: tag and your
>> Signed-off-by tag.
>>
> 
> Got it, thanks!

And that as well.
-- 
Florian
