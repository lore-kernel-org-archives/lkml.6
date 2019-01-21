Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB8EC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7750721734
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVAuiDTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfAUVoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:44:20 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35478 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfAUVoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:44:20 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so17301260itp.0;
        Mon, 21 Jan 2019 13:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2yZGcezbPhMzKa+vw2OZunQnsxNjmz81ifZewAWaKQE=;
        b=sVAuiDTYxK2uNlf9cgRCCiTBFvceOd664P2Ex6sVuVeKSgJG5oznTA/VFYzVElQXqg
         8kFGq/4TBfgQSKaPZYlg+gzckX/BatxMpFSEh54VUOy17bPHvHPJAaHuJ+jQDHOYmbzm
         sx2tPndDr16fbjhn9W7UYFmpjvPy4rDsQ4AWBNSyAoDq8EAauTX1jv3+FtzSty0GJzqz
         WQss+6O/OrffUs2KwaCDX59R3qmqhOflJv6/Yoh4Dfd4kDKC8Hno4dIi4C+hS+lRTaBD
         TRjE8k2RW9LWiEI4kJIwBcCmz0LqkoZnPFkvhQhbF7E7qeaaTONWKwlrZzNJNheTYcTU
         yJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2yZGcezbPhMzKa+vw2OZunQnsxNjmz81ifZewAWaKQE=;
        b=TR6VLgBKjViXaPYnm/vyhZxRH5eH4noGhKIlq5xsP+YuN6JVTXBmku9XnbxBmgbqFr
         radcBBe6lRjczwAqjmX1UV/oizNYrT3EP+DHYL8hm/w4QRZrkY64ni75aQ6HjnnsG7Gq
         0ez8djcyjzATvoDoAOJP9/OGGfTILJbsgRdO6HazDY30pxJUki31GR+qCuZ1aITryIAb
         TIot1cVZAeX902ouiWd4n0MnDwf8NQIsr5iQOCZgaGXKNAsqxSHdqTJhE/lLFQ57l4CR
         tyFWmeOzbn0mv1FP3wyACh9CW/NJGGraHaBYyWhPUGawa4jsUgJ9oIbLzJkbf3WfUPWG
         iYkg==
X-Gm-Message-State: AJcUukevFFKHP5OWZjlzjZMItmEOV9SYm43Uro9vix5jtY82b13j9AKo
        OONNtQY8Aeg05xMv2con/W4=
X-Google-Smtp-Source: AHgI3IbL4+nTOs60IjjDVd1icOGsT5rvKTjDoK1kylIitdJBwzl11B5q6/bBD4XidvxU3Z2C2XPaKA==
X-Received: by 2002:a24:a701:: with SMTP id a1mr704487itf.7.1548107058899;
        Mon, 21 Jan 2019 13:44:18 -0800 (PST)
Received: from [192.168.1.133] ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id n129sm7248748itb.20.2019.01.21.13.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 13:44:18 -0800 (PST)
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: chemical: Add bindings for
 bme680
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, himanshujha199640@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
 <20190111205359.14158-2-sebastien.bourdelin@gmail.com>
 <20190112182837.4cc42743@archlinux>
 <4768d945-61aa-a8ab-3e41-68b4f861cc69@gmail.com>
 <20190119165709.5045a18b@archlinux>
From:   sebastien bourdelin <sebastien.bourdelin@gmail.com>
Message-ID: <31759389-7498-6478-2408-a6de2fde9fc1@gmail.com>
Date:   Mon, 21 Jan 2019 16:43:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190119165709.5045a18b@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/19 11:57 AM, Jonathan Cameron wrote:
> On Mon, 14 Jan 2019 15:17:10 -0500
> sebastien bourdelin <sebastien.bourdelin@gmail.com> wrote:
>
>> On 1/12/19 1:28 PM, Jonathan Cameron wrote:
>>> On Fri, 11 Jan 2019 15:53:59 -0500
>>> Sebastien Bourdelin <sebastien.bourdelin@gmail.com> wrote:
>>>   
>>>> BME680 is a pressure/temperature/humidity/voc sensor.
>>>>
>>>> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
>>> Hmm. We could add the VDD and VDIO regulators perhaps.
>>> Driver assumes they are on currently but we'll get a board where control
>>> is needed sooner or later.  I'm not that fussed about this though.
>> If that's fine with you, i prefer to leave it as it is right now as i
>> don't feel
>>
>> confident enough to correctly explain it in the Documentation.
>>
>> But if you have more input, you are more then welcome!
> Given we aren't planning to do more than turn them on and that'll work
> fine with stub regulators (so they can effectively be optional for ever),
> there is no particular need to put them in now if you prefer not to.
>
> Jonathan
Ok Thanks Jonathan!
>>> Jonathan
>>>   
>>>> ---
>>>>    .../devicetree/bindings/iio/chemical/bme680.txt       | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/chemical/bme680.txt b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
>>>> new file mode 100644
>>>> index 000000000000..885a1b918340
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
>>>> @@ -0,0 +1,11 @@
>>>> +Bosch Sensortec BME680 pressure/temperature/humidity/voc sensors
>>>> +
>>>> +Required properties:
>>>> +- compatible: must be "bosch,bme680"
>>>> +
>>>> +Example:
>>>> +
>>>> +bme680@77 {
>>>> +          compatible = "bosch,bme680";
>>>> +          reg = <0x77>;
>>>> +};
