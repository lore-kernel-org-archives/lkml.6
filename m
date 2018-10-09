Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAF5C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2DF2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2DF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeJIX5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:57:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:63006 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJIX5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:57:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 09:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,360,1534834800"; 
   d="scan'208";a="97486546"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.109]) ([10.24.14.109])
  by fmsmga001.fm.intel.com with ESMTP; 09 Oct 2018 09:39:29 -0700
Subject: Re: [PATCH v2 01/11] arch/x86: Start renaming the rdt files to more
 generic names
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
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
References: <20181005205512.29545-1-babu.moger@amd.com>
 <20181005205512.29545-2-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <2fe2e853-47ef-af2a-6906-9ad7a7b8bba9@intel.com>
Date:   Tue, 9 Oct 2018 09:39:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005205512.29545-2-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/5/2018 1:55 PM, Moger, Babu wrote:
> New generation of AMD processors start support RDT(or QOS) features.
> With more than one vendors supporting these features, it seems more
> appropriate to rename these files.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/{intel_rdt_sched.h => rdt_sched.h}     | 0
>  arch/x86/kernel/cpu/Makefile                                | 6 +++---
>  arch/x86/kernel/cpu/{intel_rdt.c => rdt.c}                  | 4 ++--
>  arch/x86/kernel/cpu/{intel_rdt.h => rdt.h}                  | 0
>  .../cpu/{intel_rdt_ctrlmondata.c => rdt_ctrlmondata.c}      | 2 +-
>  arch/x86/kernel/cpu/{intel_rdt_monitor.c => rdt_monitor.c}  | 2 +-
>  .../cpu/{intel_rdt_pseudo_lock.c => rdt_pseudo_lock.c}      | 6 +++---
>  ...ntel_rdt_pseudo_lock_event.h => rdt_pseudo_lock_event.h} | 2 +-
>  .../x86/kernel/cpu/{intel_rdt_rdtgroup.c => rdt_rdtgroup.c} | 4 ++--
>  arch/x86/kernel/process_32.c                                | 2 +-
>  arch/x86/kernel/process_64.c                                | 2 +-
>  11 files changed, 15 insertions(+), 15 deletions(-)
>  rename arch/x86/include/asm/{intel_rdt_sched.h => rdt_sched.h} (100%)
>  rename arch/x86/kernel/cpu/{intel_rdt.c => rdt.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt.h => rdt.h} (100%)
>  rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c => rdt_ctrlmondata.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_monitor.c => rdt_monitor.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c => rdt_pseudo_lock.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h => rdt_pseudo_lock_event.h} (95%)
>  rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c => rdt_rdtgroup.c} (99%)

During the RFC it was agreed that "resctrl" will be the neutral name and
"intel_rdt", "amd_qos", or "arm mpam" would be the vendor specific names.

It is ok to delay that renaming but I think any renaming done from this
point should respect this agreement.

For example, if you want to rename intel_rdt.c then please rename it to
resctrl.c instead of just rdt.c which does not represent a generic name
as expressed as a goal in the subject of this patch.

Reinette
