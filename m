Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeCOR26 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:28:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751714AbeCOR24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:28:56 -0400
Date: Thu, 15 Mar 2018 18:28:52 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
Message-ID: <20180315172852.GA21667@flask>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-8-vkuznets@redhat.com>
 <2747cc75-b549-61bb-9c1b-0f554a49b536@redhat.com>
 <87zi399xih.fsf@vitty.brq.redhat.com>
 <20180315170202.GA5180@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180315170202.GA5180@flask>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-15 18:02+0100, Radim Krčmář:
> We actually already have mov in the assembly:
> 
>   "cmp %%" _ASM_SP ", %c[host_rsp](%0) \n\t"

Oh hell, I didn't pay attention to this line before.

>   "je 1f \n\t"
>   "mov %%" _ASM_SP ", %c[host_rsp](%0) \n\t" // here
>   __ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"

I bet this path is executed only once in VM's lifetime and what we're
doing is wasting more resources than we're ever going to save ...

>   "1: \n\t"
