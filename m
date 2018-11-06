Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9341B2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="CVRi8YQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9341B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbeKGIR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:17:28 -0500
Received: from imap.thunk.org ([74.207.234.97]:46280 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeKGIR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PcmNTpkMkdyOkU8A9/FFG4e0nvkX7NoDET5vJ5K0UqQ=; b=CVRi8YQv78EP5IHYIBamhes0lz
        x8QVwOFHBQgNPyCUef2p2FwWeOgscTEwtxb5T/809HWR60v6DApmM0Ih57R08dd10sbPakraxu/C9
        s3yDhJgISfAo7VZHJMEqAq+eViieZQic7kXJGZk9si8eJJB3VKpOCXDYLpdxlGR8CEl0=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKAAV-0006GQ-Ha; Tue, 06 Nov 2018 22:49:55 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8CA397A7C2B; Tue,  6 Nov 2018 17:49:54 -0500 (EST)
Date:   Tue, 6 Nov 2018 17:49:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] ext4: remove useless brelse call in
 ext4_xattr_inode_update_ref()
Message-ID: <20181106224954.GI2570@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <fb87bcc2-5e4a-34ba-a063-3f43e9de976c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb87bcc2-5e4a-34ba-a063-3f43e9de976c@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:58:46AM +0300, Vasily Averin wrote:
> brelse(iloc.bh) is useless here, it is always called with iloc.bh = NULL
> 
> Fixes dec214d00e0d ("ext4: xattr inode deduplication") # 4.13
> cc: Tahsin Erdogan <tahsin@google.com>
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Applied.  I droppped the "Fixes" since it's really not needed for
stable kernel; this is really more of a cleanup.  I used the commit
description:

    ext4: remove unneeded brelse call in ext4_xattr_inode_update_ref()

    	  	 	  	      - Ted
