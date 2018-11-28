Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E15AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562E32081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="ViC1KY8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562E32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeK2DMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:12:47 -0500
Received: from imap.thunk.org ([74.207.234.97]:40302 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeK2DMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HURevatcZuP21/Mj07Lpo+reeimkNgX+TTfBRbY4s7U=; b=ViC1KY8bY/nzK8uVcGYIp48vlG
        QwEDQqWLTSrinZHrUOjKJoI2aSWBtkgTxo0EQ5KZh8+KY0V1Wcaa4xEsMoSs80nAgoVkJLIAoE2gy
        f49bL4ycoiUX2yUKPJFgd7gYCxbek6dw95Z9qJs70rdZpp3VBAS7vSYYA5AfcHljLvzA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gS2Q6-0001E4-3r; Wed, 28 Nov 2018 16:10:34 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 55D357A45D8; Wed, 28 Nov 2018 11:10:33 -0500 (EST)
Date:   Wed, 28 Nov 2018 11:10:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Rainer Fiebig <jrf@mailbox.org>
Cc:     linux-kernel@vger.kernel.org,
        "Andrey Jr. Melnikov" <temnota.am@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
Message-ID: <20181128161033.GH31885@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Rainer Fiebig <jrf@mailbox.org>, linux-kernel@vger.kernel.org,
        "Andrey Jr. Melnikov" <temnota.am@gmail.com>,
        linux-ext4@vger.kernel.org
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <20181128041555.GE31885@thunk.org>
 <en52df-5dh.ln1@banana.localnet>
 <2547416.7Vy7A2kRpU@siriux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2547416.7Vy7A2kRpU@siriux>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 04:56:51PM +0100, Rainer Fiebig wrote:
> 
> If you still see the errors, at least the Ubuntu-kernel could be ruled out.

My impression is that some of the people reporting problems have been
using stock upstream kernels, so I wasn't really worried about the
Ubuntu kernel (although it could be something about the default
configs that Ubuntu sets up).  What I was more wondering was whether
there was something about userspace or default configs of Ubuntu.
This isn't necessarily a *problem* per se; for examople, not that long
ago some users were getting surprised when a problem showed up with an
older version of the LVM2 userspace with newer upstream kernels.
After a while, you learn to get super paranoid about making sure to
rule out all possibilities when trying to debug problems that are only
hitting a set of users.

						- Ted
