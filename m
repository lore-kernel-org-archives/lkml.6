Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755368AbeCSJFY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:05:24 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40004 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeCSJFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:05:18 -0400
X-Google-Smtp-Source: AG47ELu7aHy/sxblgDnGMLNgA8osaDhcL2GBqXNbqgCDk3AFXfIVRX1kGfo9M3maixsEyrktZNyyBg==
Subject: Re: [PATCH v5 11/11] KVM: x86: Disable Intel Processor Trace when
 VMXON in L1 guest
To: "Kang, Luwei" <luwei.kang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
 <1520165241-15819-12-git-send-email-luwei.kang@intel.com>
 <a8686725-ce27-8000-dee5-5a39d3629dd8@redhat.com>
 <82D7661F83C1A047AF7DC287873BF1E167EFC16F@SHSMSX101.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a7c53f0-8c47-0fe1-27f2-141a15ebdcff@redhat.com>
Date: Mon, 19 Mar 2018 10:05:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E167EFC16F@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2018 08:31, Kang, Luwei wrote:
>>> +	if (pt_mode == PT_MODE_HOST_GUEST) {
>> This would be vmx_pt_supported(), but I think it's better to remove that function and just test pt_mode ==
>> PT_MODE_HOST_GUEST everywhere (or !=).
> Hi Paolo,
>     There have so many vmx_pt_supported() invoked in MSRs read/write (patch 9) patch and I think it can be replaced by  pt_mode check.
>     But I think this function need to be reserved in patch 5(cpuid emulation). What is your opinion?

Yes, the function pointer needs to stay.

Paolo
