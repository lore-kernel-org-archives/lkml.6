Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB3EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7436420840
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="W/00KoUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7436420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbeG3UMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:12:34 -0400
Received: from imap.thunk.org ([74.207.234.97]:43870 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbeG3UMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OIsDH67WcLn2ONRSZEzJp5gb7ozyiHGWxEPbbUMSq28=; b=W/00KoUVxeeMULY893fPKqxfNt
        Cf3Kb+ZrMPyL2XiyOuuo/NjdFVs4Ez0fYCnfB+xYwSPP3qiLbnVBWBbUO0pg5m8fOyT19rP4/VlO/
        l2NBg7GZIkUB/qZRItTG+ZHgPz2biMEaFZbgBgNVHeOqPi+Zx+S9eGWrh+LXD6DX1bHk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fkD1k-0006L1-G4; Mon, 30 Jul 2018 18:36:16 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7A93B7A614A; Mon, 30 Jul 2018 14:36:15 -0400 (EDT)
Date:   Mon, 30 Jul 2018 14:36:15 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: mballoc: Fix spectre gadget in
 ext4_mb_regular_allocator
Message-ID: <20180730183615.GU21725@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeremy Cline <jcline@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org
References: <20180730180747.25200-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730180747.25200-1-jcline@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jeremy,

I think you are also going to be changing the 1/3 patch from the
original patch series that this was part of.  That's correct, right?

It would be easier for me if you could simply make all of the
revisions you plan to make for the patch series, and then upload a
full v2 of the entire patch series.

Right now I've mentally marked the entire patch series as "waiting
forh v2".  So when you send a V2 version of individual patch out of
that series, it leaves things unclear when/if you plan to update any
of other patches in the series.

Thanks!!

						- Ted
