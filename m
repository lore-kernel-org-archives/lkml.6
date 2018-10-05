Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268D5C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D0C2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D0C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeJEOaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:30:14 -0400
Received: from verein.lst.de ([213.95.11.211]:59398 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbeJEOaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:30:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 725D267357; Fri,  5 Oct 2018 09:32:45 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:32:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] nvme: create 'paths' entries for hidden controllers
Message-ID: <20181005073245.GA24224@lst.de>
References: <20180928191720.3461-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928191720.3461-1-cascardo@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 04:17:20PM -0300, Thadeu Lima de Souza Cascardo wrote:
> When using initramfs-tools with only the necessary dependencies to mount
> the root filesystem, it will fail to include nvme drivers for a root on a
> multipath nvme. That happens because the slaves relationship is not
> present.
> 
> As discussed in [1], using slaves will break lsblk, because the slaves are
> hidden from userspace, that is, they have no real block device, just an
> entry under sysfs.
> 
> Introducing the paths subdir and using that on initramfs-tools makes it
> possible to now boot a system with nvme multipath as root.

Do we need documentation how these paths links are supposed to work?
Who is going to parse them?
