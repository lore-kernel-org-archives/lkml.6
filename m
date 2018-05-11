Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeEKMUq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:20:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752857AbeEKMUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:20:44 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4eaa0e19-684c-bef8-5aea-ddb5ef30828e@canonical.com>
References: <4eaa0e19-684c-bef8-5aea-ddb5ef30828e@canonical.com> <152414466005.23902.12967974041384198114.stgit@warthog.procyon.org.uk> <152414469709.23902.10439448759049886690.stgit@warthog.procyon.org.uk>
To: John Johansen <john.johansen@canonical.com>
Cc: dhowells@redhat.com, kent.overstreet@gmail.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH 05/24] apparmor: Implement security hooks for the new mount API [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21732.1526041240.1@warthog.procyon.org.uk>
Date: Fri, 11 May 2018 13:20:40 +0100
Message-ID: <21733.1526041240@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Johansen <john.johansen@canonical.com> wrote:

> this looks good, and has pasted the testing that I have done so far. I
> have started on the work that will allow us to reorder the match but
> its not ready yet and shouldn't hold this up.

Excellent, thanks!

One thing to consider: Kent Overstreet mentioned the possibility of adding
support for multiple sources - something that his bcachefs would require.

>From the userspace PoV this could look something like:

	fd = fsopen("bcachefs");
	write(fd, "d /dev/sda1");
	write(fd, "d /dev/sda2");
	...

David
