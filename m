Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBIRIa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:08:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:42458 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeBIRI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:08:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,483,1511856000";
   d="scan'208";a="16519059"
Date: Fri, 9 Feb 2018 10:12:31 -0700
From: Keith Busch <keith.busch@intel.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6]nvme-pci: fixes on nvme_timeout and
 nvme_dev_disable
Message-ID: <20180209171231.GB6970@localhost.localdomain>
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
 <073ce416-fd26-b41a-187d-1db9210c48b0@grimberg.me>
 <20180208175606.GD5039@localhost.localdomain>
 <db5fe34b-3ffb-a658-d4d6-a1c619b2d590@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5fe34b-3ffb-a658-d4d6-a1c619b2d590@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 09:50:58AM +0800, jianchao.wang wrote:
> 
> if we set NVME_REQ_CANCELLED and return BLK_EH_HANDLED as the RESETTING case,
> nvme_reset_work will hang forever, because no one could complete the entered requests.

Except it's no longer in the "RESETTING" case since you added the
"CONNECTING" state, so that's already broken for other reasons...
