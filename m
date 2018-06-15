Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E312CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E14208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qn8/xPNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E14208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755907AbeFOHh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:37:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755577AbeFOHh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o/z6TtDSlniXLBY5f1NSZkTZCuudu3XXQyRYs5cvMok=; b=Qn8/xPNOG/JO9RjyK9fsWfKv2
        Q31ZHtr/pOpqIVL/VEL/uHFybNkHrO7gQaP5O8B4cDWsfbOLJYNv61kUrWrZDU5sId6cE/8wcqEHh
        CdG10z8Uaburao3WYoCoVhHLwk1R+FgoafvjbuLeJiwpxPd6Y6upJbTo+ixJLhfRkboScrFQT/O0l
        ItLtVy/4tXiHt+1D+U9lOFMWOZ18ne1IWOdqJbJgfMWlAxoHJehb2+W36v83tKjdjy/TeWqLfd8jj
        aCW7THPHZ/eRDnldzE6jCouZA2XjxEEq22dVIN7ZSeNyMO2kvlH+95sQK9WI5/vQ1qTDdkp4dZ4EA
        /mVghfmMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTjIx-0007iu-S5; Fri, 15 Jun 2018 07:37:55 +0000
Date:   Fri, 15 Jun 2018 00:37:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] Use sbitmap instead of percpu_ida
Message-ID: <20180615073755.GA22953@infradead.org>
References: <20180612190545.10781-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612190545.10781-1-willy@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, if you are on a spree to remove almost unused data structures
from target code, the lib/btree.c code is only used by the qla2xxx
target code, and doesn't really look like the best fit for it either.
