Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074B922419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074B922419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeKODoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:44:39 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:51366 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeKODoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:44:39 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gMz9K-00065w-GP from joseph_myers@mentor.com ; Wed, 14 Nov 2018 09:40:22 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 14 Nov 2018 17:40:19 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gMz9G-0004lr-LC; Wed, 14 Nov 2018 17:40:18 +0000
Date:   Wed, 14 Nov 2018 17:40:18 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Daniel Colascione <dancol@google.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
In-Reply-To: <1C1B38FC-1266-4A91-B8F6-20A0C49ED1E2@amacapital.net>
Message-ID: <alpine.DEB.2.21.1811141735070.16571@digraph.polyomino.org.uk>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com> <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com> <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com> <20181113193859.GJ3505@e103592.cambridge.arm.com> <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
 <1C1B38FC-1266-4A91-B8F6-20A0C49ED1E2@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="-1152306461-174479658-1542217218=:16571"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---1152306461-174479658-1542217218=:16571
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

On Wed, 14 Nov 2018, Andy Lutomirski wrote:

> I’m not so sure it’s useless. Historically, POSIX systems have, in 
> practice and almost by definition, been very C focused, but the world is 
> changing. A less crufty library could be useful for newer languages:

Historically, there was once an attempt to rework POSIX into a separate 
language-independent definition and language bindings (for C, Fortran, Ada 
etc.), but I don't think it got anywhere, and it's probably doubtful 
whether the idea was ever very practical.  (See the introduction to 
POSIX.1:1990, for example: "Future revisions are expected to contain 
bindings for other programming languages as well as for the C language.  
This will be accomplished by breaking this part of ISO/IEC 9945 into 
multiple portions---one defining core requirements independent of any 
programming language, and others composed of programming language 
bindings.".)

> > thread internals for syscalls that
> > require coordination between all user created
> > threads (setxid),
> 
> We should just deal with this in the kernel. The current state of 
> affairs is nuts.

Yes, we should have a few new syscalls to set these ids at the process 
level.

-- 
Joseph S. Myers
joseph@codesourcery.com
---1152306461-174479658-1542217218=:16571--
