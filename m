Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A09AC7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEBC20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N96/T1ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfATPwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:52:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39029 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfATPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:52:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so8556235wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0Ypxm0JUqcO8wVCHAxM67VbqWTm0LFt1BcktYODSJ1o=;
        b=N96/T1ueoMiIL1dnryhvC5IRdJNwOUdUkFqUuVvUvsvlIed1+gh9HsiarpLtPvBUt3
         pvTq8S0VDxe/Qsx7EBdwZ6ybDAlj1La1mFJpez0dA3K9J0EUYdp/92fbNTT2pGEM1ci7
         EY4QYE9WLxZR5aJMPV5GFh3A97VnKcLSn1/KloY01bqY1cLwDS98vwPIsPG/miC1V5GM
         Bu9SNlNp/I8di5Q0YfefatJNEl0iwiE7YXz0dMv50vQfCZ+5kKAqlgTf3eQ4sZ/tsqx7
         eYyysDWyw8/OH4bcMRdC5gle5HnnB/mDpQgZWNv5MbPqWOJ11u3myaIPh+mOcDMzMsb5
         ac0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0Ypxm0JUqcO8wVCHAxM67VbqWTm0LFt1BcktYODSJ1o=;
        b=j/ZhkCIqMAeDyuG7oJhI01Ww6WWMLS478XdU/f0Tp1FgfqE5rJObqdGX4IPWL3Vr6+
         lb6q/4uyjhV+FHgUmkojphUBk40ljJjVOOpHFVS3RycbgkWQ/b34b21iV7Typ567SAPd
         /TcEvP4n+ue6FJPXXhBVbGuqMutgkG5M573H58AGv19r4vSCBmpI1X/Z51RcSCW3I5L8
         HxTaNZR2rIas4CYfifB9gR2KQgzFtr5lsFeN3sE5y2fRURWk8z63Wun4DLyS8KSqLgk0
         l7uu23g/KHMk1Ea7X0voc1w2uXfMZJPeEFaCtTV5sAw/oHMclTyFOTxJehIE66+21Sra
         xvsQ==
X-Gm-Message-State: AJcUukfbeOFyTXjr5EyMnHTK7Ux6eX6lh+ppjtXHGHVbf0geeLBFns4y
        WVjuZ0ytBs5g6hjzmMesEMs=
X-Google-Smtp-Source: ALg8bN7b5IQyOABj4RE2XflDcJnhD4sOyIf4kfI3FBKzf2wv+T/ywqgPgYdf4H9lyQ0P9pSMWz48hA==
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr12234234wmd.98.1547999561327;
        Sun, 20 Jan 2019 07:52:41 -0800 (PST)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id m21sm37022612wmi.43.2019.01.20.07.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 07:52:40 -0800 (PST)
Date:   Sun, 20 Jan 2019 16:52:31 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v5.0-rc3
Message-ID: <20190120155231.GA30754@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A clang-format update (trivial).

Cheers,
Miguel

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.0-rc3

for you to fetch changes up to 99e309b6ed75fab4a43afd9e523441ecc5a1f511:

  clang-format: Update .clang-format with the latest for_each macro list (2019-01-19 19:26:06 +0100)

----------------------------------------------------------------
clang-format changes:

  - Update of the for_each macro list
    From Jason Gunthorpe

----------------------------------------------------------------
Jason Gunthorpe (1):
      clang-format: Update .clang-format with the latest for_each macro list

 .clang-format | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)
