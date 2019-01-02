Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0191FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF48218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfABJi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:38:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbfABJi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:38:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4497B46233;
        Wed,  2 Jan 2019 09:38:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAA7660C68;
        Wed,  2 Jan 2019 09:38:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181226061856.GA2122@avx2>
References: <20181226061856.GA2122@avx2> <20181226030642.72757-1-kjlu@umn.edu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     dhowells@redhat.com, Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: proc: check status of register_filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27135.1546421935.1@warthog.procyon.org.uk>
Date:   Wed, 02 Jan 2019 09:38:55 +0000
Message-ID: <27136.1546421935@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 02 Jan 2019 09:38:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > -	register_filesystem(&proc_fs_type);
> > +	if (register_filesystem(&proc_fs_type))
> > +		pr_err("failed to register the filesystem.\n");
> 
> No, register_filesystem() should do it.

+1

David
