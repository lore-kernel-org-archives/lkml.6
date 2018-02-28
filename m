Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934072AbeB1PyJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:54:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:34099 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934040AbeB1Pxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:53:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="23929307"
Date: Wed, 28 Feb 2018 08:53:53 -0700
From: Keith Busch <keith.busch@intel.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: assign separate irq vectors for adminq and ioq0
Message-ID: <20180228155353.GB16002@localhost.localdomain>
References: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180227151311.GD10832@localhost.localdomain>
 <9252f0a1-f3e5-414b-db49-e8053dfa48a6@oracle.com>
 <20180228152741.GA16002@localhost.localdomain>
 <8066e06c-90f4-c21b-e36f-89f6e8ca28c5@oracle.com>
 <cc46058f-bb7a-e108-c6e9-621daddae577@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc46058f-bb7a-e108-c6e9-621daddae577@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:46:20PM +0800, jianchao.wang wrote:
> 
> the irqbalance may migrate the adminq irq away from cpu0.

No, irqbalance can't touch managed IRQs. See irq_can_set_affinity_usr().
