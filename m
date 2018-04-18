Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbeDRPGb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:06:31 -0400
Received: from verein.lst.de ([213.95.11.211]:60824 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752749AbeDRPG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:06:29 -0400
Date: Wed, 18 Apr 2018 17:07:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix the suspicious RCU usage warning in
        nvme_mpath_clear_current_path
Message-ID: <20180418150710.GB7862@lst.de>
References: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com> <20180418144524.GL11513@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418144524.GL11513@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 08:45:25AM -0600, Keith Busch wrote:
> Nothing against this patch. This just doesn't look correct even from
> before since nvme_find_path can set head->current_path right back to
> this namespace that we're trying to clear.
> 
> Christoph, am I missing something here or does this need additional
> checks/synchronization?

Yes, we should probably call it after removing the namespace from
the ns_head list, instead of right before.
