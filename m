Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeC2Qiy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:38:54 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46638 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbeC2Qix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:38:53 -0400
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
 <a60ddb463159bcc287998ecfafdc2753973a4828.camel@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ec0f4fb3-33be-4343-0ee5-8fcb646e3345@deltatee.com>
Date: Thu, 29 Mar 2018 10:38:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a60ddb463159bcc287998ecfafdc2753973a4828.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, james.smart@broadcom.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Bart.VanAssche@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/18 10:14 AM, Bart Van Assche wrote:
> On Thu, 2018-03-29 at 10:07 -0600, Logan Gunthorpe wrote:
>> +	ret = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
>> +			    ((fod->io_dir == NVMET_FCP_WRITE) ?
>> +				    DMA_FROM_DEVICE : DMA_TO_DEVICE));
>> +			    /* note: write from initiator perspective */
> 
> If you have to repost this patch please remove the four superfluous parentheses.

Oh, actually, I made this change in patch 4 of this series for the next
time I post it. This allowed me to cleanup both the map and unmap
instances in the same patch.

Also, if the maintainer wants to pick up patch 3 as a bug fix I can
carry the rest in the P2PDMA series.

Thanks,

Logan
