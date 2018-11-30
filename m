Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CBCC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C57A20660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C57A20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeLAGeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:34:02 -0500
Received: from foss.arm.com ([217.140.101.70]:35440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLAGeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:34:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E52A4165C;
        Fri, 30 Nov 2018 11:23:42 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14BE83F575;
        Fri, 30 Nov 2018 11:23:40 -0800 (PST)
Subject: Re: [RFC PATCH 00/20] x86/intel_rdt: Start abstraction for a second
 arch
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        "Norov, Yuri" <Yuri.Norov@cavium.com>
References: <20180824104519.11203-1-james.morse@arm.com>
 <20181127123319.GA24166@yury-thinkpad>
From:   James Morse <james.morse@arm.com>
Message-ID: <378bfb14-df9c-bb89-8177-b4a5f6c7b226@arm.com>
Date:   Fri, 30 Nov 2018 19:23:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127123319.GA24166@yury-thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On 27/11/2018 12:33, Yury Norov wrote:
> On Fri, Aug 24, 2018 at 11:44:59AM +0100, James Morse wrote:
>> ARM have some upcoming CPU features that are similar to Intel RDT. Resctrl
>> is the defacto ABI for this sort of thing, but it lives under arch/x86.
>>
>> To get existing software working, we need to make resctrl work with arm64.
>> This series is the first chunk of that. The aim is to move the filesystem/ABI
>> parts into /fs/resctrl, and implement a second arch backend.
>>
>>
>> What are the ARM features?
>> Future ARM SoCs may have a feature called MPAM: Memory Partitioning and
>> Monitoring. This is an umbrella term like RDT, and covers a range of controls
>> (like CAT) and monitors (like MBM, CMT).

>> This series is based on v4.18, and can be retrieved from:
>> git://linux-arm.org/linux-jm.git -b mpam/resctrl_rework/rfc_1
> 
> Thank you a lot for this work on cache allocation.
> 
> We are very interested in enabling CAT on Cavium / Marvell devices.
> Could you please share another two series you mentioned above?

I'm working on assembling the whole thing as Fenghua asked, there should be a
tree that shows the shape of the whole thing soon.


> Do you have a working ARM64 CAT driver? It will much help us in our
> experimenting.

For moving the arch-independent parts to /fs/, I'm afraid its all-or-nothing.
Abstracting just the 'CAT' parts will generate much more churn for both
architectures.


Thanks,

James
