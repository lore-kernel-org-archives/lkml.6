Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbeCFTJj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:09:39 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42115 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753308AbeCFTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:09:36 -0500
X-Google-Smtp-Source: AG47ELtVEYt7WaiB4mAzgoNaub3YvF7u+UBy9nTyIuontoXa26GbziXsWnTYossjZ00jPvwqiRPJFfQuwuwntjw8Ycg=
MIME-Version: 1.0
In-Reply-To: <32ddc675-f12f-1a75-2dee-7edffc60d9c7@deltatee.com>
References: <20180306045647.7784-1-oohall@gmail.com> <32ddc675-f12f-1a75-2dee-7edffc60d9c7@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Mar 2018 11:09:35 -0800
Message-ID: <CAPcyv4gMahR82SOUBKd5sNHexFq0y6iwWkKfjjv-S+Osw8+2BA@mail.gmail.com>
Subject: Re: [PATCH] kernel/memremap: Remove stale devres_free() call
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 8:55 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 05/03/18 09:56 PM, Oliver O'Halloran wrote:
>>
>> devm_memremap_pages() was re-worked in e8d513483300 to take a caller
>> allocated struct dev_pagemap as a function parameter. A call to
>> devres_free() was left in the error cleanup path which results in
>> a kernel panic if the remap fails for some reason. Remove it
>> to fix the panic and let devm_memremap_pages() fail gracefully.
>>
>> Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface to
>> use struct dev_pagemap")
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks, applied.
