Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rdmmAcChHlsoTAAAmS7hNA
	; Mon, 11 Jun 2018 16:24:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7279E607E7; Mon, 11 Jun 2018 16:24:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XgeNG2Z4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0D25E601C3;
	Mon, 11 Jun 2018 16:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D25E601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933470AbeFKQYZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:24:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933436AbeFKQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ji1MZmi3qf1UF67FG8Q+8qrsQTP0irFyIVZ7ybYJqcc=; b=XgeNG2Z4Kyp0D9TjRuqRJ7hh5
        aQcO62H0ArbCxkOjO0ehtTT2gw3Yrp8FTaPZk1SwBXpcFr3Gl5pliYlCYlrhiaXjlwA35wzoVNpJo
        Ml3Nk8Nu8f/MO3FLBbpJoi4PrpqUS+EjCdYeNNk00R6OBGd5wOcR4spcWHexg1kgAKMKFekkVyqW5
        WV6cIlA7/jf7LS2LtQYMqSPSIyAFfwjp8Ml0g3opPchNbauRhTT1z1d2CnoqH0G1oIoQGx9BkLVrt
        bDpf6Mqe6+I9Tt7Biw0p4OuaGKvXfjCqOVTbQccVdDDJEys1NBo+OQ9xlyAmdBI8W9US2AEF82MiI
        h7PrBy/Ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSPc5-0002wB-C6; Mon, 11 Jun 2018 16:24:13 +0000
Date: Mon, 11 Jun 2018 09:24:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/39] vfs: export vfs_ioctl() to modules
Message-ID: <20180611162412.GA7574@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-8-mszeredi@redhat.com>
 <20180604084904.GF11333@infradead.org>
 <20180610045657.GM30522@ZenIV.linux.org.uk>
 <CAJfpegtGtAR25qWgpNisvL8F51h3K6s44zkWBSVVbqecut6tBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtGtAR25qWgpNisvL8F51h3K6s44zkWBSVVbqecut6tBQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:19:01AM +0200, Miklos Szeredi wrote:
> We don't.  Obviously need to make sure to only ever do ioctl's in
> overlayfs that have a common definition across filesystems.  Not a lot
> of those, luckily...

Which are those?  If they are common and possibly called from kernel
code they should probably be made into methods instead.
