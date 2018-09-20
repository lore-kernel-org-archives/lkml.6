Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4209ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A98F2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A98F2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeITWFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:05:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbeITWFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:05:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE535285B1;
        Thu, 20 Sep 2018 16:21:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89C3581C1A;
        Thu, 20 Sep 2018 16:20:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <875zz0jvfs.fsf@concordia.ellerman.id.au>
References: <875zz0jvfs.fsf@concordia.ellerman.id.au> <20180919094847.2103082b@canb.auug.org.au> <20180919073826.02370812@canb.auug.org.au> <20180910133525.28c5dd20@canb.auug.org.au> <15925.1537309041@warthog.procyon.org.uk> <3565.1537336860@warthog.procyon.org.uk> <20180919163102.1a0adefb@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31224.1537460458.1@warthog.procyon.org.uk>
Date:   Thu, 20 Sep 2018 17:20:58 +0100
Message-ID: <31225.1537460458@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 20 Sep 2018 16:21:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> wrote:

> I realise these are in samples rather than selftests, but what most of
> the selftests do is just #define the syscall number if it's not defined,
> so that you're not dependent on getting the headers.

The reason I don't want to do that is that syscall numbers aren't consistent
across arches - they aren't even consistent within arches.

I've made the VFS samples contingent on X86 in Kconfig for the moment.

David
