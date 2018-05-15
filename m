Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEOVtU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:49:20 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:39078 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEOVtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:49:18 -0400
X-Google-Smtp-Source: AB8JxZpKhMUz+pTJK4OfeuJDxFGxai7+UYiUbQluM/bRNYkDoyquILh6yF4uQ9vQ9wqyFf5AZEqrtA==
Reply-To: ahs3@redhat.com
Subject: Re: linux-next 20180515 - ACPI disabled..
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <50539.1526419088@turing-police.cc.vt.edu>
 <CAHp75VdwDPumYBphE0BTE=ngsvGkWKuOr9QjBv4c+yw-1pKBWg@mail.gmail.com>
From: Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <664f2475-9718-d38e-7270-3426c94f86e8@redhat.com>
Date: Tue, 15 May 2018 15:49:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdwDPumYBphE0BTE=ngsvGkWKuOr9QjBv4c+yw-1pKBWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 03:23 PM, Andy Shevchenko wrote:
> +Cc: Rafael
> 
> On Wed, May 16, 2018 at 12:18 AM,  <valdis.kletnieks@vt.edu> wrote:
>> Seeing this at boot with linux-next 20180415.  ACPI gets disabled, hilarity and hijinks
>> result - everything from a lot of stuff can't find an IRQ to the dual-core w/ HT CPU
>> coming up as just 1 core no HT. 20180430 works just fine...
>>
>> [    0.000000] ACPI: Early table checksum verification disabled
>> [    0.000000] ACPI: RSDP 0x00000000CB7F1000 000024 (v02 DELL  )
>> [    0.000000] ACPI: XSDT 0x00000000CB7F1088 000094 (v01 DELL   CBX3     01072009 AMI  00010013)
>> [    0.000000] ACPI: FACP 0x00000000CB7FB720 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
>> [    0.000000] ACPI: DSDT 0x00000000CB7F11B0 00A56F (v02 DELL   CBX3     00000021 INTL 20091112)
>> [    0.000000] ACPI: FACS 0x00000000CCFED080 000040
>> [    0.000000] ACPI: APIC 0x00000000CB7FB830 000072 (v03 DELL   CBX3     01072009 AMI  00010013)
>> [    0.000000] ACPI: FPDT 0x00000000CB7FB8A8 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
>> [    0.000000] ACPI: TCPA 0x00000000CB7FB8F0 000032 (v02 APTIO4 NAPAASF  00000001 MSFT 01000013)
>> [    0.000000] ACPI: MCFG 0x00000000CB7FB928 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
>> [    0.000000] ACPI: HPET 0x00000000CB7FB968 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
>> [    0.000000] ACPI: SSDT 0x00000000CB7FB9A0 000415 (v01 SataRe SataTabl 00001000 INTL 20091112)
>> [    0.000000] ACPI: SSDT 0x00000000CB7FBDB8 0009B9 (v01 PmRef  Cpu0Ist  00003000 INTL 20051117)
>> [    0.000000] ACPI: SSDT 0x00000000CB7FC778 000B22 (v01 PmRef  CpuPm    00003000 INTL 20051117)
>> [    0.000000] ACPI: DMAR 0x00000000CB7FD2A0 000080 (v01 INTEL  SNB      00000001 INTL 00000001)
>> [    0.000000] ACPI: ASF! 0x00000000CB7FD320 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
>> [    0.000000] ACPI: SSDT 0x00000000CB7FD3C8 000579 (v01 AMITCG PROC     00000001 INTL 20051117)
>> [    0.000000] ACPI: BGRT 0x00000000CB7FD948 000038 (v00 ??              01072009 AMI  00010013)
>> [    0.000000] ACPI: SSDT 0x00000000CB7FD980 00198A (v01 NvdRef NvdTabl  00001000 INTL 20091112)
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] ACPI: [APIC:0x05] Invalid zero length
>> [    0.000000] ACPI: Error parsing LAPIC address override entry
>> [    0.000000] ACPI: Invalid BIOS MADT, disabling ACPI
>> [    0.000000] tsc: Fast TSC calibration using PIT
>>
>> On next-20180430, the boot goes like this, and continues properly:
>>
>> [    0.000000] ACPI: SSDT 0x00000000CB7FD980 00198A (v01 NvdRef NvdTabl  00001000 INTL 20091112)
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>> [    0.000000] tsc: Fast TSC calibration using PIT
>>
>> Not seeing any commits to drivers/acpi/tables.c other than Al Stone's.
>>
>> This ringing any bells before I go bisecting?
>>
> 
> 
> 

Not off-hand.  Could you please send me a copy of /sys/firmware/acpi/tables/APIC
on this machine?  The commit cd8c65a6442b that I wrote looks like it got pulled
in on 20180430, which if I'm understanding correctly, seems to have fixed the
problem.  Did this work before 20180415?  I assume it did.

What puzzles me is that this message:

   ACPI: [APIC:0x05] Invalid zero length

should only have shown up if the MADT has a broken subtable, and I think that
bit of code has been that way for quite some time (git blame says somewhere
around 2012 when the test for this condition was put in).

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
