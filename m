Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10A1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CE42083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CE42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965653AbeFSIkn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:40:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756158AbeFSIkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:40:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12F268151D42;
        Tue, 19 Jun 2018 08:40:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-111.rdu2.redhat.com [10.10.121.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA4462026D68;
        Tue, 19 Jun 2018 08:40:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180619112140.58be35dd@canb.auug.org.au>
References: <20180619112140.58be35dd@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the overlayfs tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22144.1529397638.1@warthog.procyon.org.uk>
Date:   Tue, 19 Jun 2018 09:40:38 +0100
Message-ID: <22145.1529397638@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 19 Jun 2018 08:40:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 19 Jun 2018 08:40:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

>  /* These sb flags are internal to the kernel */
>  #define MS_SUBMOUNT     (1<<26)
> -#define MS_NOREMOTELOCK	(1<<27)
>  #define MS_NOSEC	(1<<28)
>  #define MS_BORN		(1<<29)
>  #define MS_ACTIVE	(1<<30)

Ummm...  Can MS_NOREMOTELOCK be removed?  I know it's listed in the internal
flags section, but all of these have been exposed to userspace for over a
year.  Ideally, I'd remove all of these from UAPI, but can anyone guarantee
that no pieces of userspace refer to them?

David
