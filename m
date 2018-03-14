Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCNMGf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:06:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeCNMGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:06:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Mar 2018 08:06:32 -0400
From: okaya@codeaurora.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <20180314041249.GA18314@ziepe.ca>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-3-git-send-email-okaya@codeaurora.org>
 <20180314041249.GA18314@ziepe.ca>
Message-ID: <c65f0d329aa50067a2c57ed71bba9131@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-14 00:12, Jason Gunthorpe wrote:
> On Tue, Mar 13, 2018 at 11:20:24PM -0400, Sinan Kaya wrote:
>> Code includes wmb() followed by writel() in multiple places. writel()
>> already has a barrier on some architectures like arm64.
>> 
>> This ends up CPU observing two barriers back to back before executing 
>> the
>> register write.
>> 
>> Since code already has an explicit barrier call, changing writel() to
>> writel_relaxed().
>> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>  drivers/infiniband/hw/qedr/verbs.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Sure matches my understanding of writel_relaxed
> 
> This is part of a series, should we take just this patch through the
> rdma tree? If not:
> 
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Feel free to take pieces.


> 
> Thanks,
> Jason
