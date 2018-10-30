Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC2C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DA220657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e5Xo3UBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DA220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJaBqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:46:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeJaBqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xuLioHbLphynXpSDo3PR4aDJTxzK9RI6VnpK+vGqijU=; b=e5Xo3UBKd0LHdh6Xc8IED2mMN
        lyA4JdCQBTAmPHnZx1x7gkMmI+apD2DLOKIsZIu7wkCtid8neHca2q887s3eD9NZ82e3304dXsExS
        L3qsVVP25JZi4pHgY1wm3rhW4TgKH25mlEBImaGJZh45drXrYYD60zdLNGBb7x0uDklt1wXqTLFs1
        ZanzVkfllZ9T0kWewBemD7kmrln8hWwlEevpM1mw1uhTW89dmEVuZFV6hHsvA1Slci9N5g2ncwHOa
        DI6sEuf9+92+nYi8lmuFvYzAcTJn0SLCpDxXpYUqeUwS19eFqoyOunIF4ZUekbozH4GmrE8/v47sO
        DdKdKO4CA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHXFf-0003Lb-0Q; Tue, 30 Oct 2018 16:52:23 +0000
Date:   Tue, 30 Oct 2018 09:52:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Improve virtio ID allocation
Message-ID: <20181030165222.GA10491@bombadil.infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
 <20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:53:39PM +0100, Gerd Hoffmann wrote:
> On Wed, Sep 26, 2018 at 09:00:27AM -0700, Matthew Wilcox wrote:
> > I noticed you were using IDRs where you could be using the more efficient
> > IDAs, then while fixing that I noticed the lack of error handling,
> > and I decided to follow that up with an efficiency improvement.
> > 
> > There's probably a v2 of this to follow because I couldn't figure
> > out how to properly handle one of the error cases ... see the comment
> > embedded in one of the patches.
> 
> #1 + #2 pushed to drm-misc-next now.
> #3 should not be needed any more.
> waiting for v2 of #4 ...

Thanks!  I think we do still need a small part of #3.  Patches in
replies to this email.
