Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A8DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE95720849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aw8+63Nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE95720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLKJ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:27:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43927 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:27:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so13270651wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AMRPkdn+nSv7Eh6FnhE8H8pu3kZ1UeB8RkXs9OKdomQ=;
        b=Aw8+63NbNhZVr20dbfq2OCvJfwq27ZAoQoT93rJnCjtCa3IGhwzpvdZrAlJ6ayNCHo
         EeQDaaP9TWUuylcGGc57rmAmgHDS1qZEO8WeO/guTenT7Ti+8isC3aRu/pmGP65vIt+o
         wc5dwo5hubSdkHSzEptmLUXuGVM+GULmIC+2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AMRPkdn+nSv7Eh6FnhE8H8pu3kZ1UeB8RkXs9OKdomQ=;
        b=W5+wTEj6EifmAyqvzGt+a9SUFKgMf2yFVtOqI/h27iydzneLeWpJb/NbkwIqLMGkYg
         rKNBxW6O8ziiHmj1pCQ7VR8Rg21F6zGy9kkrVUDsue9neiJYY7b852LY1uoE5nwMxjSd
         0DONX8SPEr1YbmnTXZtaTXPSdWmFIl/md7YS6Hkwi0N5Sg0qx+VfwpkfLaksCmsKi6ZD
         I6c7h+wGaEe/XHGpPS2HUDIMKZ7wLFFa0hGDftpeQLKnd3p3f1t/asxtNuf/lRg5P3k8
         5w9GCzPWARHpsabe0wP2cNL3q+H2SUYuFnUfMQ8+rd+xafc9sVuinD9tiMPKuRZ0O0Yv
         E+sg==
X-Gm-Message-State: AA+aEWbUX+8uqFjiER+Io0c1+EIHc1bHi1h87x//08XWmdaKWPU0i2wC
        OBJhFh4igq9eiOpB/EC0+jcE4+JiRSw=
X-Google-Smtp-Source: AFSGD/WYvCmv4dhfIt5vkyJ4+8JEn2YwMlBj3DZBE03XtoMCuYkXtj+g3ixjjIKbMFxpj5XrHjexbg==
X-Received: by 2002:adf:f1c2:: with SMTP id z2mr13393085wro.218.1544520424260;
        Tue, 11 Dec 2018 01:27:04 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y13sm14895401wrw.85.2018.12.11.01.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 01:27:03 -0800 (PST)
Subject: Re: [PATCH v2 1/6] misc: dt-bindings: Add Qualcomm Fastrpc bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-2-srinivas.kandagatla@linaro.org>
 <20181207182327.64mtkfx6v4wlwccz@lakrids.cambridge.arm.com>
 <afdeecc4-4ee9-e933-9917-9930ece85b00@linaro.org>
 <20181211001050.GA1578@tuxbook-pro>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3533d3d6-d60f-452f-87bf-d5e89ac1a2bb@linaro.org>
Date:   Tue, 11 Dec 2018 09:27:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181211001050.GA1578@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/18 00:10, Bjorn Andersson wrote:
> [..]
>>>> +- reg
>>>> +	Usage: required
>>>> +	Value type: <u32>
>>>> +	Definition: DSP Processor ID.
>>>> +	Possible values are :
>>>> +			0 - ADSP
>>>> +			1 - MDSP
>>>> +			2 - SDSP
>>>> +			3 - CDSP
>>> Why is this in a reg?
>> This is to identify which type of dsp(Audio/Modem/Sensor/Compute) it is,
>> This information is used to create device nodes for user-space access.
>>
> But it does not represent FastRPC's address on the rpmsg bus. How about
> replacing it with a "label" (or "qcom,domain" perhaps?) of type string?

Yes, we could replace reg with label in this case. I don't have any 
particular preference TBH.

I did try to something similar to "qcom,domain" for apr and Rob H 
suggested to use reg instead during review!

thanks,
srini
