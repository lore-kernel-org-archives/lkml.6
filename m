Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5064AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175CA2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USKSNKLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175CA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeKIGZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:25:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46904 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeKIGZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:25:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so10662186lfc.13;
        Thu, 08 Nov 2018 12:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kEcdbfJ2HNYnRN0/FgfobUYeU6u6imgcWAdTBB9N4Jo=;
        b=USKSNKLB2W1MFEV/mpwGcpk/cj81e7Eeg42yS5PVpcJSDY8AuF3HH3NV/5b7z83DRD
         CrkV3Sry2f8wNPfMnk6kfFmSHTg8CByeHTlxL3gmJNeh0f6Spz5qWk/pF+hgo3OQDdiw
         HM76saJBeXTmsLS3HrD9gLl4LKgC0cYUyaNJIYxsXV8J2NtMqqgVlv2tPZPi2xyoaKna
         AU6i8z+jolqALZZe3F6tfUcRn9QQNysbQfSMiUDv0K2iUpnWEZDw0bSt5dgm5qdrpOaq
         oQeGp527gtf9iuewc4dA5GsUk/mjj/G5wCHti8mIowCKX9ms4MKx03m+HGpa275jYxF+
         LAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kEcdbfJ2HNYnRN0/FgfobUYeU6u6imgcWAdTBB9N4Jo=;
        b=XlygjNN6eEvbLNml7CZg0zz1FdbPTr0dUdYiKJbBRL4m0stKn5PCEPv7yIgTg1MrXI
         JzMB5GE1VFBXVnfUpddWZKavEZyfWzIgnmvWsBD/orZAaKqkkSKX2p/56VYXWMcgWQzM
         ZWzqBIUih6QhEt+kd01USslan3R01d7dA/vcaVaW1aocWOfgRRLajIe0bJAiLOTDPMoj
         7+8i5gU80oiTYAbVk1FD6SBB3jw50T0/k3ur/Upcsz6Wedpeb9Hg1kZWYC63IF+QgRkl
         k2dLeP1QpfGQeEXVr+KP583l1R6xOVlcGIzRL3b8tuA0olAwuZP1ZOCRkVFhkpZoyUJU
         F6Iw==
X-Gm-Message-State: AGRZ1gKOxPGi8at9Qhi0SPvCCMqdJSiTocODy3J4C4BnOxVnJtyuqBls
        Gfjva+IshbvrpkkhMH0UP80=
X-Google-Smtp-Source: AJdET5dY5lExtJ7H5g0R6UntgsyjHkWR5JioB/wSjpkwaQVo04RpGdz4cJjRWqiHjDX5h4Fn+2OxtQ==
X-Received: by 2002:a19:db4a:: with SMTP id s71mr3785578lfg.36.1541710078113;
        Thu, 08 Nov 2018 12:47:58 -0800 (PST)
Received: from [192.168.1.18] (dkl219.neoplus.adsl.tpnet.pl. [83.24.15.219])
        by smtp.gmail.com with ESMTPSA id o17sm843208lff.77.2018.11.08.12.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:47:57 -0800 (PST)
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <26714494-06f8-163d-1ef8-75f75c25a467@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c650a9eb-afae-2a27-e39c-d448a5b3eadd@gmail.com>
Date:   Thu, 8 Nov 2018 21:47:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <26714494-06f8-163d-1ef8-75f75c25a467@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 11/08/2018 07:00 PM, Dan Murphy wrote:
> Jacek
> 
> On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
>> Introduce dedicated properties for conveying information about
>> LED function and color. Mark old "label" property as deprecated.
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
>>  Documentation/devicetree/bindings/leds/common.txt | 52 +++++++++++++++++++----
>>  1 file changed, 44 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
>> index aa13998..3efc826 100644
>> --- a/Documentation/devicetree/bindings/leds/common.txt
>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>> @@ -10,14 +10,20 @@ can influence the way of the LED device initialization, the LED components
>>  have to be tightly coupled with the LED device binding. They are represented
>>  by child nodes of the parent LED device binding.
>>  
>> +
>>  Optional properties for child nodes:
>>  - led-sources : List of device current outputs the LED is connected to. The
>>  		outputs are identified by the numbers that must be defined
>>  		in the LED device binding documentation.
>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
>> +	    from the header include/dt-bindings/leds/functions.h.
>> +	    If there is no matching LED_FUNCTION available, add a new one.
>> +- color : Color of the LED.
> 
> Should we define the colors too?  There are only really 4.  Red, green, blue and white.
> 
> Generally varying colors are created base on the primary colors.  Even the amber color

No problem, I can add LED colors. However, I don't quite follow how
the mix of base color strings would give "amber" ? :-)

-- 
Best regards,
Jacek Anaszewski
