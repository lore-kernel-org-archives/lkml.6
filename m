Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeDDQri (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:47:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:53272 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbeDDQrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:47:37 -0400
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-3-logang@deltatee.com>
 <2fbc3260-6682-f789-9500-2961293ff3b4@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <17515a8d-df59-9bb7-0d51-a5134858db0a@deltatee.com>
Date: Wed, 4 Apr 2018 10:47:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2fbc3260-6682-f789-9500-2961293ff3b4@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: james.smart@broadcom.com, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/4] nvmet-rdma: Use new SGL alloc/free helper for
 requests
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2018 6:43 AM, Sagi Grimberg wrote:
> IIRC, this might result in nvmet-rdma executing data-transfer even
> for failed requests in some error cases. I'm not sure this is the
> only case, but have you tested what happens in error cases?

That's why I set transfer_len to zero when we exit this function on 
error (see the error_out label):

> +error_out:
> +    rsp->req.transfer_len = 0;
> +    return NVME_SC_INTERNAL; 

I haven't tested the error path, but I can. Is it sufficient to just 
change the code to create an error or do you know of a better way to 
test this?

Thanks,

Logan
