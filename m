Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60455C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26297223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26297223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbeKMI3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:29:55 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:52320 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeKMI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:29:55 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gMKn2-00053X-BU from joseph_myers@mentor.com ; Mon, 12 Nov 2018 14:34:40 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 12 Nov 2018 22:34:36 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gMKmy-0004xj-Br; Mon, 12 Nov 2018 22:34:36 +0000
Date:   Mon, 12 Nov 2018 22:34:36 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Florian Weimer <fweimer@redhat.com>
CC:     Daniel Colascione <dancol@google.com>,
        Zack Weinberg <zackw@panix.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
In-Reply-To: <87lg5ym7qi.fsf@oldenburg.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1811122223350.18130@digraph.polyomino.org.uk>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com> <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com> <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com> <CAKCAbMiHC9r54h=XeW7CkBZ1Z5eHr9MPH3Rn7KTc9DjoHG=8UA@mail.gmail.com> <CAKOZuev7zqq+xpjyDA2mSdy-zwyNjECCzLsBELF6_v1rwar_mA@mail.gmail.com>
 <87lg5ym7qi.fsf@oldenburg.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Florian Weimer wrote:

> For that use case, a machine-readable system call ABI specification is
> the only reasonable approach: Some people want inline system calls,

I also think it's much more likely to be of use to glibc than any syscall 
library provided by the kernel.  I don't think a syscall library provided 
by the kernel is likely to be of use for implementing glibc functions, but 
some kind of textual ABI specification might at least be of use for 
checking that syscall macro calls / syscalls.list entries are consistent 
with what the kernel thinks its ABI is.  (Hopefully there would be 
automated tests on the kernel side as well of some kind of consistency 
between the ABI specification and the kernel.)

strace is indeed a more obvious potential consumer of such a description 
of syscall ABIs.

I'd think a syscall library would more likely be something a few 
applications would use if they want to access a syscall that for whatever 
reason glibc doesn't have a wrapper for yet - not something useful for 
glibc itself to call or link against.

> and for application programmer's sanity, make sure that the kernel adds
> generic system calls in a single version, across all architectures.

That would be strongly desirable for glibc as well - a way of ensuring 
that the kernel rapidly fails CI tests and does not get released if new 
syscalls are only present on some architectures (including e.g. being 
missing from some compat syscall tables, or defined in asm/unistd.h but 
not in the actual syscall table, or vice versa - or some way of making 
sure such inconsistencies cannot occur by eliminating duplicate copies of 
the syscall list information in the sources).

When we have compatibility code in glibc for the absence of some syscall, 
we can only eliminate that code when the oldest kernel version supported 
by glibc is new enough to have the syscall on whichever glibc architecture 
was slowest to introduce the syscall in the kernel - and that can often be 
years after the first architectures gained support for that syscall in the 
kernel.

-- 
Joseph S. Myers
joseph@codesourcery.com
