Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCEDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09A021532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09A021532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbeITUPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:15:13 -0400
Received: from 72-48-214-68.dyn.grandenetworks.net ([72.48.214.68]:58754 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731223AbeITUPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:15:13 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2018 16:15:12 EDT
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id B23842260B;
        Thu, 20 Sep 2018 09:26:23 -0500 (CDT)
Subject: Re: [PATCH] RDMA/cxgb4: remove redundant null pointer check before
 kfree_skb
To:     zhong jiang <zhongjiang@huawei.com>, swise@chelsio.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537437162-42846-1-git-send-email-zhongjiang@huawei.com>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <bed2c4a0-cb14-83cf-ad90-ce4e7def8b1a@opengridcomputing.com>
Date:   Thu, 20 Sep 2018 09:26:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537437162-42846-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/2018 4:52 AM, zhong jiang wrote:
> kfree_skb has taken the null pointer into account. hence it is safe
> to remove the redundant null pointer check before kfree_skb.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 3 +--
>  drivers/infiniband/hw/cxgb4/qp.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Acked-by: Steve Wise <swise@opengridcomputing.com>
