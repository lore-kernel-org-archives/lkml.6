Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBDC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640522086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lYKcg8x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640522086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeLLJd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:33:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34873 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeLLJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:33:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so5127787wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DsA1X0BCVJHLl0FybRu5giBzN/j0zxTMES8TOIFwAmM=;
        b=lYKcg8x+s00DaL6AyzkW1xjrYhV27jIHimvu/fmcQt4skGpO4myE8P87Zp6j7pkis0
         Iq75TC0zqQxkJRZ12K15g54/u7Namq5XRshw7rlUKJgnZkiZO045/diLcSLbZnXhBhbM
         6g+gGhGlVyJ9Aj+xjlp53b1OhaJ1LBtPQxR68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DsA1X0BCVJHLl0FybRu5giBzN/j0zxTMES8TOIFwAmM=;
        b=VKDRj7hmxqniW8Gn+lM7mfx/EaDECE0IFOD3QQ7yfuExbVLJWObXKn5Cwhj1rjJp3o
         ln5SHOYJ0El7ZM4gKeZZIYA3DStih+51MX+19UrqHDQkoOv9cEKUXGXW07hiUxiQrVgx
         lg8mBjoklp+clVOoSRhLCsb7lHjDxjAkSDkNwq5TVcW5qDoRBHquol1MF7WJxtydkdNJ
         cKIs5anzkYe/YNy/9QQvTYoZzuf+uRHQqQgmxvIC1HzAlP76EjMPnzdsddbA8fn8nuEz
         CZ8hAUtBGsT8RbrIQKwlLN9EDGVQbpA0O/V7HsMrvzekEj65WyZbyWY0Do9ufapf9ZxM
         GjPA==
X-Gm-Message-State: AA+aEWYbe24a/GAf3msQ3CXhUTmEXxUCRo/MH2R3aqHZEXLbPZpKUY7I
        T9Upit/1RTJ26JyfAzgbgj/mtQ==
X-Google-Smtp-Source: AFSGD/WuZPCtf0rYLDu/vww20kED8UIduYqdBVnmBPYRKSKkYx4h3dk/t2QTpCmUfogshuiUwGVddg==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr5509420wmp.19.1544607204915;
        Wed, 12 Dec 2018 01:33:24 -0800 (PST)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x12sm15136578wrt.20.2018.12.12.01.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 01:33:24 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:33:17 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 4.20-rc7
Message-ID: <20181212093317.GA15517@veci.piliscsaba.redhat.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-4.20-rc7

There's one patch fixing a minor but long lived bug, the others are fixing
regressions introduced in this cycle.

Thanks,
Miklos

----------------------------------------------------------------
Chad Austin (1):
      fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS

Miklos Szeredi (2):
      fuse: fix fsync on directory
      fuse: fix revalidation of attributes for permission check

Myungho Jung (1):
      fuse: Add bad inode check in fuse_destroy_inode()

Takeshi Misawa (1):
      fuse: Fix memory leak in fuse_dev_free()

---
 fs/fuse/dir.c    | 26 ++++++++++++++++++++---
 fs/fuse/file.c   | 64 +++++++++++++++++++++++++++++---------------------------
 fs/fuse/fuse_i.h |  4 ++--
 fs/fuse/inode.c  |  3 ++-
 4 files changed, 60 insertions(+), 37 deletions(-)
