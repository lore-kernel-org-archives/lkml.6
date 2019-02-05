Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B5C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB9D20811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QdREnxQK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J4pvpL1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfBEWiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:38:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfBEWiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:38:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1939A60741; Tue,  5 Feb 2019 22:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549406282;
        bh=aKYkj+gKA7ctD4tvHvA80Zva5tPbWXd09NizzwSBiKM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QdREnxQKtdueNECgBcjoKpwxintEI/80PpZWEf//YhdLp6kLRZyFqhFaYfdH7HdAJ
         a96EvexrFW6PcdnMDQrDQM2idSyOjsZKH2NltHn1nAiwLWsYqHG2tupbdGK4IcgKwm
         d60FMErTgAv6e+k+h2IPcnzpBII8DB74w1MuRDqs=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FFF660112;
        Tue,  5 Feb 2019 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549406281;
        bh=aKYkj+gKA7ctD4tvHvA80Zva5tPbWXd09NizzwSBiKM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J4pvpL1TJzMTmyYkNmqt9+YEScFGLJBi77uiedQPzYSvUuPTcTplJH9m9bJQUvdhl
         Z9OlZdRR2DdQmq+QW1fmCZ03KyoT4z4vRMs40kaw4NeCbSbH7W40RBxmrajkYu62WL
         xHnfuFYdlYG9TMQhdRhrv7yG1Fq+flZn7wrc5UzY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FFF660112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 1/4] clk: qcom: smd: Add XO clock for MSM8998
To:     Stephen Boyd <sboyd@kernel.org>, bjorn.andersson@linaro.org,
        mturquette@baylibre.com
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        georgi.djakov@linaro.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
 <1548866144-30265-1-git-send-email-jhugo@codeaurora.org>
 <154940408967.169292.15276398799323074789@swboyd.mtv.corp.google.com>
 <6e62a49a-fdb1-a087-fe83-e86aed969ae7@codeaurora.org>
 <154940592132.169292.15811923452101983358@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <f3b80293-a1fc-ad47-e681-a3a3ed782b0c@codeaurora.org>
Date:   Tue, 5 Feb 2019 15:37:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154940592132.169292.15811923452101983358@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2019 3:32 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-02-05 14:15:16)
>> On 2/5/2019 3:01 PM, Stephen Boyd wrote:
>>> Quoting Jeffrey Hugo (2019-01-30 08:35:44)
>>>> The XO clock generally feeds into other clock controllers as the parent
>>>> for a lot of clock generators.
>>>>
>>>> Fixes: 6131dc81211c (clk: qcom: smd: Add support for MSM8998 rpm clocks)
>>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>>
>>> We've historically left out the XO clk because it causes problems where
>>> the XO vote goes away during late init because nobody references it from
>>> the rest of the clk tree and also because RPM defers probe of the system
>>> and then the console blows up when it gets a clk that can't change rate.
>>> See commit 54823af9cd52 ("clk: qcom: Always add factor clock for xo
>>> clocks") for some more info on why we removed all the workarounds and
>>> stuff around here too.
>>>
>>> So are you sure this is OK to do?
>>>    
>>>
>>
>> So, I've got pretty much everything as modules, and I haven't seen any
>> issues.  However let me take a look at the commit you point out and see.
>>
> 
> Is the name of the clk "xo_clk_src"? That isn't the name that we were
> expecting the XO clk from RPM to be called. You might have to look back
> at the history of the rpm clk driver on the list and see when Georgi
> dropped the XO clk from it and if there was anything wrong with that. I
> can't recall if this was discussed on the list or if he just told me in
> some hallway conversation at Connect.
> 

Will do.  Thanks for pointing out the history.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
