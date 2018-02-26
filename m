Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeBZP6Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:58:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:60198 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbeBZP6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:58:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="20897517"
Date: Mon, 26 Feb 2018 08:58:30 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] nvme-pci: set cq_vector to -1 if io queue setup fails
Message-ID: <20180226155829.GA10832@localhost.localdomain>
References: <1518693221-2430-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518693221-2430-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 07:13:41PM +0800, Jianchao Wang wrote:
> nvme cq irq is freed based on queue_count. When the sq/cq creation
> fails, irq will not be setup. free_irq will warn 'Try to free
> already-free irq'.
> 
> To fix it, set the nvmeq->cq_vector to -1, then nvme_suspend_queue
> will ignore it.

Applied with updates to change log and removing the miscellaneous white
space changes.
