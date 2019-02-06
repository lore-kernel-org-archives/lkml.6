Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04CDC282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB352175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="E/cJvEJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfBFPHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:07:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39397 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfBFPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:07:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so3098546wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NXnoHJKixq4kULf8wzvIXWODecdQG95pwPnr+GtAcMY=;
        b=E/cJvEJhWfMyNDNUS9IqscVHdH/lm6oXbhxyeh0fH8YxCkwhHtBMzajDXKsH65GQQP
         5lF7fOYYzsb3sPb0IkrKa/3ic+CsddWO2XWdyHg2kWRLYmS9OaLAB4AlFqOVBNfxClWm
         YqCtAbWFt7Hn2G8C80yepLOTBRXCrYNWlSbAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NXnoHJKixq4kULf8wzvIXWODecdQG95pwPnr+GtAcMY=;
        b=Of8SASpjj64gTdjoeX9UvvmbfUSm5K8WFCKVseZvAb09caGZe21SlM6cwuK4H0/weK
         7xvgd4T9Ya9mmnNzymcyhhC47dDQWEVo5ycPxBaRerzjETUvcmYnfjIwaP+0NYun1eLX
         kkZnhDiQAAUaBV4aDHQxk98Q1lFwtgIX2vwGEppntXfJLT/qk8BgvMmPrgNS7Wh9IdZY
         tL1Zl1+4nfwbbInzCZW6QgqEJ8xpJ2bPg4caU2MLtjYGdmLci/2jl9SMaU4vrBqMVbaZ
         P4vYKxGDS9YGWRwYLLNKust1obBJCdv332FTBjLByZWH4BZjJrY06sI1LmfafgpnuVyL
         ONrg==
X-Gm-Message-State: AHQUAuZsBkunPL79+Bn7NwjZMS5IIj0QxeQgP3NjT3ib+tGxLo59XSME
        iEpkYp5eF4OI8/61DaOuQSxJdw==
X-Google-Smtp-Source: AHgI3IYfO8u8Z2EUkx3ZABfr9dAjiFe8a1GUARgascc9LkajdxGCTiA6tHQERApjKkv3eNjYp/bIpw==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr3532863wmk.149.1549465665369;
        Wed, 06 Feb 2019 07:07:45 -0800 (PST)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id j8sm15329464wrt.40.2019.02.06.07.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 07:07:44 -0800 (PST)
Date:   Wed, 6 Feb 2019 16:07:42 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.0-rc6
Message-ID: <20190206150742.GC19821@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.0-rc6

There's a fix for a CUSE regression introduced in v4.20, as well as fixes
for a couple of old bugs.

Thanks,
Miklos

----------------------------------------------------------------
Jann Horn (1):
      fuse: call pipe_buf_release() under pipe lock

Miklos Szeredi (3):
      fuse: handle zero sized retrieve correctly
      cuse: fix ioctl
      fuse: decrement NR_WRITEBACK_TEMP on the right page

---
 fs/fuse/dev.c   | 4 +++-
 fs/fuse/file.c  | 2 +-
 fs/fuse/inode.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)
