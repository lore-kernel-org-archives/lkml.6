Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55528ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85ED2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85ED2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeJRC7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:59:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbeJRC7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:59:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 580BEB010;
        Wed, 17 Oct 2018 19:02:18 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, nsaenzjulienne@suse.de, devel@driverdev.osuosl.org
Subject: [PATCH v2 0/7] staging: bcm2835-audio: Cleanups and upgrades
Date:   Wed, 17 Oct 2018 21:01:49 +0200
Message-Id: <20181017190156.30010-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just received a RPi3B+ and decided to have a go at fixing stuff in the
audio driver. The changes are mostly cosmetic. I also took the liberty
to update the TODO file.

The series was developed on top of linux-next and tested on a RPi2B and
RPi3B+. Sadly I don't have an HDMI monitor with sound so I only tested
the mini jack output.

Thanks,
Nicolas

v2: Removes the device tree related patches, updates TODO accordingly
    and adds suggestions from Takashi.

----

Nicolas Saenz Julienne (7):
  staging: bcm2835-audio: unify FOURCC command definitions
  staging: bcm2835-audio: don't initialize memory twice
  staging: bcm2835-audio: reorder variable declarations & remove trivial
    comments
  staging: bcm2835-audio: use anonymous union in struct vc_audio_msg
  staging: bcm2835-audio: more generic probe function name
  staging: bcm2835-audio: rename platform_driver structure
  staging: bcm2835-audio: update TODO

 .../staging/vc04_services/bcm2835-audio/TODO  | 25 ++----------
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 10 +----
 .../bcm2835-audio/bcm2835-vchiq.c             | 39 ++++++++-----------
 .../vc04_services/bcm2835-audio/bcm2835.c     | 26 ++++++-------
 .../bcm2835-audio/vc_vchi_audioserv_defs.h    |  6 ++-
 5 files changed, 38 insertions(+), 68 deletions(-)

-- 
2.19.1

