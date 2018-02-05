Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeBEPJb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:09:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:21162 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbeBEPJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:09:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,465,1511856000";
   d="scan'208";a="27411002"
Date: Mon, 5 Feb 2018 08:13:14 -0700
From: Keith Busch <keith.busch@intel.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown
 and reset case
Message-ID: <20180205151314.GP24417@localhost.localdomain>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
 <20180202182413.GH24417@localhost.localdomain>
 <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 10:26:03AM +0800, jianchao.wang wrote:
> > Freezing is not just for shutdown. It's also used so
> > blk_mq_update_nr_hw_queues will work if the queue count changes across
> > resets.
> blk_mq_update_nr_hw_queues will freeze the queue itself. Please refer to.
> static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,

Yes, but how many requests are you letting enter to their demise by
freezing on the wrong side of the reset? We don't use the nuclear option
out of convenience.
