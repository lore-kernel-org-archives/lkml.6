Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0A2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB66C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmZ+IfUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB66C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbeGXNx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:53:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46743 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbeGXNx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:53:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so3994251wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BZgzkwnEG9dk9VjX1gbsQE/FAzqxxsCa5+kboBU1U/o=;
        b=GmZ+IfUk0nRAum4rOnLckeDSNm/bCTTHaNpddOK0y4hvdhRlZsoNHPJ8/9pxc39DxF
         GJMsYtOb+i0PfzInSvlzR1y/Mia6B4HK/a7K4eXXGwx5FulWOqgMjAJEUOs4jmisxeaC
         Pkji0JOGHMnq0jC6k3aBHL/p2YQ3AiTBRrFHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZgzkwnEG9dk9VjX1gbsQE/FAzqxxsCa5+kboBU1U/o=;
        b=g6evKl+DRnKgVfZU9CKyljJJjXBiHSP3RV0XQoFYLqJYpb8BdJM5XuEyXKicDXGKGV
         IUJIwGTURWtMxr/gNvT1B89ZgU7tgE5usnECv929Qhz3jLkC1Ozk84I1FvFfL/EZKOu9
         m9T2SKKzgmNvkRmsaW6av/4X7hiEAfQ/KslfxOfvUdOUpR+l2lq6tetG49dgjSGXoy0h
         QrhHSBSuikF8FF6aCeuQUhmKi2vb1wEkfKWZ/LUYDzsZHpBz1lt9wu4yfeeZiYB0rxpI
         lhmD1vb6HmhAkwQ4yDv2Gcl4n0y9zIAzBmwnXf5JsDxEOScnqejcguooB8aXd0NeGJfP
         sTSg==
X-Gm-Message-State: AOUpUlEGiOnXu3n9jtmHtmRVKorWDVNZaOM8Wz4+1mmImlce7JP8Ixk1
        hY7ds0m/8hw1R+OO4NkXQ79PzvVlPd0=
X-Google-Smtp-Source: AAOMgpfrY2aAX40HUWdQ0FDHeQt/ghZrf1D30DueB9Qdk0VPe1Hs3pF//wNNIvW2bj5b59rDC6gquA==
X-Received: by 2002:adf:90e9:: with SMTP id i96-v6mr12328172wri.146.1532436457647;
        Tue, 24 Jul 2018 05:47:37 -0700 (PDT)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id g204-v6sm3089301wmd.26.2018.07.24.05.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 05:47:36 -0700 (PDT)
Subject: Re: [PATCH v3 00/35] Qualcomm Camera Subsystem driver - 8x96 support
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
 <717da3cd-7afe-9aeb-352a-898e12f2b1bc@xs4all.nl>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <d33defe8-6518-06c5-621a-a87710fe662d@linaro.org>
Date:   Tue, 24 Jul 2018 15:47:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <717da3cd-7afe-9aeb-352a-898e12f2b1bc@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.2018 14:41, Hans Verkuil wrote:
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
>>
>> --------------------------------------------------------------------------------
> 
> When running sparse I get these warnings:
> 
> camss/camss-csiphy-2ph-1-0.c:170:28: warning: symbol 'csiphy_ops_2ph_1_0' was not declared. Should it be static?
> camss/camss-csiphy-3ph-1-0.c:250:28: warning: symbol 'csiphy_ops_3ph_1_0' was not declared. Should it be static?
> camss/camss-vfe-4-1.c:976:25: warning: symbol 'vfe_ops_4_1' was not declared. Should it be static?
> camss/camss-vfe-4-7.c:1098:25: warning: symbol 'vfe_ops_4_7' was not declared. Should it be static?
> 
> checkpatch.pl complains about this as well.
> 
> There are externs in vfe.c, but those should probably be moved to camss-vfe.h.

Yes, this is correct. I can fix this in an additional small patch.

> 
> It should solves both checkpatch and sparse.
> 
> Regards,
> 
> 	Hans
> 

-- 
Best regards,
Todor Tomov
