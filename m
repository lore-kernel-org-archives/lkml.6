Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeECKun (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:50:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:38907 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbeECKuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:50:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38359660"
Date: Thu, 3 May 2018 13:50:32 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org, peterz@infradead.org,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 05/13] perf/x86/intel/pt: Introduce a new function to
 get capability of Intel PT
Message-ID: <20180503105032.h73n5lcrwkdbahgm@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-6-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525349323-9938-6-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:08:35PM +0800, Luwei Kang wrote:
> New function __pt_cap_get() will be invoked in KVM to check
> if a specific capability is availiable in KVM guest.
> Another function pt_cap_get() can only check the hardware
> capabilities but this may different with KVM guest because
> some features may not be exposed to guest.

Do we really need both in KVM?

> diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
> index 2de4db0..3a4f524 100644
> --- a/arch/x86/include/asm/intel_pt.h
> +++ b/arch/x86/include/asm/intel_pt.h
> @@ -27,9 +27,11 @@ enum pt_capabilities {
>  #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
>  void cpu_emergency_stop_pt(void);
>  extern u32 pt_cap_get(enum pt_capabilities cap);
> +extern u32 __pt_cap_get(u32 *caps, enum pt_capabilities cap);

I'd call it something like pt_cap_decode().
