Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeCTPHI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeCTPHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:07:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFC9217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <CALCETrXCRYvLthy2FMccoDhnPzyPT5J_hcvD63e-DM9okVaxeg@mail.gmail.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com> <CALCETrXCRYvLthy2FMccoDhnPzyPT5J_hcvD63e-DM9okVaxeg@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 20 Mar 2018 15:06:44 +0000
X-Gmail-Original-Message-ID: <CALCETrXwRoCyOMd0jTmY7zzt6asvB8ac0KCoHOyZgYhJyuhEVw@mail.gmail.com>
Message-ID: <CALCETrXwRoCyOMd0jTmY7zzt6asvB8ac0KCoHOyZgYhJyuhEVw@mail.gmail.com>
Subject: Re: [PATCH 00/15] x86: Enable FSGSBASE instructions
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, X86 ML <x86@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 3:05 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Mon, Mar 19, 2018 at 5:49 PM, Chang S. Bae <chang.seok.bae@intel.com> wrote:
>> FSGSBASE is 64-bit instruction set to allow read/write
>> FS/GS base from any privilege. As introduced from
>> Ivybridge, enabling effort has been revolving quite long
>> [2,3,4] for various reasons. After extended discussions [1],
>> this patchset is proposed to introduce new ABIs of
>> customizing FS/GS base (separate from its selector).
>>
>> FSGSBASE-enabled VM can be located on hosts with
>> either HW virtualization or SW emulation. KVM advertises
>> FSGSBASE when physical CPU has and emulation is
>> supported in QEMU/TCG [5]. In a pool of mixed systems, VMM
>> may disable FSGSBASE for seamless VM migrations [6].
>>
>> A couple of major benefits are expected. Kernel will have
>> performance improvement in context switch by skipping MSR
>> write for GS base. User-level programs (such as JAVA-based)
>> benefit from avoiding system calls to edit FS/GS base.
>
> Can you describe what changed since the last submission?  It looks
> like a lot has changed and this series is much more complicated and
> much more fragile than it used to be.  Why?

Also, I've been getting lots of kbuild bot complaints about something
that looks like this patches from your git tree as recently as March
17.  Have you fixed those problems?
