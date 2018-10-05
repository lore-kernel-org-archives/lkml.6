Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52CDC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520EE20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FskZNzoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520EE20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeJEPco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:32:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45911 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJEPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:32:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so12620938wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dG+BBDaGfexMW7i2icatFFXI5Kousmiy/58ToeMwKe8=;
        b=FskZNzoE5SBmbPdsVH/DYtpT0BhwgC657DXM6Iu/3PRGHTOsmleKblQifW/2ILFuG5
         Es22mwMxQrjzdP56bMKa9RQuKYXozAgbFQjvP9JwvyaLOcOcnAx+I6BTA5JOSYvIX+/H
         3Z0KXO/TYrT+BaEyPOPtEhKiBMbDYKC0HVKCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dG+BBDaGfexMW7i2icatFFXI5Kousmiy/58ToeMwKe8=;
        b=pU5fTGGKZjsEzgMgIC5Y85MQ8D7fjYUIcPonK1hjZKny82BLu1zy8/2g5EUW7GbUaV
         x3nyHeYNTAeu8dtK1i4AwcNbX4UxfHWTWgQH3qdeA7mM9iEDAqubCgHwesGmrIfD9s9b
         pbHLfyL+cwYNAoBypbbO5vm4eQ0wg1HrLK2xPPMLAurpBVdOoml3fLV59A/8xJSI1/l0
         Pa8FihfsslV5aFu/zZ2FaieYzpTTyWVX5rF+b/bEBCv43JdoJpWLiXKU6kjBxSnPYpSR
         Xj+7iuMHbWkknTzQOOardOUKCUxf7OFD/CAfIDY5iN82Bgds2BmqBHOeym8Stivo5FQy
         azeg==
X-Gm-Message-State: ABuFfoiRNwQVzDMjZOhRPZk70GGytALMz7hy0YlbbdWeaN+OCrtG3bKA
        HcMusxXH+yV7MiMkr24zupOZESvoirY=
X-Google-Smtp-Source: ACcGV60opTFoWtaXZFsGf+XXb5ReTWK+TljKO6f0QrFpGySJuCUtfBfmbBd1551/kXV8pb5UJ35GnA==
X-Received: by 2002:a5d:61ca:: with SMTP id q10-v6mr6635089wrv.33.1538728502258;
        Fri, 05 Oct 2018 01:35:02 -0700 (PDT)
Received: from [192.168.0.40] (101.142.88.92.rev.sfr.net. [92.88.142.101])
        by smtp.googlemail.com with ESMTPSA id j2-v6sm7557185wrw.29.2018.10.05.01.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:35:01 -0700 (PDT)
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from
 menu_select()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <4130376.2FFt7p4687@aspire.rjw.lan> <20181004145116.GB1881@mai>
 <CAJZ5v0h1Z7MKjq9XY0-tn9U4J3CdycYPbGkM3fjH7-FzaJ=uJA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b365081f-00bb-ec2a-84b2-48bed1b76c19@linaro.org>
Date:   Fri, 5 Oct 2018 10:35:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h1Z7MKjq9XY0-tn9U4J3CdycYPbGkM3fjH7-FzaJ=uJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 19:19, Rafael J. Wysocki wrote:
> On Thu, Oct 4, 2018 at 4:51 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Rearrange the code in menu_select() so that the loop over idle states
>>> always starts from 0 and get rid of the first_idx variable.
>>>
>>> While at it, add two empty lines to separate conditional statements
>>> one another.
>>>
>>> No intentional behavior changes.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>
>> This code is becoming a bit complex to follow :/
>>
>> May be I missed something, but it is not possible to enter the condition without
>> idx != 0, no ? (I meant the condition if ((drv->states[idx].flags &
>> FLAG_POLLING))
> 
> Not sure what you mean.

Yes, sorry let me clarify.

I meant the flag polling is always on state[0], so if the flag is set
then idx == 0.

We have the conditions:

  drv->states[idx].flags & CPUIDLE_FLAG_POLLING

If it is true then idx is zero.


Then comes the second condition:

  i == idx + 1

because of the above, idx is zero, then it can become i == 1.

Then the variable assignation:

 idx = i can be replaced by idx = 1





> We start with idx = -1, i = 0.  If state[0] is enabled, idx becomes 0.
> 
> If the target residency or exit latency of state[0] are already beyond
> the limits, we just bail out and state[0] will be returned.
> 
> If not, we go to i = 1, but idx is still 0.  If the target residency
> of state[1] is beyond predicted_us (which is the interesting case), we
> check (drv->states[0].flags & FLAG_POLLING) and so on.
> 
> Currently, the polling state must be state[0] (if used at all) anyway.
> 
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
> 
> Thanks!
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

