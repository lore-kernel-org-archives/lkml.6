Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BC4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578C32087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578C32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbeIUCzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:55:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:36689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeIUCzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:55:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 14:10:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="71648285"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2018 14:10:20 -0700
Received: from [10.251.3.103] (kliang2-mobl1.ccr.corp.intel.com [10.251.3.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 913605801CF;
        Thu, 20 Sep 2018 14:10:19 -0700 (PDT)
Subject: Re: [RESEND] [PATCH] perf/x86/intel/uncore: Use
 boot_cpu_data.phys_proc_id instead of hardcorded phy id 0
To:     Thomas Gleixner <tglx@linutronix.de>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@intel.com>
References: <20180910144750.6782-1-msys.mizuma@gmail.com>
 <alpine.DEB.2.21.1809202254530.1434@nanos.tec.linutronix.de>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7fb7e563-d911-d325-ec48-8b153bece071@linux.intel.com>
Date:   Thu, 20 Sep 2018 17:10:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809202254530.1434@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/2018 4:55 PM, Thomas Gleixner wrote:
> On Mon, 10 Sep 2018, Masayoshi Mizuma wrote:
> 
> CC+ Kan
> 
>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>
>> Physical package id 0 is not always exists. We should use
>> boot_cpu_data.phys_proc_id here.
>>
>> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>> ---
>>   arch/x86/events/intel/uncore_snbep.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index 51d7c11..53b981d 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -3061,7 +3061,7 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
>>   
>>   void bdx_uncore_cpu_init(void)
>>   {
>> -	int pkg = topology_phys_to_logical_pkg(0);
>> +	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);

I think it's better to use logical_proc_id directly.

+	int pkg = boot_cpu_data.logical_proc_id;

Thanks,
Kan

