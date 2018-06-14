Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D3F74C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A90208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BEoRKXdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A90208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755282AbeFNPjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:39:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755027AbeFNPjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RYvcZmZfuv7tBCVDzH/4nWATB4lFciGKZLgmFkbdw5g=; b=BEoRKXdiBAhqxbY1YrjWOB1U0
        ya6f+QxK8Rc1nz3DV1am/EtuceWynLE6sTOWBJvglwi+Cvff33bI0rI/tyB7X+ANOYSyP9FLguEZ0
        El3AmRWbeBOiZmG39OsmZBlW3REybfildezFTT4xz5gF1Qr3W5myOnF0LuJW4+gMbg7/IXGXbeg8j
        VTSipL/3rKHGwVmpwiQKGv8J0tUJl/i8oKt5bk3SXHssxgLGW/vRSE+ys8pLWngjNVpF3ubotGOxu
        UQELUYhSJBEvHFEnkRAl5d1oFFjaaj9lwzbt+LstFcUwwDTjLYM8I+FWZFlVruhQsXnyKNHanWK4O
        KQGx+nGZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTULC-00025i-F6; Thu, 14 Jun 2018 15:39:14 +0000
Date:   Thu, 14 Jun 2018 08:39:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org,
        linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/3] scsi: ufs: Add ufs provisioning support
Message-ID: <20180614153914.GA3906@infradead.org>
References: <1528981432-23065-1-git-send-email-sayalil@codeaurora.org>
 <1528981432-23065-3-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528981432-23065-3-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 06:33:51PM +0530, Sayali Lokhande wrote:
> A new api ufshcd_do_config_device() is added in driver
> to support UFS provisioning at runtime. Configfs support
> is added to trigger provisioning.
> Device and Unit configurable parameters are parsed from
> vendor specific provisioning data or file and
> passed via configfs node at runtime to provision ufs device.
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>

Please make that code conditionally compiled based on a config option.
For most UFS users there is no need to ever enable it.
