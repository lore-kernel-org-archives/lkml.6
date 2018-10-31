Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FD9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE78520838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE78520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeJaTl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbeJaTlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:41:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A4E281DEA;
        Wed, 31 Oct 2018 10:43:51 +0000 (UTC)
Received: from [10.36.112.62] (ovpn-112-62.ams2.redhat.com [10.36.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5D9D508E1;
        Wed, 31 Oct 2018 10:43:41 +0000 (UTC)
Subject: Re: [PATCH v13 08/12] KVM: x86: Add Intel PT context switch for each
 vcpu
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        rkrcmar@redhat.com, joro@8bytes.org, songliubraving@fb.com,
        peterz@infradead.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        konrad.wilk@oracle.com, mattst88@gmail.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        jpoimboe@redhat.com, marcorr@google.com, ubizjak@gmail.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
 <1540368316-12998-9-git-send-email-luwei.kang@intel.com>
 <87a7n37iuf.fsf@ashishki-desk.ger.corp.intel.com>
 <bc192976-2c56-3cfc-a697-cf941a92ad0a@redhat.com>
 <alpine.DEB.2.21.1810301058060.5984@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b694312e-b668-3546-f9e8-dc740f330f14@redhat.com>
Date:   Wed, 31 Oct 2018 11:43:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810301058060.5984@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 31 Oct 2018 10:43:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 11:00, Thomas Gleixner wrote:
> On Mon, 29 Oct 2018, Paolo Bonzini wrote:
>> On 24/10/2018 12:13, Alexander Shishkin wrote:
>>> Luwei Kang <luwei.kang@intel.com> writes:
>>>> +	/*
>>>> +	 * Set guest state of MSR_IA32_RTIT_CTL MSR (PT will be disabled
>>>> +	 * on VM entry when it has been disabled in guest before).
>>>> +	 */
>>>> +	vmcs_write64(GUEST_IA32_RTIT_CTL, vmx->pt_desc.guest.ctl);
>>>> +
>>>> +	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
>>>> +		wrmsrl(MSR_IA32_RTIT_CTL, 0);
>>>> +		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.addr_range);
>>>> +		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.addr_range);
>>>> +	}
>>>> +}
>>>
>>> From my side this is still a NAK, because [1].
>>>
>>> [1] https://marc.info/?l=kvm&m=153847567226248&w=2
>>
>> Then you should have replied to
>> https://marc.info/?l=kvm&m=153865386015249&w=2 instead of having Luwei
>> do the work for nothing.
>>
>> Quoting from there:
>>
>>>> One shouldn't have to enable or disable anything in KVM to stop it from
>>>> breaking one's existing workflow. That makes no sense.
>>>
>>> If you "have to enable or disable anything" it means you have to
>>> override the default.  But the default in this patches is "no change
>>> compared to before the patches", leaving tracing of both host and guest
>>> entirely to the host, so I don't understand your remark.  What workflow
>>> is broken?
>>>
>>>> There already are controls in perf that enable/disable guest tracing.
>>>
>>> You are confusing "tracing guest from the host" and "the guest can trace
>>> itself".  This patchset is adding support for the latter, and that
>>> affects directly whether the tracing CPUID leaf can be added to the
>>> guest.  Therefore it's not perf that can decide whether to turn it on;
>>> KVM must know it when /dev/kvm is opened, which is why it is a module
>>> parameter.
>>
>> I'd be happier if we found an agreement, but without discussion that
>> just won't happen.
> 
> So at least we need a way for perf on the host to programmatically detect,
> that 'guest traces itself' is enabled, so it can inject that information
> into the host data and post processing can tell that. W/o something like
> that it's going to be a FAQ.

In guest-tracing mode there will be already a TIP.PGD and TIP.PGE packet
respectively before vmentry and after vmexit, caused by the RTIT_CTL
WRMSRs in pt_guest_enter and pt_guest_exit.  The target IP of the
packets will come from kvm-intel.ko.

In system mode instead you get a Paging Information Packet on
vmentry/vmexit, with bit 0 set in the third byte.  You won't get it if
guest-side tracing is on (because tracing has been disabled by
pt_guest_enter and won't be re-enabled until pt_guest_exit).  I don't
think it's correct to "fake" the PIP in guest-tracing mode, because
TIP.PGD should be followed immediately by TIP.PGE.

Is this okay for perf users?

Paolo
