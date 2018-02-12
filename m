Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1553285-1518448694-2-4549415854096366981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518448693; b=wceqC3oF7Rd5jOGSGlnYmw6K680B/YSwkaFBTFMPKRnlaqr
    B2LaQMwuAbXKgM8lQPiNj6vk11dAkE8mVS+NEdivcwlmjDGCX/XyiPMeThiYF2+9
    KzCgqZQXZMMq3+W480rosHyUmzQoQj/SwnkUDH/H5JhfvUAXppjmGAoICylIBtvE
    8sigqWL9VnAFeHCsIHZ+1g4NeA3/7ut6e4xFHIleYE0jqCwIUdPyOTNxUfR/CD0t
    x8C286fA6eb4Qgfloi6hYraubJ7QdjFxOKx3aCmcC7wTqBCu+cwnohZv4La12ZQg
    vONMDFDTGyi0vcaoBnOWaR0/lOfNcMvTTnWmumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518448693; bh=QRfKu5iAzPByo9IGKxMXgmXOPFmY2sqez6i42zJeg8w=; b=J
    CE4csp1VlQj723M8yAoQTFFPvVlKA/UVahXu6dU3fUIl/SZfh05NyMweTGNYn7Dv
    xqMFF1dBFMr/yKQK1rLshmYQAgLgfag7mo13tvhqlB2Gej3gHyD8pQpi6dh6PmJR
    3jY8JWZyHQrCLNEAv5kK8Z6alMpTllKAuMu+M9Y1se4xEoV6LMYoyYbmEvRhycc4
    8Qh3rfnGr4YiVAna6DnBCqoGs4sum5IsvIYtj//AZzg7AhnfxfiUNuueO9dKnLPN
    GQFaTzf3sTeD5dk2+Nzo6bB6bIerHF8+EPm4tBzMplyq3cEWIVfVZwyBe0owKnRy
    BnIhVCY9nsoWVTZEty3oQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeBLPSM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 10:18:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751185AbeBLPSK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 10:18:10 -0500
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
To: Peter Zijlstra <peterz@infradead.org>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
 <20180212145652.GM25181@hirez.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org,
        mark.salter@redhat.com
From: Prarit Bhargava <prarit@redhat.com>
Message-ID: <03e799c6-a0f3-eccf-882d-78205e9335ad@redhat.com>
Date: Mon, 12 Feb 2018 10:18:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180212145652.GM25181@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/12/2018 09:56 AM, Peter Zijlstra wrote:
> On Mon, Feb 12, 2018 at 08:47:57AM -0500, Prarit Bhargava wrote:
>>
>>
>> On 02/12/2018 08:34 AM, Peter Zijlstra wrote:
>>> On Thu, Jan 18, 2018 at 10:09:51AM -0500, Prarit Bhargava wrote:
>>>>  config ACPI_SPCR_TABLE
>>>> +	bool "ACPI Serial Port Console Redirection Support"
>>>> +	default y if X86
>>>> +	help
>>>> +	  Enable support for Serial Port Console Redirection (SPCR) Table.
>>>> +	  This table provides information about the configuration of the
>>>> +	  earlycon console.
>>>
>>> I just got asked this by oldconfig, which left me rather puzzled, WTF
>>> does this do?
>>
>> Odd -- I thought I had taken care of that :(  My apologies Peter.
>>
>> ACPI SPCR is used by a vendor to define the serial console for a system.  If
>> SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
>> parameters) and the console will work out-of-the-box.
>>
>> The serial console configuration varies from vendor to vendor.  This takes the
>> guess-work out of defining a serial console.
> 
> But when I specify "earlyprintk=serial,ttyS0,115200" this SPCR crud will
> not interfere?
> 

I tested "earlyprintk=serial,ttyS0,115200" on a system which is known to have a
functional console with "console=ttyS0,1152008N1" both with and without
CONFIG_ACPI_SPCR_TABLE enabled.

I do not see any significant difference in output.

diff of boot logs:

--- earlyprintk_no_spcr_enable  2018-02-12 10:11:00.477288423 -0500
+++ earlyprintk_spcr_enable     2018-02-12 10:16:02.282574797 -0500
@@ -1,5 +1,5 @@
 microcode: microcode updated early to revision 0x2000035, date = 2017-10-17
-Linux version 4.15.0+ (root@intel-purley-lr-02.khw.lab.eng.bos.redhat.com) (gcc
version 4.8.5 20150623 (Red Hat 4.8.5-28) (GCC)) #5 SMP Mon Feb 12 10:06:08 EST 2018
+Linux version 4.15.0+ (root@intel-purley-lr-02.khw.lab.eng.bos.redhat.com) (gcc
version 4.8.5 20150623 (Red Hat 4.8.5-28) (GCC)) #6 SMP Mon Feb 12 10:11:42 EST 2018
 Command line: BOOT_IMAGE=/vmlinuz-4.15.0+
root=/dev/mapper/rhel_intel--purley--lr--02-root ro crashkernel=auto
rd.lvm.lv=rhel_intel-purley-lr-02/root rd.lvm.lv=rhel_intel-purley-lr-02/swap
earlyprintk=serial,ttyS0,115200 LANG=en_US.UTF-8
 x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
 x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
@@ -205,7 +205,7 @@
 e820: last_pfn = 0x6f800 max_arch_pfn = 0x400000000
 Using GB pages for direct mapping
 Secure boot disabled
-RAMDISK: [mem 0x3a563000-0x3bba2fff]
+RAMDISK: [mem 0x3a5da000-0x3bba2fff]
 ACPI: Early table checksum verification disabled
 ACPI: RSDP 0x000000006922A014 000024 (v02 INTEL )
 ACPI: XSDT 0x00000000690DD188 000114 (v01 INTEL  EDK2     00000000      01000013)
@@ -519,6 +519,8 @@
 ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
 Using ACPI (MADT) for SMP configuration information
 ACPI: HPET id: 0x8086a701 base: 0xfed00000
+ACPI: SPCR: SPCR table version 1
+ACPI: SPCR: console: uart,io,0x3f8,115200
 smpboot: Allowing 432 CPUs, 224 hotplug CPUs
 PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
 PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
@@ -555,10 +557,10 @@
 log_buf_len total cpu_extra contributions: 1765376 bytes
 log_buf_len min size: 524288 bytes
 log_buf_len: 4194304 bytes
-early log buf free: 477984(91%)
-Memory: 394593504K/401282564K available (10252K kernel code, 2147K rwdata,
3664K rodata, 2504K init, 1800K bss, 6689060K reserved, 0K cma-reserved)
+early log buf free: 477876(91%)
+Memory: 394593976K/401282564K available (10252K kernel code, 2147K rwdata,
3664K rodata, 2504K init, 1800K bss, 6688588K reserved, 0K cma-reserved)
 Kernel/User page tables isolation: enabled
-ftrace: allocating 35205 entries in 138 pages
+ftrace: allocating 35206 entries in 138 pages
 Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=432.
        Tasks RCU enabled.

P.

