Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C319C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1D72064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ovvqu4Lc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EXTGiZg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1D72064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeJCBlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:41:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeJCBlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:41:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6075360C6C; Tue,  2 Oct 2018 18:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538506619;
        bh=O9btvE/vX7dbqyGuzZvKQOmr8Cgw65DQCGtJ2aMOsuA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ovvqu4Lc5TCK9xhiiIop9/0TF5yJu08gbwH8KfV7cNg6w5Sf/u7DrHjkT0EJqybxi
         IaBPSppy3t0MJQ7Oafqnuj9TpOxyI0iAkXBrxwPx1pPpyosqPMBPY1L8bTVbCESygF
         W80OktTdnPcOdZ5JcabcGkD/jeKB1hVq5I39qCaY=
Received: from [10.134.64.210] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: skannan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E77E2607DC;
        Tue,  2 Oct 2018 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538506618;
        bh=O9btvE/vX7dbqyGuzZvKQOmr8Cgw65DQCGtJ2aMOsuA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EXTGiZg4SJ34EkPpOvbdBQKqk5jydq9tJnAdS5cBL6aPdaC+ill2unbuV05ol1kEV
         XkXtgIgS/1ciy7GadRadQmExcFpdnLmil86fHTUAWr0BpEn/iYoqpiOJ2Dzgw6RClp
         5egNVaU4uPp/Dsgvu0QO7gvqqKU5hVeVq5aLzlvo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E77E2607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
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
 <fa74c24f-1f22-f11f-60fe-5a4489d9c7c2@codeaurora.org>
 <20181002111758.GC1086@e107155-lin>
From:   Saravana Kannan <skannan@codeaurora.org>
Message-ID: <c17450ce-fc25-e792-b91b-51106f032542@codeaurora.org>
Date:   Tue, 2 Oct 2018 11:56:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002111758.GC1086@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/02/2018 04:17 AM, Sudeep Holla wrote:
> On Mon, Oct 01, 2018 at 04:49:32PM -0700, Saravana Kannan wrote:
>> On 09/26/2018 07:48 AM, Sudeep Holla wrote:
>>> On Wed, Sep 26, 2018 at 05:42:15PM +0300, Georgi Djakov wrote:
>>>> Hi Rob,
>>>>
>>>> Thanks for the comments!
>>>>
>>>> On 09/25/2018 09:02 PM, Rob Herring wrote:
>>>>> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
>>>>>> This binding is intended to represent the relations between the interconnect
>>>>>> controllers (providers) and consumer device nodes. It will allow creating links
>>>>>> between consumers and interconnect paths (exposed by interconnect providers).
>>>>> As I mentioned in person, I want to see other SoC families using this
>>>>> before accepting. They don't have to be ready for upstream, but WIP
>>>>> patches or even just a "yes, this works for us and we're going to use
>>>>> this binding on X".
>>>> Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
>>>> currently using this binding, there is ongoing work from at least two
>>>> other vendors that would be using this same binding. I will check on
>>>> what is their progress so far.
>>>>
>>>>> Also, I think the QCom GPU use of this should be fully sorted out. Or
>>>>> more generically how this fits into OPP binding which seems to be never
>>>>> ending extended...
>>>> I see this as a further step. It could be OPP binding which include
>>>> bandwidth values or some separate DT property. Jordan has already
>>>> proposed something, do you have any initial comments on that?
>>> I am curious as how this fits into new systems which have firmware driven
>>> CPUFreq and other DVFS. I would like to avoid using this in such systems
>>> and leave it upto the firmware to scale the bus/interconnect based on the
>>> other components that are connected to it and active.
>>>
>> You've made the same point multiple times across different patch sets. Not
>> all FW can do arbitrary functions. A lot of them are very limited in their
>> capabilities. So, as much as you and I would like to let the FW do the work,
>> it's not always possible. So, in those cases, we do need to have support for
>> the kernel scaling the interconnects correctly. Hopefully this clears up
>> your questions about FW capabilities.
> Yes, I do understand I have made the same point multiple time and it's
> intentional. We need to get the fragmented f/w support story fixed.
> Different ARM vendors are doing different things in f/w and ARM sees the
> same fragmentation story as before. We have come up with new specification
> and my annoying multiple emails are just to constantly remind the same.
>
> I do understand we have existing implementations to consider, but fixing
> the functionality in arbitrary way is not a good design and it better
> to get them fixed for future.

I believe the fragmentation you are referring to is  in the 
interface/communication protocol. I see the benefit of standardizing 
that as long as the standard actually turns out to be good. But that's 
completely separate from what the FW can/can't do. Asking to standardize 
what the FW can/can't do doesn't seem realistic as each chip vendor will 
have different priorities - power, performance, cost, chip area, etc. 
It's the conflation of these separate topics that doesn't help IMHO.

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

