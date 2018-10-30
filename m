Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DC1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926EF2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926EF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeJ3Qdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:33:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:13316 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbeJ3Qdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:33:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 00:41:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,443,1534834800"; 
   d="scan'208";a="104439448"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.66.171]) ([10.252.66.171])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2018 00:41:11 -0700
Subject: Re: [PATCH v2 4/4] platform/x86: intel_telemetry: report debugfs
 failure
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        matt.turner@intel.com, "Brown, Len" <len.brown@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
 <20181006065113.669-4-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VfS2cB3fh1R_iQk91skU-p+yZ_X1Jx2sBaiwHmtAZ0dpw@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <b1d972ce-6672-344c-e432-c8bc9bb20dad@linux.intel.com>
Date:   Tue, 30 Oct 2018 13:11:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfS2cB3fh1R_iQk91skU-p+yZ_X1Jx2sBaiwHmtAZ0dpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19-Oct-18 6:09 PM, Andy Shevchenko wrote:
> On Sat, Oct 6, 2018 at 9:54 AM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> On some Goldmont based systems such as ASRock J3455M the BIOS may not
>> enable the IPC1 device that provides access to the PMC and PUNIT. In
>> such scenarios, the IOSS and PSS resources from the platform device can
>> not be obtained and result in a invalid telemetry_plt_config which is an
>> internal data structure that holds platform config and is maintained by
>> the telemetry platform driver.
>>
>> This is also applicable to the platforms where the BIOS supports IPC1
>> device under debug configurations but IPC1 is disabled by user or the
>> policy.
>>
>> This change allows user to know the reason for not seeing entries under
>> /sys/kernel/debug/telemetry/* when there is no apparent failure at boot.
>>
> Pushed to my review and testing queue, thanks!
>
> P.S. I appended one more patch against this file, please check if it's okay.

Thank you Andy. I will check it when Infradead is online.

>
>> Cc: Matt Turner <matt.turner@intel.com>
>> Cc: Len Brown <len.brown@intel.com>
>> Cc: Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
>> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198779
>> Acked-by: Matt Turner <matt.turner@intel.com>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> ---
>> Changes in v2:
>>   * Removed print and out label both as suggested by Andy.
>>   * changed to pr_info.
>>   * Other minor style fixes.
>>
>>
>>   drivers/platform/x86/intel_telemetry_debugfs.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
>> index ffd0474b0531..1423fa8710fd 100644
>> --- a/drivers/platform/x86/intel_telemetry_debugfs.c
>> +++ b/drivers/platform/x86/intel_telemetry_debugfs.c
>> @@ -951,12 +951,16 @@ static int __init telemetry_debugfs_init(void)
>>          debugfs_conf = (struct telemetry_debugfs_conf *)id->driver_data;
>>
>>          err = telemetry_pltconfig_valid();
>> -       if (err < 0)
>> +       if (err < 0) {
>> +               pr_info("Invalid pltconfig, ensure IPC1 device is enabled in BIOS\n");
>>                  return -ENODEV;
>> +       }
>>
>>          err = telemetry_debugfs_check_evts();
>> -       if (err < 0)
>> +       if (err < 0) {
>> +               pr_info("telemetry_debugfs_check_evts failed\n");
>>                  return -EINVAL;
>> +       }
>>
>>          register_pm_notifier(&pm_notifier);
>>
>> --
>> 2.17.1
>>
>

