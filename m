Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFF9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B500620685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kcQEAB+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B500620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeKTVcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:32:25 -0500
Received: from casper.infradead.org ([85.118.1.10]:51108 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeKTVcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CmGQJk62DSmTFuatB/VB1qcTVqDOB5qaZsK7xh0vPv4=; b=kcQEAB+khIndx5g5TEbfJP4v4U
        PpcOtIFMonnPl+i663DLnQjGUoNRX4D/coZNxIkj61L6efl/CmsLECWV5dIt8aHOv/CkBXanIYjVS
        Mjf80hof7mzuvoRZ2s06HfnLGbCRjdE81LQO5POjvs2kMLsqevdmj8ZmF5qd1BtGLRoloE4gYYOu5
        jTEDYjdnPvt7QxfjaitukXS/rMVAkedtoawGCUM58q3xyytMjZssCSy8JUl9j8bPhIgiLpTc3Y2id
        blGQWWspX3nbRNQkwv/pQ68n1isrQ6eRE8EL6VIThL0GYP+rRpcuV9Oaiob+Cfl/BrD7j5jqsbjhe
        tUkli0DQ==;
Received: from [177.157.76.226] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP3oq-0006Sd-Uz; Tue, 20 Nov 2018 11:03:49 +0000
Date:   Tue, 20 Nov 2018 09:03:44 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v4.20-rc4] media fixes
Message-ID: <20181120090344.6ba64433@coco.lan>
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
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v4.20-3

For a series of fixes:
  - add a missing include at v4l2-controls uAPI header;
  - minor kAPI update for the request API;
  - some fixes at CEC core;
  - use a lower minimum height for the virtual codec driver;
  - cleanup a gcc warning due to the lack of a fall though markup;
  - tc358743: Remove unnecessary self assignment
  - fix the V4L event subscription logic
  - docs: Document metadata format in struct v4l2_format
  - omap3isp and ipu3-cio2: fix unbinding logic

PS.: I was meant to send this two weeks ago, but LPC/KS trip ended by
delaying this pull request.

Regards,
Mauro

-

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v4.20-3

for you to fetch changes up to 4e26f692e2e2aa4d7d6ddb3c4d3dec17f45d6495:

  media: ipu3-cio2: Use cio2_queues_exit (2018-11-06 07:11:59 -0500)

----------------------------------------------------------------
media fixes for v4.20-rc4

----------------------------------------------------------------
Arnd Bergmann (1):
      media: v4l: fix uapi mpeg slice params definition

Ezequiel Garcia (1):
      media: Rename vb2_m2m_request_queue -> v4l2_m2m_request_queue

Hans Verkuil (3):
      media: vicodec: lower minimum height to 360
      media: cec: check for non-OK/NACK conditions while claiming a LA
      media: cec: increase debug level for 'queue full'

Mauro Carvalho Chehab (3):
      v4l2-controls: add a missing include
      Merge tag 'v4.20-rc1' into patchwork
      media: dm365_ipipeif: better annotate a fall though

Nathan Chancellor (1):
      media: tc358743: Remove unnecessary self assignment

Sakari Ailus (5):
      media: v4l: event: Add subscription to list before calling "add" operation
      media: docs: Document metadata format in struct v4l2_format
      media: omap3isp: Unregister media device as first
      media: ipu3-cio2: Unregister device nodes first, then release resources
      media: ipu3-cio2: Use cio2_queues_exit

 Documentation/media/uapi/v4l/dev-meta.rst          |  2 +-
 Documentation/media/uapi/v4l/vidioc-g-fmt.rst      |  5 +++
 drivers/media/cec/cec-adap.c                       | 49 +++++++++++++++++-----
 drivers/media/i2c/tc358743.c                       |  1 -
 drivers/media/pci/intel/ipu3/ipu3-cio2.c           |  6 +--
 drivers/media/platform/omap3isp/isp.c              |  3 +-
 drivers/media/platform/vicodec/vicodec-core.c      |  2 +-
 drivers/media/platform/vim2m.c                     |  2 +-
 drivers/media/v4l2-core/v4l2-ctrls.c               |  5 +++
 drivers/media/v4l2-core/v4l2-event.c               | 43 ++++++++++---------
 drivers/media/v4l2-core/v4l2-mem2mem.c             |  4 +-
 drivers/staging/media/davinci_vpfe/dm365_ipipeif.c |  1 +
 drivers/staging/media/sunxi/cedrus/cedrus.c        |  2 +-
 include/media/v4l2-mem2mem.h                       |  2 +-
 include/uapi/linux/v4l2-controls.h                 |  5 +++
 15 files changed, 89 insertions(+), 43 deletions(-)

