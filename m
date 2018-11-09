Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D27C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DC220827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5TRteu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DC220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeKJHWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:22:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47000 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeKJHWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:22:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so4256373qkf.13;
        Fri, 09 Nov 2018 13:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7KJG27ObTrdYgeblw+pbQpZdm7+ORaCNagHyv+Bl4Mo=;
        b=o5TRteu0J+PQ3Wc0ntvxU7geZ+9zSvTsAphTleL0wH50W0VIEW0D//GvPdrAj+eXT5
         DnHHdGK8T2u/rz4lYuR3+tPDfk56vSjoKufVQB2b02hrYBmA5ZpooouCYUseLFrPcywE
         pGVusxNnDlaiPcxHVZJNv/Q5OWI/TGjMW2w8jvUiPXvYuUeAR4fNT2Stq6ozqenKDIZI
         bSaH3oybEloYTak9ob4kxIFscfgg+2JLDxMt7sRAqAHx/GvEdfP/MOoZ3Sp0V0HMb+6R
         U4eIaRs/BY6r9lZEilbwfoUGQR3uzYFbKmdDk9G38NZP9DfPvEDd84rfCNjWuANxiP6D
         Nf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7KJG27ObTrdYgeblw+pbQpZdm7+ORaCNagHyv+Bl4Mo=;
        b=UzxfVS4j4fm+yM9XNr2XoP4HSsQvTVOZYrnWOFsox8Vd4sB9UErqwCGRZDmMV22ymz
         FLK4RNJt63k7lzhjLW7OnULVLjO95wk0tHIg5fCR8GhUwtwSYfQWkyB+MYF6vXwIl6M8
         aSBA90thYL+3cjF3OysmDHBp/p4qcWBYHRmYjgkkKZDItwtPeOjf+srl+D9gxdP7x9Wh
         RvJEqJYuwSAsw10DlJbWV9AaMBMTI/2Ie4+NNj12E0XDzSjwtXt0iDwIedq249hxDyM2
         qEYLbfRT60Fxw5q/+YDynf3coH4u5MLI/IncDnzfrjFt/YEp13LbyU8jy4PGOijY1whR
         U8TQ==
X-Gm-Message-State: AGRZ1gIjnTNemzMpSntffqzt/zn90aihwmqdJri8J0JT8wwKN7wnPYcU
        wOYiac0VG21LPRtL1qjwXwB+VJJMmYY2KgamktjJY3Q=
X-Google-Smtp-Source: AJdET5fZ4OAmtZUIDRkJYgvl/SNegwrGM8SboQ6stX6ik0s634hAYc5fX4Vb60v+xYgSCO1d+nVxqG8KAV3TLe7S9aE=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr10577600qvb.218.1541799595276;
 Fri, 09 Nov 2018 13:39:55 -0800 (PST)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Fri, 9 Nov 2018 15:39:43 -0600
Message-ID: <CAL_JsqLOqQ3p7mScZVfusQkrEvNCKzCWL+u1Jfe_d91Eh_krwQ@mail.gmail.com>
Subject: [GIT PULL] Devicetree fixes for 4.20-rc, round 2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull.

Rob

The following changes since commit c961cb3be9064d1097ccc019390f8b5739daafc6:

  of: Fix cpu node iterator to not ignore disabled cpu nodes
(2018-11-01 16:16:54 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-4.20-2

for you to fetch changes up to 89c38422e072bb453e3045b8f1b962a344c3edea:

  of, numa: Validate some distance map rules (2018-11-08 12:44:34 -0600)

----------------------------------------------------------------
Devicetree fixes for 4.20-rc:

- Add validation of NUMA distance map to prevent crashes with bad map

- Fix setting of dma_mask

----------------------------------------------------------------
John Garry (1):
      of, numa: Validate some distance map rules

Robin Murphy (1):
      of/device: Really only set bus DMA mask when appropriate

 drivers/of/device.c  | 4 +++-
 drivers/of/of_numa.c | 9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)
