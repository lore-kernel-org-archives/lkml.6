Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0D8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8E82146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SQlItD/m";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K4Ojxky8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8E82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeJBDgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:36:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBDgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:36:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C902660376; Mon,  1 Oct 2018 20:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538427394;
        bh=i85tSHz4QTB0+V6O9i7t5cELsEgIN/2Mho/1oGKkV7g=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=SQlItD/mD3+pPQxm9he4STJHlQYlL2WbJANebD6Sxq6UuVQF8xHXM+WWpYuPbq8t9
         BxqEsPFwiqdhaYPi2o3/m5f8D2a1V5wTVAXNr7wiNPIjWCGBYSM9w3OlvPZsGB6W2e
         ZEUsWrSzijZfMGPigQKljJJtqp4IXwExKbIJtA44=
Received: from [10.134.64.210] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: skannan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AEBD60376;
        Mon,  1 Oct 2018 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538427393;
        bh=i85tSHz4QTB0+V6O9i7t5cELsEgIN/2Mho/1oGKkV7g=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=K4Ojxky8zwZdhdSiAhzfB2kcZFag1SGDEL5+cffYmtR6xHxxKYN0NUZEAOCOeVrKs
         JprM6oIjPX/YwTOiTZsoFoFPDU8vPVMT8wXZcArRtlpPKcN55g0SDzHLumSNLtw1hR
         Qq3x6jdbyyd5wAERx7a8t9NlH7sUoXjFwy4nXmTg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AEBD60376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
To:     Rob Herring <robh@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, robdclark@gmail.com
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <20180926143432.GH10761@jcrouse-lnx.qualcomm.com>
From:   Saravana Kannan <skannan@codeaurora.org>
Message-ID: <1ae0a36a-1178-4db5-1ae9-8f19e561a18b@codeaurora.org>
Date:   Mon, 1 Oct 2018 13:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926143432.GH10761@jcrouse-lnx.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/26/2018 07:34 AM, Jordan Crouse wrote:
> On Tue, Sep 25, 2018 at 01:02:15PM -0500, Rob Herring wrote:
>> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
>>> This binding is intended to represent the relations between the interconnect
>>> controllers (providers) and consumer device nodes. It will allow creating links
>>> between consumers and interconnect paths (exposed by interconnect providers).
>> As I mentioned in person, I want to see other SoC families using this
>> before accepting. They don't have to be ready for upstream, but WIP
>> patches or even just a "yes, this works for us and we're going to use
>> this binding on X".
>>
>> Also, I think the QCom GPU use of this should be fully sorted out. Or
>> more generically how this fits into OPP binding which seems to be never
>> ending extended...
> This is a discussion I wouldn't mind having now.  To jog memories, this is what
> I posted a few weeks ago:
>
> https://patchwork.freedesktop.org/patch/246117/
>
> This seems like the easiest way to me to tie the frequency and the bandwidth
> quota together for GPU devfreq scaling but I'm not married to the format and
> I'll happily go a few rounds on the bikeshed if we can get something we can
> be happy with.
>
> Jordan

Been meaning to send this out for a while, but caught up with other stuff.

That GPU BW patch is very specific to device to device mapping and 
doesn't work well for different use cases (Eg: those that  can calculate 
based on use case, etc).

Interconnect paths have different BW (bandwidth) operating points that 
they can support. For example: 1 GB/s, 1.7 GB/s, 5GB/s, etc. Having a 
mapping from GPU or CPU to those are fine/necessary, but we still need a 
separate BW OPP table for interconnect paths to list what they can 
actually support.

Two different ways we could represent BW OPP tables for interconnect paths:
1.  Represent interconnect paths (CPU to DDR, GPU to DDR, etc) as 
devices and have OPPs for those devices.

2. We can have a "interconnect-opp-tables" DT binding similar to 
"interconnects" and "interconnect-names". So if a device GPU or Video 
decoder or I2C device needs to vote on an interconnect path, they can 
also list the OPP tables that those paths can support.

I know Rob doesn't like (1). But I'm hoping at least (2) is acceptable. 
I'm open to other suggestions too.

Both (1) and (2) need BW OPP tables similar to frequency OPP tables. 
That should be easy to add and Viresh is open to that. I'm open to other 
options too, but the fundamental missing part is how to tie a list of BW 
OPPs to interconnect paths in DT.

Once we have one of the above two options, we can use the required-opps 
field (already present in kernel) for the mapping between GPU to a 
particular BW need (suggested by Viresh during an in person conversation).

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

