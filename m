Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FA4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3E6215A5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XS6n2BlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3E6215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbeHCB3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:29:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeHCB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w2J+ZKW/Apm/xUgs1CE3KFK0R4CMq0WU615Be24QUiQ=; b=XS6n2BlXD/RzJ09n3f+x3J5uk
        9pgF+VZbi+/14pUF8DKwgqv6R/WUQxrAI+yLnnppIuWw1TgupBpddf0JatDggXp7Hq9abmctljbi5
        M4o5Mo8Ci4A1OINeGDX0UrliRz5LAm9qASFMAqRFENP/9m9Yffqr3ESg/R9YGtV7oabifpXeMGAQc
        MQazYkEk6+sAHFLohW06uARtGKvog+n6N0xdnC2AzhSXwEZLQO0dTvEEQcUWP4T0M8eumCVlsc0uF
        FX3NjWZZ7tEEb6/hf3CUAEGsA7Z80uEaSd00sv8o92aDNUTK9SysPg6ZBWrQQLlhVMB/0aoPIEAge
        6QhZ3VF6w==;
Received: from 189.27.18.116.dynamic.adsl.gvt.net.br ([189.27.18.116] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flN8a-0005d5-3D; Thu, 02 Aug 2018 23:36:08 +0000
Date:   Thu, 2 Aug 2018 20:36:04 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v4.18-rc8] media fixes
Message-ID: <20180802203604.1d219a10@coco.lan>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v4.18-3

For:

  - a dead lock regression at vsp1 driver;
  - some Remote Controller fixes related to the new BPF filter
    logic added on it for Kernel 4.18.

Thanks!
Mauro

-

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v4.18-3

for you to fetch changes up to 8eb0e6421958e9777db98448a4030d8ae940c9a0:

  media: v4l: vsp1: Fix deadlock in VSPDL DRM pipelines (2018-07-30 08:22:59 -0400)

----------------------------------------------------------------
media fixes for v4.18-rc8

----------------------------------------------------------------
Laurent Pinchart (1):
      media: v4l: vsp1: Fix deadlock in VSPDL DRM pipelines

Sean Young (3):
      media: rc: be less noisy when driver misbehaves
      media: bpf: ensure bpf program is freed on detach
      media: rc: read out of bounds if bpf reports high protocol number

 drivers/media/platform/vsp1/vsp1_drm.c |  4 +---
 drivers/media/rc/bpf-lirc.c            |  1 +
 drivers/media/rc/rc-ir-raw.c           |  8 ++++----
 drivers/media/rc/rc-main.c             | 12 ++++++++++--
 4 files changed, 16 insertions(+), 9 deletions(-)

