Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4407FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED54206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bXmUUeQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfBVVVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:21:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35724 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:21:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id v7so2791880lfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4euBrx1amh8VREzowpOlG7HHzKY/P+3+k2m8hYpWdo=;
        b=bXmUUeQZYn3iYoo+sp7inmFd8U3YD0j+FUYXbPRwuqVT4OxQs6EK3W7jhv8rXcDou0
         ogSmrUHQkbEZBmlsLhN7prfCeGa1EuG26VbI13BLg+YM9t7fCrelLo96koDr2rLexMAd
         qFlXWgpdDTepvhP6unSCoKh7GNU0oNRJ0myZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4euBrx1amh8VREzowpOlG7HHzKY/P+3+k2m8hYpWdo=;
        b=l9CsityQYMECwF1PrYDCpYvm8kFI2LuXGG/RVt32OVa1gotdn0gL6Max5mG41nVk/R
         /8BvlYsG68FpmhwUkrVTc29DluX+aPG9y3sGPCyU8fkyc6z4dPm5S9kSurAj+SisffeR
         6APoRbS+LMxE3tV20UnupR3mr4ydZsL6s/B1Ui47wng8o4ToML1aIuS37lcvXTsDKRpB
         ZdfYuVe2MX9D1p/o0f5hH4rDqC6ka1WX/IslYP7SKLWFEvcUior79yfKABUeeHBQP+sW
         B+2pZSoeGktwXhwgiDxR4z8du8wELLnzuYVQ23s82qDPrTNe7unMFaIrIvE6qEqkITpI
         j6QA==
X-Gm-Message-State: AHQUAuZ9m3m8W3D5u/KzxA9bD1iBou0KznH26DUViPmhFAwTH1OIxI5y
        hfBG0U38YeIxvH373DHW2A/sV//kGSU=
X-Google-Smtp-Source: AHgI3IbT6zFhGQftW+B/ufpVTgELYDOUJRLPGnKLX0AkdfzGbQynbsz2BITLKeP5B2PrjpXgBWtUlg==
X-Received: by 2002:a19:87:: with SMTP id 129mr3566392lfa.101.1550870476737;
        Fri, 22 Feb 2019 13:21:16 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q6sm773398lfh.52.2019.02.22.13.21.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:21:15 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id l5so2814462lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:21:15 -0800 (PST)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr3093456lji.79.1550870474949;
 Fri, 22 Feb 2019 13:21:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 13:20:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
Message-ID: <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:27 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
> and users pass both user and kernel addresses into it and expect
> that the helper will actually try to read from that address.

As mentioned earlier in the thread, that's actually fundamentally broken.

There are architectures that have physically separate address spaces,
with the same pointer value in both kernel and user space.

They are rare, but they exist. At least sparc32 and the old 4G:4G split x86.

So a pointer really should always unambiguously always be explicitly
_either_ a kernel pointer, or a user pointer. You can't have "this is
a pointer", and then try to figure it out by looking at the value.
That may happen to work on x86-64, but it's literally a "happen to
work on the most common architectures", not a design thing.

                Linus
