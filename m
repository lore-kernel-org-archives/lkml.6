Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A94AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D439220676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D439220676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeIZUiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:38:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:11086 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbeIZUiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:38:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 07:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="266870072"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.74.64]) ([10.252.74.64])
  by fmsmga006.fm.intel.com with ESMTP; 26 Sep 2018 07:24:45 -0700
Subject: Re: [PATCH 2/4] platform/x86: intel_pmc_core: Fix LTR IGNORE Max
 offset
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
 <20180903180415.31575-2-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75Vcx-rk_dgf6fNRMa6o-zFeSXAG+HSNMAN-1XVCsXvvv1w@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <92d451b5-e6b7-74a2-dc71-19e30654c2f3@linux.intel.com>
Date:   Wed, 26 Sep 2018 19:54:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcx-rk_dgf6fNRMa6o-zFeSXAG+HSNMAN-1XVCsXvvv1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.


On 26-Sep-18 7:27 PM, Andy Shevchenko wrote:
> On Mon, Sep 3, 2018 at 9:05 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> Cannonlake PCH allows us to ignore LTR from more IPs than Sunrisepoint
>> PCH so make the LTR ignore platform specific.
>>
> This looks fine to me.
>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel_pmc_core.c | 4 +++-
>>   drivers/platform/x86/intel_pmc_core.h | 4 +++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
>> index 972735bd4c75..c1330a03523d 100644
>> --- a/drivers/platform/x86/intel_pmc_core.c
>> +++ b/drivers/platform/x86/intel_pmc_core.c
>> @@ -149,6 +149,7 @@ static const struct pmc_reg_map spt_reg_map = {
>>          .ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
>>          .pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
>>          .pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
>> +       .ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
>>   };
>>
>>   /* Cannonlake: PGD PFET Enable Ack Status Register(s) bitmap */
>> @@ -320,6 +321,7 @@ static const struct pmc_reg_map cnp_reg_map = {
>>          .ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
>>          .pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>>          .pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
>> +       .ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
>>   };
>>
>>   static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
>> @@ -566,7 +568,7 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file, const char __user
>>                  goto out_unlock;
>>          }
>>
>> -       if (val > NUM_IP_IGN_ALLOWED) {
>> +       if (val > map->ltr_ignore_max) {
>>                  err = -EINVAL;
>>                  goto out_unlock;
>>          }
>> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
>> index b24407048fa1..12663c58f122 100644
>> --- a/drivers/platform/x86/intel_pmc_core.h
>> +++ b/drivers/platform/x86/intel_pmc_core.h
>> @@ -44,7 +44,7 @@
>>   #define SPT_PMC_READ_DISABLE_BIT               0x16
>>   #define SPT_PMC_MSG_FULL_STS_BIT               0x18
>>   #define NUM_RETRIES                            100
>> -#define NUM_IP_IGN_ALLOWED                     17
>> +#define SPT_NUM_IP_IGN_ALLOWED                 17
>>   #define SPT_PMC_LTR_CUR_PLT                    0x350
>>   #define SPT_PMC_LTR_CUR_ASLT                   0x354
>>   #define SPT_PMC_LTR_SPA                                0x360
>> @@ -153,6 +153,7 @@ enum ppfear_regs {
>>   #define CNP_PPFEAR_NUM_ENTRIES                 8
>>   #define CNP_PMC_READ_DISABLE_BIT               22
>>   #define CNP_PMC_LATCH_SLPS0_EVENTS             BIT(31)
>> +#define CNP_NUM_IP_IGN_ALLOWED                 19
>>   #define CNP_PMC_LTR_CUR_PLT                    0x1B50
>>   #define CNP_PMC_LTR_CUR_ASLT                   0x1B54
>>   #define CNP_PMC_LTR_SPA                                0x1B60
>> @@ -215,6 +216,7 @@ struct pmc_reg_map {
>>          const u32 pm_cfg_offset;
>>          const int pm_read_disable_bit;
>>          const u32 slps0_dbg_offset;
>> +       const u32 ltr_ignore_max;
>>   };
>>
>>   /**
>> --
>> 2.17.1
>>
>

