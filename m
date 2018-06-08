Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id f4CUEyIGGltLAwAAmS7hNA
	; Fri, 08 Jun 2018 04:35:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 01CD36089E; Fri,  8 Jun 2018 04:35:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDE8OaUc"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6DD276063F;
	Fri,  8 Jun 2018 04:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DD276063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeFHEfd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbeFHEfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:35:31 -0400
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com [209.85.128.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DA8208B0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 04:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528432531;
        bh=Yy/MOg5lY8RT/R+Td8aOKYrzKBLYWUBWowtyJ0VhcdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lDE8OaUcf56dk7dqePO4PM4r6HKXlACpBiKUAhfq5kW3SXO9ZRHB/nBVdbhTTlXI7
         tOWw1eQcSvdzTdpezKisVzKAYcIZCeZLjev3J0X+vG1atRYnuRgY0tTjRTywhbaKwV
         1MBD7v9ouQto1kVU+QOsRJPIpX+PpZKEgiXGQc5c=
Received: by mail-wr0-f178.google.com with SMTP id h10-v6so11910232wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 21:35:30 -0700 (PDT)
X-Gm-Message-State: APt69E389ibLitlHZP8a+crFbJwKdsrqWOOEiwh42QrdBymYWdr2NA9N
        /TcetwCrPcTo/VVHMPcloqQFexkgWIBJ49QQvYL68A==
X-Google-Smtp-Source: ADUXVKJa9F5xGIn7S0S7RDb7sXj5LeozWn3EDkT69Picjz0wrEScVVem9JWJimQFkDY818ATJ86CJhqC4tdryHl9rCQ=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr3513194wrd.67.1528432529016;
 Thu, 07 Jun 2018 21:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com> <CAMe9rOphjpPd3HnKAdU-RmG0RGj6c2oAbnq+C2Jd1srsqTA7=w@mail.gmail.com>
In-Reply-To: <CAMe9rOphjpPd3HnKAdU-RmG0RGj6c2oAbnq+C2Jd1srsqTA7=w@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 21:35:17 -0700
X-Gmail-Original-Message-ID: <CALCETrWd+1iNmt36EFiLxMv8bQ-GodU=XygPRGb4h+xanhHHLQ@mail.gmail.com>
Message-ID: <CALCETrWd+1iNmt36EFiLxMv8bQ-GodU=XygPRGb4h+xanhHHLQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
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

On Thu, Jun 7, 2018 at 9:22 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Jun 7, 2018 at 3:02 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
> > On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >> On Thu, Jun 7, 2018 at 1:33 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >>>
> >>> On Thu, 2018-06-07 at 11:48 -0700, Andy Lutomirski wrote:
> >>> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >>> > >
> >>> > > The following operations are provided.
> >>> > >
> >>> > > ARCH_CET_STATUS:
> >>> > >         return the current CET status
> >>> > >
> >>> > > ARCH_CET_DISABLE:
> >>> > >         disable CET features
> >>> > >
> >>> > > ARCH_CET_LOCK:
> >>> > >         lock out CET features
> >>> > >
> >>> > > ARCH_CET_EXEC:
> >>> > >         set CET features for exec()
> >>> > >
> >>> > > ARCH_CET_ALLOC_SHSTK:
> >>> > >         allocate a new shadow stack
> >>> > >
> >>> > > ARCH_CET_PUSH_SHSTK:
> >>> > >         put a return address on shadow stack
> >>> > >
>
> >> And why do we need ARCH_CET_EXEC?
> >>
> >> For background, I really really dislike adding new state that persists
> >> across exec().  It's nice to get as close to a clean slate as possible
> >> after exec() so that programs can run in a predictable environment.
> >> exec() is also a security boundary, and anything a task can do to
> >> affect itself after exec() needs to have its security implications
> >> considered very carefully.  (As a trivial example, you should not be
> >> able to use cetcmd ... sudo [malicious options here] to cause sudo to
> >> run with CET off and then try to exploit it via the malicious options.
> >>
> >> If a shutoff is needed for testing, how about teaching ld.so to parse
> >> LD_CET=no or similar and protect it the same way as LD_PRELOAD is
> >> protected.  Or just do LD_PRELOAD=/lib/libdoesntsupportcet.so.
> >>
> >
> > I will take a look.
>
> We can use LD_CET to turn off CET.   Since most of legacy binaries
> are compatible with shadow stack,  ARCH_CET_EXEC can be used
> to turn on shadow stack on legacy binaries:

Is there any reason you can't use LD_CET=force to do it for
dynamically linked binaries?

I find it quite hard to believe that forcibly CET-ifying a legacy
statically linked binary is a good idea.
