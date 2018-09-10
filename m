Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B186C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A4E20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A4E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeIJLAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:00:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:5913 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbeIJLAr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:00:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2018 23:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,354,1531810800"; 
   d="scan'208";a="88625072"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.161.25]) ([10.239.161.25])
  by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2018 23:08:22 -0700
Subject: Re: [PATCH v2] perf/x86/intel/uncore: Provide alias for IIO
 free-running boxes on SKX
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@redhat.com, eranian@google.com,
        kan.liang@intel.com, jolsa@kernel.org,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, yao.jin@intel.com
References: <1536058697-22003-1-git-send-email-yao.jin@linux.intel.com>
 <20180904071349.GZ24124@hirez.programming.kicks-ass.net>
 <3dbfc026-86c2-4523-f690-df45e4ed0643@linux.intel.com>
Message-ID: <c0364c60-c812-514c-aa4b-6f268559f718@linux.intel.com>
Date:   Mon, 10 Sep 2018 14:08:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3dbfc026-86c2-4523-f690-df45e4ed0643@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One week nearly passed, I guess there is no any objections for this 
patch from community. :)

Thanks
Jin Yao

On 9/4/2018 3:45 PM, Jin, Yao wrote:
> 
> 
> On 9/4/2018 3:13 PM, Peter Zijlstra wrote:
>> On Tue, Sep 04, 2018 at 06:58:17PM +0800, Jin Yao wrote:
>>> root@skx /sys/devices# ls | grep uncore_iio
>>> uncore_iio_0
>>> uncore_iio_1
>>> uncore_iio_2
>>> uncore_iio_3
>>> uncore_iio_4
>>> uncore_iio_5
>>> uncore_iio_free_running_0
>>> uncore_iio_free_running_1
>>> uncore_iio_free_running_2
>>> uncore_iio_free_running_3
>>> uncore_iio_free_running_4
>>> uncore_iio_free_running_5
>>
>>> root@skx /sys/devices# ls | grep uncore_iio
>>> uncore_iio_0
>>> uncore_iio_1
>>> uncore_iio_2
>>> uncore_iio_3
>>> uncore_iio_4
>>> uncore_iio_5
>>> uncore_iio_cbdma
>>> uncore_iio_mcp0
>>> uncore_iio_mcp1
>>> uncore_iio_pcie0
>>> uncore_iio_pcie1
>>> uncore_iio_pcie2
>>
>> I think I'm ok with that, except of course for people that have
>> "free_running_#" in their scripts now and will to wtf when they upgrade
>> their kernel.
>>
>> Do we care about them?
>>
> 
> Yes, that may be a potential issue but maybe it's not since we really 
> don't know if some people have used uncore_iio_free_running_# in their 
> scripts or not.
> 
> I write this patch is because I always forget the meaning of 
> uncore_iio_free_running_# so I have to go back to check the document 
> "Intel Xeon Processor Scalable Memory Family Uncore Performance 
> Monitoring" again and again to find the box definition. I guess other 
> people may have similar trouble.
> 
> Maybe we wait some time to see more feedback from community?
> 
> Thanks
> Jin Yao
