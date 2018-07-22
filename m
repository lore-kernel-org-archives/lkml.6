Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6242CECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1104D20671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="SId2Pf/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1104D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbeGVTGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:06:09 -0400
Received: from imap.thunk.org ([74.207.234.97]:43318 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbeGVTGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cwUtk9mxxDxFOls6dllGOmfgfQrnYmJPKpHg3Ft4aGY=; b=SId2Pf/1SeVmfeRV/1nhhPLmJR
        f+bKOEouUDh3P+ait8BnjrixbNrxZMpG2sGbQSJofjoFt8Ks4vJBmLIyA0vmYKl77BtsEe9ekqYFQ
        BVbGopgh93nwOjyOLn9oyjUYchlM3crOmR1kG1gJiCwo6LLNI3XcMpK0XWcgC6XukHn4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhImY-0003tl-UA; Sun, 22 Jul 2018 18:08:35 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 11B7E7A44CC; Sun, 22 Jul 2018 14:08:30 -0400 (EDT)
Date:   Sun, 22 Jul 2018 14:08:30 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com,
        y2038@lists.linaro.org
Subject: Re: [PATCH v2 4/6] ext4: use timespec64 for all inode times
Message-ID: <20180722180829.GE6685@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com,
        y2038@lists.linaro.org
References: <20180711091414.1494843-1-arnd@arndb.de>
 <20180711091414.1494843-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711091414.1494843-4-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 11:14:12AM +0200, Arnd Bergmann wrote:
> This is the last missing piece for the inode times on 32-bit systems:
> now that VFS interfaces use timespec64, we just need to stop truncating
> the tv_sec values for y2038 compatibililty.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied.

					- Ted
