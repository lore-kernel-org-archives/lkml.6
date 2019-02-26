Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F03C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8982173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AguuasYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfBZFaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:30:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42617 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZFaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:30:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id d14so9583444ljl.9;
        Mon, 25 Feb 2019 21:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csKfCHjnEHfQKSvUWfDicmJococPYAbcvFqpRHGDb7Y=;
        b=AguuasYiFeYtJYECTzwIPOdq6j9TmEWl1sKahzXSMCeft9qzoyxO+rmGf6m367mM50
         m/7rEVgZ/RMvnPf9b1JDyfQaNvleG9H9Hj6K0WpSh5UoSaAT/23KiGK2YoDfG09FTsmX
         MKCB08eGmOnzsrGi3FKxb2vckkgUvfIRHjIsx+vB6aFXNPnY71SD7uhYzcARJ+A5dS6g
         RP3E0wR0cysGi6lhLfF2Q8BkrD40SHVqfMQ/oJuwyFFEp7QDCSqXSnQpVi1V350hdKM4
         DZ84svT747MQLINW9aea/5GnLDSHAgtTHU6XrxwbQOw8kbSg/EtyazB42c178R/yn5VB
         iVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csKfCHjnEHfQKSvUWfDicmJococPYAbcvFqpRHGDb7Y=;
        b=lTdbJrCLDzzcW8SzXkdvA6+hi/fwRjQhdXaxOH36b/zhElATVOZ4SpQ27IeYEeI/yp
         1I2bg4QrcjB00gDhfQw40FOYwT1BMNKJlTjyKMPNAgbwe+6yjCDzovALvPO9b9AeWt9B
         dKaR2IlTBBfs9OQIT54WFffCvB1BsJMiuM6rnvWT3Orcg58nywWGkCznjq41HzXqNEgt
         iV/s70/aybReqmOB3p3scddQyJey6NJed4l966T4Qc+yHhuoHUhsOrtZaq5dZp8oIFPe
         9y5XO29H/Rs5C+HPOrVM0HxSbdTEW9pJvekrH1uIYSR9o9OGjsoi+B7+VDgQhTRlBMMO
         sgKA==
X-Gm-Message-State: AHQUAuZCQWbn5bubstBYHYkf77KZ9+0e9zom1ms30l3mUB5PXcfjGJNA
        Pv24qmOyE9uLfCGcroh9mbPWhOpb413aJ/8d+WA=
X-Google-Smtp-Source: AHgI3IYTN7Dh8m3sCpj9WjJlVi8OvgZQVFH4I+nJIkBte3teo+mXjGjOffqVQYANHWQqCIs0QflzVZzOV0CKpzlo+RI=
X-Received: by 2002:a2e:54f:: with SMTP id 76mr12377984ljf.20.1551159002632;
 Mon, 25 Feb 2019 21:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20190223070901.GA10274@jordon-HP-15-Notebook-PC> <87tvgr1fr4.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvgr1fr4.fsf@concordia.ellerman.id.au>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 26 Feb 2019 10:59:50 +0530
Message-ID: <CAFqt6zY0HV7E+_6_s5A3eG+jEj+4hgQnAgJQm-Pc1gyX4Vnbpg@mail.gmail.com>
Subject: Re: [PATCH] tools: testing: selftests: Remove duplicate headers
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Bamvor Zhang <bamv2005@gmail.com>, shuah@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.ibm.com>, boqun.feng@gmail.com,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, sboyd@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 7:18 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Souptick Joarder <jrdr.linux@gmail.com> writes:
> > Remove duplicate headers which are included twice.
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> ...
> >  tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -
>
> I took this hunk via the powerpc tree.

How about taking this entirely through a single tree ?
or Shall I send these changes in different patches ?

>
> > diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > index 167135b..af1b802 100644
> > --- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > +++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > @@ -11,7 +11,6 @@
> >  #include <sys/wait.h>
> >  #include <unistd.h>
> >  #include <setjmp.h>
> > -#include <signal.h>
> >
> >  #include "ebb.h"
>
>
> cheers
