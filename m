Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F223AC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA46320857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="CWraBq44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA46320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeKHNLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 08:11:52 -0500
Received: from imap.thunk.org ([74.207.234.97]:51976 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbeKHNLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 08:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VdnifWpRuHlJSdG5kgRUk1JXaAPnOVejGDxqroOywzw=; b=CWraBq44Ht+15jUo8my/SBn/rM
        HKzdZohJO/NdcFUhbHF5s80n6CizYcmRq88D2xlumxwKsNuStAiLSlOVwMJCDEqh9kqfgYZQngFZM
        JBPx9LY3W9FJZrnwAxSW/ZgiBqbbr0GmmAPogiXQmbJRUsu5gSUGAwr6Jq4H8EreLzlE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKb9H-0005r9-2o; Thu, 08 Nov 2018 03:38:27 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A7F017A7D2B; Wed,  7 Nov 2018 22:38:25 -0500 (EST)
Date:   Wed, 7 Nov 2018 22:38:25 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: lost brelse in __ext4_read_dirblock()
Message-ID: <20181108033825.GD22459@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <6e5c9e17-5916-7296-35a0-cc0600a79f27@virtuozzo.com>
 <e269cf8c-b5ca-3eed-bd60-a8629378db8b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e269cf8c-b5ca-3eed-bd60-a8629378db8b@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 08:30:17PM +0300, Vasily Averin wrote:
> Fixes dc6982ff4db1 ("ext4: refactor code to read directory blocks ...")
> Cc: stable@kernel.org # 3.9
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks, applied.  I used the commit description:

    ext4: fix buffer leak in __ext4_read_dirblock() on error path

	      	     			    - Ted
