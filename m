Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4131C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD42192C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKXjHCEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390669AbeLUUxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:53:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36738 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbeLUUxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:53:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so6917687wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 12:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=m6C0YTOsmnGazriqG00r1BGh8gBzFjIOedw0WDWn8IM=;
        b=RKXjHCEttBrec00GQ9pCODecwbVN1xt5Z4xjJsX8F/hqz9aBdvGGL63LL2SVVMdVNo
         hETNndXu5W4Dsi53y9+lHQNbbIjp5xqkn/FDimv+ssQWwxWyKe2PmMCUwFZ23AlhnOO9
         ctoqZlIUMH+ngojiHQwgLRbtk9y/2M3Q3TkyuigzkQn3rI2zYlz/mJEKRBu3w49UaoAo
         wJBozyzm8Ctc2gyy4H+YPjjiCG408V4lkKa7VOGvAt4qTPLPI3Pav3r2fJ0ve5hAZD/F
         6h5zPXiSJHIoGj584Uw2WWD9gF1baaQjWaoBz88CmFVTrTomVi7xxQspvEUFVZjeBCiU
         51vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m6C0YTOsmnGazriqG00r1BGh8gBzFjIOedw0WDWn8IM=;
        b=nnHk/bBWpfC9oPg8UpwxG0zLzEISEWhhOAAnPiNtmYGoCp8sLUM5v5EMXo+TgP3AIK
         lxD60ffh7YoqI9aS8ZBXKcvttrTsIZFyPosWoSUmfPfhOop0mIcZM1yoh5SmSAALiE+E
         0GgF0QRQZBG0MBOnM9BjiCgecHhcsAXZjg0S3iWgUXl5jatlO+p5mq123QCaz6IMgB6X
         lJg68M/uFl6uqImIz+grBw1qD3bGdV5vQOk/kYnzMgXYFG3U4kc5P4UpvOBw8UuyJ01m
         9kmag537HvEl8tgyTHNAnwZWlFt0DNZH9f9DgI62P9UwGXqLToDhiQ4OzYZnV4ECUT/p
         knYQ==
X-Gm-Message-State: AA+aEWbEBM79Re1asxZyDuYbdT8TM3BEb/Sc6BEigKArKtJaxagrH2QC
        2n6LHQYrBL22n0mr/Tu62VapYK0eYvQ=
X-Google-Smtp-Source: ALg8bN73lj76QTHkOJpb48Vvs1ej7zFMh59EQVnZsC2uI1NQatVBu8U7FcDmrAlyUhQZHOtT+TynnQ==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr4166720wmb.80.1545425592737;
        Fri, 21 Dec 2018 12:53:12 -0800 (PST)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id e17sm17313160wri.36.2018.12.21.12.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 12:53:11 -0800 (PST)
Date:   Fri, 21 Dec 2018 21:53:02 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mans Rullgard <mans@mansr.com>
Subject: [GIT PULL] auxdisplay for v4.20
Message-ID: <20181221205302.GA29847@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling this small fix for auxdisplay.

It is a bit late, and has been in linux-next for a couple of days only,
but it shouldn't break anything else further, so feel free to pick it
for either 4.20 or maybe afterwards.

Cheers,
Miguel

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v4.20

for you to fetch changes up to 9bc30ab82108e6a34dc63bf956b49edf71b1681a:

  auxdisplay: charlcd: fix x/y command parsing (2018-12-21 21:27:21 +0100)

----------------------------------------------------------------
Fix bug in auxdisplay.

  - charlcd: fix x/y command parsing
    From Mans Rullgard

----------------------------------------------------------------
Mans Rullgard (1):
      auxdisplay: charlcd: fix x/y command parsing

 drivers/auxdisplay/charlcd.c | 3 +++
 1 file changed, 3 insertions(+)
