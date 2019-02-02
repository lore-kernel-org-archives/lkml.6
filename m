Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABFEC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9E720856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UusvYNRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfBBRKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:10:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45715 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBBRKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:10:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so11267648qtr.12;
        Sat, 02 Feb 2019 09:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=R3wLluV1AluAZvFSZbyGqDn6CTOFMHRiddeAm1OG2mI=;
        b=UusvYNRh/1x2IenSaNaAFX4gYYvKB/AU/22c2p5hMAp8lNG1gJNWMxMiLKAUzSFgQF
         PYty1otOUneX/s9FfB8guEHB0XY0fW6bRz4NkZSeU9J0RThLsSY2sPi5NaytWzi9ZbIZ
         hUgum14gQywq4I/wZb/O74Rez4XcZXBNJnSiwPUBn3OsdytJBX55Ea0mW/Rv6QUN12+h
         J66oX16EisyhTVe/uhtSv44z7XzkbBhmbMSejf+u6h7LFESNX2tato/BhjlSEMdNH1Pe
         eXWyfCVRs26eZKQkcdKnloUi0nbYrIcm/H6VRArCro1s7b2wzGq/4+IWdmSMpoaEZKL2
         8wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=R3wLluV1AluAZvFSZbyGqDn6CTOFMHRiddeAm1OG2mI=;
        b=WShx3oS929OVb/O0tIVFeKOpLXGqr/1Njip/8ZZ5BxnZZk0+SC9gExWIaJCvOYRZkQ
         AEnAc8zFBU8I0XmwOr6FPcs0zB51erSuy02ySUpg5ykqV5PHg21nJPZ+RV/n/Efl9Z+R
         dTnQLBRhDYoSOgOyN7UDFloPfcydnuysUG6YcWdGO/YQy7qXrk2O347eo3fNMlrR9dkK
         /RMN+LznrgnU+B4Px5e8/KhTHCxY2cBayj4bgkcrKX6mQESHcJWvyg6Cc6q2yEVH45es
         ldjujLB+XkLEdrNaubMUulm2Abj9buHh9SEordeokCEngdmW/Ej9aQXW8b8b2rKLqSbW
         OKJg==
X-Gm-Message-State: AJcUukfRSLc6iROlBncTW941l27eSqA8jYuN+51G1uuYc9o1TgRr5zDx
        mfWI5aGHD83iEtLxZR0Ln0xF2yiyOxrJJtZrkA==
X-Google-Smtp-Source: ALg8bN4wq3myVFM/ZvnCSELHrGtSKnlkdiJuGyiJhWtwbDqxc0LMS4j7pyGQTE/k8xp3OmuvnLoxYMe/Xni1EdfJGAM=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr43143831qtj.76.1549127417426;
 Sat, 02 Feb 2019 09:10:17 -0800 (PST)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Sat, 2 Feb 2019 11:10:06 -0600
Message-ID: <CAL_JsqLPN1ko5nPSTh80EQa2Zz_LHvFFCw42XYBcv8VSa_cYvg@mail.gmail.com>
Subject: [GIT PULL] Devicetree fix for 5.0-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull.

Rob

The following changes since commit 75a080cde08d2dcba19ee864f9732094d93fab41:

  powerpc: chrp: Use of_node_is_type to access device_type (2019-01-19
10:35:42 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-5.0-3

for you to fetch changes up to 5fa98c2eda35fcd1a1d91a9785c390f54688240c:

  dt-bindings: Fix dt_binding_check target for in tree builds
(2019-01-23 09:15:57 -0600)

----------------------------------------------------------------
A single fix for building DT bindings in-tree.

----------------------------------------------------------------
Rob Herring (1):
      dt-bindings: Fix dt_binding_check target for in tree builds

 Documentation/devicetree/bindings/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
