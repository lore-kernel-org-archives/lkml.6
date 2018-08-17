Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45012C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E576621878
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E576621878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHQKLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:11:23 -0400
Received: from verein.lst.de ([213.95.11.211]:34231 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeHQKLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:11:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BC35768EF0; Fri, 17 Aug 2018 09:10:09 +0200 (CEST)
Date:   Fri, 17 Aug 2018 09:10:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Wnukowski <wnukowski@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        keith.busch@linux.intel.com, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>, yigitfiliz@google.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Bugfix for handling of shadow doorbell buffer.
Message-ID: <20180817071009.GB11383@lst.de>
References: <20180814221735.62804-1-wnukowski@google.com> <20180814225716.GA3224@localhost.localdomain> <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com> <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 06:35:16PM -0700, Michal Wnukowski wrote:
> 
> The other side in this case is not actual controller hardware, but 
> virtual one (the regular hardware should rely on normal MMIO 
> doorbells).

There could very much be real hardware there.  We've made it clear
in the spec that while a typical use case is a virtualized controller
there is nothing peventing hardware implementations.  There have
been previous hardware prototypes to use very similar tricks, e.g.:

https://www.usenix.org/node/179878
