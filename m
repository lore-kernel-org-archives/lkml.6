Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeCPRap (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:30:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751064AbeCPRan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:30:43 -0400
Subject: Re: [PATCH v5 11/11] KVM: x86: Disable Intel Processor Trace when
 VMXON in L1 guest
To: Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org, joro@8bytes.org
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
 <1520165241-15819-12-git-send-email-luwei.kang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8686725-ce27-8000-dee5-5a39d3629dd8@redhat.com>
Date: Fri, 16 Mar 2018 18:30:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520165241-15819-12-git-send-email-luwei.kang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 13:07, Luwei Kang wrote:
> +	if (pt_mode == PT_MODE_HOST_GUEST) {

This would be vmx_pt_supported(), but I think it's better to remove that
function and just test pt_mode == PT_MODE_HOST_GUEST everywhere (or !=).

Paolo

> +		vmx->pt_desc.guest.ctl = 0;
> +		vmcs_write64(GUEST_IA32_RTIT_CTL, 0);
> +		pt_set_intercept_for_msr(vmx, 1);
> +	}
> +
