Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9393C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8514A2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8514A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbeKOWHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:07:46 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36652 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKOWHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:07:46 -0500
Received: by mail-oi1-f170.google.com with SMTP id r127-v6so16514610oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 04:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DLYLnAp7oKkXxtcqmiShaxm/JJayVA+5CjfmFG4t3Ks=;
        b=UP0HAFOurwVH8ioDdb0HMWiLWLXzjLwtRpt/ZMYj8XTaEJQD2lhxExHFbgvl6fZkbL
         PCkmTfeu9JEKINTMf+Axq2O2DJiVpenZVnnhp2i5zHQxi+BrWPLY+0OLRrNfbEpyDvSc
         4H0rbhzVRIm/oQLHEl1dhDscQbVMQCQS8uDWly0ylzT+/h6v8JdpgYN8yAOK3FA11zqm
         N8rQMa8oFwXZDtroOWD8Cc31c3W7JdSn59tw8zrSsRnChkILzuzPMKHaanwzpAjZRlr8
         jGKMcUk86CAM0e1rleHhyBQXfcl4Yw1HbDqAJsh0EbVIz2mhIWpYsfuM1L9ptwYA944R
         gNHw==
X-Gm-Message-State: AGRZ1gK5pF1kiBa37DelYpdVBFdvBKHIsIleL/Fk7KAzXYkhYnSzeXC8
        e+X+AOsq4/YjKSbn1GWpThKZ3RwL9iEdjxSbm6FCqg==
X-Google-Smtp-Source: AJdET5dSzkaUwcjtCBVWOB7o7rdQMtjV+VuXEPzqjnxAlcbm0iB6l59zfW9z4tPGDwmYFFTuwfLSIDUxoBm98u20EtA=
X-Received: by 2002:aca:3785:: with SMTP id e127-v6mr3565044oia.147.1542283212791;
 Thu, 15 Nov 2018 04:00:12 -0800 (PST)
MIME-Version: 1.0
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 15 Nov 2018 13:00:01 +0100
Message-ID: <CAHc6FU6P0HdDWGMmsjyArQ746N7RBE3qMVq3aZgkfGjb153yJw@mail.gmail.com>
Subject: [GIT PULL] gfs2: 4.20 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following gfs2 fixes for 4.20?

Thank you,
Andreas

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
tags/gfs2-4.20.fixes2

for you to fetch changes up to 77d36cabdf8e7c8d46b3e275a3d7958549de04b0:

  gfs2: Fix iomap buffer head reference counting bug (2018-11-11 12:20:05 +0000)

----------------------------------------------------------------
Fix two bugs leading to leaked buffer head references:

  gfs2: Put bitmap buffers in put_super
  gfs2: Fix iomap buffer head reference counting bug

And one bug leading to significant slow-downs when deleting large files:

  gfs2: Fix metadata read-ahead during truncate (2)

----------------------------------------------------------------
Andreas Gruenbacher (4):
      gfs2: Put bitmap buffers in put_super
      gfs2: Fix metadata read-ahead during truncate (2)
      Merge tag 'v4.20-rc1'
      gfs2: Fix iomap buffer head reference counting bug

 fs/gfs2/bmap.c | 54 +++++++++++++++++++++++++++---------------------------
 fs/gfs2/rgrp.c |  3 ++-
 2 files changed, 29 insertions(+), 28 deletions(-)
