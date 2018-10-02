Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527CCC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BAD20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ddGi4l5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BAD20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeJBVkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:40:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeJBVkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Si4c1CMudt/+BoxUKrnvH/SoFDhoc2Bv7Mr/78nmwno=; b=ddGi4l5c+R8gIpoB683dObJnD
        kpr9bjKrQnPL5YrIQB4KS8Ft9nfNlRXBBw99vL0/IMhQ2aPVP01Ja3nDGN7B/2txfYUmwx4791rbz
        +o0W4fKy0/DoMJZBVVDOBjaodMjpgmxpVnnY3JtsVTKuAoHmEQp5tum0X48UHBXUIe37gEwBfM5pV
        v5qvzGUJd5el/oxcPOswbpV/XmdYYP1PQ4MMDROJu23tuQKvr9LUl+MvY0w13Ham29lOloAfxdy93
        lCxBbclOsH4F+Bfy/9EhOYbN/0aHKKKI/3egSz9xf9YG9y26Ro3Kk03xB+fVjR13thby3D/4wNJDq
        BYAj97yRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7M5t-0005AU-LK; Tue, 02 Oct 2018 14:56:13 +0000
Date:   Tue, 2 Oct 2018 07:56:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
Message-ID: <20181002145613.GA11156@infradead.org>
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b12992-3570-4646-374b-82cbd7276839@acm.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 06:16:32PM -0700, Bart Van Assche wrote:
> Boaz, the most recent osd patch that is neither trivial nor treewide
> refactoring is six years old (51976a8c85ce ("[SCSI] osd_uld: Add osdname &
> systemid sysfs at scsi_osd class"). That suggests that nobody is using this
> driver anymore. Can this driver be removed from the kernel tree?

Last time we tried to exofs and the osd code Boaz complained loudly,
but as far as I can tell it really is not used and bitrotting, so we
should finally go ahead and drop it.
