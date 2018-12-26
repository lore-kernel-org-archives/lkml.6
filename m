Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C97C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FE6214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfwxmskI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeLZRzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:55:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55903 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbeLZRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:55:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so14952782wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 09:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XD5GwOCYGmsfl9NX6pGxB9PT43U39Ax78jmvM+rJXlM=;
        b=DfwxmskI+blaMa9oTM83Muz+PUgBNMGihlDCpVO2qLGBkj0UPFMFuOnyE4oPujQYXS
         C0tFz28SsK4psUNAUcphxe5s4yyCU8eBYIffr/nzOEypFA7ROdW4wq3XyVudmL+MZ0b1
         ueDWsUhb7f/fZcsNAsWP2VObVm39mloowRbnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XD5GwOCYGmsfl9NX6pGxB9PT43U39Ax78jmvM+rJXlM=;
        b=OyO4ymhC5YvZONoy7bOL8IMW/4wXieNUzGZtdg9wJJhKp8FsxtXSCOH5tAA2oX3JQI
         wEXMKpTaCD13dhHqW1jfwfmqF/G3n3lTPxMrpAWb7VQG3tuWtohx8NuTAo4eVQ4YWxAy
         E+qHGjQEgsaoOxLK/Wwmm/ObQnjxXh2qWDLRscoH4lzGUQt+LI9CvvzbywwT6EDMHZuW
         X0PH4ZYknHcxvDWz/wV6t9YVe4OKHr+Cuyiwcr2d/Es2BRKV6pShgkPel9HQnldBZfia
         Vq59TfiMI4jelaEAfy8Qpxeg2kKUEJDfuqHQal8I/+LJitSuP/LPIteadsUwgULqm8NY
         AEMw==
X-Gm-Message-State: AA+aEWZbIubnFPi45apV4bJ63bFUFrhBCdBencuKPQOmm427eO19ykqB
        6zeX28a5E9XGKSkMOP1wCIzgYg==
X-Google-Smtp-Source: AFSGD/UtLmG2xHr5SooXscLmEh4EgPP+g8cziwWw/94al7/uT1/culJVmppnJ1C00tHaqKmC0voDMw==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr19088736wmb.28.1545846902517;
        Wed, 26 Dec 2018 09:55:02 -0800 (PST)
Received: from [192.168.1.2] (227.red-79-146-82.dynamicip.rima-tde.net. [79.146.82.227])
        by smtp.gmail.com with ESMTPSA id h2sm30697357wrv.87.2018.12.26.09.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 09:55:01 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
To:     Stephen Boyd <swboyd@chromium.org>, gregkh@linuxfoundation.org,
        kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154533751009.79149.13940391507897650993@swboyd.mtv.corp.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <4d6c6cd6-9c3a-84b8-d9f2-2d9933989594@linaro.org>
Date:   Wed, 26 Dec 2018 18:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154533751009.79149.13940391507897650993@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 21:25, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz (2018-12-07 01:55:57)
>> +
>> +- qcom,vdd-voltage-level:
>> +    Value type: <prop-array>
>> +    Definition: This is a list of three integer values <no min max> where
>> +                each value corresponding to voltage corner in uV.
> 
> As far as I'm aware, this isn't how qcom's voltage corners are handled
> or are going to be handled. Can't you hardcode it in the driver for now?
> 
> 

sure will do.

if there is any other driver in some tree/branch that I could be looking 
as a reference - to avoid having to hardcode the values in the driver- 
please let me know.
