Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EFBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04C92086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUNjPqsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04C92086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeIZJvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:51:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43710 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:51:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so12640544pfi.10;
        Tue, 25 Sep 2018 20:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=64W1C74vpDhbawStvw0u/tZlcVLoJLUu6pxoy4LkJck=;
        b=AUNjPqsfxFYRBbMkj7zDSr9rxp9N9ryYWEulV0YrQFMnKJ/h2rs219Cr20c02Uormk
         O3GCsLXkXT+k5Jc7rtCW+CNF3baN0wx4uwQo3SLbV21Rx/KT/sBR1K3P/ia7u5p0rnhN
         iYxLtsxQ3CJUrYMV5ZE2EuoHMgh6fNiV2LgcxOQtTj7TYmUqL9pR63wZVRfxQKQloL4/
         k89e7dgCapl2oc9mQRFNIllC00ueLlQpNtuRBBAFpRcoiYdeCa29bjb+bz30eOHWPTQl
         ZL9j7KejYEOx3Jcbz0o20SHpMFiaPD0jmbGkMmqeoNwoot8/yvKb00nNR2ZELMRdGWo8
         kZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=64W1C74vpDhbawStvw0u/tZlcVLoJLUu6pxoy4LkJck=;
        b=AuAeoJKzr5NeHMi6gEoqVDKTvTIvaeF8E3mVLnxmhOjHy/8l1i7o1gyG/6Dxf5Ebi/
         nAYwyTvO7zAYaEhSXZX4m5BsqX3fV9DsH0PbfUCiCw73CshS1xxL1MLI+XRKMdkrhj3w
         RhBzPYQsXRKm0MVk491dknQal8Ky9DU20kvCvoejoVRcJDbM5txvZm+1VEllEXqKMigo
         eI3Ed+jlvrVJDrjFaABKsZ+RgdKIlCT5NOFwdrrG7wZHkXtm/WyhVJtlXMydjNuA2D+1
         pH29K3j0hni7qZPWF1G35whRTwR/VlnXPymTH97IE++w+p89zd7IOHw1pi1Xq5j38iXD
         EI6g==
X-Gm-Message-State: ABuFfojQIIyKGIJgm6k3fEYnEF+N92ugSBgJkfLc5s3St9rYWpKixwJ3
        BZMk85L+E5C9LaCQjDpNNI8rQk9a
X-Google-Smtp-Source: ACcGV633ZNXiBaSse0Ujus2ka90/74teZMkZxB5YCXy9T3plMeHvAErmcj63t4ARjxLnxM9/UrY6Pg==
X-Received: by 2002:a62:4b14:: with SMTP id y20-v6mr4076265pfa.93.1537933261849;
        Tue, 25 Sep 2018 20:41:01 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n9-v6sm6056809pfg.21.2018.09.25.20.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 20:41:01 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add ina3221 documentation
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180925225930.31886-1-nicoleotsuka@gmail.com>
 <20180925225930.31886-2-nicoleotsuka@gmail.com>
 <4f16baf7-b1bc-c7d2-3dd9-ed10b78d59b6@roeck-us.net>
 <20180926030857.GA458@Asurada-Nvidia.nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7896d6d6-c7c0-b462-3150-5ceff906bae0@roeck-us.net>
Date:   Tue, 25 Sep 2018 20:40:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926030857.GA458@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 08:08 PM, Nicolin Chen wrote:
> Hello Guenter,
> 
> On Tue, Sep 25, 2018 at 06:52:29PM -0700, Guenter Roeck wrote:
> 
>>> +2) child nodes
>>> +  Required properties:
>>> +  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
>>> +
>>> +  Optional properties:
>>> +  - label: Name of the input source
>>> +  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
>>> +  - status: Should be "disabled" if no input source
>>> +
>>> +  Example:
>>> +
>>> +  input@0 {
>>> +          reg = <0x0>;
>>> +          status = "disabled";
>>
>> I kind of feel embarrassed that I asked for the reg change ... especially while
>> saying at the same time that I would like to see this work for other chips
>> as well.
> 
> Well, though I didn't mention it, yet I changed it to "reg" is more
> likely an agreement than a compromise: I searched in the mail list
> and then found this mail (a year ago though):
>      https://www.spinics.net/lists/kernel/msg2455439.html
> 
> I feel it very similar to my case. So rather than betting Rob won't
> tell me the same, changing to "reg" may reduce a turnaround time :)
> 
>> Other chips have different kinds of sensors. Voltage, current, power, temperature,
>> and others. Whatever we come up with should support that.
>>
>> I see two possibilities right now. We can stick with reg and add a "type" property,
>> or we can make the index something like
>> 	{voltage,current,power,temperature,humidity}-{id,index}
> 
> One small concern is a case of being multi-type. For example, I saw
> ina2xx driver having voltage, current and power at the same time...
> 
Yes, with that we would have something like

	voltage@0 {
		type = "voltage";
		reg = <0>;
	};
	current@0 {
		type = "current";
		reg = <0>;
	};
	...

or

	voltage@0 {
		voltage-id = <0>;
	};
	current@0 {
		current-id = <0>;
	};
	...

>> I personally prefer "type", but I don't really have a strong opinion.
>> What do you think ?
> 
> I also like this over "reg" -- "reg" requires two extra properties,
> and itself sounds slightly unnatural to me for situations like this
> one where we don't use it as a register address, although I know it
> is convenient and common to use.
> 

With "type", we would still need two properties.

	reg = <0>;
	type = "voltage";

and type could be optional or not required for a chip only supporting
a single sensor type (like the ina3221).

This would be equivalent to, say,
	voltage-index = <0>;
when using a single property.

With the "reg" approach, we would be ok for now - however, I would like
to get feedback from Rob if introducing a "type" property will be
acceptable when the time comes to do so.

>> Or maybe we should really wait for feedback from Rob.
> 
> Personally I don't mind it all to change the doc and code and then
> send a v6. But eventually we'll still need the final Acked-by from
> Rob right? Then I guess it's the only option.
> 

Yes. At this point I'd rather have input from Rob than moving forward
with v6.

> By the way, I have two ina3221 hwmon patches that rebase upon this
> binding series. And I'd like to send them out to go through review
> first, but I am not sure if you'd be okay for it -- I don't really
> like to change their rebase order as it might mess up something.
> 
Are those bug fixes or further enhancements ? For enhancements,
it is your call when to send them; I am fine either way. If they are
bug fixes, they should come first so we can apply them to -stable.

Thanks,
Guenter
