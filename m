Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE2DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754C921EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754C921EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbeHIS7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:59:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730419AbeHIS7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:59:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08C797A7EB;
        Thu,  9 Aug 2018 16:33:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFF2010F1BF9;
        Thu,  9 Aug 2018 16:33:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegvWE9htLjqeR6=2BWBSuvJzJpWcjBC_EmX_k1RCGXTfbw@mail.gmail.com>
References: <CAJfpegvWE9htLjqeR6=2BWBSuvJzJpWcjBC_EmX_k1RCGXTfbw@mail.gmail.com> <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk> <153313723557.13253.9055982745313603422.stgit@warthog.procyon.org.uk> <87in4n9zg0.fsf@xmission.com> <27374.1533824694@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/33] vfs: syscall: Add fsconfig() for configuring and managing a context [ver #11]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13159.1533832400.1@warthog.procyon.org.uk>
Date:   Thu, 09 Aug 2018 17:33:20 +0100
Message-ID: <13160.1533832400@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 09 Aug 2018 16:33:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 09 Aug 2018 16:33:22 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > However, as I have said, I *am* willing to add one of more flags to help
> > with this, but I can't make any "legacy" fs honour them as this requires
> > the fs_context to be passed down to sget_fc() and the filesystem - which
> > is why I was considering leaving it for later.
>
> You can determine at fsopen() time whether the filesystem is able to
> support the O_EXCL behavior?  If so, then it's trivial to enable this
> conditionally.  I think that's what Eric is asking for, it's obviously
> not fair to ask for a change in behavior of the legacy interface.

What do you mean by "enable it conditionally"?  It cannot be enabled for
filesystems that don't pass fs_context down to sget().

mount(2) mustn't enable it lest it break userspace.

fsopen(2) can let userspace set a flag to enable it.

David
