Return-Path: <kernel-hardening-return-12207-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELssgx4K5ueZ5PVbhJZCAjxZuiOM1HRHY0x/F8oqVPSglzYmrxbpx/fbQ07wrNu5LhKU9E2r
ARC-Seal: i=1; a=rsa-sha256; t=1520450651; cv=none;
        d=google.com; s=arc-20160816;
        b=Iq6n6LJ3Wjsxtb1eCLCQjUNbBzVfY0A4iLH8EbYhq+wI020ugIvL4OetPMJNL/Bf4g
         8RQi5vPqHylP5412ZWH8v8lQ+7E8mSkrGiPK5v9872vLahIiZqygMNVDtxg5NJo7gY1/
         pNEwa1oNvXVcgXEOHXGpeQtTpElXwBGlPW/lUa2G0+9zEyCftUX2SB4U3zgCNJzAfreV
         tIOxt/l+omPnLn/wiH1cnGLQBLxs0mRt77ZxDL6f+AyeOvUlGP9Caim2TB+0COGhBPbY
         BWmjl3cidH7HslgXrxZLdnmRWa8s+qQVqgRSj93yr8d0gtFHRsM+IfPyMH7Ajh8WUoho
         8zPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=frpv8U+ZfbNiull0Uk+0rvkekxJCuwaeZWxsNhX0JT8=;
        b=ZslwslZ4LZ9zGuOvoNaHUPJp9kSldXVGrey1YtwBov0gJa8v1vTCLnrzSOSXsuVlGU
         DFDMPpodkcM3JxzFEb1rTGp5RPsxIgTK9g9bvQiCpz+XFOqaMI3TN1hLIakHEsTnvry4
         hnZjy10CXPiS6UOyoRygMvT4X2YD44fjF5GmzPlP61UsYylfSy5Jc01wLI4crDBAWkhG
         EZxf0z2lerEDv5DzW5uI7IJnjNz6gOw85VDIkaM2VgEQhum4aVdFS7vy1jO4tCVO3Nwd
         SveOYiF3ZlplGvvDAfNNzK3kIE4mZubnuP1SMJKAoexKkq35cGJFLn0zEDSnfp7ApF6S
         9wwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lgoUOOdt;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=bZO+0Khm;
       spf=pass (google.com: domain of kernel-hardening-return-12207-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12207-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lgoUOOdt;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=bZO+0Khm;
       spf=pass (google.com: domain of kernel-hardening-return-12207-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12207-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <519fee5268faea09ae550776ce969fa6e88668b0.1520449896.git.luto@kernel.org>
References: <519fee5268faea09ae550776ce969fa6e88668b0.1520449896.git.luto@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Mar 2018 11:23:48 -0800
X-Google-Sender-Auth: MHS4aJZDdjGlkib4DPbGvThAEvg
Message-ID: <CA+55aFx-ZUROd4EER+x-pSWFK9_+NOjBtDmkzjOGZ5uSMbPgAg@mail.gmail.com>
Subject: Re: [PATCH] x86/vsyscall/64: Drop "native" vsyscalls
To: Andy Lutomirski <luto@kernel.org>
Cc: "the arch/x86 maintainers" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Borislav Petkov <bp@alien8.de>,
	Kees Cook <keescook@chromium.org>, Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594307354733708248?=
X-GMAIL-MSGID: =?utf-8?q?1594308061963762102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 11:12 AM, Andy Lutomirski <luto@kernel.org> wrote:
>
> For all practical purposes, "native" was really just a chicken bit
> in case something went wrong with the emulation.  It's been over six
> years, and nothing has gone wrong.  Delete it.

Ack.

I guess we';ll hear if anybody might still use it and cares, but..

               Linus
