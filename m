Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB92C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8275A21722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8275A21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeKLSDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:03:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeKLSDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:03:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BF54308A974;
        Mon, 12 Nov 2018 08:11:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-147.ams2.redhat.com [10.36.116.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE38D608F6;
        Mon, 12 Nov 2018 08:11:15 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
        <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
        <877ehjx447.fsf@oldenburg.str.redhat.com>
        <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
Date:   Mon, 12 Nov 2018 09:11:10 +0100
In-Reply-To: <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
        (Daniel Colascione's message of "Sun, 11 Nov 2018 06:22:59 -0800")
Message-ID: <875zx2vhpd.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 12 Nov 2018 08:11:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Colascione:

> If the kernel provides a system call, libc should provide a C wrapper
> for it, even if in the opinion of the libc maintainers, that system
> call is flawed.

It's not that simple, I think.  What about bdflush?  socketcall?
getxpid?  osf_gettimeofday?  set_robust_list?  There are quite a few
irregularities, and some editorial discretion appears to be unavoidable.

Even if we were to provide perfectly consistent system call wrappers
under separate names, we'd still expose different calling conventions
for things like off_t to applications, which would make using some of
the system calls quite difficult and surprisingly non-portable.

Thanks,
Florian
