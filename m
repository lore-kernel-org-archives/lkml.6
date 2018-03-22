Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeCVQIR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751812AbeCVQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:08:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7E42183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELv5LTreVZqYke2oFu/Om2XXn0RHL/t4f5+5vwHyVypSEEIGI/yubftGUZ1Y7taiUayTFeSkoM0ggIkbE5muTZM=
MIME-Version: 1.0
In-Reply-To: <9C732DC6-F9CA-474F-B8F5-F8EBE406B12E@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
 <C78DE381-C618-4370-9B06-F6E25C850661@intel.com> <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
 <E9221EFA-636C-4D36-AEBA-3A1EEBBF2F50@intel.com> <CALCETrUxQ1XOs7V1XKOsk-iQ-qOwn41sWGYkepkVOE7PtfX24A@mail.gmail.com>
 <9C732DC6-F9CA-474F-B8F5-F8EBE406B12E@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 22 Mar 2018 16:07:53 +0000
X-Gmail-Original-Message-ID: <CALCETrWyuDC9Visx2-7rwpicVfS3wVMVFBykysaYcoBBe2y+tg@mail.gmail.com>
Message-ID: <CALCETrWyuDC9Visx2-7rwpicVfS3wVMVFBykysaYcoBBe2y+tg@mail.gmail.com>
Subject: Re: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when FS/GS
 updated by ptracer
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 3:45 PM, Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
> On 3/21/18, 18:41, "Andy Lutomirski" <luto@kernel.org> wrote:
>> mov to gs changes GSBASE even if GS was unchanged.
> In GDB, ptrace (syscall) doesn't happen when FS/GS unchanged as
> its (context) cache seems to be first checked. This does not allow to
> preserve GSBASE as you know.
>
>> But it's not clear to me that you've identified any case where
>> emulating this behavior is useful.
> One argument I heard is (if debugging a legacy application) user
> might want to (indirectly) access LDT during inferior call and this
> mov to fs/gs has been useful (maybe needed).
>
>

But your patch doesn't actually do this, since gdb will just do
SETREGS anyway, right?
