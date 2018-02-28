Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeB1Qra (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:47:30 -0500
Received: from verein.lst.de ([213.95.11.211]:54470 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753058AbeB1Qr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:47:28 -0500
Date: Wed, 28 Feb 2018 17:47:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq
        and ioq0
Message-ID: <20180228164726.GB16536@lst.de>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that we originally allocates irqs this way, and Keith changed
it a while ago for good reasons.  So I'd really like to see good
reasons for moving away from this, and some heuristics to figure
out which way to use.  E.g. if the device supports more irqs than
I/O queues your scheme might always be fine.
