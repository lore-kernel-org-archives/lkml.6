Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A10C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADD520B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADD520B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeGJXVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:21:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732291AbeGJXVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3393470219;
        Tue, 10 Jul 2018 23:19:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B386111AF0A;
        Tue, 10 Jul 2018 23:19:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <dc5039cb-97cf-fe72-d601-f48eb26e8e66@schaufler-ca.com>
References: <dc5039cb-97cf-fe72-d601-f48eb26e8e66@schaufler-ca.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126254346.14533.14191961720018099798.stgit@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 08/32] smack: Implement filesystem context security hooks [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16479.1531264793.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jul 2018 00:19:53 +0100
Message-ID: <16480.1531264793@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 10 Jul 2018 23:19:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 10 Jul 2018 23:19:55 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > Implement filesystem context security hooks for the smack LSM.
> >
> > Question: Should the ->fs_context_parse_source() hook be implemented to
> > check the labels on any source devices specified?
> 
> Checking the label on a block device when doing a mount
> is just going to end in tears. If you're remounting from
> an already mounted filesystem it might make sense to check
> that the new mount doesn't provide greater access than the
> existing mount. If the original mount has smackfsdefault="_"
> I could see prohibiting the additional mount having
> smackfsdefault="*" on a filesystem that doesn't support
> xattrs. But that requires that a (hopefully) privileged
> process be involved, and we expect them to have a clue.
> So no, I don't see it necessary.

I think I may have meant the device file rather than the actual device
content.

David
