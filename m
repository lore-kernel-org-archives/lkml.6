Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879ACC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F80B21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="gYKmn+6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F80B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeHTLUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:20:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33815 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHTLUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 07:20:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so6449364wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 01:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=172Pirb3PwhpIB7n0kyNAEjNpT5gZf6X6NlUEKw0HVs=;
        b=gYKmn+6ZIah1EplWReoN3aLFG9yjRaV16sSudj+340e0rj5ckau7fOnbSxF4iakqKR
         i7tSwXUzhVXYdXnjJUzEi1e/aCBG1i5seV91rcpoE2sjB6pSaLUMu5w8Wz2fRXSZPOWB
         hs8znrG5VKHHtrroaupsVoPhDFycKaVHjwY0aZneU2AQj8DGf4cpsWx8iKzzHiziG216
         z+qbnFEit4AmUa3VOR2dTAHwzs5pIuAIR2YqL9o+HPCtEbA+uUiypLlrE9jUb7FaeI/4
         HglzYn1brojx+dNEjhFKocL2yvEWj1QJ71CQMA7i34sZZvGwuIkEac3HyvpwDGU4Q0oC
         pZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=172Pirb3PwhpIB7n0kyNAEjNpT5gZf6X6NlUEKw0HVs=;
        b=qVk8MNv+xbXOgzh2QAGyob2L1yC9HduKqXUBq2Du6P+jfDu3gJK3bZT/3nqAXiLLZ1
         P8TyoSUbZtEbV0U5iwQNSNJMOuB8OrhCxK2mbGlUIym6ko0N0BTLgIjahiwiJwjMJRo6
         R+h2SPyonwaVO2GMykGOJdsDHBgQ09xSTu41n5HNGTnOVDsp1XSBbvqaDni5h3rBIXcb
         5ss/3pq51uLQrlnC8AMjbMYIBHolDlRhIqZnXocQBhI1rAVgMjLUCEWhne2VI9+cq0f7
         0Cz7HkjrgTeHWfz8TZtoMbIeXWzFcB5a/ZXTLgz9FIJ8vdTL/SC380pBXhgbX9vdiOiN
         yqSw==
X-Gm-Message-State: AOUpUlHXEzuVmTuzfLS63oLXZq5Efr3XZqMLDt8+4uErnW5eQP0HMoUJ
        +Jqh2CUyz7WJH5QQusE7tzyK5VfGJLPAGnuexHwnMg==
X-Google-Smtp-Source: AA+uWPwDbtZKpAEsxhYkQINjzcQqYGUPcht4TyEIQ3gnFez83SKOfCSDauJvYO8/vg3tly9YA42YSP2JhxKbdBXD+XU=
X-Received: by 2002:a1c:7ed8:: with SMTP id z207-v6mr24958285wmc.139.1534752364568;
 Mon, 20 Aug 2018 01:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEnzVo5VVSVBjCOBMhcoV1qXf0XXqJqr3C01xQn-aUiZFQ@mail.gmail.com>
 <20180816155126.GA18296@kroah.com> <CAMGffEmJR310NKHO1JpwE8yTg1Oeu_oaTaJ1D2_T_UHKCnHwKA@mail.gmail.com>
 <20180816163937.GA5105@kroah.com> <CAMGffEk2FqRn0av7T-aF-TKvRAKeinm96NYjJju_T4CmUrYPkQ@mail.gmail.com>
 <CAMGffEnKt0xcc6LhNdZQGRmckJ3qCFxCOnQ3owZmWWiaKYdYuw@mail.gmail.com>
 <20180817170129.GE24945@kroah.com> <alpine.DEB.2.21.1808181330380.2151@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808181330380.2151@nanos.tec.linutronix.de>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Mon, 20 Aug 2018 10:05:49 +0200
Message-ID: <CAMGffEk=6eVgB=A--FyooDoVPY4mEiOdf=yNnqdX4cF6Ud_NuA@mail.gmail.com>
Subject: Re: [BUG]smt sysfs dir missing on 4.4.148 and 4.14.63
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 2:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 17 Aug 2018, Greg Kroah-Hartman wrote:
> > On Fri, Aug 17, 2018 at 02:39:00PM +0200, Jinpu Wang wrote:
> > >
> > > I found the problem, CONFIG_HOTPLUG_SMT is enable due to CONFIG_SMP,
> > > but I did explicitly enable CONFIG_HOTPLUG_CPU.
> > >
> > > That's why the smt dir is missing, and kernel panic when I boot with
> > > 'nosmt' or 'l1tf=3Dfull' probably also other combination.
> > >
> > > With CONFIG_HOTPLUG_CPU=3Dy, it works fine so far.
> >
> > So do we need a new configuration dependancy here to resolve this
> > problem?  Why is this not an issue in Linus's tree?
>
> That's probably the same problem on Linus tree. Have not tested it yet
> though. I'll have a look.
>
> Thanks,
>
>         tglx
>
Yeah, it's the same problem on Linus tree.

Probably makes sense to do the following, I can sent a formal patch if
you think it's right thing to do:

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0312f8..8a52f0b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -188,7 +188,7 @@ config X86
        select HAVE_SYSCALL_TRACEPOINTS
        select HAVE_UNSTABLE_SCHED_CLOCK
        select HAVE_USER_RETURN_NOTIFIER
-       select HOTPLUG_SMT                      if SMP
+       select HOTPLUG_SMT                      if SMP && HOTPLUG_CPU
        select IRQ_FORCED_THREADING
        select NEED_SG_DMA_LENGTH
        select PCI_LOCKLESS_CONFIG


--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
