Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6D2C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D21204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="TPZ5TiAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D21204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeKDG0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 01:26:37 -0500
Received: from imap.thunk.org ([74.207.234.97]:33686 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeKDG0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 01:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3E99FgXWflVUPVI9q1FW1Z0AFZIuFEbLW3W6U9ihmGk=; b=TPZ5TiAoU3GovnVztUp2UedMHI
        SVsaPAcC1H4HicyUfnjUIbimqq0Q1R9t4Z9SHV3bfs5v4D9SYM1tFf5A+GLo74ALvmfr6HaRfXzhH
        MwShhKrnzOTSznd8/Ph5NJJRPV42KbrxFXbV061igTWk/aOn71fUjyw1raX20gfMvaQQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gJ3FB-0008TN-IN; Sat, 03 Nov 2018 21:14:09 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5F3777A7A7E; Sat,  3 Nov 2018 17:14:08 -0400 (EDT)
Date:   Sat, 3 Nov 2018 17:14:08 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] ext4 resize: lost brelse() in update_backups()
Message-ID: <20181103211408.GH28850@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <7120b1a5-fcda-8e31-fc8c-7944b4291b14@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7120b1a5-fcda-8e31-fc8c-7944b4291b14@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:58:03AM +0300, Vasily Averin wrote:
> bh was not released after error in ext4_journal_get_write_access()
> 
> Fixes ac27a0ec112a ("ext4: initial copy of files from ext3") # 2.6.19
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks, applied.  I fixed up the commit description and Fixes/Cc
trailers.

						- Ted
