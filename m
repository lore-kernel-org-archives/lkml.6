Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbeCFQzW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:55:22 -0500
Received: from ale.deltatee.com ([207.54.116.67]:41260 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750782AbeCFQzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:55:20 -0500
To: "Oliver O'Halloran" <oohall@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
References: <20180306045647.7784-1-oohall@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <32ddc675-f12f-1a75-2dee-7edffc60d9c7@deltatee.com>
Date: Tue, 6 Mar 2018 09:55:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306045647.7784-1-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dan.j.williams@intel.com, hch@lst.de, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, oohall@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] kernel/memremap: Remove stale devres_free() call
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/03/18 09:56 PM, Oliver O'Halloran wrote:
> devm_memremap_pages() was re-worked in e8d513483300 to take a caller
> allocated struct dev_pagemap as a function parameter. A call to
> devres_free() was left in the error cleanup path which results in
> a kernel panic if the remap fails for some reason. Remove it
> to fix the panic and let devm_memremap_pages() fail gracefully.
> 
> Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface to use struct dev_pagemap")
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
> Both in-tree users of devm_memremap_pages() embed dev_pagemap into other
> structures so this shouldn't cause any leaks. Logan's p2p series does
> add one usage that assumes pgmap will be freed on error so that'll
> need fixing.

Yup, nice catch! I'll fix that for the next series.

Thanks,

Logan
