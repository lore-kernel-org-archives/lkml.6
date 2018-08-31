Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66841C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0257620837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5rTh0fQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0257620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeHaMt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:49:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39446 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeHaMt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:49:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so10439499wrf.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=edqs2yv8UfeTuyXd+Al+7UCLVVQgNfMO2RyAviqlJAY=;
        b=G5rTh0fQqA20y92alTbdDgQq2dYVWZN4nwYXyEAoSmdwK5ZfZ0ikRKrYEDNyQv/i/+
         0Dfrm4tzA01ELjHvMXOvGhfODZAqVsTHGOSSaxCltMcS/oq4nA6WtWSMeMkzFHI7kaxS
         ouOjWUEspQ/Ui1Nhdkq4m2D8TuEpB0RPL198U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=edqs2yv8UfeTuyXd+Al+7UCLVVQgNfMO2RyAviqlJAY=;
        b=CI6SeNWjpTOu5B9E359i2kFgyOg10hlPU2ee5kSndo7UXNueitCyJlnYtcAwn4XYPi
         f5djo01u86NJ8bCwdYTq4pfKuEMz6cDz9LOC7NDP0U8cdw06KYF0SnBgxhZUVpgtQaSx
         bcL9vOsdyp7TaeeWyF9bQPPVCmZfuYckCJeMDLlC1xvGSAbZj9QnMQNAK3VPI1yejlpP
         CBIju37oo5/Z8AmvXO0aaQ9ed78DH9kMo98Jl00JXQdDdfT7TES8x/RHB2XLoP2KxJ5M
         fr1oyRZjXhcwR/xG5MH/fVNEVwvPTPQ2aspaks1OnwaeUkxfFC3p4tQncTNCbdQY/jyt
         XCNw==
X-Gm-Message-State: APzg51CK3onoplL9Vw9FREJr/TtJgIfCj+LicKy1xUiUzCObAkZ32+w1
        0pjbJRR9rytukM6aum1eDhbw/w==
X-Google-Smtp-Source: ANB0Vdb4gA9xFBa+UguRlmgWaa7XAX+1A2yEBgg3kSH2hV6dGx9f9hkE5eCeUwr/lje16rEKWgkgNQ==
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr9428091wrp.184.1535705012141;
        Fri, 31 Aug 2018 01:43:32 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id u40-v6sm18017476wrc.43.2018.08.31.01.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 01:43:31 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/3] device property: Support MAC address in VPD
To:     Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh@kernel.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20180814223758.117433-1-briannorris@chromium.org>
 <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
 <20180815002204.GA258561@ban.mtv.corp.google.com>
 <bb1b2b7d-2c47-a6b3-7618-063351f379b2@gmail.com>
 <20180815014436.GA17200@ban.mtv.corp.google.com>
 <20180815221601.GB24830@rob-hp-laptop>
 <20180831012656.GB67271@ban.mtv.corp.google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <44c7fc7a-9c1c-e894-f27f-5320c061aafc@linaro.org>
Date:   Fri, 31 Aug 2018 09:43:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180831012656.GB67271@ban.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay!! For some reason I missed this email thread totally!

On 31/08/18 02:26, Brian Norris wrote:
>> Seems to me that nvmem needs to be extended to allow providers to
>> retrieve and interpret data. Not everything is at some fixed offset and
>> size. Something like this is valid dts:
>>
>> nvmem = <&phandle> "a-string";
>>

There has been some discussion on extending nvmem support to MTD and 
non-DT users in https://patchwork.kernel.org/cover/10562365/

One of the thing which we discussed in this thread is adding compatible 
strings to cells mainly to
1> Differentiate between actual cells and partitions for MTD case.

2> Allow provider specific bindings for each cell, in VPD instance key 
string & value length could be one them.

This means that we would endup adding xlate callback support to the 
nvmem_config.

AFAIU, From consumer side old bindings should still work!

 From non-dt or ACPI side these cells can be parsed by the provider 
driver and add it to the nvmem_config.

Does this make sense? Or Did I miss anything obvious ?


>> But that's pretty uncommon (I can't think of a binding that actually
>> uses that). Perhaps the provider has an array of keys defined and the
>> consumer just provides the index.
> In the case of VPD, all keys are 0-terminated strings (there's also a
> length field, but the key is still 0-terminated), so that scheme could
> work. (I'm not sure an indexed provider is extremely relevant right now,
> although it probably could be supported if I expand the of_nvmem
> retrieval to support a generic of_xlate() override anyway.) The
> information represented is almost the same as in my proposal, except that:
> (a) now I have to give the VPD a phandle -- so far, I've avoided that,
>      as it's just an auto-enumerated device underneath the
>      /firmware/coreboot device (see drivers/firmware/google/vpd.c)
> (b) this is no longer directly useful to ACPI systems -- I'm not
>      actually sure how (if at all) nvmem provider/consumer is supposed to
>      work there
> 
> But maybe this isn't really that useful to ACPI, and it's sufficient to
> just have fwnode_get_mac_address() call of_get_nvmem_mac_address() when
> we're using DT.
> 
>> Or we could do '<key>-nvmem = <&phandle>', but parsing that is a bit
>> more complicated.
> That doesn't seem to have much advantage to me.
