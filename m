Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15876ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5482087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5482087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbeGMT4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:56:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:51452 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbeGMT4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:56:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 12:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,349,1526367600"; 
   d="scan'208";a="57488756"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.24.10.60]) ([10.24.10.60])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2018 12:40:41 -0700
Subject: Re: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
To:     patrickg <patrickg@supermicro.com>, len.brown@intel.com,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, alek.du@intel.com, feng.tang@intel.com
References: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <9cdcf3bb-4d01-19cc-536f-4745ecb058c6@linux.intel.com>
Date:   Fri, 13 Jul 2018 12:40:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/2018 12:19 PM, patrickg wrote:
> This RFC patch is intended to allow bypass CPUID, MSR and QuickPIT calibration methods should the user desire to.
> 
> The current ordering in ML x86 tsc is to calibrate in the order listed above; returning whenever there's a successful calibration.  However there are certain BIOS/HW Designs for overclocking that cause the TSC to change along with the max core clock; and simple 'trusting' calibration methodologies will lead to the TSC running 'faster' and eventually, TSC instability.
> 


that would be a real violation of the contract between cpu and OS: tsc is not supposed to change for the duration of the boot

> I only know that there's a use-case for me to want to be able to skip CPUID calibration, however I included args for skipping all the rest just so that all functionality is covered in the long run instead of just one use-case.

wouldn't it be better to start the detailed calibration with the value from CPUID instead; that way we also properly calibrate spread spectrum etc...

I thought we switched to that recently to be honest...
