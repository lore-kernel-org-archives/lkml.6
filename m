Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6641C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E52208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRjiookJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E52208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbeFLQCF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933137AbeFLQCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:02:03 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FCA208B8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528819323;
        bh=qz844i3hlmnmB8pkhGqjdrUbbK1JubnKcBc70gs4OjU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WRjiookJB6fro00rW7i/oWYdJqMgT5rgaW2hz0rFM406ldh9VdecdFNjAjkueiIX1
         5apPoQKXsBxYQWhLdT2cdbTX8EwCj4RfEE2mrzdaTrz8kb8SyRHasGbx1bbQfp1Pj9
         Fn0wLomwZtR1blwOTFHJuhkkKRABzcUvM1w4chwY=
Received: by mail-wm0-f51.google.com with SMTP id r125-v6so24348453wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 09:02:02 -0700 (PDT)
X-Gm-Message-State: APt69E3dO8i+bauoy+7/uEIYi8UunK9fow7ztV+913NPDS2ht2mJ9+CS
        6sIuyiWaWjETAh01Epf2N2xue+bJWmd6+wFWg3f8gQ==
X-Google-Smtp-Source: ADUXVKI2lsg84R0HHIhWP3bDNk0Li4NcoKf/JDKVKbMn80xXN3AdZsK+lBGU2K8pKRJHHkge80te0sTDWnFSBYjOhuM=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr690294wma.21.1528819321435;
 Tue, 12 Jun 2018 09:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de> <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
In-Reply-To: <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Jun 2018 09:01:48 -0700
X-Gmail-Original-Message-ID: <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
Message-ID: <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To:     "H. J. Lu" <hjl.tools@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
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

On Tue, Jun 12, 2018 at 4:43 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Tue, Jun 12, 2018 at 3:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 7 Jun 2018, H.J. Lu wrote:
> >> On Thu, Jun 7, 2018 at 2:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >> > Why is the lockout necessary?  If user code enables CET and tries to
> >> > run code that doesn't support CET, it will crash.  I don't see why we
> >> > need special code in the kernel to prevent a user program from calling
> >> > arch_prctl() and crashing itself.  There are already plenty of ways to
> >> > do that :)
> >>
> >> On CET enabled machine, not all programs nor shared libraries are
> >> CET enabled.  But since ld.so is CET enabled, all programs start
> >> as CET enabled.  ld.so will disable CET if a program or any of its shared
> >> libraries aren't CET enabled.  ld.so will lock up CET once it is done CET
> >> checking so that CET can't no longer be disabled afterwards.
> >
> > That works for stuff which loads all libraries at start time, but what
> > happens if the program uses dlopen() later on? If CET is force locked and
> > the library is not CET enabled, it will fail.
>
> That is to prevent disabling CET by dlopening a legacy shared library.
>
> > I don't see the point of trying to support CET by magic. It adds complexity
> > and you'll never be able to handle all corner cases correctly. dlopen() is
> > not even a corner case.
>
> That is a price we pay for security.  To enable CET, especially shadow
> shack, the program and all of shared libraries it uses should be CET
> enabled.  Most of programs can be enabled with CET by compiling them
> with -fcf-protection.

If you charge too high a price for security, people may turn it off.
I think we're going to need a mode where a program says "I want to use
the CET, but turn it off if I dlopen an unsupported library".  There
are programs that load binary-only plugins.
