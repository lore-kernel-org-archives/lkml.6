Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676B8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D42721855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAYWmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:42:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:56577 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfAYWmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:42:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 14:42:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,523,1539673200"; 
   d="scan'208";a="313596251"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jan 2019 14:42:22 -0800
Received: from [10.254.80.124] (kliang2-mobl1.ccr.corp.intel.com [10.254.80.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5DE815806CD;
        Fri, 25 Jan 2019 14:42:22 -0800 (PST)
Subject: Re: perf/x86/intel/uncore
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
References: <E44A3BE5-E45A-4D88-818C-02E6E6342060@fb.com>
 <2f74c906-6d13-ff18-f967-100e82343f2f@linux.intel.com>
 <5350E02A-6457-41A8-8F33-AF67BFDAEE3E@fb.com>
 <50e2eb5b-bb83-6219-d2d7-4ec832b9f5d5@linux.intel.com>
 <700FE2CF-4DA0-4B62-B0B0-A740014CD7B6@fb.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b2f5eaf7-066a-0492-a5fe-e4cc9b1161d0@linux.intel.com>
Date:   Fri, 25 Jan 2019 17:42:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <700FE2CF-4DA0-4B62-B0B0-A740014CD7B6@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2019 5:24 PM, Song Liu wrote:
> I also noticed that uncore_pci_probe() returns at
> 
>          if (atomic_inc_return(&pmu->activeboxes) > 1)
>                  return 0;
> 
> for bus 1-7. So we only probed bus 0 (socket 0). Is this expected behavior?

We probed all, but only need to register PMU once.
It can be distinguished by cpumask. E.g. you may want to check 
"/sys/devices/uncore_imc_0/cpumask".


Thanks,
Kan
