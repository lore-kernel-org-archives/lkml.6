Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9546C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BA22085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAWQuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:50:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:18995 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfAWQuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:50:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 08:50:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; 
   d="scan'208";a="109173853"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2019 08:50:03 -0800
Subject: Re: [PATCHv1] firmware: intel_stratix10_service: add hardware
 dependency
To:     Greg KH <gregkh@linuxfoundation.org>, Alan Tull <atull@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        todd.riffel@intel.com, Richard Gong <richard.gong@intel.com>
References: <1548258476-16821-1-git-send-email-richard.gong@linux.intel.com>
 <20190123160019.GB4764@kroah.com>
 <CANk1AXR2K5j6iU1y8GGn_8agOUY6ca8xKXPrFGT5Ht6_La7VrA@mail.gmail.com>
 <20190123164317.GA16162@kroah.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <0d04145a-bd8b-5257-bccd-f9b6c855edcb@linux.intel.com>
Date:   Wed, 23 Jan 2019 10:59:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123164317.GA16162@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 1/23/19 10:43 AM, Greg KH wrote:
> On Wed, Jan 23, 2019 at 10:37:07AM -0600, Alan Tull wrote:
>> On Wed, Jan 23, 2019 at 10:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> Hi Greg,
>>
>>>
>>> On Wed, Jan 23, 2019 at 09:47:56AM -0600, richard.gong@linux.intel.com wrote:
>>>> From: Richard Gong <richard.gong@intel.com>
>>>>
>>>> Add a Kconfig dependency to ensure Intel Stratix10 service layer driver
>>>> can be built only on the platform that supports it.
>>>>
>>>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>>>> ---
>>>>   drivers/firmware/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>>>> index f754578..cac16c4 100644
>>>> --- a/drivers/firmware/Kconfig
>>>> +++ b/drivers/firmware/Kconfig
>>>> @@ -218,7 +218,7 @@ config FW_CFG_SYSFS_CMDLINE
>>>>
>>>>   config INTEL_STRATIX10_SERVICE
>>>>        tristate "Intel Stratix10 Service Layer"
>>>> -     depends on HAVE_ARM_SMCCC
>>>> +     depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
>>>
>>> That's lame, what about building for testing?
>>
>> Do you mean this instead?
>>
>> depends on (ARCH_STRATIX10 && HAVE_ARM_SMCCC) || COMPILE_TEST
> 
> Yes, that would be better, right?
> 
>>>
>>> And is this needed now, for 5.0-final, or can it wait for 5.1?
>>
>> This change will reduce kernel size for most arm64.  It can go into
>> whichever kernel.  We can resubmit allowing for COMPILE_TEST.
> 
> So it's not fixing a bug, but rather just allowing you to shrink an
> image?  If so, then 5.1 is good.
> 
> Please resubmit, after making sure it doesn't break the normal builds :)

Thanks for your review comments, I will resubmit the patch.
> 
> thanks,
> 
> greg k-h
> 
