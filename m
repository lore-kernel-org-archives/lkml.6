Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCACC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50859208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50859208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeJEXTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:19:16 -0400
Received: from foss.arm.com ([217.140.101.70]:54700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbeJEXTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:19:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2F780D;
        Fri,  5 Oct 2018 09:19:51 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADFEB3F5D3;
        Fri,  5 Oct 2018 09:19:45 -0700 (PDT)
Subject: Re: [RFC PATCH 00/10] arch/x86: AMD QoS support
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
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
 <20181002170655.GA92941@romley-ivt3.sc.intel.com>
 <BL0PR12MB2468F1F6EA31332657802C7595E80@BL0PR12MB2468.namprd12.prod.outlook.com>
 <20181002184614.GC92941@romley-ivt3.sc.intel.com>
 <2549597a-440c-ab77-2c35-01a648703b9f@amd.com>
 <20181003185209.GA98542@romley-ivt3.sc.intel.com>
 <874cdcfb-26fa-2bdb-095d-b1b5a88250b9@amd.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <9500445c-019d-9b77-0b51-48922bf47007@arm.com>
Date:   Fri, 5 Oct 2018 17:19:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <874cdcfb-26fa-2bdb-095d-b1b5a88250b9@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 03/10/18 21:09, Moger, Babu wrote:
> On 10/03/2018 01:52 PM, Fenghua Yu wrote:
>> On Tue, Oct 02, 2018 at 07:16:23PM +0000, Moger, Babu wrote:
>>> On 10/02/2018 01:46 PM, Fenghua Yu wrote:
>>>> I don't see the name 'RDT' (Resource Director Technology) in the
>>>> spec "AMD64 Technology Platform Quality of Service Extensions".
>>>> Does AMD use the same name 'RDT' as Intel?
>>>
>>> No. AMD uses the word "Platform Quality of Service"(or in short QoS) to
>>> refer this feature.
>>
>> Hi, Thomas, Babu, and James,
>>
>> Can we use "resctrl" to replace "intel_rdt" and "rdt" in kernel? "resctrl"
>> is a neutral name and has been used in user interface already. Hopefully
>> "resctrl" can be acceptable by ARM, AMD, and Intel. We only use "intel_rdt",
>> "amd_qos", or "arm mpam" for vendor specific code.
> 
> Yes. resctrl seems like a reasonable name. >
>> Can we move all of Intel RDT, AMD QoS, and ARM MPAM code into a generic

all? Hmmm... I wanted to keep anything with an ABI implication under /fs/ so its
definitely the same. Obviously some things are definitely arch specific, e.g.
writing msr-s in intel_rdt_sched_in().


>> place fs/resctrl where both ARM and X86 code can stay?
> 
> Looking at the James patches, I thought he is going in the same(or
> similar) direction eventually.

Yes, I was trying to name stuff 'resctrl' if its moving to /fs/, and
resctrl_arch if its arch specific, thus stays where it is. (and the existing
names if I didn't need to touch it).

The struct names all have rdt in them, I thought it too noisy to change them.



Thanks,

James
