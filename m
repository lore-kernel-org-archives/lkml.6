Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C94C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B57223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="oPwRQliG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B57223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbeKMA2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:28:55 -0500
Received: from imap.thunk.org ([74.207.234.97]:45956 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeKMA2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3+7QyY3MLdp4z/8AaWca3nf86q43vXRoldp+QtPjis4=; b=oPwRQliGjJ2SOfDRL464xjc3e+
        hzXIDYEheI6bzxenB1XonoknKTDXDGVwtATy742onUNZgGF+/Y1RFrKrWOuXBWOU91klsYLyp5NcV
        rnd/211bXQHNjgjfZ1Rk7wnGFY3rXeo/BwKRXB7UANawyjnxVAPA22WJH7LofsgbTWcs=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gMDIy-00009e-22; Mon, 12 Nov 2018 14:35:08 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 64E677A47B5; Mon, 12 Nov 2018 09:35:06 -0500 (EST)
Date:   Mon, 12 Nov 2018 09:35:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>, nd <nd@arm.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181112143506.GC7377@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>, nd <nd@arm.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <45cf58e0-909e-262c-5b9f-b91d62350a79@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45cf58e0-909e-262c-5b9f-b91d62350a79@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:45:26PM +0000, Szabolcs Nagy wrote:
> >> A lot of the new system calls lack clear specifications or are just
> >> somewhat misdesigned.  For example, pkey_alloc
> > [snip]
> >> getrandom still causes boot delays

I'll note that what some people consider misdesigns, others consider
"fix CVE's".

Some people may consider it more important to avoid boot delays;
others would consider internet-wide security problems, ala
https://factorable.net to be higher priority.

It's clear this is one area where I and some glibc developers have had
a difference of opinion.  The bigger problem is that if a single glibc
developer is able to veto any new system call, maybe we *do* need to
have a kernel-provided library which bypasses glibc....

						- Ted
