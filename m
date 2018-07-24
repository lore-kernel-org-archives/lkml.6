Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2618AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A7A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Krxz3Snk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A7A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbeGXNvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:51:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45444 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeGXNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:51:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id t13-v6so3989409wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ohk6vanHvp6EtnqecZC1eKlDGR9Ndg+XQD0fvlMTc28=;
        b=Krxz3SnkDMAhe7NvOzHlfmIl12MxNVYBaQIs2r7qdcxQas80vyKWz2HNLK5rmPzWJ3
         1gIjzbNWudgjPFwlcHCowZ+JEDv3K72jclyQWSH0EX9KqexkR4MxzfeTFok0XMG5w2zM
         g2D8IotrlU7WcavNPVruH1hoLZPawyeboV1FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohk6vanHvp6EtnqecZC1eKlDGR9Ndg+XQD0fvlMTc28=;
        b=HWA4A0f0cSJuZt87YA49A41pRmwItAa36PbX46DMTz1IozyP7fzbpIo8/pn8WjX+kF
         Y1RvIFWanVxm4Krw66DDjr345VJv+pmXPWt4xItl5/T0venzsZVUncct2Z8vtNHAJ0yd
         SC844SyLXeagK6XA+Torn+9CNDUQsClZunC3bYuvbuWxaEctpk5mDQ4c3jaezUgq6ckk
         16T7/nadV0jDhPYnl3qAIfui45iRcBfd4LGBF5ynfkVryd5quAiSmKaRfejnLQ8qZNqE
         gQVoftTT9L8jnrd2dWCTEdpSfBU5N3dRGVJx69luK1jPGc8UX+zAPCZ1+IglS+nLjw6M
         ArsQ==
X-Gm-Message-State: AOUpUlHMpH8LKcse0vSR0/V4blAuEoS/X/WjHZHIxmN7WkE8zCKg0BDT
        WLBjl5yfYYHJQack2b5wToASPXkYX5Q=
X-Google-Smtp-Source: AAOMgpeuJ1UWWEohdISU5xmkTUaFUaeX+LYUEk/UwniTU4OgsDd028jrqxLSaq8lBD558Va5qouG+g==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr11183492wrd.67.1532436331920;
        Tue, 24 Jul 2018 05:45:31 -0700 (PDT)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id b10-v6sm10016051wrp.49.2018.07.24.05.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 05:45:31 -0700 (PDT)
Subject: Re: [PATCH v3 00/35] Qualcomm Camera Subsystem driver - 8x96 support
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
 <d548ed20-23ac-0ef9-9cbe-67da42cde19a@xs4all.nl>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <a102905e-8dd1-935d-1e50-57c42d949feb@linaro.org>
Date:   Tue, 24 Jul 2018 15:45:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d548ed20-23ac-0ef9-9cbe-67da42cde19a@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 24.07.2018 14:22, Hans Verkuil wrote:
> Hi Todor,
> 
> On 23/07/18 13:02, Todor Tomov wrote:
>> Changelog v3:
>> - split patch 08 to device tree binding patch and driver patch and
>>   improve commit message.
>>
>> --------------------------------------------------------------------------------
>>
>> This patchset adds support for the Qualcomm Camera Subsystem found
>> on Qualcomm MSM8996 and APQ8096 SoC to the existing driver which
>> used to support MSM8916 and APQ8016.
>>
>> The camera subsystem hardware on 8x96 is similar to 8x16 but
>> supports more cameras and features. More details are added in the
>> driver document by the last patch.
>>
>> The first 3 patches are dependencies which have already been on
>> the mainling list but I'm adding them here for completeness.
>>
>> The following 12 patches add general updates and fixes to the driver.
>> Then the rest add the support for the new hardware.
>>
>> The driver is tested on Dragonboard 410c (APQ8016) and Dragonboard 820c
>> (APQ8096) with OV5645 camera sensors. media-ctl [1], yavta [2] and
>> GStreamer were used for testing.
>>
>> [1] https://git.linuxtv.org//v4l-utils.git
>> [2] http://git.ideasonboard.org/yavta.git
> 
> Unless I am mistaken the only thing we're waiting for is an Ack from Rob for
> patch 8 (dt bindings), right?

We are definitely waiting for Rob's feedback. If there are more comments
meanwhile I will take care of them too but I think we don't have any so
far (or at least didn't have any until some minutes ago :)).

> 
> If I get that this week, then I can make a pull request in time for 4.19.

This will be really nice if we can do it. Thanks!

> 
> Regards,
> 
> 	Hans
> 

-- 
Best regards,
Todor Tomov
