Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425849AbeCBJhg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:37:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1424982AbeCBJg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:36:26 -0500
Subject: Re: [PATCH] KVM: VMX: expose the host's ARCH_CAPABILITIES MSR to
 userspace
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
References: <1519433546-33879-1-git-send-email-pbonzini@redhat.com>
 <20180226221300.GK22024@char.us.oracle.com> <20180301213205.GB29001@flask>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ccead1df-ba70-f365-c816-7892834a290c@redhat.com>
Date: Fri, 2 Mar 2018 10:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301213205.GB29001@flask>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2018 22:39, Radim Krčmář wrote:
> [Resent after removing g@char.us.oracle.com.]
> 
> 2018-02-26 17:13-0500, Konrad Rzeszutek Wilk:
>> On Sat, Feb 24, 2018 at 01:52:26AM +0100, Paolo Bonzini wrote:
>>> Use the new MSR feature framework to expose the ARCH_CAPABILITIES MSR to
>>> userspace.  This way, userspace can access the capabilities even if it
>>> does not have the permissions to read MSRs.
>>
>> ... That is good but could you expand a bit of why it would want this?
>>
>> I am 99% sure it is due to the lovely spectre_v2 mitigation but
>> could you include that in the commit message so that in say a year
>> folks would know what this is?
> 
> Userspace can currently get the MSR by creating a VCPU and reading its
> MSR_IA32_ARCH_CAPABILITIES, because it is set from the hardware MSR.
> 
> I thought that "permissions to read MSRs" talked about hardware MSRs, so
> the purpose of this patch would be a better interface, but I don't see
> how if we keep the auto-setting on VCPU creation.

Yeah, it's mostly about a better interface and being able to do checks
before creating the VCPU.  The commit message was written before I
noticed the auto-setting on VCPU creation, and I failed to update it.

Thanks,

Paolo

> Is this aimed towards userspaces that want nothing else from KVM than
> the MSR value?
> 
> Thanks.
> 
