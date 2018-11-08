Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF788ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F7120840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="OvWpKhjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F7120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeKIDJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:09:01 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46610 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeKIDJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:09:00 -0500
Received: by mail-oi1-f172.google.com with SMTP id e19-v6so1843292oii.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhr3DtJr5hHG40nJ43PZkz4HjRD/MEosnMu6p+jKu7s=;
        b=OvWpKhjq8+ogeWawJE9I/rdBQqXBwGERKQbm0lV31BcZvk2XiZR5fP9uVN6kKY8deB
         jW+mMIyfiaknnPN7lsMNvG8dLt51tJFyXOru9+c7aUp1oiEAZcGO11lFiNniCtHDIR66
         +wbD7vSG+FGxIK6mCWTUlf/q0RC0XNROoNP5jshC4/RT/Ntj0041OLFfUN0Jn4mfRwYM
         nY6gw39Xe2cG2EMCT96Tju5V7s3LQAMVBTNZz6dwWymbgNAasG3LSez//JkR3q/mzPF8
         ma5623Ru4UDYB7aY8KEDGdVtNPk89OOkjWJRPRThpf4pxOWlUg3tWPu/fDSEZEUdCGXY
         1jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhr3DtJr5hHG40nJ43PZkz4HjRD/MEosnMu6p+jKu7s=;
        b=lIvdsfOh2K3cyNTG9gP/KQdvdOq/ZX/gYsUo5/taXZH15K6x/DgiAGhNfteK0dySKH
         X/aKoWphqMY1nA+QWs9flYV3YmzQIFez7ciy5/Z+lp+uQDmTHyWOh0AeaDI5Kr436gAd
         riyZ7SNwkT+vAwDrtl27WdU//l3JZ+LaYTnfnQgZvMHzTouDCaIkloWEOoqNfB3JF8QI
         CKlD4LrYVyenD6/LDdTifQZ64dRAHwerL7AYExOPbRYU0snKFjqLiL1ynB9MmhWwYpdn
         AZZZdd+LA0TjvwQYy0YKIYJeHQWytHBJNK48gBihy9nWpaVt7Z8bpjKhT2ysBqT0hJSu
         HFTg==
X-Gm-Message-State: AGRZ1gJ88/6D0s9aa+IyMOZWO7kQiFVWhjAABHvCuibLejei/IwtKP7X
        METqjr4MK/NKOotJjf7Qbz8mxH6vJll5nMo6SRIOLQ==
X-Google-Smtp-Source: AJdET5e2KwN4nyhCA6bgt4OfNQ8rUOjZnrFsSMXxuufyCDXxORZBCJ0GCvwo0OXlw+xrazct/Icfza6akCpw9yxL9C0=
X-Received: by 2002:aca:5204:: with SMTP id g4-v6mr3264326oib.149.1541698349024;
 Thu, 08 Nov 2018 09:32:29 -0800 (PST)
MIME-Version: 1.0
References: <20181107171010.421878737@linutronix.de> <20181107124855.328133e7@lwn.net>
 <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
 <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
 <20181108074920.4c601ee3@lwn.net> <20181108150517.GV9761@hirez.programming.kicks-ass.net>
 <20181108162133.GC1080@thunk.org> <20181108163223.GH6675@sirena.org.uk>
In-Reply-To: <20181108163223.GH6675@sirena.org.uk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 8 Nov 2018 09:32:18 -0800
Message-ID: <CAPcyv4h1ABBz7OaZB5d--fjtwvfrM=TZs7XFCG54PYRm_Fr8WQ@mail.gmail.com>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
To:     Mark Brown <broonie@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>, acme@redhat.com,
        frederic@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 8:32 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 08, 2018 at 11:21:33AM -0500, Theodore Y. Ts'o wrote:
> > On Thu, Nov 08, 2018 at 04:05:17PM +0100, Peter Zijlstra wrote:
>
> > > My plumbers schedule is already 100% booked with MCs and other things.
> > > There is no kernel-summit schedule details available as of yet, but it
> > > is already almost certain that I will not have time for anything in that
> > > track anyway :/
>
> > I thought there was a slot already scheduled on the refereed track,
> > "Towards a Linux Kernel Mainainer Handbook" (Tuesday at 4:45pm) for
> > this purpose?
>
> I'm not 100% sure that people will pick up that the topic is about a
> handbook for working with maintainers rather than a handbook for being a
> maintainer from that title...

The intent is a handbook for being a maintainer. However, in the
process of describing how a given sub-system is maintained one also
needs to describe the local rules. So contributors should be able to
glean what matters to a sub-system from a description of how that
sub-system is maintained. In other words the direct audience is
maintainers, but it also hopefully makes the process more transparent
for contributors.
