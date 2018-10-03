Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78D6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B2B213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B2B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJCVNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:13:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:35309 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbeJCVNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:13:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 07:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="75096221"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2018 07:25:05 -0700
Received: from [10.251.17.70] (kliang2-mobl1.ccr.corp.intel.com [10.251.17.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 78C1A5801E6;
        Wed,  3 Oct 2018 07:25:04 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel: Add counter freezing quirk for Goldmont
To:     linux-kernel-owner@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, x86@kernel.org
References: <1538515812-8808-1-git-send-email-kan.liang@linux.intel.com>
 <alpine.DEB.2.21.1810030803260.1435@nanos.tec.linutronix.de>
 <b3834054-cb2c-2074-7b7d-ad9eb4961a07@linux.intel.com>
 <alpine.DEB.2.21.1810031550550.23677@nanos.tec.linutronix.de>
 <a72002d5-be3a-1f51-dc26-ac4e962586d2@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3d5a49d4-85c8-0d7f-254e-d9d02419e718@linux.intel.com>
Date:   Wed, 3 Oct 2018 10:25:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a72002d5-be3a-1f51-dc26-ac4e962586d2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2018 10:15 AM, linux-kernel-owner@vger.kernel.org wrote:
> To make it more generic, I think we also need to extend the struct 
> sku_microcode to check vendor and family.
> The "model" in struct x86_cpu_id is u16. I will also change "model" and 
> "stepping" to u16.
> 
> struct sku_microcode {
>      u16 vendor;
>      u16 family;
>      u16 model;
>      u16 stepping;
>      u32 microcode;
> };

No, should be consistent as struct cpuinfo_x86.
The struct sku_microcode should be

struct sku_microcode {
       u8 vendor;
       u8 family;
       u8 model;
       u8 stepping;
       u32 microcode;
};

Thanks,
Kan
