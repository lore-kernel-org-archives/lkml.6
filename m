Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0631EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2E020C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2E020C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbeGKQXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:23:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732721AbeGKQXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:23:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 363B081A4EAF;
        Wed, 11 Jul 2018 16:18:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D3B41C662;
        Wed, 11 Jul 2018 16:18:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180711095159.08e5435c@lwn.net>
References: <20180711095159.08e5435c@lwn.net> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14218.1531325881.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jul 2018 17:18:01 +0100
Message-ID: <14219.1531325881@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 16:18:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 16:18:04 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote:

> A minor detail but ... the "r" operation mentioned above is not actually
> implemented in this system call.

Yeah, that's something I'd like to add.  NFS4 already does this inside its
->mount() method, so my thought is that we might be able to move this from
there to the core.

David
