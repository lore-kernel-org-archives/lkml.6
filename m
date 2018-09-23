Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7B1ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555C3214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWhde9eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555C3214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeIWLmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 07:42:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35047 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeIWLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 07:42:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id v133-v6so262087pgb.2;
        Sat, 22 Sep 2018 22:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tq9bvVBhYJhxEf9Gn7mmNpxAVaVdpAByjBlJ2fL4DIo=;
        b=pWhde9eGE7Fq0gCBbhRMHYVsx9qERxcuFUdDEzw6oGUC0co1bJ2RYY8F13DzCNcwJS
         RJCNPgdfkjjS5r0DoWQdWq2Eo0giYypwllJclKMNhwX7RRvCk+tdukFaHkrFrvUQZWYr
         hVtuCv2i5Gik/7HWGW71Q9mexvHImeQyUcPOIheaK/DmwRm0mMHjgEHRJNnYghiE+soa
         Cft9YNsvQdVzOd/FPwW4qo38mKi3AyHlkZDDLTt16VQ2USP2BgvssAvTLIbt68s03Jif
         nxEeY3ZVuFeUbeZJ5alC8GAPGALf8OfvON8Lyw57GxsBuQGIyjF7JU9d3GCO3J6VOS7X
         gy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tq9bvVBhYJhxEf9Gn7mmNpxAVaVdpAByjBlJ2fL4DIo=;
        b=Qx1k84c8Cdg9kQ2K2dPDEazqwhKZkNjHIq+mN4qGJFuOW/fYa3xrzwZ2t7PO5sjheD
         rT2sud6AZuf/r9k8qqb7mEMjLXLpuvLz7C6pREsLpeQLPt087sRmrTPAwxf9k9tQO9Gt
         Z8R4ozx5j5ZezSFzHwHHhujw3lkGCl3xVzpAySEkpeEf1SVQm0vXWlo8WJEIzx+/pE3K
         2PH5PHjdQYQWNs3NuFujwKjyPrawFODitPX4Hy8TJl3KxDlC/5jMbTXXUdeP6dxk4sAW
         Q/vwpXUK9wFEgLqV+mJVabiOklhdysPrGNWc8LCLsTQMWy4VpeYBHNerBBC6BYw1lFeT
         aYww==
X-Gm-Message-State: APzg51CxBr1O/3BgP84ye0ANG+lUIbZEsU0DNPnyyifPh9TU/Ei7F5xc
        lDzr5bcYb9n6a/oi7IsOC82giiIb
X-Google-Smtp-Source: ANB0VdbedHPjvY2YJgjC6/EwYQV0EoWqg3DrMWk2tA4U9i1E27IGI9JFcncwBjLNkI46+kcRhVTZeA==
X-Received: by 2002:a62:cc83:: with SMTP id j3-v6mr4981393pfk.255.1537681552122;
        Sat, 22 Sep 2018 22:45:52 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m26-v6sm54502277pfi.102.2018.09.22.22.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 22:45:51 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: Add ina3221 documentation
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180923041118.8743-1-nicoleotsuka@gmail.com>
 <20180923041118.8743-2-nicoleotsuka@gmail.com>
 <353ccbbd-94c8-72eb-eb98-8a0507431e15@roeck-us.net>
 <20180923053151.GB9960@Asurada>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ce76fdf2-2894-96ad-d2f5-b2c25f197ee4@roeck-us.net>
Date:   Sat, 22 Sep 2018 22:45:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923053151.GB9960@Asurada>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/2018 10:31 PM, Nicolin Chen wrote:
> On Sat, Sep 22, 2018 at 10:19:42PM -0700, Guenter Roeck wrote:
>>> +2) child nodes
>>> +  Required properties:
>>> +  - input-id: Must be 1, 2 or 3
>>> +
>>> +  Optional properties:
>>> +  - input-label: Name of the input source
>>> +  - shunt-resistor: Shunt resistor value in micro-Ohm
>>> +  - status: Should be "disabled" if no input source
>>> +
>>> +  Example:
>>> +
>>> +  input1 {
>>> +          input-id = <0x1>;
>>
>> We'll have to find a better name for this. Feel free to look up examples in the
>> existing devicetree descriptions. The one that seems to be used most of the time
>> to indicate a channel index or id is "reg". It should also start with 0 - there
>> is no real reason for it to start with 1; it only makes the code more complex.
> 
> The reason is that the port start from 1 in the datasheet.
> 

Maybe, but for me I'll want to have something that we can reuse for other chips.
Having the index start with 0 for one chip and with 1 for another would be
confusing. It is bad enough that we have in[0..n] for voltages and temp[1..n]
for temperatures. I would not want to see the same in devicetree files,
and much less so on a per-device basis. It is also pretty common to start
channel numbers with 0 in devicetree files.

> I don't mind using reg or count it from 0, will look up to
> see if I can find something solid; otherwise, I'll wait for
> binding doc maintainers' opinions before sending v5.
> 
Sure, no problem.

Guenter

>>> +          status = "disabled";
>>> +  };
>>> +  input2 {
>>> +          input-id = <0x2>;
>>> +          shunt-resistor = <5000>;
>>
>> I would suggest shunt-resistor-micro-ohms as per
>> Documentation/devicetree/bindings/property-units.txt.
> 
> Will change it.
> 
> Thank you
> Nicolin
> 

