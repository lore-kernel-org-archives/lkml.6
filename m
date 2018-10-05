Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC4DC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D530E208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D530E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbeJEXS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:18:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54606 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbeJEXS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:18:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 615B980D;
        Fri,  5 Oct 2018 09:19:03 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EEDB3F5D3;
        Fri,  5 Oct 2018 09:18:56 -0700 (PDT)
Subject: Re: [RFC PATCH 00/10] arch/x86: AMD QoS support
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <alpine.DEB.2.21.1809272209160.8118@nanos.tec.linutronix.de>
 <DM5PR12MB24719940B13119E05738DB3495EC0@DM5PR12MB2471.namprd12.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ab23dbf9-276c-73c3-933b-1354ef6da355@arm.com>
Date:   Fri, 5 Oct 2018 17:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB24719940B13119E05738DB3495EC0@DM5PR12MB2471.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

(Thanks for looping me in!)

On 28/09/18 02:57, Moger, Babu wrote:
>> On Mon, 24 Sep 2018, Moger, Babu wrote:
>>
>>> This series adds support for AMD64 architectural extensions for Platform
>>> Quality of Service. These extensions are intended to provide for the
>>> monitoring of the usage of certain system resources by one or more
>>> processors and for the separate allocation and enforcement of limits on
>>> the use of certain system resources by one or more processors.
>>>
>>> The monitoring and enforcement are not necessarily applied across the
>>> entire system, but in general apply to a QOS domain which corresponds to
>>> some shared system resource.  The set of resources which are monitored
>> and
>>> the set for which the enforcement of limits is provided are implementation
>>> dependent. Platform QOS features are implemented on a logical processor
>> basis.
>>> Therefore, multiple hardware threads of a single physical CPU core may
>> have
>>> independent resource monitoring and enforcement configurations.
>>>
>>> AMD's next generation of processors support following QoS sub-features.
>>> - L3 Cache allocation enforcement
>>> - L3 Cache occupancy monitoring
>>> - L3 Code-Data Prioritization support
>>> - Memory Bandwidth Enforcement(Allocation)
>>>
>>> The public specification is still in works. Will add the link when it is
>>> available.
>>>
>>> Obviously, there are multiple ways we can go about these changes. We felt
>>> it is appropriate to rename and re-organize the code little bit before
>>> making the functional changes. The first few patches(1-6) renames and
>>> re-organizes the sources in preparation. Rest of the patches(7-10) adds
>>> support for AMD QoS features.
>>
>> On the first glance this all looks sensible, but there is work in progress
>> by James Morse (Cc'ed), who wants to generalize the resctrl filesystem so
>> it can be reused by ARM. I just want to make sure that your reorganization
>> is not colliding or creating duplicate effort.

Aha, some of this makes my life easier. I'm against having the ABI different
between architectures. This meant contiguous bitmaps on arm, which the MPAM
stuff doesn't actually require...


> Thanks for pointing this out. I have looked thru James patches. It appears this
> series is only a small part of his much bigger change. Don't know the timeframe
> of his overall changes.
> I will let him speak on that.

Longer, as its more invasive,


> That being said, I don't consider our efforts as
> duplicate. He is touching the resource structures, and trying to separate arch,
> non-arch components.
> My changes are mostly inside the resource structures(mostly resource handlers)

> and trying to accommodate minor differences within the architecture.  It will
> be mostly involve rebase
> effort on either side in the end whoever goes first.

> James, What are your thoughts? 

I think your stuff should go first. It doesn't look like you are adding new
features/controls, so its normally:painful for me to rebase over it.
(doing it the other-way round would be harder!)


Thanks,

James
