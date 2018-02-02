Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754388AbeBBSUo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:20:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:12052 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752964AbeBBSU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:20:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="28354757"
Date: Fri, 2 Feb 2018 11:24:13 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown
 and reset case
Message-ID: <20180202182413.GH24417@localhost.localdomain>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 03:00:45PM +0800, Jianchao Wang wrote:
> Currently, request queue will be frozen and quiesced for both reset
> and shutdown case. This will trigger ioq requests in RECONNECTING
> state which should be avoided to prepare for following patch.
> Just freeze request queue for shutdown case and drain all the resudual
> entered requests after controller has been shutdown.

Freezing is not just for shutdown. It's also used so
blk_mq_update_nr_hw_queues will work if the queue count changes across
resets.
