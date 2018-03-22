Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCVVZU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:25:20 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34460 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCVVZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:25:18 -0400
X-Google-Smtp-Source: AG47ELtVaCynhVUt+3tEM2tsKzbLcwoS24lIke+ufzQ/nBpRs7EAnvG/UlVe5nAVtTb32J915DR1eA==
Date: Thu, 22 Mar 2018 15:25:10 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Casey Leedom <leedom@chelsio.com>
Cc: SWise OGC <swise@opengridcomputing.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "'kbuild test robot'" <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Steve Wise <swise@chelsio.com>, "'Doug Ledford'" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Werner <werner@chelsio.com>
Subject: Re: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
Message-ID: <20180322212510.GE9469@ziepe.ca>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
 <03d201d3c1eb$b71fb460$255f1d20$@opengridcomputing.com>
 <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>
 <52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
 <BY2PR1201MB098352CB012D8AE8084882F3C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
 <20180322201649.GC9469@ziepe.ca>
 <BY2PR1201MB098367F8F217A8BF66AE68B6C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY2PR1201MB098367F8F217A8BF66AE68B6C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 08:45:11PM +0000, Casey Leedom wrote:

> I'm guessing~ that this line in the documentation ~may~ imply the GCC
> ordering:
> 
>      ... Note that relaxed accesses to
>      the same peripheral are guaranteed to be ordered with respect to each
>      other. ...

An arch can't guarentee "ordered with respect to each other" without
preventing the compiler from re-ordering, so yes, any correct
implementation of writel_relaxed must prevent compiler re-ordering.

eg with volatile or a compiler barrier, or whatever.

> In any case, we really only have a few places where we (the various Chelsio
> drivers) need to worry about this: the "Fast Paths" where we have a lot of
> I/O to the device.  I think we should leave everything else alone.

Yes.

Jason
