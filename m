Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22504C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88AF214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHVrjgC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88AF214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbeHPKea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:34:30 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36825 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHPKe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:34:29 -0400
Received: by mail-lf1-f49.google.com with SMTP id b22-v6so2703282lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=0LIZgRDMj2Cg+2yu3HrHXtsegmQ3MGjuuiwU+gPTS0w=;
        b=OHVrjgC5mMl41tvkeTr0Hvpa9ZaT/UuEq406+k+/cb1aQmetwOlsofZ7Nm8HxfGnQF
         JVUyWPg2F2mq46Q8u4aGgv4q8WroEQEF1+972DiOsWv58565Xk2mBurBxqG9tseaRHCB
         uX7Kje3vEC9rCMBmBdqqIYV7uVj4fuZCivA627qrLEeBdvdXAQ7yh5ZjFJaJr/ba2LOo
         uz6/yFKeS9b0yl19Y+j1L+x99z2nemCIlMXy7cRBX+DTsre+zbItaN23U0UwFuFB9cdF
         uwp8SgHJK8UUsmO9D+NDu0VVxdBOJzj2Bno4ROHmx9C0y+5u0ZsTmrBCmEqF5GgAgvcf
         keJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=0LIZgRDMj2Cg+2yu3HrHXtsegmQ3MGjuuiwU+gPTS0w=;
        b=kS1LR8ZbLMi8DDyTSUVog3sEqQK74f4XfYdNCW+PPuPYjg8Ou0K82C9ujJUxD1qAaR
         vvIQXuBNI0gGYleHed9aUOPGZEirQ+4mKv0/15yiLgwwCG1hZmC21H0+jD1hQZIv2ec5
         f6VGcHC5YxsSoOHr+v0T3P1LvPP/UaP0hns3DRhAQ0U83NED5Y4CAT30DkO8v5A4E1Wv
         E+mv1BltT2SmVbXmF5FTSvOGEqAPadVYL2gIaP4ExdGNTHdyC2k078LaTinHv06tKn7Z
         lh9+m9V7vZ44k4eYbWK/tprjDlY33gsX+TNTJmcO1DT9RaKRMJHMDUnQkhL3XfQBv/ZP
         +WrQ==
X-Gm-Message-State: AOUpUlFVISjs+nj4M7LqadIz6Y94PLTMz5iPzo0aKrWNu0PWAke4uMX+
        z5VKJmXYGvNvkqOYGPp1sYPlVxWGCTbZICzdtH4=
X-Google-Smtp-Source: AA+uWPy3AlR9bwe6To7TNz26DiYSZBu6Og55SONSL0clr890dqjnk1Wth0f4yZ/HuCi8rlrmH3V0s1yRJcvJGhGzI7g=
X-Received: by 2002:ac2:4308:: with SMTP id l8-v6mr19257925lfh.35.1534405073717;
 Thu, 16 Aug 2018 00:37:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a87:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 00:37:53 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 16 Aug 2018 09:37:53 +0200
Message-ID: <CA+icZUW9Cg0G41ZSwjUBaJ+F9qCc23GGMp8aCgfNQejstKJmmQ@mail.gmail.com>
Subject: Re: Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I am here on Linux v4.18 and tried first to merge the l1tf-final Git-branch.
Unfortunately, this is no more available in the tip Git-tree.

Then I saw Linux v4.18.1 which includes all the above stuff.

I tried to 'git cherry-pick -m 1 958f338e96f874a0d29442396d6adf9c1e17aa2d'.
I know the commit-id is the hash of a merge.
Luckily, I could get the "diff" and applied it.
But the history misses.

How can I get the history and subjects of all commits in your tree to
cherry-pick the single commits?

Do you happen to know another solution to get easily all L1TF commits
with any other tricks?

Thanks in advance.

Regards,
- Sedat -
