Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE28C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB08240BE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB08240BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeF0G5m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:57:42 -0400
Received: from verein.lst.de ([213.95.11.211]:49072 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752054AbeF0G5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:57:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 609A768E45; Wed, 27 Jun 2018 09:07:45 +0200 (CEST)
Date:   Wed, 27 Jun 2018 09:07:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ye Xiaolong <xiaolong.ye@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org,
        viro@zeniv.linux.org.uk
Subject: Re: [lkp-robot] [fs]  3deb642f0d:  will-it-scale.per_process_ops
        -8.8% regression
Message-ID: <20180627070745.GA9765@lst.de>
References: <20180622082752.GX11011@yexl-desktop> <20180622150251.GA12802@lst.de> <20180626060338.GU12146@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626060338.GU12146@yexl-desktop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 02:03:38PM +0800, Ye Xiaolong wrote:
> Hi,
> 
> On 06/22, Christoph Hellwig wrote:
> >Hi Xiaolong,
> >
> >can you retest this workload on the following branch:
> >
> >    git://git.infradead.org/users/hch/vfs.git remove-get-poll-head
> >
> >Gitweb:
> >
> >    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/remove-get-poll-head
> 
> Here is the comparison for commit 3deb642f0d and commit 8fbedc1 ("fs: replace f_ops->get_poll_head with a static ->f_poll_head pointer") in remove-get-poll-head branch.

Especially the boot time ones and others look like they have additional
changes.

Can you compare the baseline of my tree, which is
894b8c00 ("Merge tag 'for_v4.18-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs") against 8fbedc1
(("fs: replace f_ops->get_poll_head with a static ->f_poll_head pointer") ?
