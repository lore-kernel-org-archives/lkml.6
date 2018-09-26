Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D2CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6782D20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6782D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeIZU2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:28:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:4581 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeIZU2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:28:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 07:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="266868113"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.74.64]) ([10.252.74.64])
  by fmsmga006.fm.intel.com with ESMTP; 26 Sep 2018 07:11:51 -0700
Subject: Re: [PATCH 1/4] platform/x86: intel_pmc_core: Show Latency Tolerance
 info
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75Vesn4TrdF8tWLkU7nCRGp_o8fEK6gxpTkwM7E7zQo0qKg@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <04398317-a3b8-9387-e532-fcf26da9220e@linux.intel.com>
Date:   Wed, 26 Sep 2018 19:41:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vesn4TrdF8tWLkU7nCRGp_o8fEK6gxpTkwM7E7zQo0qKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Sep-18 7:18 PM, Andy Shevchenko wrote:
> On Mon, Sep 3, 2018 at 9:06 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> This adds support to show the Latency Tolerance Reporting for the IPs on
>> the PCH as reported by the PMC. The format shown here is raw LTR data
>> payload that can further be decoded as per the PCI specification.
>>
>> This also fixes some minor alignment issues in the header file by
>> removing spaces and converting to tabs at some places.
> Thanks for the patch, my comments below.

Hi Andy,

Thanks for the review, my answers below.
>
>> +static const struct pmc_bit_map spt_ltr_show_map[] = {
>> +       {"IP 0  : LTR_SOUTHPORT_A",             SPT_PMC_LTR_SPA},
>> +       {"IP 1  : LTR_SOUTHPORT_B",             SPT_PMC_LTR_SPB},
>> +       {"IP 2  : LTR_SATA",                    SPT_PMC_LTR_SATA},
>> +       {"IP 3  : LTR_GIGABIT_ETHERNET",        SPT_PMC_LTR_GBE},
>> +       {"IP 4  : LTR_XHCI",                    SPT_PMC_LTR_XHCI},
>> +       /* IP 5 is reserved */
>> +       {"IP 6  : LTR_ME",                      SPT_PMC_LTR_ME},
>> +       /* EVA is Enterprise Value Add, doesn't really exist on PCH */
>> +       {"IP 7  : LTR_EVA",                     SPT_PMC_LTR_EVA},
>> +       {"IP 8  : LTR_SOUTHPORT_C",             SPT_PMC_LTR_SPC},
>> +       {"IP 9  : LTR_HD_AUDIO",                SPT_PMC_LTR_AZ},
>> +       /* IP 10 is reserved */
>> +       {"IP 11 : LTR_LPSS",                    SPT_PMC_LTR_LPSS},
>> +       {"IP 12 : LTR_SOUTHPORT_D",             SPT_PMC_LTR_SPD},
>> +       {"IP 13 : LTR_SOUTHPORT_E",             SPT_PMC_LTR_SPE},
>> +       {"IP 14 : LTR_CAMERA",                  SPT_PMC_LTR_CAM},
>> +       {"IP 15 : LTR_ESPI",                    SPT_PMC_LTR_ESPI},
>> +       {"IP 16 : LTR_SCC",                     SPT_PMC_LTR_SCC},
>> +       {"IP 17 : LTR_ISH",                     SPT_PMC_LTR_ISH},
>> +       /* Below two cannot be for LTR_IGNORE */
>> +       {"LTR_CURRENT_PLATFORM",                SPT_PMC_LTR_CUR_PLT},
>> +       {"LTR_AGGREGATED_SYSTEM",               SPT_PMC_LTR_CUR_ASLT},
> Before no map has this fancy "IP xx :" prefixes. Please, remove.

  The users of the driver often ask for IP Numbers while performing 
LTR_IGNORE operation so this is deliberately added. Please consider it.

>
>> +       {},
> No need for comma
Ok.
>> +
> Redundant.

OK
>
>> +};
>> +static const struct pmc_bit_map cnp_ltr_show_map[] = {
> Same comments as above.
>
>> +};
>> +       debugfs_create_file("ltr_show", 0644, dir, pmcdev,
>> +                           &pmc_core_ltr_fops);
> One line?

IIRC, it was crossing the limit. I will check again and if possible 
would change it.

>
>>   #define NUM_RETRIES                            100
>>   #define NUM_IP_IGN_ALLOWED                     17
> + blank line here.

Sure.

>
>> +#define SPT_PMC_LTR_CUR_PLT                    0x350

