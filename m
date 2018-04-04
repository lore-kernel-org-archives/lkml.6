Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDDO1s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:27:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:63393 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751167AbeDDO1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:27:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,406,1517904000";
   d="scan'208";a="30650430"
Date: Wed, 4 Apr 2018 08:30:27 -0600
From: Keith Busch <keith.busch@intel.com>
To: "Eric H. Chang" <echang@sk.com>
Cc: Christoph Hellwig <hch@lst.de>, Baegjae Sung <baegjae@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-multipath: implement active-active round-robin
        path selector
Message-ID: <20180404143027.GE4485@localhost.localdomain>
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
 <20180328194741.GJ13039@localhost.localdomain>
 <CAB2tqtvZ6zQ60jca7W4uKka2LfavsW=oKhTx9Gv0sXR7-SBUVg@mail.gmail.com>
 <20180330070651.GA17095@lst.de>
 <e22676055aca4e8d936b7479d6301d85@skt-tnetpmx2.SKT.AD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22676055aca4e8d936b7479d6301d85@skt-tnetpmx2.SKT.AD>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 09:04:46AM +0000, Eric H. Chang wrote:
> We internally call PCIe-retimer as HBA. It's not a real Host Bus Adapter that translates the interface from PCIe to SATA or SAS. Sorry for the confusion.

Please don't call a PCIe retimer an "HBA"! :)

While your experiment is setup to benefit from round-robin, my only
concern is it has odd performance in a real world scenario with
IO threads executing in different nodes. Christoph's proposal will
naturally utilize both paths optimally there, where round-robin will
saturate node interlinks.

Not that I'm against having the choice; your setup probably does represent
real use. But if we're going to have multiple choice, user documentation
on nvme path selectors will be useful here.
