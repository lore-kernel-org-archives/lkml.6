Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C83AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA1020850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Ln+6vaGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA1020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbeGVXWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:22:15 -0400
Received: from imap.thunk.org ([74.207.234.97]:43726 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbeGVXWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0MMzdCmbKVmPeabgHjrL7CvtSp8+eDTIEoCSsL4OgBQ=; b=Ln+6vaGQazd6AGVE0P7FJHXve9
        1KtS8d2ietxHWVHcxux5y0wOxpNVI261TM8iUsZbyiz8wbbttA0gLzbXGGsbVFFtzNTwOg8q//Q79
        jo6HLmrTPTaOo0WTJAbrslWJCOS7TEFrkG40Gn0+Jy8ChrUND/0MqKGFYmDiHgXbM1Ns=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhMlk-0005Xp-Ph; Sun, 22 Jul 2018 22:24:01 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2DF817A6463; Sun, 22 Jul 2018 18:23:56 -0400 (EDT)
Date:   Sun, 22 Jul 2018 18:23:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Junichi Uekawa <uekawa@google.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix warning message to output correct type.
Message-ID: <20180722222356.GD3358@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Junichi Uekawa <uekawa@google.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180713091547.231108-1-uekawa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713091547.231108-1-uekawa@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 06:15:47PM +0900, Junichi Uekawa wrote:
> Output the warning message before we clobber type and be -1 all the time.
> The error message would now be
> 
> [    1.519791] EXT4-fs warning (device vdb): ext4_enable_quotas:5402:
> Failed to enable quota tracking (type=0, err=-3). Please run e2fsck to fix.
> 
> Signed-off-by: Junichi Uekawa <uekawa@google.com>

Thanks, applied.

					- Ted
