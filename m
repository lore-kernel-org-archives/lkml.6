Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4125586-1527070505-2-5074806348082939640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527070504; b=VmYZBZ5bZxSkguG4k3gLuMqpvErNPCtOfgL4J6MGfjDMILifd5
    6ebO5EsRFVuj1/pIcqTs7UOQC/jtqMbx039b3mGdq07G+DHsyQmuzZdFdsB2ezdu
    oKTQ22b4Wc7Sqv0YQ+T0ArywBHsBFF6bLdAedAavFthMKmwk1Zv1FqmefwR9dhKH
    sbJBTlPKyWwY2JdBCES57vY/7qyFIWT4huhlmyD5qrAUS0YCAIgxptnPcLpgAe23
    CnT7Ft28bHTThbe4DSSAyWq766j1bDS0rMz/UOwwOf3y85CviiZpP82Z4+yJtDnH
    l1jRVg2gNvwrclsspt5qwG5mg8qpNw0Mpfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:sender:list-id; s=fm2; t=
    1527070504; bh=+x8v6Tcj31dqAA1iz3THoU3frInB4x4G3LyQU0XChJY=; b=W
    LGp6RkF6t6JHVExhaCjq/Kckb3XfIM2P2WajVf+YlXfbKqmJrEMrYAy4Igok68Lh
    iaev8k/XGndEqYKvGpZZP5irDbceDoLhz+1bxGIXY+R7vBmeQ1vTMsELVGK8lOz4
    6EkbJDy1r3KjzWxX8Io+03HWKhM5udbY1URURe1IywTNUOX2IHogskxn+YU51Zhe
    /t/1axEZNWUAYzbW/KPwE+tzywYi+/rROv7d66/14JKALiggOjJlIWMhNbqxqf3z
    ylc1ot4h2Okd0GfSe6U2XlbkGsYAZHbv9w7jc6qXtUSWjz/Olq2V/hTFUOwDJFg2
    jsU6kmBleUAxyYxXmiahg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIKRFCzBpWX31cpVq8TuNDD8ag3bisOmPLw06G+qfH8RfoN3Cu2RcE8U1CxcUtJ4zr36Q0Jk6FBhdMBakudvHQsN91cc/gulDBMyQgtcuZcQgNBBS1Wq
    fYuBh0L2U03V/XFNCCIRSvg4s+8WccaPrs9RfLMJJlS/Aez/JeH/ajyEFZLc3T2YwkIGp/Q7cBr/LIxtZwH6dXJ7n9oCPrTUgaPtSuJnJgx4aUC4CEL7aeBT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=3_uRt0xjAAAA:8 a=CNXvVXXJ7dQv4NPE_MMA:9 a=CjuIK1q_8ugA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=z1SuboXgGPGzQ8_2mWib:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932326AbeEWKPD (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 06:15:03 -0400
Received: from foss.arm.com ([217.140.101.70]:52486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932307AbeEWKPC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 May 2018 06:15:02 -0400
Date: Wed, 23 May 2018 11:14:52 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Hogan <jhogan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [RFC PATCH 01/11] prctl: Support movement of arch prctls out of
 common code
Message-ID: <20180523101451.GH13470@e103592.cambridge.arm.com>
References: <5252accbd67022cea25e5aa80e48d95c.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 07:28:26PM +0100, Will Deacon wrote:
> Hi Dave,
> 
> On Mon, May 14, 2018 at 06:14:17PM +0100, Dave Martin wrote:
> > The core framework for the prctl() syscall is unloved and looking
> > rather crusty these days.  It also relies on defining ancillary
> > boilerplate macros for each prctl() in order to control conditional
> > compilation of the different prctl calls.  We have better ways to
> > do this now, using Kconfig.
> > 
> > This patch defines a new arch hook arch_syscall().  Architectures
> > that implemement arch-specific syscalls can now select
> > HAVE_ARCH_SYSCALL in their Kconfig and define this function
> > appropriately.
> > 
> > The core prctl() implementation now matches option against the list
> > of common or legacy prctls, deferring to prctl_arch() if an
> > unrecognised option is encountered.
> > 
> > (arch_prctl() would have been a nicer name, but it conflicts with the
> > pre-existing syscall of the same name on x86, particularly in the um
> > code.)
> > 
> > No functional change.
> 
> [...]
> 
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index af5f8c2..c911ff0 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > -#ifndef _LINUX_PRCTL_H
> > -#define _LINUX_PRCTL_H
> > +#ifndef _UAPI_LINUX_PRCTL_H
> > +#define _UAPI_LINUX_PRCTL_H
> 
> Is it safe to rename this #define, or is there a possibility that userspace
> could be using it for something and relying on it not changing?
> 
> Other than that:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

I think that header guards are generally viewed as being private to a
project and not API.  codesearch.debian.net yields few hits, where there
are actual #ifdefs on this symbol, they seem to be pastes of the kernel
headers:

https://codesearch.debian.net/search?q=_LINUX_PRCTL_H&perpkg=1

 -> android, linux, dietlibc ... gnome-chess (?)


There is plenty of precedent in the Howells special:

607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux")

See for example <{,uapi/}linux/loop.h>.

Cheers
---Dave
