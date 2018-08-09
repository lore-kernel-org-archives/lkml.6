Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267FEC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC52122392
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC52122392
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeHIWdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:33:08 -0400
Received: from fieldses.org ([173.255.197.46]:49056 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeHIWdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:33:08 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 598E11E3A; Thu,  9 Aug 2018 16:06:44 -0400 (EDT)
Date:   Thu, 9 Aug 2018 16:06:44 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net:svc_rdma_transport: remove unneeded variable
 'ret' in rdma_listen_handler
Message-ID: <20180809200644.GN23873@fieldses.org>
References: <1533640809-1221-1-git-send-email-zhongjiang@huawei.com>
 <1533640809-1221-2-git-send-email-zhongjiang@huawei.com>
 <2c343d78-e668-1b97-a4e6-228296da0d70@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c343d78-e668-1b97-a4e6-228296da0d70@Netapp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:49:11AM -0400, Anna Schumaker wrote:
> (Adding Bruce since he takes nfs / sunrpc server patches)

Applied, thanks.--b.

> 
> On 08/07/2018 07:20 AM, zhong jiang wrote:
> > The ret is not modified after initalization, So just remove the variable
> > and return 0.
> > 
> > Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> > ---
> >  net/sunrpc/xprtrdma/svc_rdma_transport.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > index 547b2cd..2848caf 100644
> > --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > @@ -296,7 +296,6 @@ static int rdma_listen_handler(struct rdma_cm_id *cma_id,
> >  			       struct rdma_cm_event *event)
> >  {
> >  	struct sockaddr *sap = (struct sockaddr *)&cma_id->route.addr.src_addr;
> > -	int ret = 0;
> >  
> >  	trace_svcrdma_cm_event(event, sap);
> >  
> > @@ -315,7 +314,7 @@ static int rdma_listen_handler(struct rdma_cm_id *cma_id,
> >  		break;
> >  	}
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static int rdma_cma_handler(struct rdma_cm_id *cma_id,
> > 
