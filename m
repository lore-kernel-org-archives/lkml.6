Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0F5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A672082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHed+tBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A672082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeH3MZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:25:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38986 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeH3MZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:25:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so7206040wrf.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lY42SZCRkHxSBOkhCWN5fyRy4QhW25Gv+Ent0kaufHg=;
        b=eHed+tBGYDlVqr69+5/Y8QMG510XOu0M1Ao/LA0Busufjx8LiX6d5FhSODi4GJ4hrj
         H6O0//CiBNje5WOgPx2958DYZXAVrUDY1aTRUSNu+q9onZFFYGqBBi0He/tuGNL0tBWz
         GijQAg98Ry6deb/5RP2zrNAEieuABdxwbhFzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lY42SZCRkHxSBOkhCWN5fyRy4QhW25Gv+Ent0kaufHg=;
        b=sFlD3WOqnkR9QoNIB0YRSbDHiwa6In9yrQ0y3fZvFwJtKNxgwBUYbIAi9mMIhhXjmK
         9FMpFJ/SLYLvE6nlgtFxfa0ivKBU5tYET6B89liUAkmJyIfvnM3puSD7UZ63SlryQ6P1
         ifWe1gzxjjKlG4e9fBE21AyibMkp6UIMo1hmCOr3KYzwSQqlV6bkSIZdKR7rvRxBidLd
         rQqOTShtkxLfveW85csVXlwv2PiHxBTww7A2PIE7vW4+nbv5PWNXgr3o2c+UkB6TGxkJ
         4tpHceS4tdb/CPIeNbRUgi2hHC2N3qgM1JD+Fj6uhbfXBQxHhkhowgIwKs3BzacPAk4A
         TeCQ==
X-Gm-Message-State: APzg51AF9dKjhPN3qK8ifPCJMnSr5+GF2l4jAFqbIcfWHQy7LByuMIzf
        EA7GNscXf1MsmOBlTpGYZJuLTw==
X-Google-Smtp-Source: ANB0VdbwmubPLN6KUqVx5mbP8Tx7CL0mT1ovUtGftQBQRRxFsD/dgqxiFeILEXBp413KC/oRjYIsfw==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr6972685wra.120.1535617495130;
        Thu, 30 Aug 2018 01:24:55 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm9745883wrd.74.2018.08.30.01.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 01:24:54 -0700 (PDT)
Subject: Re: [RFD] Add debugfs for cpuidle ?
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <516d8599-8038-7b47-a3f5-640bf13856c2@linaro.org>
 <2682482.uFPN0cxrGI@aspire.rjw.lan>
 <bcdbf067-4213-18ed-6d30-dc0dd2376c02@linaro.org>
 <CAPDyKFrOoJam38Nc05DTo09HbY964bGaw+27GuikYuEz3o=UWw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <aafd9a8a-9007-fca4-6ef8-a72920513d5c@linaro.org>
Date:   Thu, 30 Aug 2018 10:24:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrOoJam38Nc05DTo09HbY964bGaw+27GuikYuEz3o=UWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2018 10:22, Ulf Hansson wrote:
> On 24 May 2018 at 10:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 24/05/2018 10:28, Rafael J. Wysocki wrote:
>>> On Thursday, May 24, 2018 10:14:31 AM CEST Daniel Lezcano wrote:
>>>>
>>>> Hi all,
>>>
>>> Hi,
>>>
>>>> would it be interesting to add debugfs metrics for cpuidle in order
>>>> to read some statistics from there and investigate the behavior ?
>>>
>>> What exactly would you like to see in there?
>>
>> It could be interesting to have statistics on a per cpu and global basis
>> for:
>>
>> - prediction accuracy:
>>
>> /sys/kernel/debug/cpuidle/prediction/[good|over|under]
>> /sys/kernel/debug/cpuidle/cpu*/state*/prediction/[good|over|under]
>>
>>  - exit latency
>>
>> In addition, it is often the case the idle states values are dropped
>> randomly, it is interesting to see the average exit latency for the
>> states. That could give also an indication the cluster idle state success.
>>
>> /sys/kernel/debug/cpuidle/state*/latency/[min|max|avg|stddev]
>> /sys/kernel/debug/cpuidle/cpu*/state*/prediction/[min|max|avg|stddev]
>>
>> And perhaps more information like the tick stopped stat ?
>>
> 
> Daniel,
> 
> Any chance that you have some draft version of actual code implementing this?
> 
> I would be very interested to try then - or help out to implement
> this, in case you haven't started yet.

Yes, I have a draft version, a bit incomplete but easy to fill. I'm just
not fully convinced about the metrics we need yet.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

