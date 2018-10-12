Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69488C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32999206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyuxmGTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32999206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJLNa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:30:27 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:39809 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJLNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:30:27 -0400
Received: by mail-qk1-f176.google.com with SMTP id q5-v6so7040714qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 22:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1iaDiMR/vCCuR1t5UcRyCxEKhR0z9t76HvyP/s7dUtM=;
        b=LyuxmGTzN+QjDy+e/sRWZwyTGKR+WEc5fuo1lCcEFNHBh2tlT4eisNEx9pIn++hgVR
         eg9srnUfDqDU1WXt4cZGdGmVGHNZSYdc35u+syb1pxHroHO/CqKDVfw0oTLnTc0Y7HDE
         qhuU1aXcLuxOFu77R9MU37gllt6gzRTQQ2/kEHx1hz20PR8IIRIqAbBfmOIsyXR3wWBO
         +2h5KWTNwHOuU4VENvyrwNWE1mMtyJLFcYcXZ6AoVvtH3r6/KLLtluR/vQd9slntIFpl
         ynX2aS3CSGBifgKOI6+RzNPpIKxRhYRF5M4FO23B1Gys2YoqZ85tdM3mqNJrLJpgrVvi
         8eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1iaDiMR/vCCuR1t5UcRyCxEKhR0z9t76HvyP/s7dUtM=;
        b=gWA3uVd9bYCuku91Qx6sG5kZNQzNowHLtzCXGpqnAB909jm5upJSL+KC5nDcKIO1gL
         RoU0UFYl7I54QmdYCbOAgjqiUrwKjXyY3edWQIn5gEf19AKywSqRm0o1yxwEhieiavyv
         E1yk1f68PkiCILgkb9iFq/DUg6CIjo4ZlA4uQJBNAa9aLK2SgPPUryTURU1rBhlphSGw
         KduDWqk20rlHxXExKItNxt0xYXKT6dAPjiNxf+VldMRs7TiP3hQe64DkdqMYjvZX1ZeU
         aI8NTk+qR4l/e8QyVFbtMqgyd8Xs8xsSZxofSoIxP0IfgH5Y4dYqdw07KkjY1VztpCHx
         i2og==
X-Gm-Message-State: ABuFfogwjyLqG7Bm014XPTx3EzNDaVqvTpzXma+GxSHvd1DDgZuw9KxE
        qLtGg5IM0eSASQedm3Z5s+nwaNtf22pgDpvpN0H2JyVn
X-Google-Smtp-Source: ACcGV62zhKq/+aR4r2SgheDyLA5kOCHbdHD1lN5O3YevTtdyNtYVLMn8n2+qLvT1zQqdxmubMovoTKCzDXzGXie3KWs=
X-Received: by 2002:a37:4b44:: with SMTP id y65-v6mr4321296qka.218.1539323978208;
 Thu, 11 Oct 2018 22:59:38 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 12 Oct 2018 15:59:26 +1000
Message-ID: <CAPM=9tzc0vn_bC9eXGpHyf562RmXx7C_rO9=g_JjYz2+xz8TmA@mail.gmail.com>
Subject: [git pull[ drm fixes for 4.19-rc8
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

just a single nouveau fix from last week. Seems to be winding now correctly.

Dave.

drm-fixes-2018-10-12-1:
single nouveau runtime reference and mst change
The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-10-12-1

for you to fetch changes up to 5ba15878f23c4bafb95afa0dabe9d08d89520259:

  Merge branch 'linux-4.19' of git://github.com/skeggsb/linux into
drm-fixes (2018-10-08 16:37:59 +1000)

----------------------------------------------------------------
single nouveau runtime reference and mst change

----------------------------------------------------------------
Dave Airlie (1):
      Merge branch 'linux-4.19' of git://github.com/skeggsb/linux into drm-fixes

Lyude Paul (1):
      drm/nouveau/drm/nouveau: Grab runtime PM ref in nv50_mstc_detect()

 drivers/gpu/drm/nouveau/dispnv50/disp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)
