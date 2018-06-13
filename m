Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B569BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7AE208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YOmil6c8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7AE208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964786AbeFMStJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:49:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935219AbeFMStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eOo5Ou83jTMWw3TezSV/xJEczEVjYtRkJP4XjIMG4Us=; b=YOmil6c8GWkdqtjoJEzW6ImAFw
        MH9XM9HCjaGQBs3Oc5SH/6+8dDQQaYiGTCUofwvYCtcIIqphboNxEpXxNUgQEv4YgB6o0L8biDF/Q
        LD/1AmD5hc18Gpm73cBdkykXpK+wXO9/0Q5R2wx8tWaSSXWAu4T4Szj3igCCbCMc9bQrDZhkdZ8Nv
        NtM2jUZG58mGJLEKAAItJR0ABWG/6G/MqaIXYcW87HqD11fnA3uCQBA5RtkdbWsLGdwBeX3L0RAxF
        n/fotNFv1v3S/oDl4KdgN2F7LM9vXqzkqpTogKK03o2DCOTuVffSKpZjrEg69hV+uQEEJqJq1C7I/
        WPKhNtsA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTApL-00048I-KQ; Wed, 13 Jun 2018 18:49:03 +0000
Date:   Wed, 13 Jun 2018 11:49:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] IDR: Expose the XArray lock
Message-ID: <20180613184903.GA22381@bombadil.infradead.org>
References: <20180613123403.25233-1-willy@infradead.org>
 <20180613123403.25233-2-willy@infradead.org>
 <20180613173057.GA27281@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180613173057.GA27281@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 11:30:57AM -0600, Jason Gunthorpe wrote:
> Hmm, what do I need to apply this?
> 
> drivers/infiniband/core/mad.c: In function ‘ib_register_mad_agent’:
> drivers/infiniband/core/mad.c:387:34: error: ‘struct idr’ has no member named ‘idr_xa’; did you mean ‘idr_rt’?
>   idr_lock(&ib_mad_clients);
>                                   ^     
>                                   idr_rt
> 
> Linus's master (be779f03d563981)  doesn't seem to have idr_xa?

*groan*.  My fault.  I just sent a replacement 1/2.  Sorry!
