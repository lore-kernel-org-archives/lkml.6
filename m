Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeBIObW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:31:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeBIObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:31:20 -0500
Date: Fri, 9 Feb 2018 12:31:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] target-i386: add KVM_HINTS_DEDICATED performance hint
Message-ID: <20180209143117.GL13981@localhost.localdomain>
References: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 06:15:25AM -0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Add KVM_HINTS_DEDICATED performance hint, guest checks this feature bit
> to determine if they run on dedicated vCPUs, allowing optimizations such 
> as usage of qspinlocks.  
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
[...]
> +    [FEAT_KVM_HINTS] = {
> +        .feat_names = {
> +            "hint-dedicated", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EDX,
> +        .tcg_features = TCG_KVM_FEATURES,
> +    },

Do you have a pointer to the KVM patch that adds this bit to
Documentation/virtual/kvm/cpuid.txt?  I would like to wait until
the KVM CPUID docs are updated before applying the patch to QEMU.

-- 
Eduardo
