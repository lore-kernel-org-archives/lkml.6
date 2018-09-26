Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469B7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053F820676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053F820676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeIZUha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:37:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:5724 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeIZUha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:37:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 07:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="266870004"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.74.64]) ([10.252.74.64])
  by fmsmga006.fm.intel.com with ESMTP; 26 Sep 2018 07:24:14 -0700
Subject: Re: [PATCH 4/4] platform/x86: intel_telemetry: report debugfs failure
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        matt.turner@intel.com, "Brown, Len" <len.brown@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
 <20180903180415.31575-4-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcE+BY=8aKEGqzkDBVazLGtwNNCa1CYCKGirS1vBLVXPg@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <69ad420e-362c-d8c9-331f-056cdaefb1eb@linux.intel.com>
Date:   Wed, 26 Sep 2018 19:54:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcE+BY=8aKEGqzkDBVazLGtwNNCa1CYCKGirS1vBLVXPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Sep-18 7:26 PM, Andy Shevchenko wrote:
> On Mon, Sep 3, 2018 at 9:05 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> On some Goldmont based systems such as ASRock J3455M the BIOS may not
>> enable the IPC1 device that provides access to the PMC and PUNIT. In
>> such scenarios, the ioss and pss resources from the platform device can
> IOSS
> PSS

Fine.

>
>> not be obtained and result in a invalid telemetry_plt_config.
> What is telemetry_plt_config?

Internal data structure that holds platform config, maintained by the 
telemetry platform driver.

>
>> This is also applicable to the platforms where the BIOS supports IPC1
>> device under debug configurations but IPC1 is disabled by user or the
>> policy.
>>
>> This change allows user to know the reason for not seeing entries under
>> /sys/kernel/debug/telemetry/* when there is no apparent failure at boot.
>>
>> Cc: Matt Turner <matt.turner@intel.com>
>> Cc: Len Brown <len.brown@intel.com>
>> Cc: Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
>> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198779
>>
> There should be not a blank line.

OK.

>
>> Acked-by: Matt Turner <matt.turner@intel.com>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> +exit:
>> +       pr_debug(pr_fmt(DRIVER_NAME) " Failed\n");
> Completely useless.
>
> Device core does it in generic way.

If i remove this print then perhaps there is no need of this patch. 
Reason to print this is that the platform driver / core driver does not 
show any error. In-fact they are even loaded in module table. OTOH, this 
debugfs interface fails. This is very confusing to the users if they 
check the lsmod output so i feel this print might help.

>

