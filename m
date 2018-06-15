Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5F8C4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB52208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OnQqRs7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB52208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965456AbeFOChf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:37:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965015AbeFOChd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BTpA1wMErZIXaW7KuJxgSpRZchpEnWiyH/BfQHvddd0=; b=OnQqRs7FgPQhULV8UGKEC/Dum
        N77uoyczvXtckzy9oqerUmE5uaedW/y9fuImSHGYzUC3jP8u1J1Mt0aSnRe6yn9rxulnQJZgY2zbA
        TXrBjlWLJ8Ws/aDRPl6LZhEAc7xhetGRaRxtQHH/8sk0IexNAJ8Oelqf8+rGphReD48cjRib6KD4n
        21bupz9nbSM3loBqpZEDW1v4mug4b/Jrt1F1CDNkzF8XIdbGKW7/mQr2k3pcFFJ5eFeyC348K6gAZ
        vwBKa3VAEeEFidimeQM+HD8I9X5fqN+OwKM4CjYQ2DXfLcWYIy/gw+v196njk7WE9gyQqNHdwJLML
        87lTrWdNg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTecF-0003Nl-En; Fri, 15 Jun 2018 02:37:31 +0000
Date:   Thu, 14 Jun 2018 19:37:31 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] Use sbitmap instead of percpu_ida
Message-ID: <20180615023731.GA5706@bombadil.infradead.org>
References: <20180612190545.10781-1-willy@infradead.org>
 <yq136xols59.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq136xols59.fsf@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:06:58PM -0400, Martin K. Petersen wrote:
> 
> Matthew,
> 
> > Removing the percpu_ida code nets over 400 lines of removal.  It's not
> > as spectacular as deleting an entire architecture, but it's still a
> > worthy reduction in lines of code.
> 
> Since most of the changes are in scsi or target, should I take this
> series through my tree?

I'd welcome that.  Nick seems to be inactive as target maintainer;
his tree on kernel.org hasn't seen any updates in five months.

Thanks!
