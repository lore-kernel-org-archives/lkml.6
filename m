Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97630C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D2F20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D2F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeKHSvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:51:04 -0500
Received: from verein.lst.de ([213.95.11.211]:53761 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKHSvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:51:03 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B3D3068C38; Thu,  8 Nov 2018 10:16:28 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:16:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] nvme: create 'paths' entries for hidden controllers
Message-ID: <20181108091628.GA4217@lst.de>
References: <20181101232955.19329-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101232955.19329-1-cascardo@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 08:29:55PM -0300, Thadeu Lima de Souza Cascardo wrote:
> When using initramfs-tools with only the necessary dependencies to mount
> the root filesystem, it will fail to include nvme drivers for a root on a
> multipath nvme. That happens because the slaves relationship is not
> present.
> 
> As discussed in [1], using slaves will break lsblk, because the slaves are
> hidden from userspace, that is, they have no real block device, just an
> entry under sysfs.

I wonder if the better way would be to unhide the slaves, but always
have a claim on them, so that others can't really use them?  While the
hiding idea seamed very neat it seems to cause a fair amount of problems
after all.
