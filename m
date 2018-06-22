Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0947924496
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0947924496
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933761AbeFVPT0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:19:26 -0400
Received: from verein.lst.de ([213.95.11.211]:57106 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933304AbeFVPTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:19:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F059568E45; Fri, 22 Jun 2018 17:28:50 +0200 (CEST)
Date:   Fri, 22 Jun 2018 17:28:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <xiaolong.ye@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [lkp-robot] [fs]  3deb642f0d:  will-it-scale.per_process_ops
        -8.8% regression
Message-ID: <20180622152850.GA14366@lst.de>
References: <20180622082752.GX11011@yexl-desktop> <20180622150251.GA12802@lst.de> <20180622151409.GA30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622151409.GA30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:14:09PM +0100, Al Viro wrote:
> >     http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/remove-get-poll-head
> 
> See objections upthread re "fs,net: move poll busy loop handling into a
> separate method"; as for the next one... I'd like an ACK from networking
> folks.  The rest of queue makes sense.

I want to see basic results first before micro-optimizing.  After that
I'll send it out to the net folks for feedback.
