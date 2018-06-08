Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ngTwBibSGVvhPwAAmS7hNA
	; Fri, 08 Jun 2018 00:47:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F41AB6089E; Fri,  8 Jun 2018 00:47:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zRDyYmqC"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6CAB8605A2;
	Fri,  8 Jun 2018 00:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CAB8605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeFHAra (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbeFHAr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:47:28 -0400
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE06B208AD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 00:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528418848;
        bh=BFYsEP3KIs/UJ/g3xa53oBl8SbvI8q5sY2hMyWdX8vI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zRDyYmqCFzoNu6H7TySb+PdmEKBktdpN96vW4VmOJcJtP/r2qt6Y6XSfHXM+vg+R0
         Y6GhZNTXeEoxjGfvUg710d4Iw7tW8EWCIudM02/KmJ8uQo0C6vdj542DFqCqHWkxJg
         Vj7a8mebaTHttNeUQkYlVrk9jCuMj6Fb28KEJDPw=
Received: by mail-wr0-f176.google.com with SMTP id d8-v6so11628356wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 17:47:27 -0700 (PDT)
X-Gm-Message-State: APt69E0aoOzBx8L2fS4rNaozlEiLej8Q2qQyo2lIpnjaZ63g+XMCMp3c
        I7fmSwnyfd8nYiL5Wb9bfIGFdhS8HiKP8w/BqDWvTQ==
X-Google-Smtp-Source: ADUXVKJJN3IXZo3A86Qpw/Nn7z3qMfNzseImDVz+ZokOLUy5hmeJg3zAn5Ykq9qAPQgzbEP8Be83tAJeGkYrP8TEiQs=
X-Received: by 2002:adf:b1ca:: with SMTP id r10-v6mr3085508wra.221.1528418846307;
 Thu, 07 Jun 2018 17:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143855.3681-1-yu-cheng.yu@intel.com> <20180607143855.3681-6-yu-cheng.yu@intel.com>
 <CALCETrVRH8LeYoo7V1VBPqg4WS0Enxtizt=T7dPvgoeWfJrdzA@mail.gmail.com>
 <CAMe9rOp9YtNnTzsDPFXukK6ps7VNa2MU6o0GwnoES5Ma_AC65A@mail.gmail.com>
 <CALCETrXOc3-2QLks3iaTTvEE=4+2Oi3PORa8HPbYiDTtKV6CLQ@mail.gmail.com> <CAMe9rOphRmP4aEGGwmM=d+D7GyZWrC_hMTWaiy1tEtBd0PLdxA@mail.gmail.com>
In-Reply-To: <CAMe9rOphRmP4aEGGwmM=d+D7GyZWrC_hMTWaiy1tEtBd0PLdxA@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 17:47:14 -0700
X-Gmail-Original-Message-ID: <CALCETrXZjcTs6y8u5SvdUw_9itpb6EhLbMWpVJTAXVNkkvas_Q@mail.gmail.com>
Message-ID: <CALCETrXZjcTs6y8u5SvdUw_9itpb6EhLbMWpVJTAXVNkkvas_Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86: Insert endbr32/endbr64 to vDSO
To: "H. J. Lu" <hjl.tools@gmail.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 5:31 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Jun 7, 2018 at 4:00 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Thu, Jun 7, 2018 at 3:03 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> >>
> >> On Thu, Jun 7, 2018 at 1:50 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >> > On Thu, Jun 7, 2018 at 7:42 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >> >>
> >> >> From: "H.J. Lu" <hjl.tools@gmail.com>
> >> >>
> >> >> When Intel indirect branch tracking is enabled, functions in vDSO which
> >> >> may be called indirectly should have endbr32 or endbr64 as the first
> >> >> instruction.  We try to compile vDSO with -fcf-protection=branch -mibt
> >> >> if possible.  Otherwise, we insert endbr32 or endbr64 by hand to assembly
> >> >> codes generated by the compiler.
> >> >
> >> > Wow, that's... a genuine abomination.  Do we really need to support
> >> > CET on kernels built with old toolchains?
> >> >
> >>
> >> Yes.  GCC 7 should be able to build CET kernel.
> >>
> >
> > Why?  Presumably people running distros that use CET are going to have
> > kernels build with a CET-supporting compiler.
> >
>
> Good point.  It was needed before GCC 8 was released.   We can drop
> arch/x86/entry/vdso/endbr.sh now.
>

Phew!  We'll still need a patch to prevent configuring CET on a
compiler that can't support it.
