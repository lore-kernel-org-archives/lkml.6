Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211D5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D583620827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D583620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbeKFGWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:22:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:32979 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387441AbeKFGWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:22:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 13:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="105504096"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.93.140]) ([10.252.93.140])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2018 13:00:42 -0800
Subject: Re: [PATCH v3 3/3] platform/x86: intel_pmc_core: Decode Snoop / Non
 Snoop LTR
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20181102103441.21943-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VfCcLPc_y4ZxvkahpMxjkj_5sntamYze90p7Ki94yU5Lg@mail.gmail.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <8021ed8d-6931-3ffd-6e46-630e9a2c4a66@linux.intel.com>
Date:   Tue, 6 Nov 2018 02:30:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfCcLPc_y4ZxvkahpMxjkj_5sntamYze90p7Ki94yU5Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03-Nov-18 12:02 AM, Andy Shevchenko wrote:
> On Fri, Nov 2, 2018 at 12:37 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@linux.intel.com> wrote:
>> The LTR values follow PCIE LTR encoding format and can be decoded as per
>> https://pcisig.com/sites/default/files/specification_documents/ECN_LatencyTolnReporting_14Aug08.pdf
>>
>> This adds support to translate the raw LTR values as read from the PMC
>> to meaningful values in nanosecond units of time.
>> +#include <linux/bits.h>
> I told you something different, i.e. put this header where you _use_
> it, i.o.w into the header file.

Oops! Will move it to the header.

>
>> +#define LTR_REQ_NONSNOOP                       BIT(31)
>> +#define LTR_REQ_SNOOP                          BIT(15)
>> +#define LTR_DECODED_VAL                                GENMASK(9, 0)
>> +#define LTR_DECODED_SCALE                      GENMASK(12, 10)
> If these are in one register, please keep ordered by start bit.

Sure, will do.

>
> The rest is fine.
>

Many thanks again for your detailed review.

