Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032830AbeCAQIr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:08:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:53500 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031777AbeCAQIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:08:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="33890401"
Date: Thu, 1 Mar 2018 09:10:42 -0700
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
Message-ID: <20180301161042.GA14799@localhost.localdomain>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <20180301150329.GB6795@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301150329.GB6795@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:03:30PM +0800, Ming Lei wrote:
> If all CPUs for the 1st IRQ vector of admin queue are offline, then I
> guess NVMe can't work any more.

Yikes, with respect to admin commands, it appears you're right if your
system allows offlining CPU0.

> So looks it is a good idea to make admin queue's IRQ vector assigned as
> non-managed IRQs.

It'd still be considered managed even if it's a 'pre_vector', though
it would get the default mask with all possible CPUs.
