Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753506AbeBBTDE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:03:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752181AbeBBTC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:02:58 -0500
Date: Fri, 2 Feb 2018 20:02:43 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] KVM: X86: Add per-VM no-HLT-exiting capability
Message-ID: <20180202190242.GE26932@flask>
References: <1517555473-8313-1-git-send-email-wanpengli@tencent.com>
 <1517555473-8313-3-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517555473-8313-3-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-01 23:11-0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> If host CPUs are dedicated to a VM, we can avoid VM exits on HLT.
> This patch adds the per-VM non-HLT-exiting capability.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---

SMM handling needs more work: I think we should vmx_clear_hlt() upon SMI
and RSM needs to implement auto halt restart (AMD might differ).

And also look if we don't need vmx_clear_hlt() around INIT handling,
thanks.
