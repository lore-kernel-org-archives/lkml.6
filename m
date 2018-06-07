Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cfTjOcK4GVvLDQAAmS7hNA
	; Thu, 07 Jun 2018 23:00:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 82080606FA; Thu,  7 Jun 2018 23:00:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSs3FBvN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1061F602FC;
	Thu,  7 Jun 2018 23:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1061F602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeFGXAZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 19:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751641AbeFGXAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 19:00:22 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F97208AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528412421;
        bh=X9mB3BMubu2rf2zG4I+wWVzfEh9NkrUASkflKEe3eKU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HSs3FBvNPF8CtlsxPgd+HfgcG/kLdlJZ8lis1FZstS+gJ6h4IEGNLIfSgV81kIRQu
         QJTOMP9XO/ErKvA/nDKyQ6c5HESs37ResONQ+/F+mYOvhtytGGd0GHah1PBl0ryQWQ
         /GM9UFK7PkU2SLPZ6viu5hz/k1tfg4fFo+dMZeug=
Received: by mail-wm0-f51.google.com with SMTP id p126-v6so126226wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 16:00:21 -0700 (PDT)
X-Gm-Message-State: APt69E1TKoF9e56Qw+bi6BdSw782/Bn4CTunw/rtdx5MxjHFrd7eXPCP
        w/ho/0C7xqwy+9WcUVaO49OH+zoIXLIYgg2EPpxO1w==
X-Google-Smtp-Source: ADUXVKLLWPi/uSpRUwLLVmW7ArZjjYHamstqTRxKmJlntsyDhJ7TidKvm5NMG6KcVVSxV/pX9K9eoSGSPEFvsP/rxRM=
X-Received: by 2002:a1c:dca:: with SMTP id 193-v6mr2713781wmn.36.1528412419860;
 Thu, 07 Jun 2018 16:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143855.3681-1-yu-cheng.yu@intel.com> <20180607143855.3681-6-yu-cheng.yu@intel.com>
 <CALCETrVRH8LeYoo7V1VBPqg4WS0Enxtizt=T7dPvgoeWfJrdzA@mail.gmail.com> <CAMe9rOp9YtNnTzsDPFXukK6ps7VNa2MU6o0GwnoES5Ma_AC65A@mail.gmail.com>
In-Reply-To: <CAMe9rOp9YtNnTzsDPFXukK6ps7VNa2MU6o0GwnoES5Ma_AC65A@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 16:00:08 -0700
X-Gmail-Original-Message-ID: <CALCETrXOc3-2QLks3iaTTvEE=4+2Oi3PORa8HPbYiDTtKV6CLQ@mail.gmail.com>
Message-ID: <CALCETrXOc3-2QLks3iaTTvEE=4+2Oi3PORa8HPbYiDTtKV6CLQ@mail.gmail.com>
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

On Thu, Jun 7, 2018 at 3:03 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Jun 7, 2018 at 1:50 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Thu, Jun 7, 2018 at 7:42 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >>
> >> From: "H.J. Lu" <hjl.tools@gmail.com>
> >>
> >> When Intel indirect branch tracking is enabled, functions in vDSO which
> >> may be called indirectly should have endbr32 or endbr64 as the first
> >> instruction.  We try to compile vDSO with -fcf-protection=branch -mibt
> >> if possible.  Otherwise, we insert endbr32 or endbr64 by hand to assembly
> >> codes generated by the compiler.
> >
> > Wow, that's... a genuine abomination.  Do we really need to support
> > CET on kernels built with old toolchains?
> >
>
> Yes.  GCC 7 should be able to build CET kernel.
>

Why?  Presumably people running distros that use CET are going to have
kernels build with a CET-supporting compiler.

If we really really need this patch, then I want some kind of
assurance that selftests will catch the failure if something breaks it
or a new vDSO entry point is added.  But my inclination is to NAK this
patch and let the distros carry it if they really really want it.  As
it stands, this sucks for maintainability.
