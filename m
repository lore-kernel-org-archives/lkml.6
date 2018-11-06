Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D5C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811B42083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="SG0gd6vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811B42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbeKGHUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:20:30 -0500
Received: from imap.thunk.org ([74.207.234.97]:46048 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeKGHU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iXElp8w1zzYKfimvI2VqAXLUv+s8NYA+OE6lJJAihF4=; b=SG0gd6vznAW8aPfLq/LtEl3oQ2
        6BMI2NaEXrrtsNloF7rDPSB5PS8UxEJ1WZHidvgprCLeAYFUROaNmXLZ/r/K1fKi27qnqu3vzon4R
        iFIKtfvikfP98RTVLbpWr2bB4Rz4T/3JeB+BNl45yKW+6MaZ9/L/W37RRYTtleEuT/J4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gK9Ha-0005nF-Ku; Tue, 06 Nov 2018 21:53:10 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7B6B87A7C2F; Tue,  6 Nov 2018 16:53:09 -0500 (EST)
Date:   Tue, 6 Nov 2018 16:53:09 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] ext4: lost put_bh in ext4_mark_iloc_dirty()
Message-ID: <20181106215309.GF2570@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <61d28461-8fdd-d614-8bde-844703936ac1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d28461-8fdd-d614-8bde-844703936ac1@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:58:24AM +0300, Vasily Averin wrote:
> ext4_mark_iloc_dirty() callers expect that it releases iloc->bh
> even if it returns an error.
> 
> Fixes 0db1ff222d40 ("ext4: add shutdown bit and check for it") # 4.11
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks, applied.  I fixed up the commit description and Fixes/Cc
trailers.  I used the one-line description:

    ext4: avoid buffer leak on shutdown in ext4_mark_iloc_dirty()

    	  	       	       		- Ted
