Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4575FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134E520883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfACIvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:51:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:22573 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbfACIvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:51:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 00:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,434,1539673200"; 
   d="scan'208";a="103586778"
Received: from rfried-ivm1.ger.corp.intel.com (HELO [10.185.130.184]) ([10.185.130.184])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2019 00:51:03 -0800
Subject: Re: RFC: gpio: mmio: add support for 3 direction regs
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vladimir.kondratiev@linux.intel.com
References: <32edfd70-95dc-26a1-2ea6-143344cb2384@linux.intel.com>
 <ca7c1b99-4166-652b-aa53-8272aa66eb73@mentor.com>
From:   "Fried, Ramon" <ramon.fried@linux.intel.com>
Message-ID: <28205214-d395-1c17-51ee-970300b6a14e@linux.intel.com>
Date:   Thu, 3 Jan 2019 10:51:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <ca7c1b99-4166-652b-aa53-8272aa66eb73@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/3/2019 10:07, Vladimir Zapolskiy wrote:
> Hi Ramon,
>
> On 01/03/2019 09:36 AM, Fried, Ramon wrote:
>> Hi.
>>
>> I'm working on a driver for STA2X11 GPIO controller who seems to fit
>> best to the generic mmio driver,
> I hope you have seen the existing driver drivers/gpio/gpio-sta2x11.c
I surely did. we have the same IP in our soc but it was changed a lot internally, don't want to litter the original.
>
>> the only problem I have is with the dir register case. The STA2X11
>> has 3 registers for dir, one for data, one for set and one for
>> clear. The generic-mmio driver has support for this fashion for the
>> dat & set & clear registers but not for dirout/dirin registers.
>>
>> I wonder if support for this is generic enough to deserve a patch, if
>> so I'm willing to quickly add this support, if not, adding a flag
>> such as below, will allow partly using the generic mmio driver only
>> for set/get and the direction can be handled outside the driver.
>>
> If gpio-mmio fits well, then it might be simpler to set a flag
> BGPIOF_UNREADABLE_REG_DIR, then call bgpio_init() and then overwrite
> .direction_input, .direction_output and .get_direction callbacks,
> as a reference you can take a look at gpio-74xx-mmio.c

Nice.
That's an option I didn't think of, better than setting the flag. what about adding the generic support ?

>
> --
> Best wishes,
> Vladimir
