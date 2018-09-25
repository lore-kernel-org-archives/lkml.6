Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CCF214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CCF214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeIYNt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:49:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:37885 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeIYNt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:49:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 00:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,301,1534834800"; 
   d="scan'208";a="94575360"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.4]) ([10.239.13.4])
  by orsmga002.jf.intel.com with ESMTP; 25 Sep 2018 00:43:01 -0700
Subject: Re: [LKP] [mm, oom] 6209f6fc62: general_protection_fault:#[##]
To:     Michal Hocko <mhocko@kernel.org>
Cc:     lkp@01.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180925054820.GC27173@shao2-debian>
 <20180925060653.GN18685@dhcp22.suse.cz>
 <084cf8cd-f384-8694-16c0-d1e2abfb9099@intel.com>
 <20180925073145.GO18685@dhcp22.suse.cz>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <917270d5-8755-b0d6-60c4-871f8c7ff982@intel.com>
Date:   Tue, 25 Sep 2018 15:43:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180925073145.GO18685@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/25/2018 03:31 PM, Michal Hocko wrote:
> On Tue 25-09-18 15:00:15, Rong Chen wrote:
>>
>> On 09/25/2018 02:06 PM, Michal Hocko wrote:
>>> On Tue 25-09-18 13:48:20, kernel test robot wrote:
>>>> FYI, we noticed the following commit (built with gcc-7):
>>>>
>>>> commit: 6209f6fc62835d84c2a92d237588a114e39436ce ("mm, oom: rework mmap_exit vs. oom_reaper synchronization")
>>>> https://github.com/0day-ci/linux UPDATE-20180911-024633/Tetsuo-Handa/mm-oom-Fix-unnecessary-killing-of-additional-processes/20180910-163452
>>> Do you have a msg-id to the patch that has been tested?
>> message_id: 20180910125513.311-2-mhocko@kernel.org
> Thanks! It woudl be really great if this was a part of the report when
> testing patches which are not mainline yet.
>
> This patch resulting in a crash is quite surprising. The patch is RFC
> and not tested yet but I will definitely have a look. Could you help me
> some more and give faddr2line __oom_reap_task_mm+0x40 please?
$ faddr2line ./vmlinux __oom_reap_task_mm+0x40
__oom_reap_task_mm+0x40/0x175:
can_madv_dontneed_vma at mm/internal.h:48
  (inlined by) __oom_reap_task_mm at mm/oom_kill.c:505

Best Regards,
Rong Chen
