Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeBLPhj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:37:39 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35186 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbeBLPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:37:37 -0500
X-Google-Smtp-Source: AH8x227yczWZ8CsZXCThG6kysQ/BzTAwmtw0jDoeoja5xb62Fksbaos9R6cmue/DNvwcE+Xj2swm37Sxd5/ygjZbs1A=
MIME-Version: 1.0
In-Reply-To: <20180212152630.GD13962@amd>
References: <20171227054354.20369.94587.stgit@tlendack-t1.amdoffice.net> <20180212152630.GD13962@amd>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 12 Feb 2018 10:37:36 -0500
Message-ID: <CAMzpN2gRtzyHZ8Pt3T55_tP+uRxe47x-OqveA7Gda4M3Lb87Gw@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu, x86/pti: Do not enable PTI on AMD processors
To: Pavel Machek <pavel@ucw.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 10:26 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2017-12-26 23:43:54, Tom Lendacky wrote:
>> AMD processors are not subject to the types of attacks that the kernel
>> page table isolation feature protects against.  The AMD microarchitecture
>> does not allow memory references, including speculative references, that
>> access higher privileged data when running in a lesser privileged mode
>> when that access would result in a page fault.
>>
>> Disable page table isolation by default on AMD processors by not setting
>> the X86_BUG_CPU_INSECURE feature, which controls whether X86_FEATURE_PTI
>> is set.
>
> PTI was originally meant to protect KASLR from memory leaks, before
> Spectre was public. I guess that's still valid use on AMD cpus?
>                                                                 Pavel

KASLR leaks are a much lower threat than Meltdown.  Given that no AMD
processor supports PCID, enabling PTI has a much more significant
performance impact for a much smaller benefit.  For the paranoid user
they still have the option to enable PTI at boot, but it should not be
on by default.

--
Brian Gerst
