Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18452C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D774C2245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D774C2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbeKOEw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:52:26 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:53589 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeKOEw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:52:26 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gN0Cn-0005DP-0w from joseph_myers@mentor.com ; Wed, 14 Nov 2018 10:48:01 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 14 Nov 2018 18:47:57 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gN0Cj-0005hl-5M; Wed, 14 Nov 2018 18:47:57 +0000
Date:   Wed, 14 Nov 2018 18:47:57 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Daniel Colascione <dancol@google.com>
CC:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
In-Reply-To: <CAKOZuetCGCfNdJ2QM0phu3_3Q29f5Yeh=NHiM_A9MhHsCjK48A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811141840140.16571@digraph.polyomino.org.uk>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com> <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com> <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com> <20181113193859.GJ3505@e103592.cambridge.arm.com> <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com> <CAKOZuesta_V=doXsVLc2E6WCQvywdur3F+u2pFKaPN+CEQd+ZQ@mail.gmail.com>
 <alpine.DEB.2.21.1811141741000.16571@digraph.polyomino.org.uk> <CAKOZuetCGCfNdJ2QM0phu3_3Q29f5Yeh=NHiM_A9MhHsCjK48A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Daniel Colascione wrote:

> A good demonstration of a new commitment to pragmatism would be
> merging the trivial wrappers for gettid(2).

I support the addition of gettid (for use with those syscalls that take 
tids, and with appropriate documentation explaining the properties of 
tids) - and, generally, wrappers for all non-obsolescent 
architecture-independent Linux kernel syscalls, including ones that are 
very Linux-specific, except maybe for a few interfaces fundamentally 
inconsistent with glibc managing TLS etc. - they are, at least, no worse 
as a source of APIs than all the old BSD / SVID interfaces we have from 
when those were used as sources of APIs.

-- 
Joseph S. Myers
joseph@codesourcery.com
