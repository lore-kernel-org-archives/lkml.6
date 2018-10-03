Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF8CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C1720835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AKUT3BVe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bLkT8j00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C1720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJDA4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:56:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDA4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:56:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B51BE60C7B; Wed,  3 Oct 2018 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538590007;
        bh=ug2A6TtuLgLgzns59XWGYEjAvn8K3iYXQDG6q6IjJL8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AKUT3BVeJ8uuWble8Abpxod2KPojeNeMApnjhUU7wkn0rsnw6mWsPmnZIrtFUxqxJ
         ErYQfPLDFhGEetgzAdHmJZQ3NJZmzPkP7gZgotaRM728/1ak/iJwZg7zplLH0qoX38
         +bQSHTwjBItQ+r3N5biJOVkCtuchbRkQDV+wJClA=
Received: from [10.134.64.210] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: skannan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99DF06076A;
        Wed,  3 Oct 2018 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538590006;
        bh=ug2A6TtuLgLgzns59XWGYEjAvn8K3iYXQDG6q6IjJL8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bLkT8j00DW4pAy5xCgP/9WLFp5ReD/ZhiMPDRWpJJXwrNbRDExy2jQGCcUcWRF5iI
         LTxUsyNOi1sPgvbvtLzpCRZea/zVDDL5dpD0Wgt0OAwOs7sz/m8hbbl255NXsqfJPr
         fQNPP+4z0Jx7lla6z654T4sLVx8JNcn9zaNFWBTo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99DF06076A
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
 <c17450ce-fc25-e792-b91b-51106f032542@codeaurora.org>
 <20181003093346.GA12570@e107155-lin>
From:   Saravana Kannan <skannan@codeaurora.org>
Message-ID: <0a276103-15fb-807c-5379-1a35de789290@codeaurora.org>
Date:   Wed, 3 Oct 2018 11:06:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003093346.GA12570@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2018 02:33 AM, Sudeep Holla wrote:
> On Tue, Oct 02, 2018 at 11:56:56AM -0700, Saravana Kannan wrote:
>> On 10/02/2018 04:17 AM, Sudeep Holla wrote:
> [...]
>
>>> Yes, I do understand I have made the same point multiple time and it's
>>> intentional. We need to get the fragmented f/w support story fixed.
>>> Different ARM vendors are doing different things in f/w and ARM sees the
>>> same fragmentation story as before. We have come up with new specification
>>> and my annoying multiple emails are just to constantly remind the same.
>>>
>>> I do understand we have existing implementations to consider, but fixing
>>> the functionality in arbitrary way is not a good design and it better
>>> to get them fixed for future.
>> I believe the fragmentation you are referring to is  in the
>> interface/communication protocol. I see the benefit of standardizing that as
>> long as the standard actually turns out to be good. But that's completely
>> separate from what the FW can/can't do. Asking to standardize what the FW
>> can/can't do doesn't seem realistic as each chip vendor will have different
>> priorities - power, performance, cost, chip area, etc. It's the conflation
>> of these separate topics that doesn't help IMHO.
> I agree on interface/communication protocol fragmentation and firmware
> can implement whatever the vendor wish. What I was also referring was
> the mix-n-match approach which should be avoided.
>
> e.g. Device A and B's PM is managed completely by firmware using OSPM hints
> Suppose Device X's PM is dependent on Device A and B, in which case it's
> simpler and cleaner to leave Device X PM to firmware. Reading the state
> of A and B and using that as hint for X is just overhead which firmware
> can manage better. That was my main concern here: A=CPU and B=some other
> device and X is inter-connect to which A and B are connected.
>
> If CPU OPPs are obtained from f/w and this inter-connect from DT, mapping
> then is a mess and that's what I was concerned. I am sorry if that's not
> the scenario here, I may have mistaken then.
>
What you are asking would be an ideal case, but this is not an ideal 
world. There are tons of constraints for each chip vendor. Saying you 
can't mix and match makes perfect the enemy of the good. Adding FW 
support for A and B might make them optimal. But adding support for X 
might not be possible for multiple real world constraints (chip area, 
cost, time to market, etc). Saying "either do it all or do nothing" is 
going to hold back a lot progress that can come in increments. Heck, we 
do the same thing in the kernel. We'll add basic simple features first 
and then improve on them. Why is it suddenly frowned up if a FW/HW 
follows the same approach? I'll just have to agree to disagree with you 
on this view point.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

