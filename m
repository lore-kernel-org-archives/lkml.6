Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E097ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAE72082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA2Bj1zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAE72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJ0D6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:58:51 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:43264 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJ0D6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:58:51 -0400
Received: by mail-qk1-f173.google.com with SMTP id r71so1351653qkr.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O4meVGNYs8kZqYVa8CCngOivEK22E/2Sn1LUryZ1aM4=;
        b=aA2Bj1zvovtqU6sC3yaZmgXx71DbwdaG+hqdNUsyCGm/pLR1HOKq0qH3fvpXbmGPCq
         wdTCteQsDB8Z94NxxOsQNTy6NVL2TIs+PYxK3DCsJ5IWYlTuM/0hL3JG1OH5+eCZQtfd
         LVcd4wp/g1yXXfDLOEixukjkx2X2uHBYtTe/8d9L0jEBGSd3BY54txDyG4oiX3+Ga1sU
         F7PyXP59zuz5XaOQ8kFLYE5fIL2ATxWkYIH8W438prw2xFKYy6DvW0O21WY7nEdzo0vm
         YQq84MSA43FV8vTc5LzCTa26vt0ECZQ2t4fliS2z78r7IvL3wYxKQEp7hAXTs7KPsNPf
         44dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O4meVGNYs8kZqYVa8CCngOivEK22E/2Sn1LUryZ1aM4=;
        b=XfSprZoRLHmu5nV1JxNnguAcyA2sg5flB82fJ/jp1LpWYNqSc4Ino69BP4mXmVKJRg
         6ew7qEBVleekP2p8V9p5i3wT3lXysmeWYkAOfor4mSgOHDX4/GTcmywO3mAXiWBOBoU9
         N1xHGaGkva0ozylVzRd8OkoYTGJ8pnDAcwKj/LOilbjUNmqFwKDatTPUsmgu4nDFYgcg
         DZMFafF7+d89WkB/bOhCDE0t3ErfAZVtgbqjl6qCRG1vgdWh5Wtu2jGit2jYxPALZIAn
         bL2/cIWmx4qxfLVizfFNp74ShzZDUOaZkw5VjIWmLL9uVoy3f7MPw71Zgn/zWhXwP5os
         u8wQ==
X-Gm-Message-State: AGRZ1gI0ilUxRsb55Cp91CzyRCQAFEFUC111VSCsOmE3QtGGgi/XEnDr
        xU5/N9HbKgHPvRaZVnmNaE8=
X-Google-Smtp-Source: AJdET5ejGHoC5aMAgWBgw6ZE3rGnOq75a/KUPmacbcpuvFao33RkFWIwQnQqts4KOwY81wRjIEfE/w==
X-Received: by 2002:ae9:e012:: with SMTP id m18-v6mr4325860qkk.25.1540581634839;
        Fri, 26 Oct 2018 12:20:34 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u74-v6sm5928214qka.37.2018.10.26.12.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:20:34 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:20:30 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 0/6] drm/qxl: Remove checkpatch issues 
Message-ID: <cover.1540579956.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans the following checkpatch.pl issues:

ERROR: trailing whitespace
WARNING: Missing a blank line after declarations
CHECK: Please don't use multiple blank lines
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
ERROR: space required before the open parenthesis '('
CHECK: Avoid using bool structure members because of possible alignment issues

Shayenne da Luz Moura (6):
  drm/qxl: Remove trailing whitespace
  drm/qxl: Add line after variable declarations
  drm/qxl: Remove exceding whiteline
  drm/qxl: Use 'unsigned int' instead of 'usigned'
  drm/qxl: Add space before open parentheses
  drm/qxl: Use 'unsigned int' instead of bool

 drivers/gpu/drm/qxl/qxl_cmd.c     |  7 +++++--
 drivers/gpu/drm/qxl/qxl_debugfs.c |  5 ++---
 drivers/gpu/drm/qxl/qxl_dev.h     |  1 -
 drivers/gpu/drm/qxl/qxl_display.c | 19 ++++++++++---------
 drivers/gpu/drm/qxl/qxl_draw.c    | 11 ++++++-----
 drivers/gpu/drm/qxl/qxl_drv.h     | 31 ++++++++++++++-----------------
 drivers/gpu/drm/qxl/qxl_dumb.c    |  3 ++-
 drivers/gpu/drm/qxl/qxl_fb.c      |  4 ++--
 drivers/gpu/drm/qxl/qxl_image.c   |  4 +++-
 drivers/gpu/drm/qxl/qxl_ioctl.c   |  2 ++
 drivers/gpu/drm/qxl/qxl_kms.c     |  2 +-
 drivers/gpu/drm/qxl/qxl_object.c  |  5 ++---
 drivers/gpu/drm/qxl/qxl_object.h  |  2 ++
 drivers/gpu/drm/qxl/qxl_prime.c   |  1 -
 drivers/gpu/drm/qxl/qxl_release.c |  1 -
 drivers/gpu/drm/qxl/qxl_ttm.c     | 12 +++++-------
 16 files changed, 56 insertions(+), 54 deletions(-)

-- 
2.19.1

