Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C0BECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725F620852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="wxixSne2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725F620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeGWRZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:25:40 -0400
Received: from imap.thunk.org ([74.207.234.97]:46918 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388240AbeGWRZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1vx6/v9z+VUP7z90oycMxX1+tVpB9QCRB7pzQ0glGjU=; b=wxixSne2ghqqeUG+DZGgFyosyf
        ZMYkMfif9/q0yKb62OtBspmN+/KZTweQ/zFWgaDV2nKBWkefl6UEM97cL49cg2OF6nui1yeUDvL89
        RKXTDV/gW0DiMhudgPfT6Gkj1r3vE4Qv+uAXF1PR11vp2aVDc45t24B1o/gVbiVU3C/g=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhdcZ-0002R2-Sx; Mon, 23 Jul 2018 16:23:39 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6B1687A6463; Mon, 23 Jul 2018 12:23:38 -0400 (EDT)
Date:   Mon, 23 Jul 2018 12:23:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?7J207KSA7J28L+yXsOq1rOybkC9NQ+yXsOq1rOyGjCBCU1Dsi6QgQlNQNg==?=
         =?utf-8?B?7YyAKGp1bmlsMDgxNC5sZWVAbGdlLmNvbSk=?= 
        <junil0814.lee@lge.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, junil0814.lee@MIT.EDU
Subject: Re: [PATCH] ext4: remove abnormal set for I_DATA_SEM subclass
Message-ID: <20180723162338.GG3358@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?B?7J207KSA7J28L+yXsOq1rOybkC9NQ+yXsOq1rOyGjCBC?=
        =?utf-8?B?U1Dsi6QgQlNQNu2MgChqdW5pbDA4MTQubGVlQGxnZS5jb20p?= <junil0814.lee@lge.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, junil0814.lee@MIT.EDU
References: <1531123108-45918-1-git-send-email-junil0814.lee@lge.com>
 <20180722220841.GA3358@thunk.org>
 <ccb7943b-44af-5031-8410-f1c0851e70c2@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccb7943b-44af-5031-8410-f1c0851e70c2@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:48:37AM +0900, 이준일/연구원/MC연구소 BSP실 BSP6팀(junil0814.lee@lge.com) wrote:
> Then, I have a question.
> quotactl() doesn't have case only to set limits flag, the routine to set
> the DQUOT_LIMITS_ENABLED flag is under dquot_enable() function.
> According to this logic, if users makes duplicate request to set
> DQUOT_LIMITS_ENABLED flags, can lockdep make the false alarm with ext4 ?

With the upstream kernel, if you call quotactl with the Q_QUOTAON
command, it will fail with EEXIST before it ever gets to the file
system specific quota code.  This happens in dquot_quota_enable() in
fs/quota/dquot.c.

I'm going to guess you didn't try to reproduce the problem with the
latest mainstream kernel, and then applied the patch, and verified the
problem went away before you submitted it?

Regards,

					- Ted
