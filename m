Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C168ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3679220858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="DeV5yACy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3679220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeIROIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:08:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43918 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbeIROIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:08:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id z27-v6so1170848edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Gm30PgSyP47GC3d+U1olzZtdKkZ2NMWb4GWEJqW9bg=;
        b=DeV5yACy2RHcQAxAZnkXlGBU7dQQGKd5tngXgGDVc3R49bapzlv5xyACnqPrC0cLtl
         e60p7j+Pk74sFzd4AMrVTWnhlqPZ2hL2SdnUr4XXHRJo8ZiC5Fje367mw/vmC85DoN63
         NdQo8Pd4CDp9wy+lTArUUTDVyDpQjSYXW+hNkVtwbf/0VdTlTwB0DnUqAJ86iqwqa0bA
         0uBDSUPs+YK/T5IZhinPpzv4Ke0Ri5UHS97TItNr2MhV2xB/1yEcpQB4lW2fOsoGMUAe
         Ji0L1IXAlSGYyPbI9vFc8Se9taMcUPjNqiS5BFmG5KMRUORHVXXqldXvyShBPzJYuISC
         X3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Gm30PgSyP47GC3d+U1olzZtdKkZ2NMWb4GWEJqW9bg=;
        b=e/vN6mHVr1B7u3FE73Ycks3EyMbY6XT8jJEhT/5ArMwVsyX1PIRMqUmwskXV5taLPr
         Isgq7v1PzIK1r4or4XGpl46xVjcT98y6i2FF7KHPGbadP14Am3LzilBeoRjoqLMDaLbi
         z4b2wJzMzdNWPNkXYnIDlfs11h8E3nhnUDlqqwHCNFF/C9Q9bsGDG6nWPpkcT7DXTij6
         3KSUSiXBbvaDqtfYsEVn0aQaYdi91pGWDDDaCi261nQCmPoe9Z/DNwxptnUxso44KlYG
         LVo+5i/5er/B/++RJAXBoZYO8SdbybxmK+lth/KJtKxJZ33xhIKEnUXf9w9hTWQhC7IV
         PLOw==
X-Gm-Message-State: APzg51DdkGqL/1ZxPFT3tyU/Qvi57gsaos+RgNOYH/B1RvcFTvspArRg
        PWXRROrFwHtQKQyossXS2+KXOyayVpQ=
X-Google-Smtp-Source: ANB0VdbuUpqzqogjLGqXxU/lLVsSy0a5QogZ8CPNh8PoLpmhTE/0HKu9R7Yyy5+w5zOdPzFjsMOO9A==
X-Received: by 2002:a50:e79c:: with SMTP id b28-v6mr47492552edn.246.1537259827582;
        Tue, 18 Sep 2018 01:37:07 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id x22-v6sm7530341edb.8.2018.09.18.01.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:37:06 -0700 (PDT)
Subject: Re: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
 <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
 <7493E737-A7F5-4F86-A91D-8BA01755714D@cnexlabs.com>
 <9C271B60-C421-4C9B-99B6-C30B65494095@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <52cca772-f7dc-9e7b-c9aa-92a390533382@lightnvm.io>
Date:   Tue, 18 Sep 2018 10:37:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9C271B60-C421-4C9B-99B6-C30B65494095@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 01:30 PM, Javier Gonzalez wrote:
>> On 11 Sep 2018, at 10.50, Javier Gonzalez <javier@cnexlabs.com> wrote:
>>
>>> On 7 Sep 2018, at 12.28, Matias Bjørling <mb@lightnvm.io> wrote:
>>>
>>> On 08/29/2018 12:09 PM, Javier González wrote:
>>>> In the OCSSD 2.0 spec., the sector and metadata sizes are reported though
>>>> the standard nvme identify command. Thus, the lightnvm subsystem needs
>>>> to update this information on the geometry structure on bootup.
>>>> Since 1.2 devices report these values on the OCSSD geometry identify,
>>>> avoid this update is it is unnecessary and can also corrupt the geometry
>>>> if the devices does not report the nvme sizes correctly (which is not
>>>> required by the OCSSD 1.2 spec either) >
>>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>>> ---
>>>> drivers/nvme/host/lightnvm.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>>> index 5bfa354c5dd5..33ed09f8410e 100644
>>>> --- a/drivers/nvme/host/lightnvm.c
>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>> @@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>>>> 	struct nvm_dev *ndev = ns->ndev;
>>>> 	struct nvm_geo *geo = &ndev->geo;
>>>> +	if (geo->version == NVM_OCSSD_SPEC_12)
>>>> +		return;
>>>
>>> The lba format sizes are not explicit in 2.0 either. For a conforming drive, it should implement the NVM Command Set and expose the LBA format correctly. Although, I do get your incentive, and if it is okay with you, I'll reword the commit message to this and apply it?:
>>>
>>> "1.2 devices exposes their data and metadata size through the separate
>>> identify command. Make sure that the NVMe LBA format does not override
>>> these values."
>>
>> Sounds good. I'll resend either way as I rebased on top of for-4.20/core
>> - you can change the commit as you think it suits.
> 
> Since Igor will send a patch for the OOB, can you pick this up
> separately? No changes needed after rebase.
> 
> Thanks,
> Javier
> 

Applied for 4.20.
