Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC81C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B692185B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B692185B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeHQJ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:56:25 -0400
Received: from verein.lst.de ([213.95.11.211]:34058 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeHQJ4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:56:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 26A2E70573; Fri, 17 Aug 2018 08:55:14 +0200 (CEST)
Date:   Fri, 17 Aug 2018 08:55:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Bart van Assche <bart.vanassche@wdc.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
        groups
Message-ID: <20180817065514.GC11170@lst.de>
References: <20180814073305.87255-1-hare@suse.de> <20180814073305.87255-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 09:33:02AM +0200, Hannes Reinecke wrote:
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I only reviewed the original patch without the lightnvm additions.
Please drop reviewed-by tags if you make non-trivial changes.

In this case I also wonder if you should have just kept the original
patch as-is and added a new one for lightnvm.
