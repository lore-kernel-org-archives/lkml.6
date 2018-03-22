Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeCVBlE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbeCVBlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:41:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881562183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELtlkf/7CEQHiVe5eNxpYp1KRusvdRBTzMdt364Fh2GZ+3D8WisB3SEVNPl6H0jV3Yr69l1OgajAjVlOhwtOGjU=
MIME-Version: 1.0
In-Reply-To: <E9221EFA-636C-4D36-AEBA-3A1EEBBF2F50@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
 <C78DE381-C618-4370-9B06-F6E25C850661@intel.com> <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
 <E9221EFA-636C-4D36-AEBA-3A1EEBBF2F50@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 22 Mar 2018 01:40:38 +0000
X-Gmail-Original-Message-ID: <CALCETrUxQ1XOs7V1XKOsk-iQ-qOwn41sWGYkepkVOE7PtfX24A@mail.gmail.com>
Message-ID: <CALCETrUxQ1XOs7V1XKOsk-iQ-qOwn41sWGYkepkVOE7PtfX24A@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 3:11 PM, Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
> On 3/20/18, 17:47, "Andy Lutomirski" <luto@kernel.org> wrote:
>>    If I've understood all your emails right, when you looked at existing
>>    ptrace users, you found that all of them that write to gs and/or
>>    gs_base do it as part of a putregs call that writes them at the same
>>    time.  If so, then your patch does exactly the same thing that my old
>>    patches did, but your patch is much more complicated.  So why did you
>>    add all that complexity?
>
> What is tried to be provided is backward compatibility by emulating
> “mov gs (fs) …” when index is only changed and preserve a (given) base value
> in other cases.

mov to gs changes GSBASE even if GS was unchanged.

But it's not clear to me that you've identified any case where
emulating this behavior is useful.
