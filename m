Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeC2Qax (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:30:53 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46568 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbeC2Qav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:30:51 -0400
To: James Smart <james.smart@broadcom.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
 <03cb3610-8ec7-9dc4-9e0a-82f4c30de578@broadcom.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5ba62675-39b4-6409-5628-c59d8ae048de@deltatee.com>
Date: Thu, 29 Mar 2018 10:30:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <03cb3610-8ec7-9dc4-9e0a-82f4c30de578@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, james.smart@broadcom.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/18 10:24 AM, James Smart wrote:
> Signed-off-by: James Smart  <james.smart@broadcom.com>

Thanks James.

> As for "not used anywhere", be careful as the structure being prepped is 
> passed from the nvme-fc transport to an underlying lldd. So the 
> references would likely be in the lldd.

Can you elaborate? The 'data_sg_cnt' member was in 'struct
nvmet_fc_fcp_iod' which is declared in fc.c so it doesn't seem sane for
lower driver to access it... In fact the next patch in the series
removes it completely.

Logan
