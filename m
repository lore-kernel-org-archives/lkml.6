Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeDJIrE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:47:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751992AbeDJIrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:47:03 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
References: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: Re: [PATCH] uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19744.1523350020.1@warthog.procyon.org.uk>
Date: Tue, 10 Apr 2018 09:47:00 +0100
Message-ID: <19745.1523350020@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> Since this header is in "include/uapi/linux/", apparently people
> want to use it in userspace programs -- even in C++ ones.
> However, the header uses a C++ reserved keyword ("private"),
> so change that to "dh_private" instead to allow the header file
> to be used in C++ userspace.
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=191051

Ugh.  Yeah.  This is a UAPI breaker, but I think we have to do it, despite it
being 2 years old.  Maybe wrap that element in a #ifdef so it's still allowed
in C?

cc'ing Mat Martineau as he's the originator of the structure.

David
