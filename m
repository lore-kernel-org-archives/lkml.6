Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933478AbeCGSF2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:05:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751211AbeCGSF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:05:26 -0500
Date: Wed, 7 Mar 2018 19:04:43 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to
 HV_X64_MSR_VP_ASSIST_PAGE
Message-ID: <20180307180442.GA16795@flask>
References: <20180226171121.18974-1-vkuznets@redhat.com>
 <20180226171121.18974-2-vkuznets@redhat.com>
 <20180307161944.GE12290@flask>
 <20180307164812.GA2366@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180307164812.GA2366@rkaganb.sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-07 19:48+0300, Roman Kagan:
> On Wed, Mar 07, 2018 at 05:19:44PM +0100, Radim Krčmář wrote:
> > 2018-02-26 18:11+0100, Vitaly Kuznetsov:
> > > diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
> > > @@ -275,10 +275,10 @@ struct hv_tsc_emulation_status {
> > >  #define HVCALL_POST_MESSAGE			0x005c
> > >  #define HVCALL_SIGNAL_EVENT			0x005d
> > >  
> > > -#define HV_X64_MSR_APIC_ASSIST_PAGE_ENABLE		0x00000001
> > > -#define HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_SHIFT	12
> > > -#define HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_MASK	\
> > > -		(~((1ull << HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
> > 
> > Removing definitions from userspace api isn't a good idea.
> > 
> > I have no idea why hyper.h is a userspace api, though -- Linux doesn't
> > define any of those, so we could copy the definitions to a private
> > header, rename, and never look at this file again.
> 
> That was a thinko when it was moved to uapi, and it has already been
> identified as a problem, so now QEMU has its own header with the
> definitions it needs, and I'm unaware of any other userspace project
> that depends on this stuff.  So I've been planning to remove it from
> uapi but still haven't got around to posting the patch :(

Great, let's be bold here.
