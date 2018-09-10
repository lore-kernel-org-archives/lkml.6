Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED07C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7EE20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7EE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeIJVD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:03:27 -0400
Received: from muru.com ([72.249.23.125]:55752 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeIJVD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:03:27 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E2A8D80B6;
        Mon, 10 Sep 2018 16:12:44 +0000 (UTC)
Date:   Mon, 10 Sep 2018 09:08:36 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression in next with filesystem context concept
Message-ID: <20180910160836.GT5662@atomide.com>
References: <20180907161023.GF5662@atomide.com>
 <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
 <11959.1536420266@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11959.1536420266@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells <dhowells@redhat.com> [180908 15:28]:
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > > > Looks like next-20180906 now has a regression where mounting
> > > > root won't work with commit fd0002870b45 ("vfs: Implement a
> > > > filesystem superblock creation/configuration context").
> > > 
> > > Am I right in thinking you're not using any of the LSMs?
> > 
> > Assuming LSM as in Documentation/lsm.txt, right not using any.
> 
> The default return value for security_fs_context_parse_param() should be
> -ENOPARAM, both in security.h and security.c.
> 
> I've fixed my tree and Al has pulled it, but we're now waiting on Stephen
> Rothwell to refresh linux/next.

OK thanks for tracking that down, next-20180910 boots again
for me.

Regards,

Tony
