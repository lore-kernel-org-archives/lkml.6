Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD70C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8A6208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jbroqMJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8A6208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH0WtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:49:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44532 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeH0WtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:49:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7RIxUgq097233;
        Mon, 27 Aug 2018 19:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kuJzdlxHk6CebePCOorWWuX/D/cxPRZXdw5sY3EOwwU=;
 b=jbroqMJVLjfkIZuLaqUVjqMWkPndTNDGbmdXU7EIbPN4ZRkJtex1pDFg8d1jFoGqzfVd
 nzasruNLfzVV7KlCXhBy1s2LOYle5KR2C4jAoX61aU3MmwmoZ9r/bplYeqrrS1O32t4N
 b1wuBBLkItV8WKuUEm1dhaXJ2R7YroF2ujdrfK3XdxINxhHhLrqT7tN+OtFVwouWYop2
 2tVc0vaTByM9qJTmxtHGtOjNZPCk80CzxBzYS/LbISvo1jI0SZTOPkw2GwDFKzAMZ0mM
 4wV6Sd1nhF66kyQNjT2DJ7KloG+5Ac6+yd27h6jRBL75zzACHOOV7uZ7lVMM/2lxliK7 8w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m2yrpypy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 19:00:56 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7RJ0stC007877
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 19:00:55 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7RJ0qRr019601;
        Mon, 27 Aug 2018 19:00:52 GMT
Received: from char.us.oracle.com (/10.152.35.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Aug 2018 12:00:52 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 1DE786A0112; Mon, 27 Aug 2018 15:00:51 -0400 (EDT)
Date:   Mon, 27 Aug 2018 15:00:51 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: swiotlb cleanup (resend)
Message-ID: <20180827190051.GD14594@char.us.oracle.com>
References: <20180725113802.18943-1-hch@lst.de>
 <20180827181309.GA3834@0021ccb48c25>
 <20180827183308.GA496@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827183308.GA496@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808270195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:33:08PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 27, 2018 at 02:13:11PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Wed, Jul 25, 2018 at 01:37:56PM +0200, Christoph Hellwig wrote:
> > > Hi Konrad,
> > > 
> > > below are a few swiotlb patches.  Mostly just cleanups, but the removal
> > > of the panic option is an actual change in (rarely used) functionality.
> > > 
> > > I'd be happy to pick them up through the dma-mapping tree if you are
> > > fine with that.
> > 
> > Hey,
> > 
> > I put them in my 'devel/for-linus-4.19' as I would like to make
> > sure that they work just fine with Xen-SWIOTLB and some baremetal
> > machines.
> 
> I actually have a new version of these combined with merging
> arm64 support into the main swiotlb ops.  Please hold off a bit for
> now.

<nods>
