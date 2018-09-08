Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05E9C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6BB206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6BB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIHUKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 16:10:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbeIHUKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 16:10:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04B58814F0A1;
        Sat,  8 Sep 2018 15:24:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 981B0101043B;
        Sat,  8 Sep 2018 15:24:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180907161023.GF5662@atomide.com>
References: <20180907161023.GF5662@atomide.com> <20180906164358.GI5659@atomide.com> <9053.1536310046@warthog.procyon.org.uk>
To:     Tony Lindgren <tony@atomide.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression in next with filesystem context concept
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11958.1536420266.1@warthog.procyon.org.uk>
Date:   Sat, 08 Sep 2018 16:24:26 +0100
Message-ID: <11959.1536420266@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 08 Sep 2018 15:24:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 08 Sep 2018 15:24:28 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote:

> > > Looks like next-20180906 now has a regression where mounting
> > > root won't work with commit fd0002870b45 ("vfs: Implement a
> > > filesystem superblock creation/configuration context").
> > 
> > Am I right in thinking you're not using any of the LSMs?
> 
> Assuming LSM as in Documentation/lsm.txt, right not using any.

The default return value for security_fs_context_parse_param() should be
-ENOPARAM, both in security.h and security.c.

I've fixed my tree and Al has pulled it, but we're now waiting on Stephen
Rothwell to refresh linux/next.

David
