Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7654C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2DF208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2DF208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbeGKP5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:57:02 -0400
Received: from ms.lwn.net ([45.79.88.28]:40396 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732411AbeGKP5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:57:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E70217DA;
        Wed, 11 Jul 2018 15:52:02 +0000 (UTC)
Date:   Wed, 11 Jul 2018 09:51:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
Message-ID: <20180711095159.08e5435c@lwn.net>
In-Reply-To: <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
        <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 23:44:09 +0100
David Howells <dhowells@redhat.com> wrote:

> 	sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> 	write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg
> 	write(sfd, "o noatime");
> 	write(sfd, "o acl");
> 	write(sfd, "o user_attr");
> 	write(sfd, "o iversion");
> 	write(sfd, "o ");
> 	write(sfd, "r /my/container"); // root inside the fs
> 	write(sfd, "x create"); // create the superblock

A minor detail but ... the "r" operation mentioned above is not actually
implemented in this system call.

jon
