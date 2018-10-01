Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2BEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1F9213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WLwM23nR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KMhcs3g9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1F9213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJBG3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:29:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBG3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:29:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 16FE260C63; Mon,  1 Oct 2018 23:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538437775;
        bh=E8VPZ7hnduZEFNHuLvnFgE7VPFlJOQa1+CemyOhJAYk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WLwM23nRtdrzpQa67AQNOue+sT6SV4CVVlgQ02yvoTG5gK5L2M4tk4ArLpRwGnARM
         1CB2QMQgDdH0Jlj/l4u45kJpeb5cdv80ErA4Z8tkrzvG0wt2P027ZyW7FC5OJkmjUm
         XoWHI/4i9rZyZFRAJl/t67l9lWy23YCrx6PiDH24=
Received: from [10.134.64.210] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: skannan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD5C960265;
        Mon,  1 Oct 2018 23:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538437773;
        bh=E8VPZ7hnduZEFNHuLvnFgE7VPFlJOQa1+CemyOhJAYk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KMhcs3g9vXX0c5pAfsIQNXR7bX/sHsjIh8K8Xuu3SRtAX3NyaNTi09PTJ7PsOIyBk
         6vgyvSkjvdif1Liny5JemCNXMwvUMjhq7hpNm8m2p79PuAbwBspj/lxPlys+jA+X1G
         KzXkS5aUjIZb6vARv4AI9WYgW5IROMeBtYwCrBpc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD5C960265
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
 <20180926144830.GB25838@e107155-lin>
From:   Saravana Kannan <skannan@codeaurora.org>
Message-ID: <fa74c24f-1f22-f11f-60fe-5a4489d9c7c2@codeaurora.org>
Date:   Mon, 1 Oct 2018 16:49:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926144830.GB25838@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 07:48 AM, Sudeep Holla wrote:
> On Wed, Sep 26, 2018 at 05:42:15PM +0300, Georgi Djakov wrote:
>> Hi Rob,
>>
>> Thanks for the comments!
>>
>> On 09/25/2018 09:02 PM, Rob Herring wrote:
>>> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
>>>> This binding is intended to represent the relations between the interconnect
>>>> controllers (providers) and consumer device nodes. It will allow creating links
>>>> between consumers and interconnect paths (exposed by interconnect providers).
>>> As I mentioned in person, I want to see other SoC families using this
>>> before accepting. They don't have to be ready for upstream, but WIP
>>> patches or even just a "yes, this works for us and we're going to use
>>> this binding on X".
>> Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
>> currently using this binding, there is ongoing work from at least two
>> other vendors that would be using this same binding. I will check on
>> what is their progress so far.
>>
>>> Also, I think the QCom GPU use of this should be fully sorted out. Or
>>> more generically how this fits into OPP binding which seems to be never
>>> ending extended...
>> I see this as a further step. It could be OPP binding which include
>> bandwidth values or some separate DT property. Jordan has already
>> proposed something, do you have any initial comments on that?
> I am curious as how this fits into new systems which have firmware driven
> CPUFreq and other DVFS. I would like to avoid using this in such systems
> and leave it upto the firmware to scale the bus/interconnect based on the
> other components that are connected to it and active.
>

You've made the same point multiple times across different patch sets. 
Not all FW can do arbitrary functions. A lot of them are very limited in 
their capabilities. So, as much as you and I would like to let the FW do 
the work, it's not always possible. So, in those cases, we do need to 
have support for the kernel scaling the interconnects correctly. 
Hopefully this clears up your questions about FW capabilities.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

