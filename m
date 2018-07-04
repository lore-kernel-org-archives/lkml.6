Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F15C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDC924496
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HwkwOurl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NF5nqKCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDC924496
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeGDLTi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:19:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbeGDLTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:19:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2D9460B23; Wed,  4 Jul 2018 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530703173;
        bh=OK8r5tpUNeoaq1l2aV/uY3n26/SIZs0ajZcmYBe+uio=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HwkwOurlO6C/WtrfWJOatMdI2c3aFOIpZEy7QqLqvLbzNWHRKdbhxKiFCIaf73xmQ
         XxYnmFKq8EydWaZwL5ylbTKFFtP79vsS6R8vzr8Aefh5TeAO1NBCqFErPWewyfAuZ9
         jh5lArmU3H+6Up+RDjFPGM2U+O/an0sJp0lAGQfM=
Received: from [10.79.40.41] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1893D6031A;
        Wed,  4 Jul 2018 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530703171;
        bh=OK8r5tpUNeoaq1l2aV/uY3n26/SIZs0ajZcmYBe+uio=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NF5nqKCb1SO0xjpxMqyEect8UgvCQLvUnAckjDzNqflDWwSUu5w7+AwKscyqL+VeS
         XPgIxE/K3UbA+Ra3L7SuJkIMmHsBM7YFaVJvHGsIPkujdUct81w6o4SDcsLZnqAaK6
         bRjvyciA/Ex+SUVTVMpozBR0ijlS09ObQlPuaMxs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1893D6031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on
 supplier unbind
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
 <20180627125056.12851-2-vivek.gautam@codeaurora.org>
 <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
 <2991909.NMIP74eIIJ@aspire.rjw.lan>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <105f8027-782b-b16c-3267-cc07cde34d34@codeaurora.org>
Date:   Wed, 4 Jul 2018 16:49:26 +0530
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
> Hi Rafael,

> They are fine by me.

Cool.

>
> I can queue them up for 4.19 if no one has objections (Greg in
> particular).

Thanks for this.
Robin, If this approach is fine with you too, then I can go ahead and 
respin the
smmu patch series - updating the device link flag.

Best regards
Vivek

> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

