Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B11C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93BD20858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iBK01pXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93BD20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeKPGIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:08:14 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:32995 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeKPGIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:08:14 -0500
Received: by mail-wr1-f45.google.com with SMTP id u9-v6so22521817wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FvAy8mN7qbYvQaEB02DOWcB6LaHJi1yXr2P6IN/AmZg=;
        b=iBK01pXt6XuwnXxdqy/CY/6qixAPC2m+hoCwM9UzL0JoWc36TwMItw2O6JVJ6Hh2u9
         SotXoFXw6sI/pql2aZ1xsbjEOARLZen1sMQ1JZyFU+len04NB4I9c9wkDPSW5XUxYgJ0
         BjzflYCHFDwp+gLrOl4M2PQJEHTm5pmb5yY3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FvAy8mN7qbYvQaEB02DOWcB6LaHJi1yXr2P6IN/AmZg=;
        b=tqXTi77qj9HRoyX4ENJkkj78N8fvKuLFQv7cAKeuqVhiCFNp84tzigOYTPOuAtzxKm
         fvidwvgu+NHkklQdZJNPmJ1Czk7ydTBZi/QdwQNqlV7A1NRkpNr028hpVKVgE6XwZ6Zn
         tbxde8dXNsStfr4isEOr6YOPACZoZJ1tko2t+MJL+1QuB9LgETX2iHV/QPHw8CN3y4L7
         nnoqkeqLdzP3Jhgv9Mp9Od+mbjzVRJ5Kq6/pcr15M5WsNNQsG1cyAlsu4a7oP0UQx69H
         d5zDbi8LI5kUP88aoLG7M2fS4S2EE5OGXg0aSQKbVsQtCWO7p1PxKD/RX5wcMUHexaP6
         ku2w==
X-Gm-Message-State: AA+aEWbAp+Tl7Qegv9keXvMPj3kUnejfqjirbbLKVOBxVOAZIOJ+YEuk
        Im8JgdYPUjr4SHT9mCSB0j5DyQ==
X-Google-Smtp-Source: AFSGD/VCnEgy+zl4xQePhJpe8twMBxgClriFg3s7y7CH6Gmx9sNOVOju7h8013GOxCSGSKbgesLCHg==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr3300345wrw.159.1542311939437;
        Thu, 15 Nov 2018 11:58:59 -0800 (PST)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id e16sm3422942wrn.72.2018.11.15.11.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:58:58 -0800 (PST)
Date:   Thu, 15 Nov 2018 20:58:52 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 4.20-rc3
Message-ID: <20181115195852.GA5245@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-4.20-rc3

A couple of fixes, all bound for -stable (i.e. not regressions in this
cycle).

Thanks,
Miklos

----------------------------------------------------------------
Lukas Czerner (1):
      fuse: fix use-after-free in fuse_direct_IO()

Miklos Szeredi (2):
      fuse: fix leaked notify reply
      fuse: fix possibly missed wake-up after abort

---
 fs/fuse/dev.c  | 16 ++++++++++++----
 fs/fuse/file.c |  4 +++-
 2 files changed, 15 insertions(+), 5 deletions(-)
