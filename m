Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeDDMgt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:36:49 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:42645 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDDMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:36:48 -0400
X-Google-Smtp-Source: AIpwx4+1dSebRYHMxeRSDkZwwPCznd9IzH+qP4+F7YzT10tIm3DrjzI2kTMjWEGo7wnRhnZPqya9aA==
Subject: Re: [PATCH] nvme-multipath: implement active-active round-robin path
 selector
To: Christoph Hellwig <hch@lst.de>, Baegjae Sung <baegjae@gmail.com>
Cc: keith.busch@intel.com, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a8574e1c-d749-3abd-bc7d-2d6010087993@grimberg.me>
Date: Wed, 4 Apr 2018 15:36:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328080646.GB20373@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> For PCIe devices the right policy is not a round robin but to use
> the pcie device closer to the node.  I did a prototype for that
> long ago and the concept can work.  Can you look into that and
> also make that policy used automatically for PCIe devices?

I think that active/active makes sense for fabrics (link throughput
aggregation) but also for dual-ported pci devices (given that
this is a real use-case).

I agree that the default can be a home-node path selection.
