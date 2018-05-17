Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1627028-1526539235-2-772356725968384214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526539234; b=AixQc1b+H+ddWwj6o47qLvCcju1X3y5U/Q+gOx6GYWrs5qHe8Q
    jAYHkh7J2NJn0yL0C/R4mnJf6gZfAbLxn364g5KwlObpMIjKDBCD5T8lTrDMkbER
    +D4B/2UulChdPh6Cbfh+vPhBcNHLTXJvn0f/2WPtoj5bzQIvDJtQ0gy+L2N2MjDC
    2l13is68rGvj284yoE4NhQY0IFpmqP3rx5MftRH+jW2b5D5VQful+L6efStYVpA6
    rBStJ/tXRI2/gosKF+X8CIjffV8h5gCf3dQk25+CvwOvv7Q9XkX3Cxp6h0paATPK
    hwjnAypzQyRPzsHT+jXglDlIghZ36HqLvyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1526539234; bh=AB0iH8rDW0SmRn9gvLXc6AIABJXYyBbmWj9QmVRgMt
    0=; b=i7L2p8e7TDQkgaKo88wsH+fuhh2FUBx1odj3+rK120KcXprkOGoUA3ilsS
    4fLX+zXctXsbvaWoSnd9t2KCW8LhOOX2IUy3miEmcI/M2iZcapGTm6dFmKIRmWXG
    8BTtqzRY1iMjdws9GSWZEl6VODrD3SgfieT4pKE27DKCTPKLgtkaAxoiSYMdOsBq
    3Ir/1OuQn8P43GMsLUWsobd6jWmfR3pPViVBzVG1Ft1pmUDQKc2QY9L8T6qa16FO
    vB8+/XLnetIpnztlvhGmNvPZqa9IDVyzaNEwf5M6wx0FVMl6RO1B1Q36r8tH0/Zb
    g7fBI20HEO8F5uN2p0aWma1Rdw7w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ellerman.id.au header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ellerman.id.au header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLtn95Hlg/VwjARj0PZ5zuJSBPCcRig1Cuq1ELKYbfh5O/PSmJkc8lLzYrvGeDMOP20znj14z41sOALPq2ptnSRRWI5y5wXdmeU8qC6Qgk3R+eU7REjf
    2B9QVK7xZ86Xvy5/hjo2v2d73Lq/P49cLextQeQbaqz60my6BUAPTuumGvhYOxFxy6HSTK74w6yrCokvlHpwUF/u6RfxkL2k06VfSduPKS6bSx9l/96RB1H/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=VwQbUJbxAAAA:8 a=1SOAIPgsxdmGRmlvJekA:9 a=x8gzFH9gYPwA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeEQGkc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 02:40:32 -0400
Received: from ozlabs.org ([203.11.71.1]:47325 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeEQGkb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 May 2018 02:40:31 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [RFC PATCH] UAPI: Document auxvec AT_* namespace policy and note reservations
In-Reply-To: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
References: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
Date: Thu, 17 May 2018 16:40:19 +1000
Message-ID: <8736yqokdo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dave Martin <Dave.Martin@arm.com> writes:

> There are constraints on defining AT_* auxvec tags that are not
> obvious to the casual maintainer of either the global
> <uapi/linux/auxvec.h> or the arch-specific headers.  This is likely
> to lead to mistakes.  (I certainly fell foul of it...)

Thanks for cleaning this up.

It looks like us (powerpc) / me is the main offender here.

My excuse is it was glibc folk who asked us to add all those new AT_
entries in the first place. </buckpassing>

> For the benefit of future maintainers, this patch collects the
> relevant information in one place, documenting how the namespace
> needs to be managed, and noting all the values currently in use.
>
> Maintaining a global list may result in some merge conflicts, but
> AT_* values are not added frequently.  I'm open to suggestions on
> the best approach.

Yeah I agree with Rich that having a global list would be best. That is
the most reliable to make people think twice about adding new entries.

> I also assume that values 38 and 39 may have been used for
> historical purposes, such as an architecture that is no longer
> supported.  If they have definitely never been used for anything,
> they could be removed from the "reserved" list.

I don't know why we added the new entries starting at 40, maybe Ben
remembers. Quite likely it was just an accident.

I don't see any sign of 38 or 39 in glibc history.

cheers
