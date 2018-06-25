Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B83FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC012572E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LB6nxSJv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A0+agDNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC012572E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755157AbeFYKKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:10:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755044AbeFYKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:10:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3AEF760712; Mon, 25 Jun 2018 10:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529921414;
        bh=YvDE1ptx9lR2drPc8jPNiArSJkLwhpGYY5qBndN0C8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LB6nxSJvhZZzK1oUZ2J/OSsWtEZdV6JrnV/A2d978vafrlNQPzTmu5o4SMzdWxnxN
         m2S5R25lgHDy8Dy+ANnXbKWCSiqrMRkaWIxJfBrkCZE4Eb1ePhL2urnu3LQEvASGd1
         Tlqi530JiM+CE6n01/JKPt5oIEBYFTwTp0T35Lak=
Received: from [10.79.40.88] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1190660585;
        Mon, 25 Jun 2018 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529921413;
        bh=YvDE1ptx9lR2drPc8jPNiArSJkLwhpGYY5qBndN0C8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A0+agDNFJUkgLPJ9KHy670x5q7R/VrkMvHTAGvDRf/0kI35MNqZ/ArftDX6XEI+Pu
         xbIh2zAF4JGFwuiCzKMeg722eWGdFxFwzLn+SCA7RsIdfCsAhZ9DoJqC7oiKz09qBt
         ajJEz6PaRnu8DX/+ChVNBiV701RMkIz3vIU2z0PQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1190660585
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 7/7] soc: qcom: rpmpd/rpmhpd: Add a max vote on all
 corners at init
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-8-rnayak@codeaurora.org>
 <414598de-00a1-9ce7-3a7e-4a95fd1bd35d@codeaurora.org>
 <f5014664-1639-c610-a50a-db66484428dc@codeaurora.org>
 <20180619101016.hbgjvev7d3h4yg7x@vireshk-i7>
 <CAPDyKFpvBXbppamoDDUKcMTnD8S3U7ZTKutLgSsLYQkAU0JXZg@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <08963d3b-324e-8401-9d03-74900fe6b0ec@codeaurora.org>
Date:   Mon, 25 Jun 2018 15:40:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpvBXbppamoDDUKcMTnD8S3U7ZTKutLgSsLYQkAU0JXZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/25/2018 02:27 PM, Ulf Hansson wrote:
> On 19 June 2018 at 12:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 14-06-18, 12:05, Rajendra Nayak wrote:
>>> On 06/14/2018 03:58 AM, David Collins wrote:
>>>> Hello Rajendra,
>>>>
>>>> On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
>>>>> As we move from no clients/consumers in kernel voting on corners,
>>>>> to *some* voting and some not voting, we might end up in a situation
>>>>> where the clients which remove votes can adversly impact others
>>>>
>>>> s/adversly/adversely/
>>>>
>>>>> who still don't have a way to vote.
>>>>>
>>>>> To avoid this situation, have a max vote on all corners at init.
>>>>> This should/can be removed once we have all clients moved to
>>>>> be able to vote/unvote for themselves.
>>>>
>>>> This change seems like a hack.  Do you intend for it to be merged and then
>>>> later reverted in Linus's tree?  Could it instead be implemented in a way
>>>> that does not require reverting and instead is enabled by some DT
>>>> property?  Alternatively, could this feature be added to the power domain
>>>> core since it is relatively generic?
>>>>
>>>>
>>>>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>> ---
>>>>>  drivers/soc/qcom/rpmhpd.c | 12 +++++++++++-
>>>>>  drivers/soc/qcom/rpmpd.c  |  9 +++++++++
>>>>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>>>>> index 7083ec1590ff..3c753d33aeee 100644
>>>>> --- a/drivers/soc/qcom/rpmhpd.c
>>>>> +++ b/drivers/soc/qcom/rpmhpd.c
>>>>> @@ -329,7 +329,7 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>>>>>
>>>>>  static int rpmhpd_probe(struct platform_device *pdev)
>>>>>  {
>>>>> -  int i, ret;
>>>>> +  int i, ret, max_level;
>>>>>    size_t num;
>>>>>    struct genpd_onecell_data *data;
>>>>>    struct rpmhpd **rpmhpds;
>>>>> @@ -390,6 +390,16 @@ static int rpmhpd_probe(struct platform_device *pdev)
>>>>>            pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>>>>>
>>>>>            data->domains[i] = &rpmhpds[i]->pd;
>>>>> +
>>>>> +          /*
>>>>> +           * Until we have all consumers voting on corners
>>>>> +           * just vote the max corner on all PDs
>>>>> +           * This should ideally be *removed* once we have
>>>>> +           * all (most) consumers being able to vote
>>>>> +           */
>>>>> +          max_level = rpmhpds[i]->level_count - 1;
>>>>> +          rpmhpd_set_performance(&rpmhpds[i]->pd, rpmhpds[i]->level[max_level]);
>>>>> +          rpmhpd_power_on(&rpmhpds[i]->pd);
>>>>
>>>> Clearly these calls will result in max level requests being sent for all
>>>> power domains at probe time.  However, it isn't clear that this will
>>>> actually help at runtime in these two cases:
>>>>
>>>> 1. A consumer enables and then disables a power domain.
>>>>     - It seems like the PD would just be disabled in this case.
>>
>> So instead of rpmhpd_power_on() we should be doing gepnd_power_on() or whatever
>> the API is, so the user count stays at 1.
> 
> There is no such API.
> 
> Instead a device needs to be attached to genpd and that's it. As long
> as the device don't enables runtime PM and that the device gets
> runtime suspended, genpd will remain powered on.

Its more to do with keeping the power domains at a desired 'performance level'
than just keeping them on.

> 
>>
>>>> 2. A consumer sets a non-max performance state of a power domain.
>>>>     - It seems like the PD would just be set to the new lower
>>>>       performance state since the max vote isn't known to the
>>>>       PD core for aggregation purposes.
>>
>> Right, and that's because the patch isn't implemented properly yet. I asked to
>> do a fake vote from some user with their dev structure, so the vote always
>> stays.
>>
>>> Yes, you are right. I certainly did not seem to have thought through this enough.
>>>
>>> A need for something like this came up at a point where genpd could not deal with
>>> devices with multiple power domains. So the concern at that point was that if some
>>> consumers (which only need to vote on one corner) move to using this driver, while
>>> some others (which need to vote on multiple corners) cannot, we would end up breaking
>>> them.
>>>
>>> That does not seem to be true anymore since we do have patches from Ulf which support
>>> having devices with multiple power domains attached which can be controlled individually.
>>> So if some consumer voting makes some others break, they should just be fixed and patched
>>> to vote as well. If all this gets handled centrally from within the clock drivers then we
>>> most likely won't even end up with a situation like this.
>>>
>>> I think I will just drop this one unless Stephen/Viresh still see an issue with some early
>>> voters breaking others.
>>
>> So what if the LCD/DDR/etc are getting used at boot and someone requests a lower
>> vote?  Wouldn't we just break ?
> 
> Sounds like we need a way to manage votes for "boot constraints
> performance levels". :-)

Yes, I think we are mixing up whats needed for 'boot constraints' and what this
patch was meant to do.
Boot constraints is a generic problem not limited to power domains alone and this patch
isn't trying to solve that.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
