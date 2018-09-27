Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EABDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53712170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GOrLG8DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53712170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeI1CKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:10:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45175 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeI1CKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:10:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id h6-v6so4659232eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3yjM3Iy/Hd7t2W7TMvAfVwjq4ZFChBdV6RM32+xONy4=;
        b=GOrLG8DP7Ou22I5ofp71ogWnaskBpgT6jLv2CuF+TA5af6GQsrcm0qdc+AHyl5hmgJ
         Lhez7u1z+UCUdo3owRhJGsXDEP71I2+G4QdKE8gzmIfwCYcuwziKlbwJXpyC4mcp2Vai
         gx2PHs7XUMGmmXvJpIVhCL2Pgni/LvRyBulZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3yjM3Iy/Hd7t2W7TMvAfVwjq4ZFChBdV6RM32+xONy4=;
        b=b3Zs4VnfeV8iG3CR3ZZJECgpVrUxPHfxS9vG11uASfgBH6LyguIp1PuUXzKrkXJCWL
         aoOxh4jI2ej9G7ICDR8TO7l4/+Us4vVKkJ/PTWF2CR4JtZ3Urdgk7smjyTV5uh9dv1Bq
         zfT5VXx6QzeoXMESWLEYHMScNX5RpThOIovVeV5IJFmYi66+TLObm655Do9sh4WXfQWW
         4sSi9rdGtE9ghqJgTXHXGE/N4sC/mmyKlU4PL+WUzPWMNIQGghq36ljsgPyWgS/UaHNe
         tlwmUToWXN+JFUa3mEoF2s79P/dN3iw9G3THGGDJxnqjomit3leb10zpDpkrSbBnNUAm
         ILxA==
X-Gm-Message-State: ABuFfog48VY2ZR/d8SbdjLo3+5nI8M5B+KfU8/eMfRvb4xtvwYH2iRIX
        d0m2WfjkI/5+f0OngzQojgU0Kg==
X-Google-Smtp-Source: ACcGV60/F+3D3iLQRPa7gvpMrWxCB8bxEXDhUHOjXd5U1leAGQcEqhcZpuuvGI17smi+cMbFZP+6uA==
X-Received: by 2002:a50:91ad:: with SMTP id g42-v6mr20610899eda.43.1538077827891;
        Thu, 27 Sep 2018 12:50:27 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m42-v6sm1326832edd.46.2018.09.27.12.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:50:26 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
References: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
 <1538062603-7490-2-git-send-email-srinath.mannam@broadcom.com>
 <20180927172758.GA17761@bogus>
 <b1099893-f704-8ca6-a945-2711d6945a0f@gmail.com>
 <f20afabc-e712-8f35-8dd6-d42b9a0131f0@broadcom.com>
 <20180927185943.GA31385@bogus>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <70fc705c-4629-ed4b-e700-6555a4278428@broadcom.com>
Date:   Thu, 27 Sep 2018 12:49:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927185943.GA31385@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-09-27 11:59 AM, Rob Herring wrote:
> On Thu, Sep 27, 2018 at 11:00:33AM -0700, Scott Branden wrote:
>>
>> On 18-09-27 10:31 AM, Florian Fainelli wrote:
>>> On 09/27/2018 10:27 AM, Rob Herring wrote:
>>>> On Thu, Sep 27, 2018 at 09:06:41PM +0530, Srinath Mannam wrote:
>>>>> From: Pramod Kumar <pramod.kumar@broadcom.com>
>>>>>
>>>>> Add binding document for supported thermal implementation
>>>>> in Stingray.
>>>>>
>>>>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>>>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>> ---
>>>>>    .../bindings/thermal/brcm,sr-thermal.txt           | 25 ++++++++++++++++++++++
>>>>>    1 file changed, 25 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>>> new file mode 100644
>>>>> index 0000000..717617b
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>>> @@ -0,0 +1,25 @@
>>>>> +* Broadcom Stingray Thermal
>>>>> +
>>>>> +This binding describes thermal sensors that is part of Stingray SoCs.
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible : Must be "brcm,sr-thermal"
>>>>> +- reg : memory where tmon data will be available.
>>>>> +- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
>>>>> +                  Each bit represents single TMON source.
>>>>> +- brcm,max-crit-temp: Maximum supported critical temperature.
>>>> We already have a defined binding for setting trip points.
>>> Indeed, and if you have multiple TMONs, they would in premise possibly
>>> each have a different critical trip point.
>> Which may be a good reason to go back to our original bindings which were
>> generic and had each sensor in its own node?
> Perhaps. I wouldn't call it going back to your original, but rather
> defining a complete binding. Of course, if you don't need different trip
> points, then again that is just unnecessary bloat. But I can't argue
> whether you do or don't.
We currently do not need different trip points as detailed analysis of 
each sensor's trip point has not been needed.  If we do add different 
trip points per sensor the node per sensor approach looks very 
flexible.  Call it what you like: Srinath's original driver.
>
> Rob

