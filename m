Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA6EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588A821571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxZvokNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588A821571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeI0Xus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:50:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42309 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeI0Xur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:50:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so5772618edr.9;
        Thu, 27 Sep 2018 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OMTtJMhxXR9NVbHNvWG7YYMqd9OA6DI+PT0LHupkNhw=;
        b=JxZvokNP/OVJzO1q2mhoBHcLcPG00qrdxdkZInge0pTnSjdiIbI0ejtRGZGuW+ub/h
         aMAt0nr4gXVYVRdP2wGaxZuB2MIB2xm6NOT17Fv7SP39tPg1JAUU4s1zyHlcfY9A4fCm
         4CT9sNRF9AudMsU8voTdhO2lGEPL0U34gIx5FkJQXNX1ZyBLrzG0nj1Y01XZu5xNoYCv
         ge4hTsdB3mPlEBhKMJG5fT2CDpKcIp+zvgl0f0eIwaMT5Bg8NXBQnu8OZcIqNJlFKou+
         1HBVJ/p2Q6ZaVS9h1k9cwtPdx73eh1uPtYx5iY+TV5YJbf5i1c5sUkWQdDPOlbvWXeDB
         5sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OMTtJMhxXR9NVbHNvWG7YYMqd9OA6DI+PT0LHupkNhw=;
        b=B4VmdIvvgxrEjGmPWM14IUxkj8oN0lAWQEkYsr8A+QtJyhrJG3p8U/1veXP9ehn7Ke
         AG5N1YnQ9/4FY3BIE7IAbY9elTStcbEg/Bglwegurtfgj4nsLb2jM0fIi6ONOVq73tg/
         eTeZtQobpIBpSl192AI8729B4jT03yobLVjkPCrjkC5gW045s+ojg2tpqQh6/757MecH
         KxP5QuMXjIwllRLcls6kOGkS1HMvPdISiUnQmMKJ7fLDBzspzKztHPWQHGH3EAZkEiRr
         5HH+LO+8EYWu6nF8/+5lZAiB5WcMVv5PjKyshB/LVor3F5qC2YkLzYYTS42BwkNZpDgu
         Op1w==
X-Gm-Message-State: ABuFfoj9zw2lStDakb2BQybaf8y0BLFrJSVqSzt1gl02iU0d573Pdwd3
        JbGgWXZo6sj3ELhVoms47TU=
X-Google-Smtp-Source: ACcGV60B8rQ45b+WazNbPPHqkYxOJRljPmNs5Ie/KTNgDwrD2Tiymh4RWshgD2lLYR97sJbO5Zcn4A==
X-Received: by 2002:a17:906:6ad4:: with SMTP id q20-v6mr3086066ejs.235.1538069485481;
        Thu, 27 Sep 2018 10:31:25 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id a16-v6sm191061ejv.65.2018.09.27.10.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:31:24 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
To:     Rob Herring <robh@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
References: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
 <1538062603-7490-2-git-send-email-srinath.mannam@broadcom.com>
 <20180927172758.GA17761@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <b1099893-f704-8ca6-a945-2711d6945a0f@gmail.com>
Date:   Thu, 27 Sep 2018 10:31:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927172758.GA17761@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 10:27 AM, Rob Herring wrote:
> On Thu, Sep 27, 2018 at 09:06:41PM +0530, Srinath Mannam wrote:
>> From: Pramod Kumar <pramod.kumar@broadcom.com>
>>
>> Add binding document for supported thermal implementation
>> in Stingray.
>>
>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  .../bindings/thermal/brcm,sr-thermal.txt           | 25 ++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>> new file mode 100644
>> index 0000000..717617b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>> @@ -0,0 +1,25 @@
>> +* Broadcom Stingray Thermal
>> +
>> +This binding describes thermal sensors that is part of Stingray SoCs.
>> +
>> +Required properties:
>> +- compatible : Must be "brcm,sr-thermal"
>> +- reg : memory where tmon data will be available.
>> +- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
>> +                  Each bit represents single TMON source.
>> +- brcm,max-crit-temp: Maximum supported critical temperature.
> 
> We already have a defined binding for setting trip points. 

Indeed, and if you have multiple TMONs, they would in premise possibly
each have a different critical trip point.

> 
>> +
>> +Example:
>> +	tmons {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x8f100000 0x100>;
>> +
>> +		tmon: thermal@0 {
>> +			compatible = "brcm,sr-thermal";
>> +			reg = <0 0x40>;
>> +			brcm,tmon-mask = <0x3f>;
>> +			brcm,max-crit-temp = <105000>;
>> +		};
>> +	};
>> -- 
>> 2.7.4
>>


-- 
Florian
