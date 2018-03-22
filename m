Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeCVV23 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbeCVV22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:28:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6272183D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELudz44+G/xlsHZS3vPaWWnh6lv1r12TaAx1oMpKGPIK2CcCXs92LGMhXjpjRdb5XGh+J/QhgIA++gktVMXywuI=
MIME-Version: 1.0
In-Reply-To: <C9BB696F3A938947B10DCAD29FAB8FFA66AC932C@CRSMSX101.amr.corp.intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
 <C78DE381-C618-4370-9B06-F6E25C850661@intel.com> <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
 <E9221EFA-636C-4D36-AEBA-3A1EEBBF2F50@intel.com> <CALCETrUxQ1XOs7V1XKOsk-iQ-qOwn41sWGYkepkVOE7PtfX24A@mail.gmail.com>
 <9C732DC6-F9CA-474F-B8F5-F8EBE406B12E@intel.com> <CALCETrWyuDC9Visx2-7rwpicVfS3wVMVFBykysaYcoBBe2y+tg@mail.gmail.com>
 <E3872173-6EDB-4861-896E-4D636A5A9B55@intel.com> <CALCETrUZk0m2-aJpzBbUR1-rSZkKCX6hKS3K3O_3LQJSkKKKGg@mail.gmail.com>
 <C9BB696F3A938947B10DCAD29FAB8FFA66AC932C@CRSMSX101.amr.corp.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 22 Mar 2018 21:28:06 +0000
X-Gmail-Original-Message-ID: <CALCETrU9mhVx8eCd0W6LbtGB9BXPWXOnMp0F9K4UTE738ZMPsA@mail.gmail.com>
Message-ID: <CALCETrU9mhVx8eCd0W6LbtGB9BXPWXOnMp0F9K4UTE738ZMPsA@mail.gmail.com>
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

On Thu, Mar 22, 2018 at 9:17 PM, Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
>
> ________________________________________
> From: Andy Lutomirski [luto@kernel.org]
> Sent: Thursday, March 22, 2018 09:53
>>>> But your patch doesn't actually do this, since gdb will just do
>>>> SETREGS anyway, right?
>>> GDB does SETREGS on any exclusive (FS/GS) updates in inferior call.
>
>> This means that your patch has exactly the same effect as the code in
>> my git tree, right?  Then let's stick with something like what's in my
>> git tree, since it's far simpler.
>
> Difference is if flipping FS/GS multiple times, user may check the base from LDT.
> But I don't have strong will to keep arguing this; Markus or somebody might
> want to say something.
>
> The whole point as I understand is to avoid any regression on legacy ptracers.
> If a strong confidence lies on the simple version, let me. My first thought bought
> this in fact.

I agree that we want to avoid regressions, but you seem to have
discovered that basically all ptracers() use SETREGS.  Your patch
behaves the same as the simple patch if SETREGS is used.

>
> Thanks,
> Chang
