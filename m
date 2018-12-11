Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72315C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358FB20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EVv5tis9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RD2tAHCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358FB20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeLKKdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:33:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:33:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 39E91607DC; Tue, 11 Dec 2018 10:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544524413;
        bh=04bfWuXk5IS22g19OE3O1vkoh9oZ723zXgQ0eCo4LRo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EVv5tis9EJzasACSyrCWVC6Zm59PTiDcZAKwu2MoyO1qmS9r8XjGTNPecmvgBlfxi
         zS4TScxYK7x9U9zqhiHslhiNwGuTZbmzB5GgW3HRdTNUwT7Y9MMFLl0D6fXc0Ldttr
         4PzIWytYqqyHMETYgrTlBqYxYQkDUUQMrdOPHJ5k=
Received: from [10.79.128.19] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5B40601A1;
        Tue, 11 Dec 2018 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544524408;
        bh=04bfWuXk5IS22g19OE3O1vkoh9oZ723zXgQ0eCo4LRo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RD2tAHCCDdgMfo2HhxMFSnPq59F8KYZUnrkRP7w0m6uhiqWhU7TCMBpJnE+HAJGJv
         ihw4pP8KY37awwT250TSIRtSkmi+P75cYJvJbCDhtlbQUPwkcBKhFX4TXglGCAFMs4
         93+yuUlOuZ+oUaaGV8jDNPDcxWchJb83tvpepDZ8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5B40601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>, Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181211094938.25086-1-rnayak@codeaurora.org>
 <20181211094938.25086-11-rnayak@codeaurora.org>
 <CAPDyKFof-rkzmzibWOrAhDFysU=y+C8Bp0cK=_iht4=vmv-0vw@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <00d91f90-ccf1-3486-0d42-0c4105058e61@codeaurora.org>
Date:   Tue, 11 Dec 2018 16:03:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAPDyKFof-rkzmzibWOrAhDFysU=y+C8Bp0cK=_iht4=vmv-0vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2018 3:52 PM, Ulf Hansson wrote:
> On Tue, 11 Dec 2018 at 10:50, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>> Specify the active + sleep and active-only MX power domains as
>> the parents of the corresponding CX power domains. This will ensure that
>> performance state requests on CX automatically generate equivalent requests
>> on MX power domains.
>>
>> This is used to enforce a requirement that exists for various
>> hardware blocks on SDM845 that MX performance state >= CX performance
>> state for a given operating frequency.
> 
> I assume that also means the MX power domain must not be power off as
> long as the CX power domain is powered on?

So with rpmh, there's really no separate on/off control, we just put
it in the lowest perf state at off.

> 
> Just to make sure there are no conflicting hierarchical constraints
> between idle management and performance state management!?
> 
> Kind regards
> Uffe
> 
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>> This patch is dependent on the series from
>> Viresh [1] which adds support to propogate performance states across the
>> power domain hierarchy which is still being reviewed.
>>
>> [1] https://lkml.org/lkml/2018/11/26/333
>>
>>   drivers/soc/qcom/rpmhpd.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>> index 1ce86f0cc9fa..af7b07d49e4f 100644
>> --- a/drivers/soc/qcom/rpmhpd.c
>> +++ b/drivers/soc/qcom/rpmhpd.c
>> @@ -102,12 +102,14 @@ static struct rpmhpd sdm845_cx_ao;
>>   static struct rpmhpd sdm845_cx = {
>>          .pd = { .name = "cx", },
>>          .peer = &sdm845_cx_ao,
>> +       .parent = &sdm845_mx.pd,
>>          .res_name = "cx.lvl",
>>   };
>>
>>   static struct rpmhpd sdm845_cx_ao = {
>>          .pd = { .name = "cx_ao", },
>>          .peer = &sdm845_cx,
>> +       .parent = &sdm845_mx_ao.pd,
>>          .res_name = "cx.lvl",
>>   };
>>
>> @@ -389,6 +391,15 @@ static int rpmhpd_probe(struct platform_device *pdev)
>>                  data->domains[i] = &rpmhpds[i]->pd;
>>          }
>>
>> +       /* Add subdomains */
>> +       for (i = 0; i < num_pds; i++) {
>> +               if (!rpmhpds[i])
>> +                       continue;
>> +               if (rpmhpds[i]->parent)
>> +                       pm_genpd_add_subdomain(rpmhpds[i]->parent,
>> +                                              &rpmhpds[i]->pd);
>> +       }
>> +
>>          return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>>   }
>>
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>
