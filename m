Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E42C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62E120873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P8kUBjNw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P8kUBjNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62E120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeLMHsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:48:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLMHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:48:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E4FE0608FB; Thu, 13 Dec 2018 07:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544687328;
        bh=wO2+tBLzvjM9latYmCvhXPtbyqczn04etYpNU1M1lbI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P8kUBjNwUrq0buUVrvTu85+leuj5l6FS5X5ZIBW/u0uiN/kKbzHGn3FOquMJO0E0j
         w7SQVAida58sDUWJ7V+TAJWIK0FMk4oJ6yCvI+kBRmbYs6/Los2QLsaeLBC//dt+iE
         hBXPnGiiz5MdwO2XfmmWn5Y4p1HxXXy4y0p3q1iY=
Received: from [10.79.165.62] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 403D36081C;
        Thu, 13 Dec 2018 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544687328;
        bh=wO2+tBLzvjM9latYmCvhXPtbyqczn04etYpNU1M1lbI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P8kUBjNwUrq0buUVrvTu85+leuj5l6FS5X5ZIBW/u0uiN/kKbzHGn3FOquMJO0E0j
         w7SQVAida58sDUWJ7V+TAJWIK0FMk4oJ6yCvI+kBRmbYs6/Los2QLsaeLBC//dt+iE
         hBXPnGiiz5MdwO2XfmmWn5Y4p1HxXXy4y0p3q1iY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 403D36081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
 <20181205061600.7zglbpkgbktn27am@vireshk-i7>
 <82b168d1-79bc-f454-8e19-4f7630a34069@codeaurora.org>
 <20181212044702.jp2r3mviq4ffal42@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <72a7312a-5529-92df-63e9-c3e6905103c2@codeaurora.org>
Date:   Thu, 13 Dec 2018 13:18:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212044702.jp2r3mviq4ffal42@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

On 12/12/2018 10:17 AM, Viresh Kumar wrote:
> On 11-12-18, 19:05, Taniya Das wrote:
>> The design here assumes that there would not be any per-cpu/per-cluster
>> based SW requirement for the HW during frequency transitions, which again
>> makes me think that we would require to re-introduce these structures again
>> in case we have such requirements in near future.
> 
> Firstly, even in such cases we can go ahead with the design we proposed. And I
> am not at all concerned about some hardware which we don't have right now. We
> will see what to do when such hardware comes, maybe reintroduce the structures,
> but that doesn't matter right now.
> 
>> Also I think leaving the structures also helps us debug any boot up issues
>> looking at the ram contents of the per-(cpu/cluster) structures with the
>> contents from the firmware.
> 
> I don't see how debugging would be hard without those structures in place.
> 
>> Hope these above helps us to go ahead with the current SW design.
> 
> Sorry, but I don't see any satisfactory reason on why you shouldn't make the
> suggested changes. We are trying to make your (and any other developer who will
> work on that driver) life simple by simplifying the code. Nothing beyond that :)
> 

Sure, Thanks, will submit the next patch series for your ACK :).

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
