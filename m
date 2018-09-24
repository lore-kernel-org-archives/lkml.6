Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1124AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AD02148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBEx9NS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AD02148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbeIXS2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:28:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbeIXS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OGphOM6JdKkmme4bOwtZjwFA5f7w3qmaFpokZs+sefg=; b=JBEx9NS7lMOs1hz+moV1G79fd
        +DS+wzkLqMe2PsLqbiR6vkzIGViPFPbnhqdXkeV2t+VN6ger6tZvMV2VOJL1xfLNm2es29DtsY5i9
        t1FbxHC9NyAbfVdeMrZLkDPwlHOcE5Pjxetw88BB9pIhTpKPAGgb3mt2++X1359cwaEou/j344C3u
        yt8EdfPY0FVKZPg6lxPBOvaOUBlAy54ZxWK+GAGuW8y+KuesL+Hh7emhM35oC2tSGOOL8xIPf51zY
        2IDkHbINYtUrU+mNEBbEic/dmnyAK6KjDiW3x9Ag/uRCYoLBbG8yTPVQi8fzzLbH+eO4EMlN0WL+K
        PMHvZxtDA==;
Received: from 179.176.114.192.dynamic.adsl.gvt.net.br ([179.176.114.192] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4Pws-0000ky-7H; Mon, 24 Sep 2018 12:26:46 +0000
Date:   Mon, 24 Sep 2018 09:26:39 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v4.19-rc5] media fixes
Message-ID: <20180924092639.6aaf8371@coco.lan>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v4.19-2

For some drivers and Kbuild fixes.

DISCLAIMER NOTE
========== ====

Please notice that this pull request complies with what's written at
Documentation/process/submitting-patches.rst with regards to meta-tags
like Acked-by and Signed-off-by. 

The patches in this series contain electronic addresses from people
that posted patches and/or replied to them using the usual Kernel
development workflow, e. g. without any explicit request to publish them. 

Feel free to ignore it if you feel it doesn't follow the new CoC.

Thanks!
Mauro

-


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v4.19-2

for you to fetch changes up to 324493fba77500592bbaa66421729421f139d4b5:

  media: platform: fix cros-ec-cec build error (2018-09-17 14:32:29 -0400)

----------------------------------------------------------------
media fixes for v4.19-rc5

----------------------------------------------------------------
Arnd Bergmann (2):
      media: camss: mark PM functions as __maybe_unused
      media: camss: add missing includes

Hans Verkuil (2):
      media: video_function_calls.rst: drop obsolete video-set-attributes reference
      media: staging/media/mt9t031/Kconfig: remove bogus entry

Jacopo Mondi (1):
      media: i2c: mt9v111: Fix v4l2-ctrl error handling

Jozef Balga (1):
      media: af9035: prevent buffer overflow on write

Randy Dunlap (1):
      media: platform: fix cros-ec-cec build error

Todor Tomov (1):
      media: camss: Use managed memory allocations

 .../media/uapi/dvb/video_function_calls.rst        |  1 -
 drivers/media/i2c/mt9v111.c                        | 41 +++++++---------------
 drivers/media/platform/Kconfig                     |  2 ++
 drivers/media/platform/qcom/camss/camss-csid.c     |  1 +
 .../platform/qcom/camss/camss-csiphy-2ph-1-0.c     |  1 +
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |  1 +
 drivers/media/platform/qcom/camss/camss-csiphy.c   |  1 +
 drivers/media/platform/qcom/camss/camss-ispif.c    |  5 +--
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c  |  1 +
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c  |  1 +
 drivers/media/platform/qcom/camss/camss.c          | 15 ++++----
 drivers/media/usb/dvb-usb-v2/af9035.c              |  6 ++--
 drivers/staging/media/mt9t031/Kconfig              |  6 ----
 13 files changed, 36 insertions(+), 46 deletions(-)

