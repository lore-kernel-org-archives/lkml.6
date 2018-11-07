Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A51BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507A720892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tK2JSOyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507A720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeKHFA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:00:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38557 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHFA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:00:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id q186-v6so15801150ljb.5;
        Wed, 07 Nov 2018 11:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8yObZic22laKE6sPg62QYL0oYKr4EANq4WTyr1g0HS0=;
        b=tK2JSOyXT4RvFKhJFqaA8BoT7z7iX6niqUTrKYbpZIYAJtm0tEZJTrTtQ/raMVhgGF
         ZzH0CWtAsz+lzcoUYK8xooaK0RmJnQWEUawHD/MMaoorF6FevABh0hgu1fQlVzhQyicg
         jTNRFkM4Lxh47E8TImRJdi+qHQACz2Y7EKs7XSTLoeZ0nGbKG7r2c+voPsTa1ml5wl3C
         HmDIdnEtWX/Tb6uvrUeYzh44Fj0pJumur95xVpuC9JsRRK6agPcGbViR7uE8kZRULTiH
         HVZ3PCzrdvedMrbQUeaxQNYTftfO/sYBNJwQZVzLS8Umbd2V1hPKPq2GvSphg60KBNLG
         2K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8yObZic22laKE6sPg62QYL0oYKr4EANq4WTyr1g0HS0=;
        b=GYiH5D5kf+MAliPBsGFUcagdVkHZ2rXZpzHRUx/SSTjM7PGSrRvwlr7h8bmFVN6XO6
         aST+j1Hfw4nZWHDvLipICBQDbGevZ6dUVWp2pS41hfzqDHDUptOnQXDd0VnsiLikJZZG
         wXiarCCIbbgLr8WNfoxTgNH+GDiXBp3S2UErSV5kkKcbjL1SgPpO9kkUK37C7ySTN9pd
         JPEC/smUkBSQ0KyLUDa4F1j/xgBE71VEkp63CLFZ74FFMizeUTb52y8UoBnMMuW9dMv2
         zZQjpeHtEe2hVCExqrSdCzdiEIKPS7wDyc8GmpBI8aqi9CMOVYuYBgDaQnZQHgFNbXcS
         39Zg==
X-Gm-Message-State: AGRZ1gIQfx5VkfDIeFxo9ty9P6w/H6nzFmzl3APtlMcsUmk0VTW/MgJ4
        kc57BvOJZWC+bHJ3u1/U/rA=
X-Google-Smtp-Source: AJdET5fwIUEZfFStJNVj03ZYatVmOG49ImYMZpDo7SISBQDwKgfPT4DLP2ikF7b/gSUqBN2FWxd6EQ==
X-Received: by 2002:a2e:91d1:: with SMTP id u17-v6mr975359ljg.160.1541618922414;
        Wed, 07 Nov 2018 11:28:42 -0800 (PST)
Received: from [192.168.1.18] (dnl153.neoplus.adsl.tpnet.pl. [83.24.93.153])
        by smtp.gmail.com with ESMTPSA id s20sm267720lfb.51.2018.11.07.11.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 11:28:41 -0800 (PST)
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
To:     =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "robh@kernel.org" <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
 <ee6b35ab-6e26-a5fa-538e-d33b88903330@ysoft.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <e1c7a64d-30ae-c649-fd72-1359d3339d2d@gmail.com>
Date:   Wed, 7 Nov 2018 20:28:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ee6b35ab-6e26-a5fa-538e-d33b88903330@ysoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal

On 11/07/2018 09:36 AM, Vokáč Michal wrote:
> On 6.11.2018 23:07, Jacek Anaszewski wrote:
>> Add common LED function definitions for use in Device Tree.
>> The function names were extracted from existing dts files
>> after eliminating oddities.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
>> Cc: Daniel Mack <daniel@zonque.org>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Simon Shields <simon@lineageos.org>
>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>> ---
>>   include/dt-bindings/leds/functions.h | 101 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 101 insertions(+)
>>   create mode 100644 include/dt-bindings/leds/functions.h
> 
> Hi Jacek,
> Just nit picking. I think the subject should be:
> 
> "dt-bindings: leds: ..." to be consistent.

Thanks for the heads-up. I'll change it in the v2.

-- 
Best regards,
Jacek Anaszewski
