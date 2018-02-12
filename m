Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeBLTLM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:11:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:3871 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753866AbeBLTLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:11:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000";
   d="scan'208";a="203499943"
Date: Mon, 12 Feb 2018 12:15:19 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: drain the entered requests after ctrl is
 shutdown
Message-ID: <20180212191519.GD16255@localhost.localdomain>
References: <1518440222-652-1-git-send-email-jianchao.w.wang@oracle.com>
 <b466996e-b00a-e848-25a0-e6ba768a573f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b466996e-b00a-e848-25a0-e6ba768a573f@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 08:43:58PM +0200, Sagi Grimberg wrote:
> 
> > Currently, we will unquiesce the queues after the controller is
> > shutdown to avoid residual requests to be stuck. In fact, we can
> > do it more cleanly, just wait freeze and drain the queue in
> > nvme_dev_disable and finally leave the queues quiesced.
> 
> Does this fix a bug? What is the benefit of leaving the queues
> quiesced in shutdown?

This doesn't appear to fix anything. The things this patch does do are
either unnecessary (quiece), or already done elsewhere (wait freeze).
