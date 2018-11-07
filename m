Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B364C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DC720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="m8FjoKgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DC720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeKHBj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:39:28 -0500
Received: from imap.thunk.org ([74.207.234.97]:49392 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeKHBj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7AE4OJ7IwM64nMxZd3So8NMXiXZM3kqZ8yoD3EgR4AQ=; b=m8FjoKgNBF0RXrkRc+MotJwfzQ
        NsQDQV6ZbJ4W/T98BWNHG781diwOo6FI4R+qHuxFX07PZSebJ5jFlhtwpl3fp0/Ihc6Jd4G3Ls34N
        kis4Q5v8eStMD9pacjCgHWcP5rEeteafzEbMlDXxISeoPQHoK4IYpWviUwo4fsOxxicQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKQNX-0000WK-Ps; Wed, 07 Nov 2018 16:08:27 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E60FF7A7D14; Wed,  7 Nov 2018 11:08:26 -0500 (EST)
Date:   Wed, 7 Nov 2018 11:08:26 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Tiger Yang <tiger.yang@oracle.com>
Subject: Re: [PATCH 5/7] ext4: bs.bh cleanup before re-using in
 ext4_xattr_block_find()
Message-ID: <20181107160826.GF9919@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Tiger Yang <tiger.yang@oracle.com>
References: <cover.1541011937.git.vvs@virtuozzo.com>
 <1a83ea26-a159-490a-1e07-e7c8f187672a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a83ea26-a159-490a-1e07-e7c8f187672a@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:12:52PM +0300, Vasily Averin wrote:
> bs.bh was taken in previous ext4_xattr_block_find() call,
> it should be released before re-using
> 
> Fixes 7e01c8e5420b ("ext3/4: fix uninitialized bs in ...") # 2.6.26
> cc: Tiger Yang <tiger.yang@oracle.com>
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks, applied.  I used the commit description:

    ext4: release bs.bh before re-using in ext4_xattr_block_find()

    	  	  	       		   - Ted
