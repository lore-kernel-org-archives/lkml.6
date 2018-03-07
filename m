Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeCGPKR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:10:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754608AbeCGPKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:10:14 -0500
Subject: Re: [PATCH] KVM: VMX: expose the host's ARCH_CAPABILITIES MSR to
 userspace
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
References: <1519433546-33879-1-git-send-email-pbonzini@redhat.com>
 <20180226221300.GK22024@char.us.oracle.com> <20180301213205.GB29001@flask>
 <ccead1df-ba70-f365-c816-7892834a290c@redhat.com>
 <20180302214212.GB13606@flask>
 <9cad32c8-fdb6-95db-2cd3-a0e3297b1811@redhat.com>
 <20180307145628.GA12299@flask>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37a89c09-e933-9256-1b7a-3a9df846a672@redhat.com>
Date: Wed, 7 Mar 2018 16:10:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307145628.GA12299@flask>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 15:56, Radim Krčmář wrote:
> The MSR_F10H_DECFG default is questionable -- MSR_F10H_DECFG is an
> architectural MSR, so we'd be changing the guest under the sight of
> existing userspaces.
> A potential security risk if they migrate the guest to a CPU that
> doesn't serialize LFENCE.  ARCH_CAPABILITIES are at least hidden by a
> new CPUID bit.

Good point.  Perhaps we should add a KVM-specific CPUID bit for
serializing LFENCE.

> The feature MSR defaults are going to be a mess anyway: we have
> MSR_IA32_UCODE_REV that is tightly coupled with CPUID.  Not a good
> candidate for passing by default and currently also has a default value.

Yeah, ucode revision is out of question.

Paolo
