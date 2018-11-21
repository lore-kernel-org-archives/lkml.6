Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F42AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD6B2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GgBpQ0Zd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kTp6lXqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD6B2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKUQvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:51:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:51:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B5F960791; Wed, 21 Nov 2018 06:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542781107;
        bh=Htyu4si3exwnC6RnHpuDQNSHcMimfRAp6bRj5clcuak=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GgBpQ0ZdGop2mNL8kcEJus7maW/medRtB2uNqJADd+pkshlp258wDMMG5yirvqRHR
         IDUMvE0/AWzDntEVPRX3VQiD8G0ehXTcsHvOaHdViO37iL/KjfHFxKYjleWCnTZh6F
         nzN2Qyc7wTBy6b0NXUgsdfE1o/pYgV06ohsX6rEU=
Received: from [10.79.128.198] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB31D60714;
        Wed, 21 Nov 2018 06:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542781106;
        bh=Htyu4si3exwnC6RnHpuDQNSHcMimfRAp6bRj5clcuak=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kTp6lXqxnTsHT8A6yRlqdsaNOiFm3O5jToORULkQr/bkD3SHvahA7ycTdeEkOUvTW
         cYhdOd+xGOGHV1qlg4Hkntuxk7X6ynQJjZEdKKZlxw0F/D8C/JZFsXyCuwQcE/aPEJ
         iUvFhoH8XJWVX17bvulUR6IfGA17Nesi1yxm2L6I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB31D60714
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
 <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
 <20181121051718.a5yo3ibhaihgrwra@vireshk-i7>
 <20181121060622.blnlvydbc4wo5y3y@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <0b40a76d-f779-391a-2770-4a3d368679a9@codeaurora.org>
Date:   Wed, 21 Nov 2018 11:48:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181121060622.blnlvydbc4wo5y3y@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2018 11:36 AM, Viresh Kumar wrote:
> On 21-11-18, 10:47, Viresh Kumar wrote:
>> On 21-11-18, 10:34, Rajendra Nayak wrote:
>>>
>>>
>>> On 11/5/2018 12:06 PM, Viresh Kumar wrote:
>>>> Introduce a new helper dev_pm_opp_xlate_performance_state() which will
>>>> be used to translate from pstate of a device to another one.
>>>>
>>>> Initially this will be used by genpd to find pstate of a master domain
>>>> using its sub-domain's pstate.
>>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>    drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/pm_opp.h |  7 ++++++
>>>>    2 files changed, 56 insertions(+)
>>>>
>>>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>>>> index 0eaa954b3f6c..010a4268e8dd 100644
>>>> --- a/drivers/opp/core.c
>>>> +++ b/drivers/opp/core.c
>>>> @@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
>>>>    		dev_err(virt_dev, "Failed to find required device entry\n");
>>>>    }
>>>> +/**
>>>> + * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
>>>> + * @src_table: OPP table which has dst_table as one of its required OPP table.
>>>
>>> So I have a case where the src_table and dst_table are shared/same. Can you explain how would
>>> it work in such a case?
>>
>> Can you give the example, as I am finding some issues with such shared
>> tables. Though the code may work just fine btw.
> 
> I may have found the problem you are facing here. Please try this diff
> and tell me if you hitting it, check this in dmesg.

Yes, I do seem to be hitting this.

> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 3740822b4197..6c45774306b0 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -225,6 +225,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>   free_required_tables:
>          _opp_table_free_required_tables(opp_table);
>   put_np:
> +       dev_err(dev, "Failed to allocate required OPP tables\n");
>          of_node_put(np);
>   }
> 
> 
