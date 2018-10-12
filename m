Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59F2C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A00520865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A00520865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbeJLXEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:04:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43067 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbeJLXEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:04:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id p34-v6so9613083lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gGOgPpxHabdlfaa8kF6e+iMWj1eaZSwypQdSRUJOT4o=;
        b=KKWVOCdA0V0SZuUcyZ0/ydR1nFRM1AW6sRuw9zdEmAocxGIFNMFQXEFlibacFZ9NgF
         hsaZGjjYVDJlqVLHBprHXWjkcQMqOwSAtIb0bywcjqX72HDWdbLh1QOJaPvrGeFR1/35
         AA53zJPNKFW2Gn9/KIOsX2hH87F27nTJEabvC/CpQTKtWIMm9I1BUXkiTjX2B206n2MH
         HuEePHi2xTj9qmgMWp7S3rRqr1w+Ar/IiBn+h1TP9wZmIj8nfIlGQYWarj1/VpPPOV8H
         6L73bl9t52wCnwO8h7gpU8r/PsuTmSfdoloUgEutiscVuqjjCZ2nMc4Jvof0RgfmO8pd
         2GmQ==
X-Gm-Message-State: ABuFfojXa6LSshCxxyUxp3rVk2fTBO0A6MxKGetanEi+Z0tfiOGk10SX
        5n2mFrQStfMsq09Rm5towREbipJ0uqe0fmlmjRk=
X-Google-Smtp-Source: ACcGV62RMnR0Gl/r/Bt0mIJTBZCBqD0/c6dsLUEwIiPKVjT3PaEozJgPv8okFhGLTT/NWmFMptaJvz83vc4s2fKUhi8=
X-Received: by 2002:a19:6f0a:: with SMTP id k10-v6mr4364429lfc.8.1539358294319;
 Fri, 12 Oct 2018 08:31:34 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Oct 2018 17:31:17 +0200
Message-ID: <CAK8P3a0V3ddscW3x94rU0Yfh3HuTWhuhTsaKhKVy85+8ygf3Lg@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for 4.19
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes-4.19

for you to fetch changes up to 3f4258bbe0363b3d5330b93de0e86b7796ff1a74:

  Merge tag 'soc-fsl-fix-v4.19-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux into fixes
(2018-10-04 18:01:20 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.19

Two last minute bugfixes, both for NXP platforms:

* The Layerscape 'qbman' infrastructure suffers from probe ordering
  bugs in some configurations, a two-patch series adds a hotfix for
  this. 4.20 will have a longer set of patches to rework it.

* The old imx53-qsb board regressed in 4.19 after the addition
  of cpufreq support, adding a set of explicit operating points
  fixes this.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'imx-fixes-4.19-2' of
git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'soc-fsl-fix-v4.19-2' of
git://git.kernel.org/.../leo/linux into fixes

Laurentiu Tudor (2):
      soc: fsl: qbman: add APIs to retrieve the probing status
      soc: fsl: qman_portals: defer probe after qman's probe

Sascha Hauer (1):
      ARM: dts: imx53-qsb: disable 1.2GHz OPP

 arch/arm/boot/dts/imx53-qsb-common.dtsi | 11 +++++++++++
 drivers/soc/fsl/qbman/bman_ccsr.c       | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_ccsr.c       | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_portal.c     |  8 ++++++++
 include/soc/fsl/bman.h                  |  8 ++++++++
 include/soc/fsl/qman.h                  |  8 ++++++++
 6 files changed, 57 insertions(+)
