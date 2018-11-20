Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E14C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009AB206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YHk8MyXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009AB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeKUDFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:05:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55168 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeKUDFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:05:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAKGY7ju097457;
        Tue, 20 Nov 2018 16:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qKj78wwkoTbA2c5GvuXOfhnao08lS9Joiojynra3Bdw=;
 b=YHk8MyXn/MFnK2dSUtr/t74WjkJ7vuGChwDheYX+/tM5eOYAeBR0Cwl7a3k/oUE2gBNe
 FfaKXz47Jhs9HGnjg2eqlG3eTIxcWlzofmGviwW069h4yiOsVC0wUt4ETkh1i4oVcgtF
 Dcnkm5abyCyEOs0DGgmr99SBE3dSGcx0pPD+dPa8cMdLjT8RGj+1TYpX7VBkZkIiXgVr
 2M8Lc9fmpg71rulXq1gvCMbER15zUV/SkubQ6bVDM5PqLiEiRddAa8jMuG+wDbAOBe3U
 B7cDqVDTO+o/h1mNI68hH+xtUJink/Dr9CmuSKC9SLjLWrNPGeZAsfOsncx014F9SJ51 RA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ntadtw0mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 16:34:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAKGYhAj017797
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 16:34:44 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAKGYgZ9006492;
        Tue, 20 Nov 2018 16:34:43 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Nov 2018 08:34:42 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id AA2BF6A00D4; Tue, 20 Nov 2018 11:34:41 -0500 (EST)
Date:   Tue, 20 Nov 2018 11:34:41 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
Message-ID: <20181120163441.GD31199@char.us.oracle.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <20181120160818.GC2492@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120160818.GC2492@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=873
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811200147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 05:08:18PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 20, 2018 at 02:09:51PM +0000, Robin Murphy wrote:
> > This is what I have so far, which at least resolves the most ovbious
> > problems. I still haven't got very far with the USB corruption issue
> > I see on Juno with -rc1, but I'm yet to confirm whether that's actually
> > attributable to the SWIOTLB changes or something else entirely.
> 
> This looks good modulo the minor nitpicks.
> 
> Konrad, are you ok with me picking up both through the dma-mapping
> tree?

Yes, albeit I would want Stefano to take a peek at patch #2 just in case.

