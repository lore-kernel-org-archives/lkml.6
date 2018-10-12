Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFCDC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440AB206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440AB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJMClg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:41:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:18449 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeJMClg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:41:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 12:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="240886094"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.63]) ([10.24.14.63])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2018 12:07:40 -0700
Subject: Re: [PATCH v3 01/11] arch/x86: Start renaming the rdt files to more
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
References: <20181011203223.18157-1-babu.moger@amd.com>
 <20181011203223.18157-2-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <9c0e5be7-20e7-39dd-0852-e9b22d1df156@intel.com>
Date:   Fri, 12 Oct 2018 12:07:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011203223.18157-2-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/11/2018 1:33 PM, Moger, Babu wrote:
> New generation of AMD processors start supporting RDT(or QOS) features.
> With more than one vendors supporting these features, it seems more
> appropriate to rename these files.
> 
> Changed intel_rdt to resctrl where applicable.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/{intel_rdt_sched.h => resctrl_sched.h} | 0
>  arch/x86/kernel/cpu/Makefile                                | 6 +++---
>  arch/x86/kernel/cpu/{intel_rdt.c => resctrl.c}              | 4 ++--
>  arch/x86/kernel/cpu/{intel_rdt.h => resctrl.h}              | 6 +++---
>  .../cpu/{intel_rdt_ctrlmondata.c => resctrl_ctrlmondata.c}  | 2 +-
>  .../kernel/cpu/{intel_rdt_monitor.c => resctrl_monitor.c}   | 2 +-
>  .../cpu/{intel_rdt_pseudo_lock.c => resctrl_pseudo_lock.c}  | 6 +++---
>  ..._rdt_pseudo_lock_event.h => resctrl_pseudo_lock_event.h} | 2 +-
>  .../kernel/cpu/{intel_rdt_rdtgroup.c => resctrl_rdtgroup.c} | 4 ++--
>  arch/x86/kernel/process_32.c                                | 2 +-
>  arch/x86/kernel/process_64.c                                | 2 +-
>  11 files changed, 18 insertions(+), 18 deletions(-)
>  rename arch/x86/include/asm/{intel_rdt_sched.h => resctrl_sched.h} (100%)
>  rename arch/x86/kernel/cpu/{intel_rdt.c => resctrl.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt.h => resctrl.h} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_ctrlmondata.c => resctrl_ctrlmondata.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_monitor.c => resctrl_monitor.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock.c => resctrl_pseudo_lock.c} (99%)
>  rename arch/x86/kernel/cpu/{intel_rdt_pseudo_lock_event.h => resctrl_pseudo_lock_event.h} (95%)
>  rename arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c => resctrl_rdtgroup.c} (99%)
> 

I missed this earlier ... this change creates a need to change the
MAINTAINERS file. There were some other things that a run of
"checkpatch.pl --strict" picked up in the other patches that you could
consider.

Reinette
