Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A532DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F722145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSJDs2ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F722145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLCKQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39527 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so2602144wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eyh8qLhmyzxUWr11DOnuiPDrpCJ4d/tW5WAKd3eL7y0=;
        b=NSJDs2lsUG4KfjCHvYncROpRanDBeboUNbGniy8NN8pFMN2tGzGTOTuwgFGnDjnBGY
         ISrbgxCW8KtlQdLuPfsES0cLgQcpfYinzMHqO5AbifUvme6necSqvFjxqSqaBHbvLPLv
         lTvi+nXrr3Hmk4aETZBknmK2a61cE/xBwlKv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eyh8qLhmyzxUWr11DOnuiPDrpCJ4d/tW5WAKd3eL7y0=;
        b=gJvsjVZycme6PqFOporyP+rDSVUI2JICI3D+LNJbv4auO0u9O6/BSTjWZqgZt486RO
         Jy9A8VEyUWQ2wkmbFdZ87rFm2iXU8iPbksPW/j7bz5AjUcL1FPpuRuW0T/6IYSskz/rw
         8D2RIxwcehMIOTEMQNZyzVX1rTRkHxohUqirtP1sI11hvqn4KxHd1PnTNEMhODNaUSnn
         g0cBcYl2VtiywjHPT/10Wc2perx9cggHmClBewh231xQ9AKCKmaU+R6aerBuBspCVe3h
         wIgkaieJqTQbBShE6sFJm9zIVYAI9JxcPK7vrcXuefOv4qbUH//0HE0QYmf+RhRPGldj
         HSpw==
X-Gm-Message-State: AA+aEWZXQ8J2v7asjNoAFuamJ3daoNJ9MijKG8aoPDT37S28XlE0Cz/D
        3dhnFvDgEMHTtUzLEj4iREh6IE0j9V4=
X-Google-Smtp-Source: AFSGD/X1W/N2xkRSIP/C9PJnEfA/EePfZ95zXRYHnUnr51SfHuILwOZZD5t202NlFbBuesb9WOkbGg==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr7781980wmi.144.1543832135904;
        Mon, 03 Dec 2018 02:15:35 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id s66sm6484976wmf.34.2018.12.03.02.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:15:35 -0800 (PST)
Subject: Re: [PATCH] sched/cpufreq: Add the SPDX tags
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <1539892534-16917-1-git-send-email-daniel.lezcano@linaro.org>
 <e21423b4-ec9c-ae6e-0b1f-c33e659b3cb0@linaro.org>
 <CAJZ5v0gHDzY9W0UG9QUDGTZGDD74ovRCj4dDFbksH0b4AoMvjg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d8a5aef3-fd22-1ce5-37f5-1c8a9db0168e@linaro.org>
Date:   Mon, 3 Dec 2018 11:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gHDzY9W0UG9QUDGTZGDD74ovRCj4dDFbksH0b4AoMvjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 11:12, Rafael J. Wysocki wrote:
> On Mon, Dec 3, 2018 at 11:07 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 18/10/2018 21:55, Daniel Lezcano wrote:
>>> The SPDX tags are not present in cpufreq.c and cpufreq_schedutil.c.
>>>
>>> Add them and remove the license descriptions
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Hi Rafael,
>>
>> I think this patch passed between the cracks.
> 
> Well, please resend. :-)

I can resend, but can't you pick this one directly?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

