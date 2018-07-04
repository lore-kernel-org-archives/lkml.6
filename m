Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CB7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50441242EC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SvB4h9SN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nQOIBZtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50441242EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeGDSJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:09:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbeGDSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:09:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C7A6160B28; Wed,  4 Jul 2018 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530727796;
        bh=gssCFuDdKeHtS68DmIUgZnngcflGnQoNZwDy8HHjGw8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SvB4h9SNL9kjd8oBuVYSM+La6zZYn5iUC56U0r4fKRvirpFrP4TubpwEZY2LZTvZZ
         QLgvyNtJ2kSgQQM/gWcotHjwme7oJ/8MYjm/uM9xADbLRMnhNBCjuZi06YqJc0J1jF
         ABxWs8mVPg9PmCqrVgUSCYxN9KX9vVgec5kBur+I=
Received: from [192.168.0.4] (unknown [27.7.124.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 608D360251;
        Wed,  4 Jul 2018 18:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530727795;
        bh=gssCFuDdKeHtS68DmIUgZnngcflGnQoNZwDy8HHjGw8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nQOIBZtYvjJD7cYvVzQ0pxnWruA9htUdttv2rSP8A0TacG9LP8C/wWFBNOY/S9Q0n
         PsrPT3/kTYXnMdhylLV8JoE7tI6sAIX0MQDfRVCIkx8n63xE+KjLm7DfYV607hRrvx
         Mpa93w+Hyjz7BGHX2jVt33UdiyOM1SyAYS/gY4w0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 608D360251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on
 supplier unbind
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
 <20180627125056.12851-2-vivek.gautam@codeaurora.org>
 <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
 <2991909.NMIP74eIIJ@aspire.rjw.lan>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <52724c9d-4650-9095-fb68-c4dff21a48f6@codeaurora.org>
Date:   Wed, 4 Jul 2018 23:39:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2991909.NMIP74eIIJ@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/2018 4:14 PM, Rafael J. Wysocki wrote:
> On Wednesday, July 4, 2018 9:16:20 AM CEST Vivek Gautam wrote:
>> Adding Ulf and Marek.
>>
>> On 6/27/2018 6:20 PM, Vivek Gautam wrote:
>>> Add a flag to autoremove the device links on supplier driver
>>> unbind. This obviates the need to explicitly delete the link
>>> in the remove path.
>>> We remove these links only when the supplier's link to its
>>> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: linux-arm-msm@vger.kernel.org
>>> ---
>> Hi Rafael, et al.
>>
>> Gentle ping.
>> Do you have comments on this series. I would really like to conclude these
>> device link additions sooner, and get things moving on the long awaited
>> arm-smmu clock/runtime support series.
>>
>> Thanks again for reviewing these patches.
> They are fine by me.
>
> I can queue them up for 4.19 if no one has objections (Greg in
> particular).

Hi Rafael,

I will resubmit these 2 patches as part of the arm-smmu series, as one
of the patch in the series depends on addition of 
DL_FLAG_AUTOREMOVE_SUPPLIER.
So these 2 patches and arm-smmu series should go together.
Can you please consider givnig your Ack?

Best regards
Vivek

>
> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

