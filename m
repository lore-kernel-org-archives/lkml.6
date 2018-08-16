Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A68C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D96C20898
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xw1YT5m/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D96C20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeHQC4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 22:56:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36600 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeHQC4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 22:56:04 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so2846656plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wooRs1j7GGKe1/E1z7EJoM0S7cq2/FARBc1id7t/uTw=;
        b=Xw1YT5m/FeMPxFmvafTv7TtXchuh0eNdPBMyIkRdK613VhOO7hvsEnx6uawxWOLrw0
         XU0jvE8MzBFuUGApoYllEvIZDukUskzcHhHnAdhfKyFVcK0mpsOGtALBfafNVh9KEpzn
         Sjp6meSSfD3lPX3IdlbgE/c+WbCGZ+uEOFkFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wooRs1j7GGKe1/E1z7EJoM0S7cq2/FARBc1id7t/uTw=;
        b=AurxIqpdp728DoR955gAeKQI8YfNsKB9o7vq64obv2dvOSQxO9RMon3tyj/w3O8BwE
         WWOw3JlqNlhpqqQ4oyaqcQA0f1b5iElb2tKIxMgNb1E1OuL+U5tqaiOzV7rrNFDbQlwV
         rdSV3z9gCrRGDEREVfIUZuFONeCcLcvPgCgCwRnzGNrtf9YzI3tqA9zpAUXJ+MVR+7Vj
         UX0QvZMtbRoCMSdTeFh/uYcIOC2EPLYIdUfk2MoHgXjrKy8DaX4meJA9IYlGBMcvT3OT
         fmPEAcM2ao1rxI+lNpEZWeevMsQPYYQ0qcuqJ0GQZl35ZCkXdNlDGmo+9kszR782Sg8u
         pgjg==
X-Gm-Message-State: AOUpUlGxS37mTfGoVTnk4+WKFo9W2YqBRCkb9g1BHBW2P53MyBPqpKhg
        wKSd3bEB5H/0RYWVrzOuCbDuyA==
X-Google-Smtp-Source: AA+uWPxkigSvoPUtBeAd9olrCiffKmISJrchtTpJwE75bRn2ADEtHdPxsBnExDPv+3kYJbOlS3n6EQ==
X-Received: by 2002:a17:902:22:: with SMTP id 31-v6mr31155663pla.190.1534463699214;
        Thu, 16 Aug 2018 16:54:59 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e7-v6sm439328pgc.55.2018.08.16.16.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 16:54:58 -0700 (PDT)
Date:   Thu, 16 Aug 2018 16:54:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [GIT PULL] VLA removal leftovers for v4.19-rc1
Message-ID: <20180816235457.GA14528@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two VLA removals for v4.19-rc1. It didn't seem
sensible to me to wait to add these: they're both trivial and have been
sitting in -next while I tried to get them picked up by their respective
maintainers. Instead, I can just be that maintainer. :) After these,
only some core crypto VLA removals remain, as the series that fixes them
is still under review.

Thanks!

-Kees

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/vla-leftovers-v4.19-rc1

for you to fetch changes up to d8dfa59f5a512a536b80a4a8f12fa993683f48df:

  bus: imx-weim: Remove VLA usage (2018-08-13 13:40:52 -0700)

----------------------------------------------------------------
VLA leftovers pull summary:

- bus/imx-weim: Use maximum register count to avoid VLA

- drm/i2c/tda9950: Use maximum CEC message size to avoid VLA

----------------------------------------------------------------
Kees Cook (2):
      drm/i2c: tda9950: Remove VLA usage
      bus: imx-weim: Remove VLA usage

 drivers/bus/imx-weim.c        | 7 ++++++-
 drivers/gpu/drm/i2c/tda9950.c | 5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
Kees Cook
Pixel Security
