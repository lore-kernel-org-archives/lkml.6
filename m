Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95057C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505AE21479
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505AE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbeKBIgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:36:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59419 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeKBIgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:36:54 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gIMR5-00057z-V3; Thu, 01 Nov 2018 23:31:36 +0000
Date:   Thu, 1 Nov 2018 20:31:30 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] nvme: create 'paths' entries for hidden controllers
Message-ID: <20181101233129.GB4249@calabresa>
References: <20180928191720.3461-1-cascardo@canonical.com>
 <20181005073245.GA24224@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005073245.GA24224@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 09:32:45AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 28, 2018 at 04:17:20PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > When using initramfs-tools with only the necessary dependencies to mount
> > the root filesystem, it will fail to include nvme drivers for a root on a
> > multipath nvme. That happens because the slaves relationship is not
> > present.
> > 
> > As discussed in [1], using slaves will break lsblk, because the slaves are
> > hidden from userspace, that is, they have no real block device, just an
> > entry under sysfs.
> > 
> > Introducing the paths subdir and using that on initramfs-tools makes it
> > possible to now boot a system with nvme multipath as root.
> 
> Do we need documentation how these paths links are supposed to work?
> Who is going to parse them?

Hi, Christoph.

I have just sent a v2 against block/for-next with a Documentation file
describing it. The first intended user is initramfs-tools, documented there as
well.

Thanks.
Cascardo.
