Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162321AbeCAVjw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:39:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162200AbeCAVjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:39:40 -0500
Date: Thu, 1 Mar 2018 22:39:04 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH] KVM: VMX: expose the host's ARCH_CAPABILITIES MSR to
 userspace
Message-ID: <20180301213205.GB29001@flask>
References: <1519433546-33879-1-git-send-email-pbonzini@redhat.com>
 <20180226221300.GK22024@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226221300.GK22024@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resent after removing g@char.us.oracle.com.]

2018-02-26 17:13-0500, Konrad Rzeszutek Wilk:
> On Sat, Feb 24, 2018 at 01:52:26AM +0100, Paolo Bonzini wrote:
> > Use the new MSR feature framework to expose the ARCH_CAPABILITIES MSR to
> > userspace.  This way, userspace can access the capabilities even if it
> > does not have the permissions to read MSRs.
> 
> ... That is good but could you expand a bit of why it would want this?
> 
> I am 99% sure it is due to the lovely spectre_v2 mitigation but
> could you include that in the commit message so that in say a year
> folks would know what this is?

Userspace can currently get the MSR by creating a VCPU and reading its
MSR_IA32_ARCH_CAPABILITIES, because it is set from the hardware MSR.

I thought that "permissions to read MSRs" talked about hardware MSRs, so
the purpose of this patch would be a better interface, but I don't see
how if we keep the auto-setting on VCPU creation.

Is this aimed towards userspaces that want nothing else from KVM than
the MSR value?

Thanks.
