Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754844AbeCPQGS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:06:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754537AbeCPQGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:06:16 -0400
Date: Fri, 16 Mar 2018 17:06:09 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
Message-ID: <20180316160609.GD5180@flask>
References: <20180316142220.32506-1-vkuznets@redhat.com>
 <20180316142220.32506-8-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316142220.32506-8-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-16 15:22+0100, Vitaly Kuznetsov:
> Enlightened VMCS is just a structure in memory, the main benefit
> besides avoiding somewhat slower VMREAD/VMWRITE is using clean field
> mask: we tell the underlying hypervisor which fields were modified
> since VMEXIT so there's no need to inspect them all.
> 
> Tight CPUID loop test shows significant speedup:
> Before: 18890 cycles
> After: 8304 cycles
> 
> Static key is being used to avoid performance penalty for non-Hyper-V
> deployments.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Looks good, thanks.

Reviewed-by: Radim Krčmář <rkrcmar@redhat.com>
