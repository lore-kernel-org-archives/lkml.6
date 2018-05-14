Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932224AbeENNer (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:34:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:52534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752142AbeENNep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:34:45 -0400
Date: Mon, 14 May 2018 15:34:42 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: fix lockdep warning in
 nvme_mpath_clear_current_path
Message-ID: <20180514133442.dyvveuxkaeithb4r@linux-x5ow.site>
References: <20180514121312.13624-1-jthumshirn@suse.de>
 <20180514124230.GA654@infradead.org>
 <20180514133105.GU26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180514133105.GU26088@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 06:31:05AM -0700, Paul E. McKenney wrote:
> If you are just looking at the value of an RCU-protected pointer, then
> using rcu_access_pointer() will cause RCU to just read out the value
> and otherwise keeps its mouth shut.
> 
> If you use rcu_access_pointer() and later dereference the value without
> protection, you will of course get what you deserve, good and hard.  ;-)

Thanks Paul.

Christoph, I'll be sending the v2 probably tomorrow as I have more
lockdep fixes for nvme in the pipe and I'll send them out as a
complete series.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
