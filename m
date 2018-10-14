Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F0C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B65120876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B65120876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeJNXca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:32:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52164 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeJNXXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:23:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so16384013wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 08:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6W6TLoHreDbZDQd/BOmpLyuPhPgBULQEI+fiILWuAoQ=;
        b=gSycAihRSc+M4xQBfTyUJEJ91az+fmDGW22JzeT2OT05L1tvML8IW/+6wRqpXSpbmM
         IPyzdSEnyp63/zTRdmItYxg6bEriLfa3G2F/quxbHvxExPiskmXvtjgjwWMmBYBLuIi6
         5/KRTafvdAYsMV+qdYDm/BeRVDp9MG1x6md4irM2CH7ZVQFWb2gC4kdGBTe5dee0Pl46
         UBgfzd+ae/FBtCwMYq44GYYiuPjGB5sFMCdRAtkypyOz63zyZDUoAboAO+LPv5PzGvXw
         LmmtySRSCn56MRAFy/MonTvBt7wq40CbMdkIKa4houViY7YkE3MLsw4B+yu0uKKOW97n
         Z3eQ==
X-Gm-Message-State: ABuFfogWCWc3WeVr9u2Bb+P4uBhvj7fWLwuGapMhRsKYpS2vgHV+Nbz0
        sp+zjskNvsbdq9wgKQ7KhgvPtLAIhaY=
X-Google-Smtp-Source: ACcGV628VUAVU+U7bRJ4TPKrtXr9ojPm4TjjRhvflQk2zPXkiAeES8bfTOw87rpBi92mLOGiwACPGQ==
X-Received: by 2002:a1c:950f:: with SMTP id x15-v6mr10295784wmd.3.1539531742914;
        Sun, 14 Oct 2018 08:42:22 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 199-v6sm5088014wme.39.2018.10.14.08.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 08:42:22 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: Add Intel ISP dummy driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180829135744.16205-1-hdegoede@redhat.com>
 <20180829182011.GG11447@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ce4d574f-51da-fd41-81ee-b1cb2792ff31@redhat.com>
Date:   Sun, 14 Oct 2018 17:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180829182011.GG11447@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 29-08-18 20:20, Andy Shevchenko wrote:
> On Wed, Aug 29, 2018 at 03:57:44PM +0200, Hans de Goede wrote:
>> The Image Signal Processor found on Cherry Trail devices is brought up in
>> D0 state on devices which have camera sensors attached to it. The ISP will
>> not enter D3 state again without some massaging of its registers beforehand
>> and the ISP not being in D3 state blocks the SoC from entering S0ix modes.
>>
>> There was a driver for the ISP in drivers/staging but that got removed
>> again because it never worked. It does not seem likely that a real
>> driver for the ISP will be added to the mainline kernel anytime soon.
>>
>> This commit adds a dummy driver which contains the necessary magic from
>> the staging driver to powerdown the ISP, so that Cherry Trail devices where
>> the ISP is used will properly use S0ix modes when suspended.
>>
>> Together with other recent S0ix related fixes this allows S0ix modes to
>> be entered on e.g. a Chuwi Hi8 Pro and a HP x2 210.
>>
> 
> Thanks for the patch, my comments below.

Thank you for the review and sorry for being a bit slow with responding
I've been quite busy with other stuff.

>>   drivers/platform/x86/intel_isp_dummy.c | 119 +++++++++++++++++++++++++
> 
> First of all, I would like to see that this is about pm and pm only, so,
> perhaps
> 
> intel_isp_pm ?
> 
> OTOH, it would be nice to have less confusing of what ISP we are talking about,
> so,
> 
> intel_atomisp2_pm ?

Works for me, intel_atomisp2_pm it is for v2 of this patch.

>> +config INTEL_ISP_DUMMY
>> +	tristate "Intel ISP dummy driver"
> 
>> +	depends on PCI && IOSF_MBI && PM
> 
> If someone decides to port this to kernels where ATOMISP driver is still
> available, it might be a conflict here. I dunno if it's a good idea to put
> something like depends !ATOMISP here taking into consideration that it would be
> staled option.

I don't look adding deps / conflucts on options which are
not present upstream, so I'm going to keep this as for v2.

> 
>> +	while (1) {
> 
> A nit: I would rather put it like
> 
> do {
> ...
> } while (time_after(...));

That would need to be time_before then, since the time check is a timeout
and then I would need to re-check the time outside the loop to see if
a timeout happened. So I believe it would better to keep this as is.


>> +		/* Wait until ISPSSPM0 bit[25:24] shows 0x3 */
>> +		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ, ISPSSPM0, &val);
>> +		val = (val & ISPSSPM0_ISPSSS_MASK) >> ISPSSPM0_ISPSSS_OFFSET;
>> +		if (val == ISPSSPM0_IUNIT_POWER_OFF)
>> +			break;
>> +
>> +		if (time_after(jiffies, timeout)) {
>> +			dev_err(&dev->dev, "IUNIT power-off timeout.\n");
>> +			return -EBUSY;
>> +		}
>> +		usleep_range(1000, 2000);
>> +	}
> 

Regards,

Hans

