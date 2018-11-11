Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D418C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568362087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568362087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeKKSFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 13:05:34 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:41825 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbeKKSFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 13:05:34 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wAB8HQRa030289;
        Sun, 11 Nov 2018 09:17:26 +0100
Date:   Sun, 11 Nov 2018 09:17:25 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181111081725.GA30248@1wt.eu>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 07:55:30AM +0100, Michael Kerrisk (man-pages) wrote:
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=6399 is a
>     longstanding example.

This one was a sad read and shows that applications will continue to
suffer from glibc's prehistorical view on operating systems and will
continue to have to define their own syscall wrappers to exploit the
full potential of the modern operating systems they execute on. This
reminds me when one had to write their own spinlocks and atomics many
years ago. Seeing comments suggesting an application should open
/proc/$PID makes me really wonder if people actually want to use slow
and insecure applications designed this way. Bah, after all, this
wipes quite a bit of the shame I feel every time I do something to
bypass it :-/

The sad thing is that the energy wasted arguing in the bug above could
have been better spent designing and implementing a generic solution
to expose syscalls without depending on glibc's politics anymore.

Willy
