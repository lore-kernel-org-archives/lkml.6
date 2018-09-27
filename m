Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D99C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E192172E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L5dA4XKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E192172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeI1AUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:20:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41385 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeI1AUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:20:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so5853822edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=n3ktsnD+yok69VnSyFU16j3H/ZpzQu/cKDfNwOD/jjk=;
        b=L5dA4XKHOBofkJGfn7HJJ0rWi9hwX9VEEFFI7x4t3uOi/2od+dyrKXvcNcTEHfU4lM
         9uwJINri+LNat5XPBR8nycrwDOoQYypcGV3OWnoCPCRWSJymvP69Jy3V0ohpotVOfMZs
         3J5okCT4UPjVmr9XXMd8s6LomVUuujkfYwepo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n3ktsnD+yok69VnSyFU16j3H/ZpzQu/cKDfNwOD/jjk=;
        b=f8ZKvcxFtAN3Mp5PzEyrCZs5mxyBiYwvq3TAeg0zmZKVniI4MIHFY2btt1Q1MGPy6Y
         Dpx7XcD/Anj1KBYzv0NJcgUkcfk5S0ArM/+tdntxCD6nBeFFiPpJRvdKqCE8dT+kI4SG
         sEnrCBhbPSvFQyflcBXDgM/07koaNOSRXdOqT9p9FUYMmA1/acgl7bMz0nLhnlMhbtBv
         SePx2xn8kN8P3IG4yyeh2VbbM3STo2d97WC2GAq05ea25IiQG5VI8ktzmTiMybtvRON3
         kITzPMLGYpNlsg8S6Q0UfVNme1Gc2VzJ0SIhyCofL8zH1KhsUCV1f7EihfbrEHr/mEaY
         0MVw==
X-Gm-Message-State: ABuFfogf3cDfxH/eNVV8iaJULENsVemTCvh0GK87jVB8maTho6MfYM4l
        j5Uz6FbJp0upDoNC/MAlmjQWKw==
X-Google-Smtp-Source: ACcGV63/06WDcQTH/E5gdbU5nBN2Ff+ZqrTks/w/q3QcwMddkQ7PHJQwP2Kc3uqO7hjXYzPvO8IQTA==
X-Received: by 2002:a50:aed4:: with SMTP id f20-v6mr19231643edd.271.1538071266964;
        Thu, 27 Sep 2018 11:01:06 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k5-v6sm209554eja.44.2018.09.27.11.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 11:01:05 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
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
 <b1099893-f704-8ca6-a945-2711d6945a0f@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <f20afabc-e712-8f35-8dd6-d42b9a0131f0@broadcom.com>
Date:   Thu, 27 Sep 2018 11:00:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b1099893-f704-8ca6-a945-2711d6945a0f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-09-27 10:31 AM, Florian Fainelli wrote:
> On 09/27/2018 10:27 AM, Rob Herring wrote:
>> On Thu, Sep 27, 2018 at 09:06:41PM +0530, Srinath Mannam wrote:
>>> From: Pramod Kumar <pramod.kumar@broadcom.com>
>>>
>>> Add binding document for supported thermal implementation
>>> in Stingray.
>>>
>>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>   .../bindings/thermal/brcm,sr-thermal.txt           | 25 ++++++++++++++++++++++
>>>   1 file changed, 25 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>> new file mode 100644
>>> index 0000000..717617b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>> @@ -0,0 +1,25 @@
>>> +* Broadcom Stingray Thermal
>>> +
>>> +This binding describes thermal sensors that is part of Stingray SoCs.
>>> +
>>> +Required properties:
>>> +- compatible : Must be "brcm,sr-thermal"
>>> +- reg : memory where tmon data will be available.
>>> +- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
>>> +                  Each bit represents single TMON source.
>>> +- brcm,max-crit-temp: Maximum supported critical temperature.
>> We already have a defined binding for setting trip points.
> Indeed, and if you have multiple TMONs, they would in premise possibly
> each have a different critical trip point.
Which may be a good reason to go back to our original bindings which 
were generic and had each sensor in its own node?
>>> +
>>> +Example:
>>> +	tmons {
>>> +		compatible = "simple-bus";
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		ranges = <0x0 0x0 0x8f100000 0x100>;
>>> +
>>> +		tmon: thermal@0 {
>>> +			compatible = "brcm,sr-thermal";
>>> +			reg = <0 0x40>;
>>> +			brcm,tmon-mask = <0x3f>;
>>> +			brcm,max-crit-temp = <105000>;
>>> +		};
>>> +	};
>>> -- 
>>> 2.7.4
>>>
>

