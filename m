Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeCPR2J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:28:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751064AbeCPR2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:28:07 -0400
Subject: Re: [PATCH v5 03/11] perf/x86/intel/pt: Introduce a new function to
 get the capability of Intel PT
To: Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org, joro@8bytes.org
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
 <1520165241-15819-4-git-send-email-luwei.kang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98515f5f-9c8a-8e1a-4fef-c9a8a0e9e8f5@redhat.com>
Date: Fri, 16 Mar 2018 18:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520165241-15819-4-git-send-email-luwei.kang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 13:07, Luwei Kang wrote:
> +u32 pt_cap_get_ex(u32 *caps, enum pt_capabilities cap)
> +{
> +	struct pt_cap_desc *cd = &pt_caps[cap];
> +	u32 c = caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
> +	unsigned int shift = __ffs(cd->mask);
> +
> +	return (c & cd->mask) >> shift;
> +}
> +EXPORT_SYMBOL_GPL(pt_cap_get_ex);
> +

You should change pt_cap_get to use this function.  Also, "_ex" is not a
very common suffix, so perhaps you can call it __pt_cap_get.

I don't have any other comments on patches 1-3, so when you resend we
can ask the x86 maintainers for approval.

Thanks,

Paolo
