Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91B8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D4620844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D4620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeIGUwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:52:02 -0400
Received: from muru.com ([72.249.23.125]:55414 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbeIGUwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:52:02 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E823880CF;
        Fri,  7 Sep 2018 16:14:28 +0000 (UTC)
Date:   Fri, 7 Sep 2018 09:10:23 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression in next with filesystem context concept
Message-ID: <20180907161023.GF5662@atomide.com>
References: <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9053.1536310046@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells <dhowells@redhat.com> [180907 08:51]:
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > Looks like next-20180906 now has a regression where mounting
> > root won't work with commit fd0002870b45 ("vfs: Implement a
> > filesystem superblock creation/configuration context").
> 
> Am I right in thinking you're not using any of the LSMs?

Assuming LSM as in Documentation/lsm.txt, right not using any.

BTW, I don't think this issue shows up with ramdisk either,
so that's probably why for example kernelci.org does not
show errors.

Regards,

Tony
