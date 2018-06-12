Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CB496C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B0F208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y/H4x5Ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B0F208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964797AbeFLDGx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:06:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935168AbeFLDGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xz7wr3n+tpyz8zXrsKfW5yxYXNUuax3fBirLrwaTYcQ=; b=Y/H4x5Ug4qUrvmaqu912jmgqC
        UIwKHjDA/FGA9tlps57RyN21l6rsPnFP6lQWWvAd7LVcJGx0e5emgsfqA7riXg2Rg3qqF9srTEFaK
        71EvF0tMLWZRhxAhwpMOu6eSSWdr48OPaa7/yuJWlKmXfyNRkAcEOLv20bTp25OmjFTvxdjHfBPJV
        2j2R237NAiuzXRT2Bs16prinNPvFcAHIrmA9lVown05uv6Yp+jvl8mJBVOru71Xbl59vlicWZSXbA
        CjRO1Bk1vUxmWT4iVGiP02kCtA5uLmLoVRE6syCfkowI8zxaK1TR/l9B+fd7hshT/LK6mFGvviDnV
        14qTdqKTA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSZdx-0002U2-33; Tue, 12 Jun 2018 03:06:49 +0000
Date:   Mon, 11 Jun 2018 20:06:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
Message-ID: <20180612030648.GA14222@bombadil.infradead.org>
References: <20180515160043.27044-1-willy@infradead.org>
 <20180515160043.27044-2-willy@infradead.org>
 <3a56027b-47bc-dcb8-a465-3670031572f1@kernel.dk>
 <02326395-3241-c94b-ad70-3de27a6f5a8c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02326395-3241-c94b-ad70-3de27a6f5a8c@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 07:18:55PM -0600, Jens Axboe wrote:
> Are you going to push this further? I really think we should.

Yes, I'll resubmit it tomorrow.  Sorry for dropping the ball on this one.
