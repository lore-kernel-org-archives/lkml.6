Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E843C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D596A20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D596A20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbeKFGUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:20:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:52825 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbeKFGUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:20:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 12:58:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="105503305"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.93.140]) ([10.252.93.140])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2018 12:58:12 -0800
Subject: Re: [PATCH v3 1/3] platform/x86: intel_pmc_core: Show Latency
 Tolerance info
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20181102102703.21846-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcJDSM31JMzHnFcb=Rh9wOn+LJ-qKe7x-S8h3P9AQwcdQ@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <9b306a95-9587-656f-e5ac-ac05daa263c9@linux.intel.com>
Date:   Tue, 6 Nov 2018 02:28:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcJDSM31JMzHnFcb=Rh9wOn+LJ-qKe7x-S8h3P9AQwcdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again for your time. My response inline.


On 02-Nov-18 11:57 PM, Andy Shevchenko wrote:
> On Fri, Nov 2, 2018 at 12:29 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> This adds support to show the Latency Tolerance Reporting for the IPs on
>> the PCH as reported by the PMC. The format shown here is raw LTR data
>> payload that can further be decoded as per the PCI specification.
>>
>> This also fixes some minor alignment issues in the header file by
>> removing spaces and converting to tabs at some places.
> Thanks for the update, my comments below.
>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> [andy: fixed output to avoid LTR duplication and put space after colon]
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> You incorporated changes I proposed — good!
> But please, don't do my job with signing stuff, etc. Just mention what
> you did in the changelog.

Okay.  I downloaded the patch applied on review-andy branch and worked 
on it. Those two lines came along with the downloaded patch but i 
understood your concern now.

>
>
>> +static const struct pmc_bit_map spt_ltr_show_map[] = {
>> +       {"SOUTHPORT_A",         SPT_PMC_LTR_SPA},
>> +       {"SOUTHPORT_B",         SPT_PMC_LTR_SPB},
>> +       {"SATA",                SPT_PMC_LTR_SATA},
>> +       {"GIGABIT_ETHERNET",    SPT_PMC_LTR_GBE},
>> +       {"XHCI",                SPT_PMC_LTR_XHCI},
>> +       /* IP 5 is reserved */
> Since we dropped explicit numbering, this line and similar sounds redundant.

Fine.

>
>> +       {"ME",                  SPT_PMC_LTR_ME},
>> +       /* EVA is Enterprise Value Add, doesn't really exist on PCH */
>> +       {"EVA",                 SPT_PMC_LTR_EVA},
>> +       {"SOUTHPORT_C",         SPT_PMC_LTR_SPC},
>> +       {"HD_AUDIO",            SPT_PMC_LTR_AZ},
>> +       /* IP 10 is reserved */
>> +       {"LPSS",                SPT_PMC_LTR_LPSS},
>> +       {"SOUTHPORT_D",         SPT_PMC_LTR_SPD},
>> +       {"SOUTHPORT_E",         SPT_PMC_LTR_SPE},
>> +       {"CAMERA",              SPT_PMC_LTR_CAM},
>> +       {"ESPI",                SPT_PMC_LTR_ESPI},
>> +       {"SCC",                 SPT_PMC_LTR_SCC},
>> +       {"ISH",                 SPT_PMC_LTR_ISH},
>> +       /* Below two cannot be used for LTR_IGNORE */
>> +       {"CURRENT_PLATFORM",    SPT_PMC_LTR_CUR_PLT},
>> +       {"AGGREGATED_SYSTEM",   SPT_PMC_LTR_CUR_ASLT},
>> +       {}
>> +};
>>   /* Cannonlake Power Management Controller register offsets */
>> -#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
>> -#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
>> -#define CNP_PMC_PM_CFG_OFFSET                  0x1818
>> +#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
>> +#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
>> +#define CNP_PMC_PM_CFG_OFFSET                  0x1818
>>   #define CNP_PMC_SLPS0_DBG_OFFSET               0x10B4
> Can we preserve ordering?

Doesn't harm, will reorder based on offsets increasing order.

>
>>   /* Cannonlake: PGD PFET Enable Ack Status Register(s) start */
>> -#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
>> +#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
> What's wrong with this line? Why is it changed?

This and below are edited to convert spaces to tabs. This is captured in 
commit message too.

>
>> -#define CNP_PMC_MMIO_REG_LEN                   0x2000
>> -#define CNP_PPFEAR_NUM_ENTRIES                 8
>> -#define CNP_PMC_READ_DISABLE_BIT               22
>> +#define CNP_PMC_MMIO_REG_LEN                   0x2000
>> +#define CNP_PPFEAR_NUM_ENTRIES                 8
>> +#define CNP_PMC_READ_DISABLE_BIT               22
> What happened to these lines?

same as above.

>
>>   #define CNP_PMC_LATCH_SLPS0_EVENTS             BIT(31)
> Perhaps
>   + blank line
> here

This is from a previous commit but i think its better to move it up the 
block and insert one blank line after. If we insert one blank line after 
its current position, it looks odd and cuts the logical block unnecessarily.

>
>> +#define CNP_PMC_LTR_CUR_PLT                    0x1B50
>> +#define CNP_PMC_LTR_CUR_ASLT                   0x1B54
>> +#define CNP_PMC_LTR_SPA                                0x1B60
>> +#define CNP_PMC_LTR_SPB                                0x1B64
>> +#define CNP_PMC_LTR_SATA                       0x1B68
>> +#define CNP_PMC_LTR_GBE                                0x1B6C
>> +#define CNP_PMC_LTR_XHCI                       0x1B70
>> +#define CNP_PMC_LTR_ME                         0x1B78
>> +#define CNP_PMC_LTR_EVA                                0x1B7C
>> +#define CNP_PMC_LTR_SPC                                0x1B80
>> +#define CNP_PMC_LTR_AZ                         0x1B84
>> +#define CNP_PMC_LTR_LPSS                       0x1B8C
>> +#define CNP_PMC_LTR_CAM                                0x1B90
>> +#define CNP_PMC_LTR_SPD                                0x1B94
>> +#define CNP_PMC_LTR_SPE                                0x1B98
>> +#define CNP_PMC_LTR_ESPI                       0x1B9C
>> +#define CNP_PMC_LTR_SCC                                0x1BA0
>> +#define CNP_PMC_LTR_ISH                                0x1BA4
>> +#define CNP_PMC_LTR_CNV                                0x1BF0
>> +#define CNP_PMC_LTR_EMMC                       0x1BF4
>> +#define CNP_PMC_LTR_UFSX2                      0x1BF8

