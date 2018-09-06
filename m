Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5B8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3351F20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3351F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbeIFTMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:12:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729735AbeIFTMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:12:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D16C2402332F;
        Thu,  6 Sep 2018 14:36:59 +0000 (UTC)
Received: from redhat.com (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with SMTP id 774B02027EA4;
        Thu,  6 Sep 2018 14:36:59 +0000 (UTC)
Date:   Thu, 6 Sep 2018 10:36:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] UAPI: virtio_net: Fix use of C++ keywords as
 structural members
Message-ID: <20180906101318-mutt-send-email-mst@kernel.org>
References: <20180905125636-mutt-send-email-mst@kernel.org>
 <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
 <153616289529.23468.7498785670556620808.stgit@warthog.procyon.org.uk>
 <9357.1536217759@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9357.1536217759@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 14:36:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 14:36:59 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 08:09:19AM +0100, David Howells wrote:
> Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> > As long as you do not intend to use any classes, how about
> > simply adding
> > 
> > -Dclass=_class
> > 
> > to your command line?
> 
> That kind of misses the point;-).  It's not reasonable to expect all userspace
> C++ users to do this.
> 
> David

I thought one of the points was that building kernel with c++ catches
some bugs, no?  If the point is to make life easier for c++ userspace
I'm not sure what we can do to be frank. C++ seems to be adding new
keywords with no restraint (C99 did it with inline and restrict too, but
it seems this stopped) so no good way to future-proof code for all
language dialects.

So I'd like to know which are the actual c++ users asking for this - we
can then accomodate the specific version they need.
Meanwhile people can get by with a wrapper along the lines of
#define class _class
#include <linux/virtio_net.h>
#undef class

-- 
MST
