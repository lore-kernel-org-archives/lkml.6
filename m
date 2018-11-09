Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4899C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E02A20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5CZz7os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E02A20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeKJGY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:24:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33253 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeKJGY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:24:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so2291886lfc.0;
        Fri, 09 Nov 2018 12:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EicsfJjbxmnOxlY5wu7LX8cpcT21JFm1l3YAUagB6vo=;
        b=o5CZz7osWirVig3z/u/H9SbqmGMsZ7xIGLYRnovUbC7Iu6NcFRNKWnNRbyBV/bggBg
         Yj+ghZPeGHhOLN7E+DDsPtLS1q0pWgg3UTQ34d5WoFMvcE058OPhiecHFXyBBmSJWOma
         BrkgF+lp8tuaUdomFVXVCE+kg6aNMV/GOefBQb5ZnzPA/RA1o+4AH2yww9OaglHOIICE
         SQm/m0WbrzGlqrf7ZrNsJMEqOK1b0nhLQziypOPFEgB8FYkST4KktYgtyQhBkBIbezGx
         g6hTaTat0svSf0IVqGeH7hZ+bLGc09w1AAI98LWpVwEY++0hNyjQZfo5MwkmAynDPLih
         z2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EicsfJjbxmnOxlY5wu7LX8cpcT21JFm1l3YAUagB6vo=;
        b=bU8m6F3nEmTNjzLsPMB7ahrFnfp9egatinhELUQ3g/NTNKN/SLbdL3hlPWQ7i5wCIk
         l4TOlm5E0uBbxBpLJLk52QuvZ0d/mpjuv0Qvxzi2/fNyFTP75JtIJBbLeuWKYE9SoMGb
         AujOQRauDh9tSqRKCi+FjX7yETIxLytsjqOj1abJh8WkyqAyA6/78KkdviaYriRMiJDn
         +ml7Rhe7b+HN2eCRTZkZTv+gcJYhs6lfrTmJcsv+o2+IE6dnX+IjKzcrZVWL4785oJnr
         W6ngswuAuhhgB3JCjX3PsavVOrhkHH0BiqFTVczPJquD+TsfUStIyFufHgVBv+UJwVv4
         4y+w==
X-Gm-Message-State: AGRZ1gLS8FB1v/c2UGaBwonsaNBU4d7yRNGw4332742XlwkaT2jpBxhe
        3hc4Zk8nMFnN8T3R0A5Ki9s=
X-Google-Smtp-Source: AJdET5eRMC7ai3Tt58XXMGKaX0EyJhDG+iKQrklI6L6K1vPuf49ZkEcQJ6UpcU3pJVdHdF3L09K18Q==
X-Received: by 2002:a19:aace:: with SMTP id t197mr6221436lfe.7.1541796130840;
        Fri, 09 Nov 2018 12:42:10 -0800 (PST)
Received: from [192.168.1.18] (coo53.neoplus.adsl.tpnet.pl. [83.31.194.53])
        by smtp.gmail.com with ESMTPSA id a9sm1574888lfa.19.2018.11.09.12.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 12:42:10 -0800 (PST)
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <bdd18dc6-0dee-5957-81d4-39254c7ad74d@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <be4e75ed-746e-ed55-0bbe-0fd710bd4162@gmail.com>
Date:   Fri, 9 Nov 2018 21:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bdd18dc6-0dee-5957-81d4-39254c7ad74d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vesa,

On 11/09/2018 09:32 AM, Vesa Jääskeläinen wrote:
> On 07/11/2018 0.07, Jacek Anaszewski wrote:
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
>>   Documentation/devicetree/bindings/leds/common.txt | 52
>> +++++++++++++++++++----
>>   1 file changed, 44 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/common.txt
>> b/Documentation/devicetree/bindings/leds/common.txt
>> index aa13998..3efc826 100644
>> --- a/Documentation/devicetree/bindings/leds/common.txt
>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>> @@ -10,14 +10,20 @@ can influence the way of the LED device
>> initialization, the LED components
>>   have to be tightly coupled with the LED device binding. They are
>> represented
>>   by child nodes of the parent LED device binding.
>>   +
>>   Optional properties for child nodes:
>>   - led-sources : List of device current outputs the LED is connected
>> to. The
>>           outputs are identified by the numbers that must be defined
>>           in the LED device binding documentation.
>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed
>> definitions
>> +        from the header include/dt-bindings/leds/functions.h.
>> +        If there is no matching LED_FUNCTION available, add a new one.
>> +- color : Color of the LED.
> 
> We have had for years out-of-tree patch for multi color gpio led driver
> which extends this concept with multiple colors. Then in sysfs there has
> been possibility to control the color and otherwise use blinking or
> other features.
> 
> Our need is multi color status led of the device which includes
> different kind of blinkings and colors on different situations.
> 
> Current in-tree gpio led driver just wasn't atomic enough and a bit
> clumsy interface for handling this.
> 
> Now that this is being looked at could we come up with solution that we
> could define multiple colors for one led in device tree and then we
> could work on getting the driver upstreamed?
> 
> What we did was generally:
> 
> leds-multi {
>     compatible = "gpio-multi-leds";
> 
>     status {
>         gpios = <...>;
>         linux,default-trigger = "none";
>         deafult-state = "keep";
> 
>         color-red {
>             pin-mask = <0x01>;
>         };
> 
>         color-green {
>             pin-mask = <0x02>;
>         };
> 
>         color-orange {
>             pin-mask = <0x03>;
>         };
>     };
> };
> 

Device Tree node implementation doesn't actually say too much
about the sysfs interface you came up with, which is most vital
in this case.

Support for RGB LEDs, or other variations of LED synchronization
have been approached several times, but without satisfying result
so far.

Generally the problem boils down to the issue of how triggers
should handle multiple synchronized LED class devices in a backwards
compatible way with monochrome LEDs.

At some point the HSV [0] approach was proposed, but there was a problem
with getting uniform colors across devices. Especially white.
Certainly a calibration mechanism would be required.

[0] https://lkml.org/lkml/2017/8/30/423

-- 
Best regards,
Jacek Anaszewski
