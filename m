Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387529-1526575471-2-17732174411620286230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526575465; b=eLQXGxTF6RjE6g/pcyo/KoqjdvIkXIRzSmFxrwLu7aHB1fbjKX
    xWza0i37QH5zDVLgOlYMiQHjSR8rYTDti/qTNdYIduPsGFGxG78ueyg0tl4VKBme
    CgzL9vSOmdczXsY0/0n2t0476CRMbp9caAk2hYC8j1p999eb4rspX2JybGJ4hVEs
    VnMY0heLNhU7a+ngJelh19sK04X2jmmfCrZhrILf4jcflbhN/PFRjdatQHsytIEA
    2OLRqoNa7OdXXz64kj+bVaREAfrLvOrDJ4ef0WSuPhFT0igK0M6mn2+XwrHPQh3q
    39Dkbd0Kt61DAKVsOhi4eXIE/U/mgJj2+FLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :subject:sender:list-id; s=fm2; t=1526575465; bh=xiVHje/0g8m0PRz
    PQF+SftjFu7WLHi1jMZDCpceigjc=; b=MjVv1swhDk37Ai1XMLNGRk7XkOxrc37
    H6SjtFEkAsBbUjfU/R+ooMo/HZOhsIvIglcwP5mtU22BGL8ZCGccOzgSpKpIzHot
    BhNirdn8W1XTWs9MdfgetPXOF7Hn1oZ3f4GT4thhB60H/J3Cu/J275MAJn1Ubuh6
    up76VOYUIbHCHTzHtcw5neuz/Bv37gAqqwXFqp5pFZt0eXXArMvlcmdWXDVPjNPf
    4DDBYncKWrgxV9vlK0o5rvfzSZTpLHTLezGM+kDqxnd2ycrstJgMUEU3bS7jjp0l
    gPLtg+5A7fcyLYGJep6AJnzQ1LwRU3g/e7tLyA//M1iD/uxe2NOLdQQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=opteya.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=opteya.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=opteya.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=opteya.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDYiak0ewsfa5fbZNVSBgH3nKs3bKcdfeUwasZaBRMzRKfStLzNqCZCjEtm4KmsgGFSUahIf5V5ur6YlvEoi9PoTxpErjlGnGWavlaaibFaqpbmTaRcz
    k705vQhpR1ZD12A3PLpFuwKSwWst+pOKL5sEyeBB8/S2vqmvqXmoYGHexqPl0i9cRE1aiFUlVbiRdQqMcgxuectMNXouR1V5unkW8LWPvAHn8D7sXY7JCyE0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=GcyzOjIWAAAA:8 a=VwQbUJbxAAAA:8 a=CCpqsmhAAAAA:8 a=uZvujYp8AAAA:8
    a=NjSbwwVobzkeZmvLg38A:9 a=QEXdDO2ut3YA:10 a=MzO75494WNQA:10 a=ZJS8QRBZMWAA:10
    a=JMmSJqSQVT4A:10 a=x8gzFH9gYPwA:10 a=Eb_T4WrUtxUA:10
    a=hQL3dl6oAZ8NdCsdz28n:22 a=AjGcO6oz07-iQ99wixmX:22 a=ul9cdbp4aOFLsgKbc677:22
    a=SLzB8X_8jTLwj6mN0q5r:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeEQQne (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 12:43:34 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:36022 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbeEQQnb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 May 2018 12:43:31 -0400
Message-ID: <a30a44883d7cf06c4bb06feb33784905497b234c.camel@opteya.com>
From: Yann Droneaud <ydroneaud@opteya.com>
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
        Michael Ellerman <mpe@ellerman.id.au>,
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
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Date: Thu, 17 May 2018 18:00:28 +0200
In-Reply-To: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
References: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 82.251.90.223
X-SA-Exim-Mail-From: ydroneaud@opteya.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ou.quest-ce.net
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham version=3.3.2
Subject: Re: [RFC PATCH] UAPI: Document auxvec AT_* namespace policy and
 note reservations
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Le mercredi 16 mai 2018 à 15:20 +0100, Dave Martin a écrit :
> There are constraints on defining AT_* auxvec tags that are not
> obvious to the casual maintainer of either the global
> <uapi/linux/auxvec.h> or the arch-specific headers.  This is likely
> to lead to mistakes.  (I certainly fell foul of it...)
> 
> For the benefit of future maintainers, this patch collects the
> relevant information in one place, documenting how the namespace
> needs to be managed, and noting all the values currently in use.
> 
> Maintaining a global list may result in some merge conflicts, but
> AT_* values are not added frequently.  I'm open to suggestions on
> the best approach.
> 
> I also assume that values 38 and 39 may have been used for
> historical purposes, such as an architecture that is no longer
> supported.  If they have definitely never been used for anything,
> they could be removed from the "reserved" list.
> 

Some of those AT_* values are described in getauxval(3) man-page:

http://man7.org/linux/man-pages/man3/getauxval.3.html

https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man3/g
etauxval.3?id=4eae8eb731386d81797d5c30365426722410874e

And glibc provides <elf.h> with definitions for almost all AT_*,
regardless of the current target architecture:

https://sourceware.org/git/?p=glibc.git;a=blob;f=elf/elf.h;h=954f3266f7
11ab83996670ea504a17dcf668e061;hb=23158b08a0908f381459f273a984c6fd32836
3cb#l1135

Also, despite not being listed as a reserved namespace by POSIX, one
should try to avoid name collision with other AT_ constants,
those used with *at() functions (openat(), etc.):

- AT_EACCESS 
- AT_EMPTY_PATH
- AT_FDCWD
- AT_NO_AUTOMOUNT
- AT_REMOVEDIR
- AT_STATX_DONT_SYNC
- AT_STATX_FORCE_SYNC
- AT_STATX_SYNC_AS_STAT
- AT_SYMLINK_FOLLOW
- AT_SYMLINK_NOFOLLOW

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/fcntl.h.html

http://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.htm
l#tag_15_02_02

https://sourceware.org/git/?p=glibc.git;a=blob;f=io/fcntl.h;h=3d239e8f0
9f7ce0a3106621be327e1ea4cd1a3e7;hb=23158b08a0908f381459f273a984c6fd3283
63cb#l142

And there's also AT_ANYNET and AT_ANYNODE from ddp (aka. AppleTalk)

http://man7.org/linux/man-pages/man7/ddp.7.html

Regards.

-- 
Yann Droneaud
OPTEYA

