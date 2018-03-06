Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeCFOoA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:44:00 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:37734 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753790AbeCFOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:39:42 -0500
X-IronPort-AV: E=Sophos;i="5.47,431,1515456000";
   d="scan'208";a="598137756"
Date: Tue, 6 Mar 2018 06:39:39 -0800
From: Eduardo Valentin <eduval@amazon.com>
To: Wanpeng Li <kernellwp@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 0/3] KVM: Introduce dedicated vCPUs hint
 KVM_HINTS_DEDICATED
Message-ID: <20180306143939.GA23766@u40b0340c692b58f6553c.ant.amazon.com>
References: <1518483942-14741-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1518483942-14741-1-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

On Tue, Feb 13, 2018 at 09:05:39AM +0800, Wanpeng Li wrote:
> This patchset introduces dedicated vCPUs(vCPU pinning, and there is no 
> vCPU over-commitment) hint KVM_HINTS_DEDICATED, it has two users now:
> 
> 1) Waiman Long mentioned that:
> 
>     Generally speaking, unfair lock performs well for VMs with a small
>     number of vCPUs. Native qspinlock may perform better than pvqspinlock
>     if there is vCPU pinning and there is no vCPU over-commitment.
> 
> 2) vCPUs are very unlikely to get preempted when they are the only task 
>    running on a CPU. PV TLB flush is slower that the native flush in that 
>    case.
> 
> v3 -> v4:
>  * update feature bit document
> v2 -> v3:
>  * a separate table for CPUID[0x40000001].EDX bits
>  * a new kvm_hint_has_feature macro
> v1 -> v2:
>  * update to KVM_HINTS_DEDICATED

Great to see this has finally moved forward! Thanks for picking it up Wanpeng.

I would just request to next time at least reference the original thread and
copy the original authors of the patch/idea.

Thanks a lot.

-- 
All the best,
Eduardo Valentin
