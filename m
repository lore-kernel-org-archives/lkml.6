Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F6AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C252084D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fw8p5h1X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VQlC57mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C252084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeGEE22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 00:28:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeGEE2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 00:28:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7AAA160249; Thu,  5 Jul 2018 04:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530764904;
        bh=s6WwQIKIlZ+tB8KK9D7prUCEkQfdIXaysJtQIu5A1kw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fw8p5h1XFcHuhOejNisudJYa5HahjccBYtpFBzI0XDYybB5zwXta+xhBR32uTidS0
         ogEPxWlDnMyjPzgikGpX95pju909wrDRktCrkEUvXEAbTqqfvMMGD9XnvR4JBcpgJH
         B5VKDhSdQKbzc2izdOiRspMnVaMrLQ65Dy753K7g=
Received: from [192.168.0.4] (unknown [27.7.124.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C42460249;
        Thu,  5 Jul 2018 04:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530764903;
        bh=s6WwQIKIlZ+tB8KK9D7prUCEkQfdIXaysJtQIu5A1kw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VQlC57mvoDQbyBPqQlegZIDgimcdJ5FVfq5qIv/jhu3hJ53SW1N7wFCX+F67dQ79d
         OVwjJLRYPOvfnzO92ydgTK1OqBIyXzU60pNB/saH0FupjPGUobmWYNA/Ykc/uWdW+r
         Bix2JPEdJ1hAuPSOxyMDl1+OAW8vY3+syQkrOqLk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C42460249
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on
 supplier unbind
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
 <20180627125056.12851-2-vivek.gautam@codeaurora.org>
 <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
 <2991909.NMIP74eIIJ@aspire.rjw.lan>
 <52724c9d-4650-9095-fb68-c4dff21a48f6@codeaurora.org>
 <CAJZ5v0jb2075fcabZDxPpE+7Bo=NpcFm7kEY5QfO-ZbcfGkDyw@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <1c0f5cb8-4805-4200-406f-0725122b524f@codeaurora.org>
Date:   Thu, 5 Jul 2018 09:58:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jb2075fcabZDxPpE+7Bo=NpcFm7kEY5QfO-ZbcfGkDyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/2018 4:49 AM, Rafael J. Wysocki wrote:
> On Wed, Jul 4, 2018 at 8:09 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>>
>> On 7/4/2018 4:14 PM, Rafael J. Wysocki wrote:
>>> On Wednesday, July 4, 2018 9:16:20 AM CEST Vivek Gautam wrote:
>>>> Adding Ulf and Marek.
>>>>
>>>> On 6/27/2018 6:20 PM, Vivek Gautam wrote:
>>>>> Add a flag to autoremove the device links on supplier driver
>>>>> unbind. This obviates the need to explicitly delete the link
>>>>> in the remove path.
>>>>> We remove these links only when the supplier's link to its
>>>>> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
>>>>>
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>> Cc: linux-doc@vger.kernel.org
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> Cc: linux-pm@vger.kernel.org
>>>>> Cc: linux-arm-msm@vger.kernel.org
>>>>> ---
>>>> Hi Rafael, et al.
>>>>
>>>> Gentle ping.
>>>> Do you have comments on this series. I would really like to conclude
>>>> these
>>>> device link additions sooner, and get things moving on the long awaited
>>>> arm-smmu clock/runtime support series.
>>>>
>>>> Thanks again for reviewing these patches.
>>> They are fine by me.
>>>
>>> I can queue them up for 4.19 if no one has objections (Greg in
>>> particular).
>>
>> Hi Rafael,
>>
>> I will resubmit these 2 patches as part of the arm-smmu series, as one
>> of the patch in the series depends on addition of
>> DL_FLAG_AUTOREMOVE_SUPPLIER.
>> So these 2 patches and arm-smmu series should go together.
>> Can you please consider givnig your Ack?
> I would prefer to apply them myself to be honest and put them on an
> public git branch for you to pull from.

Sure. Fine with me. I will base the smmu patches on your branch.

Thanks
Vivek
>
> Thanks,
> Rafael

