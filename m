Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5F8C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505AD2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltGJ1qE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505AD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJLDHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:07:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38804 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeJLDHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:07:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id v7-v6so9312220ljg.5;
        Thu, 11 Oct 2018 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RVD1QeC4Rgyzzsq0lIDVEru40UkmjvaVTLg9ogzMLSI=;
        b=ltGJ1qE52kub4dwDDvURr74OaByDn/ibcWGcMpT2a+9q1HvodD4BgF42eCGSQzHKJq
         eZ18y8DLUAjFPUW3glsP4pe87GK0oHpJjHiHsxWewEx+ICpzq8FyoXe0tbie6oonoU+6
         oAP/g34c7ZipYjqhbnbHY+6+EJakkv+oid0H/+a2FAA1TzLO62mf6u8BCz+9Tubf8Db6
         QlFSAZuOzQS4AQy4pGvFJwNyS6eYFwaxIM9Aly2FqHDDrKIssSdrwS7jHyHUFpfwdM01
         McGiU+giRdJzbz86oaZeD8q7+E5ylI0k6IDdU1pDZ1LcPAMlA+iXVmnvgmo2L2d+dvg5
         MuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RVD1QeC4Rgyzzsq0lIDVEru40UkmjvaVTLg9ogzMLSI=;
        b=H6+s+bvvJsWcpCwsjl4MLRcljQWqMigGWY0L9r2Jf2bZ7753FMGsAvWwQFuFBSi6ce
         fsb4gY6hr17DSZ0ibsb6ud8x/GxIe4CeAXF6HqReGyJEKVd/Ftzdy0oYWVzE4J8AnlXB
         zT8KK+dAQUf5rog0PNMpwZAep7LpT00Og4f2oxdUaSErk8u8L7wC/wPbZjKcNLkZAgOH
         acsj9XqlNqQ7SbqwBtI7yUf7CGkqQNomwWmtK7Hsc2wlSzBKVdB9PYzaq+JlaZbA4kBg
         d9GmM5krbKqb7l77YoYsXyNKe1aoJqDCEDs2jlzak6h2PjI1qgVzTrVWQs4tfcHvf/Ul
         nJVw==
X-Gm-Message-State: ABuFfohPlwf+WTmI8BSCt6KrfCJtwbdcXN6mN1Dp+NvF6vMxHzyHV6Uy
        +ADWttMm1d3684ekxTg50oVpVlNd
X-Google-Smtp-Source: ACcGV61B2XjcEvfIiN0FDb9JSStIYCVZ8X/htfcDzW7O/WiJTl09Kj1fNBG2v72JlOachgF7zqHqug==
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr2261896ljj.80.1539286737381;
        Thu, 11 Oct 2018 12:38:57 -0700 (PDT)
Received: from [192.168.1.18] (dkt144.neoplus.adsl.tpnet.pl. [83.24.23.144])
        by smtp.gmail.com with ESMTPSA id p11-v6sm6521271lji.87.2018.10.11.12.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:38:56 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-3-dmurphy@ti.com> <20181011182734.GA7973@amd>
 <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
Date:   Thu, 11 Oct 2018 21:38:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 08:34 PM, Dan Murphy wrote:
> Pavel
> 
> On 10/11/2018 01:27 PM, Pavel Machek wrote:
>> On Thu 2018-10-11 11:51:16, Dan Murphy wrote:
>>> Remove support for the LM3697 LED device
>>> from the ti-lmu.  The LM3697 will be supported
>>> via a stand alone LED driver.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>
>> NAK.
> 
> Thanks for the NAK.
> 
> This NAK was NAK'd by other maintainer in the V2 RFC patchset
> 
> https://lore.kernel.org/patchwork/patch/993171/

I confirm. LM3697 is a standalone device and not a cell of any
MFD device.

Waiting for DT maintainer's ack.

Best regards,
Jacek Anaszewski
								
>>> index c885cf89b8ce..920f910be4e9 100644
>>> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>>> @@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
>>>    LM3632       Backlight and regulator
>>>    LM3633       Backlight, LED and fault monitor
>>>    LM3695       Backlight
>>> -  LM3697       Backlight and fault monitor
>>>  
>>>  Required properties:
>>>    - compatible: Should be one of:
>>> @@ -18,11 +17,10 @@ Required properties:
>>>                  "ti,lm3632"
>>>                  "ti,lm3633"
>>>                  "ti,lm3695"
>>> -                "ti,lm3697"
>>>    - reg: I2C slave address.
>>>           0x11 for LM3632
>>>           0x29 for LM3631
>>> -         0x36 for LM3633, LM3697
>>> +         0x36 for LM3633
>>>           0x38 for LM3532
>>>           0x63 for LM3695
>>>  
>>> @@ -38,7 +36,6 @@ Optional nodes:
>>>      Required properties:
>>>        - compatible: Should be one of:
>>>                      "ti,lm3633-fault-monitor"
>>> -                    "ti,lm3697-fault-monitor"
>>>    - leds: LED properties for LM3633. Please refer to [2].
>>>    - regulators: Regulator properties for LM3631 and LM3632.
>>>                  Please refer to [3].
>>> @@ -220,24 +217,3 @@ lm3695@63 {
>>>  		};
>>>  	};
>>>  };
>>> -
>>> -lm3697@36 {
>>> -	compatible = "ti,lm3697";
>>> -	reg = <0x36>;
>>> -
>>> -	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
>>> -
>>> -	backlight {
>>> -		compatible = "ti,lm3697-backlight";
>>> -
>>> -		lcd {
>>> -			led-sources = <0 1 2>;
>>> -			ramp-up-msec = <200>;
>>> -			ramp-down-msec = <200>;
>>> -		};
>>> -	};
>>> -
>>> -	fault-monitor {
>>> -		compatible = "ti,lm3697-fault-monitor";
>>> -	};
>>> -};
>>
> 
> 

