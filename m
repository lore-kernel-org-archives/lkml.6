Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D9EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5AD20813
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5AD20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439264AbeKWMFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 07:05:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:16492 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733058AbeKWMFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 07:05:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 17:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,267,1539673200"; 
   d="scan'208";a="110581457"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2018 17:23:35 -0800
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order of
 operations for deferred probe and remove
To:     Bart Van Assche <bvanassche@acm.org>,
        kbuild test robot <lkp@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-nvdimm@lists.01.org,
        tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
References: <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
 <201811061228.iteFLO2p%fengguang.wu@intel.com>
 <1541548274.196084.197.camel@acm.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d70f2bcb-0e1c-2d69-2692-329ef5cf81bc@intel.com>
Date:   Fri, 23 Nov 2018 09:23:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1541548274.196084.197.camel@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/2018 07:51 AM, Bart Van Assche wrote:
> On Tue, 2018-11-06 at 12:10 +0800, kbuild test robot wrote:
>> Hi Alexander,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on driver-core/master]
>>
>> url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Add-NUMA-aware-async_schedule-calls/20181106-093800
>> reproduce: make htmldocs
>>
>> All warnings (new ones prefixed by >>):
>>
>>     include/net/mac80211.h:1001: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
>> [ ... ]
> There are plenty of references in this report to header files not touched
> by patch 5/9 in this series. I assume that this report indicates a bug in
> the 0-day testing infrastructure?
>
> Bart.
>
Hi Bart,

Kbuild robot printed all warnings and the below warning was found in 
patch 5/9.

"include/linux/device.h:1056: warning: Function parameter or member 
'async_probe' not described in 'device'"

Best Regards,
Rong Chen
