Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC0AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E417D20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfBHQ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:57:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:37662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfBHQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:57:36 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 11:57:35 EST
Received: (qmail 6048 invoked by uid 109); 8 Feb 2019 16:50:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 16:50:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25440 invoked by uid 111); 8 Feb 2019 16:51:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 11:51:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 11:50:52 -0500
Date:   Fri, 8 Feb 2019 11:50:52 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Message-ID: <20190208165052.GC23461@sigill.intra.peff.net>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 06:08:33AM -0500, Randall S. Becker wrote:

> t5318 is rather problematic and I have no good way to fix this. There
> is no /dev/zero on the platform, and the corrupt_graph_and_verify
> hard-codes if=/dev/zero, which is a linux-specific pseudo device.
> Please provide a more platform independent way of testing this
> feature. Pretty much all subtests from 46 onward fail as a result.

We did discuss this at the time of the patch, but it seems we already
use /dev/zero in a bunch of places:

  https://public-inbox.org/git/xmqqbm57rkg5.fsf@gitster-ct.c.googlers.com/

Were you just skipping the other tests before?

-Peff
