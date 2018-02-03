Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-154589-1517637525-2-14838459280703676609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517637524; b=QQWGUpoaSeIej5ddw3vp2LnXOUQ0wHoTs8f5DvqqFeUniq5
    5Frh3Zmk9wXWR3G+4kpbtdxGO6CnxezPsRMPbW9pmyq4YgUAiyQsS42ZOYN6oV7i
    JuqHxQwqhUOEtD+G38Kh9OBU8+0Dm8zc3dQ9nP21jDnErmZQwBE35QeLqX4KN8/S
    cL3Kk3L9Ty7fBzTAKseJzs8WJ2B3AhhUKLOYZ8yme3APxIv2rRJ/nGPypDr4hm0y
    DhmBs9nxhUYnpCgkGxt/VVtUXPz8Td9/4Q6HYEjkkj/Z6BR5zGqHtyTyw5IFC441
    os03N4KDrbx80slpmG5E2b4rXQgnP9HGa7csccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517637524; bh=5BWX5a5n2Hnaw/JeAP/0ozUyAzJKkO4o+T4r5+YVEtk=; b=R
    3IRz1Juj1wu31cB0MSP8AziGFYsAIWF8OvJ1OeJXV/gSnWcyKZ7RdF6okMZGj/Nh
    EoA9/KjMsDiYgiVsu/ZN9ZJC1TDSnzQKv6O/LZEcJA2ca6sg6C/mUDQKQ5Znw1ft
    UdWBqFExXzCd1ceQbu+zI9uexG9uHXePPAgoov2Gh7UQJcV7Svpv6qlTfQnnTUem
    OyjgOTNfnIgDea1TRJVuYNAQj9N17mJSXi6ML1L7j0IsI0k+0VTq3Ir9VJkMKNc4
    NiFG2UnSPeq8sPbTq/Kx4gGPVaUO2EWeZTw7ubpSorSX8Wg18Sn0Th6Zwp44o2rr
    G3eLDIbo6sD10J6DonyCA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qKBRec5y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f+NMJVLc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qKBRec5y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f+NMJVLc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750740AbeBCF6g (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 00:58:36 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34156 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBCF6f (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 00:58:35 -0500
X-Google-Smtp-Source: AH8x226Zxe/FtAqRCaDTY/l+0morrVt6Db4VgVQsH2Jk10LVJ/YKYJ8L4t1FXCZch0YhmnLA+3R/CQ==
Date: Sat, 3 Feb 2018 15:58:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: alexander.levin@verizon.com,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable\@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 3.18 36/40] powerpc/xmon: Avoid tripping SMP
 hardlockup watchdog
Message-ID: <20180203155822.01e2e34b@roar.ozlabs.ibm.com>
In-Reply-To: <87h8r47yl1.fsf@concordia.ellerman.id.au>
References: <20171213015905.7059-1-alexander.levin@verizon.com>
        <20171213015905.7059-36-alexander.levin@verizon.com>
        <87lgi6ai40.fsf@concordia.ellerman.id.au>
        <20171213134453.4sbmin2tjprrjnty@sasha-lappy>
        <87h8r47yl1.fsf@concordia.ellerman.id.au>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 30 Jan 2018 15:35:54 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> alexander.levin@verizon.com writes:
> 
> > On Thu, Dec 14, 2017 at 12:10:39AM +1100, Michael Ellerman wrote:  
> >>alexander.levin@verizon.com writes:
> >>  
> >>> From: Nicholas Piggin <npiggin@gmail.com>
> >>>
> >>> [ Upstream commit 064996d62a33ffe10264b5af5dca92d54f60f806 ]
> >>>
> >>> The SMP hardlockup watchdog cross-checks other CPUs for lockups, which
> >>> causes xmon headaches because it's assuming interrupts hard disabled
> >>> means no watchdog troubles. Try to improve that by calling
> >>> touch_nmi_watchdog() in obvious places where secondaries are spinning.
> >>>
> >>> Also annotate these spin loops with spin_begin/end calls.  
> >>
> >>These macros didn't exist until 4.13, and haven't been backported AFAIK.  
> >
> > But the touch_nmi_watchdog() bits are something we want in stable, right?  
> 
> I don't think you need them unless you've also back ported
> arch/powerpc/kernel/watchdog.c, which I don't think you have.
> 
> Maybe Nick can confirm?

I'm not 100% sure. The CPUs only check themselves for lockups. They will
blow their threshold when in xmon, but when they come out of xmon, I think
by a quirk of our local_irq_enable() implementation that actually checks
timers explicitly and runs them first before re-enabling hard interrupts,
then our heartbeat starts up again just before the perf interrupt would
come in to report the lockup.

I think.

Given that we've had no reports of misbehaviour of the old perf watchdog,
I would say you can skip the backport.

Thanks,
Nick
