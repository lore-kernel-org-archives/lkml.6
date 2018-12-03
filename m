Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60655C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A982208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oyYAzkjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A982208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeLCSJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:09:20 -0500
Received: from casper.infradead.org ([85.118.1.10]:59034 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeLCSJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Uj7HCIPyCKKpNRNyaT3DCApf83E0xXs8PSm0Y8yIx0=; b=oyYAzkjznGecKHxKnGJa9BXibE
        l0RhEoRpM4RzXTpLk+79g4w2RUUDG8JJYctZ3709jUWnzMUuNns6AnD82sSwJhMPW4UTDwt9ms3pk
        2iXR50fL23wkwGOx+2yJgWiLf/9RWCh2lh3360kK6zHR8T/Zc5keBRNugxqK1d7Kf4aCxNXtLUTl9
        L/oZvkeQgTh91TnFg7zepNQVuoYs682LfOJ0LFj8ledfQPl3F+IK5vWjdLATbxfPYam6dNvJi9XMz
        K/veYL6Be3cX3UdJdSVd5OC7gTcuAdHryctmTFVbstAaLcwRLAJkZge8XVrcq+qFYpJCm64LfWSZd
        m9NC+PJA==;
Received: from [191.33.148.129] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTseh-0001RM-Cr; Mon, 03 Dec 2018 18:09:15 +0000
Date:   Mon, 3 Dec 2018 16:09:11 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v4.20-rc6] media fixes
Message-ID: <20181203160911.539c9dcd@coco.lan>
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
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v4.20-4

For a couple of fixes:

  - Revert a dt-bindings patch whose driver didn't make for 4.20;
  - fix a kernel oops at vicodec driver;
  - fix a frame overflow at gspca with was causing regressions on some
    cameras, making them to not work;
  - use the proper type for wait_queue head;
  - make media request API compatible with 32 bits userspace on 64 bits
    Kernel;
  - fix a regression on Kernel 4.19 at dvb-pll;
  - don't use SPDX headers yet for GFDL.

Thanks!
Mauro

The following changes since commit 4e26f692e2e2aa4d7d6ddb3c4d3dec17f45d6495:

  media: ipu3-cio2: Use cio2_queues_exit (2018-11-06 07:11:59 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v4.20-4

for you to fetch changes up to a7c3a0d5f8d8cd5cdb32c06d4d68f5b4e4d2104b:

  media: mediactl docs: Fix licensing message (2018-11-27 13:52:46 -0500)

----------------------------------------------------------------
media fixes for v4.20-rc4

----------------------------------------------------------------
Ezequiel Garcia (1):
      media: Revert "media: dt-bindings: Document the Rockchip VPU bindings"

Hans Verkuil (3):
      media: cedrus: add action item to the TODO
      media: vicodec: fix memchr() kernel oops
      media: gspca: fix frame overflow error

Jasmin Jessich (1):
      media: Use wait_queue_head_t for media_request

Jernej Skrabec (1):
      media: media-request: Add compat ioctl

Mauro Carvalho Chehab (3):
      media: dvb-pll: fix tuner frequency ranges
      media: dvb-pll: don't re-validate tuner frequencies
      media: mediactl docs: Fix licensing message

 .../devicetree/bindings/media/rockchip-vpu.txt     |  29 ------
 .../uapi/mediactl/media-ioc-request-alloc.rst      |  26 ++++-
 .../uapi/mediactl/media-request-ioc-queue.rst      |  26 ++++-
 .../uapi/mediactl/media-request-ioc-reinit.rst     |  26 ++++-
 Documentation/media/uapi/mediactl/request-api.rst  |  26 ++++-
 .../media/uapi/mediactl/request-func-close.rst     |  26 ++++-
 .../media/uapi/mediactl/request-func-ioctl.rst     |  26 ++++-
 .../media/uapi/mediactl/request-func-poll.rst      |  26 ++++-
 drivers/media/dvb-frontends/dvb-pll.c              | 106 ++++++++++-----------
 drivers/media/media-request.c                      |   3 +
 drivers/media/platform/vicodec/vicodec-core.c      |   3 +-
 drivers/media/usb/gspca/gspca.c                    |  11 ++-
 drivers/staging/media/sunxi/cedrus/TODO            |   5 +
 include/media/media-request.h                      |   2 +-
 14 files changed, 240 insertions(+), 101 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/rockchip-vpu.txt

