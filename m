Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF22AECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 02:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8D021476
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 02:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7bgvK6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8D021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJTKmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 06:42:19 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:36712 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbeJTKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 06:42:19 -0400
Received: by mail-qt1-f178.google.com with SMTP id u34-v6so40536250qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 19:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9iLO1SR+KNupdfBdAatovIH04aSXOVhLdzeH9j63E+Q=;
        b=E7bgvK6DUpc7TqDLObQ2LxKKvJCc1ieNsLg9Cqgtd787GS2DSIJlFiWtXDGfV7lLpp
         SPw3awy57ccKgWDqibgSFgLfdIHDJFJw17MQBb2hzUNAkYAadLWR+kkNJPWnEqnmXlA1
         4aVh4n/s+V94IJ2Db7il4p2EkD5G90eCdbNKzffJHlV1DBHvK+296HmJE7zAXXihwMEm
         B7NQqUe0MSAyIKGLPJDdRSy+wrg/IR3/WZOCewBjvL0KAEn5uUSnVPUDMwEhPs1Nhii2
         mLvLFopcZCCdcsmVabC66umkhxpUGAP53krAzMzFW4/lS5ZU5P2me5xZWVNplV5Uw+O2
         K/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9iLO1SR+KNupdfBdAatovIH04aSXOVhLdzeH9j63E+Q=;
        b=k2FJqKnjYztMQr3hBcnqOlMhpbJTP5mPn8ZgjKDo/l/NXnaNEiI5Q866eraABF2HzO
         Xco6ktUbmb/Fl+bPaKeGWi48GMKPzS7CjwX3LgS9tBN5ZGpb6sctJ4dJQ4EvOdBbS1pq
         uPtOjCPPjoHeu2tqn/7ve0K2fYsEfqSlpyb7toiXMF1QKvjAMuD3xZRi3pOIOthXFOGh
         3jQ5YBQjblNJncILxeNirYbW+GLtXsAOT6OuJTj3Die0yUruRHr3WnNaprfC/WXfEVAB
         n5/7XYVWQQuv0wMidGd6Az+/CAl2gU8vJRHJxrJb4VeMkgbR77OWP9qW2tM5d88TC+RO
         FNuw==
X-Gm-Message-State: ABuFfoh2vrahscRMuFYFSeeBgUJ2oyrZ7fVR+SYvJqw00Nc5VI3atxRV
        8vfseGxChzPpFb4gd5vKBmE0l4nEy2ogjmFrGGQh+6hv
X-Google-Smtp-Source: ACcGV62E7g5VEWcDQw2RYOdmFQXnGFeeLiLVUMpTCqqGpm+fuQ6M864Atcrv5XkwWK+sl7xS/AZFtwm3SfUIpRQjFPY=
X-Received: by 2002:a0c:9213:: with SMTP id a19mr35917790qva.124.1540002812977;
 Fri, 19 Oct 2018 19:33:32 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 20 Oct 2018 12:33:20 +1000
Message-ID: <CAPM=9tzvmdwN2DWFMnH_OQfaz_M8YtGUO6K+Z0QRzuX1z6FoqQ@mail.gmail.com>
Subject: [git pull] drm fixes for 4.19 final (part 2)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Looked like two stragglers snuck in, one very urgent the pageflipping
was missing a reference that could result in a GPF on non-i915
drivers, the other is an overflow in the sun4i dotclock calcs
resulting in a mode not getting set.

Thanks,
Dave.

drm-fixes-2018-10-20-1:
GPF fix in atomic flipping, sun4i overflow fix.
The following changes since commit f8e6e1b6f0ae3bb91cdcd08213d36a0ce6e98535:

  Merge tag 'drm-misc-fixes-2018-10-18' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2018-10-19
13:52:03 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-10-20-1

for you to fetch changes up to fe7acd1e303d74584040a902d78726ba5a4b9b4a:

  Merge tag 'drm-misc-fixes-2018-10-19' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2018-10-20
12:26:26 +1000)

----------------------------------------------------------------
GPF fix in atomic flipping, sun4i overflow fix.

----------------------------------------------------------------
Boris Brezillon (1):
      drm/sun4i: Fix an ulong overflow in the dotclock driver

Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2018-10-19' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Leo Li (1):
      drm: Get ref on CRTC commit object when waiting for flip_done

 drivers/gpu/drm/drm_atomic.c           |  5 +++++
 drivers/gpu/drm/drm_atomic_helper.c    | 12 ++++++++----
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 12 +++++++++++-
 include/drm/drm_atomic.h               | 11 +++++++++++
 4 files changed, 35 insertions(+), 5 deletions(-)
