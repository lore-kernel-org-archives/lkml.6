Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCAEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E975E20824
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E975E20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbeKXODT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 09:03:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:41047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbeKXODT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 09:03:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2018 19:16:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,272,1539673200"; 
   d="scan'208";a="283681780"
Received: from maxkim-mobl.gar.corp.intel.com (HELO [10.251.149.90]) ([10.251.149.90])
  by fmsmga006.fm.intel.com with ESMTP; 23 Nov 2018 19:16:32 -0800
Subject: Re: [alsa-devel] [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S
 support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        vkoul@kernel.org, broonie@kernel.org
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
 <20181121142721.GO10650@smile.fi.intel.com>
 <414b4c3a-7e04-2775-7d87-16a236b5b4e8@linux.intel.com>
 <20181121173841.GS10650@smile.fi.intel.com> <s5hh8gaaxdm.wl-tiwai@suse.de>
 <20181122095611.GV10650@smile.fi.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7598e3f5-d936-709b-85e4-eecfa5d149fd@linux.intel.com>
Date:   Fri, 23 Nov 2018 21:16:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122095611.GV10650@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/18 3:56 AM, Andy Shevchenko wrote:
> On Wed, Nov 21, 2018 at 11:17:41PM +0100, Takashi Iwai wrote:
>> On Wed, 21 Nov 2018 18:38:41 +0100, Andy Shevchenko wrote:
>>> Compare:
>>>
>>> 	/* CFL */
>>> 	{ PCI_DEVICE(0x8086, 0xa348),
>>> 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
>>>
>>> to something like:
>>>
>>> #define PCI_DEVICE_ID_INTEL_AUDIO_CFL	0xa348
>>> ...
>>>
>>> 	{PCI_DEVICE_DATA(INTEL, AUDIO_CFL, &snd_soc_acpi_intel_cnl_machines)},
>> The former gives a better grep-ability, though.
>>
>> I have no big preference over two, just want to mention that both have
>> merits and demerits.
> True.
> So, up to you, guys, what to choose.

I am leaning to leave the PCI stuff alone for now. If we change the PCI 
definitions I'd like to do it on the SKL and legacy sides at the same 
time, to avoid multiple definitions or redundancies.

However I like your suggestion for the macros on the other patch so will 
change the code.

Thanks for the reviews!

>
