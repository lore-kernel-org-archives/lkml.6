Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B6BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3AE20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3AE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJPWys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:54:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbeJPWys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:54:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25C46AF68;
        Tue, 16 Oct 2018 15:03:55 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, tiwai@suse.de,
        nsaenzjulienne@suse.de
Subject: [PATCH 0/9] staging: bcm2835-audio: Cleanups and upgrades
Date:   Tue, 16 Oct 2018 17:02:19 +0200
Message-Id: <20181016150228.16994-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just received a RPi3B+ and decided to have a go at fixing stuff in
the audio driver:

The first half of the patchset are just random fixes found while reading
the code.

The second half provides devicetree bindings for bcm2835-audio and fixes
the probe sequence so it fails gracefully if VCHIQ isn't there (as per
TODO).

The series was developed on top of linux-next and tested on a RPi2B and
RPi3B+. Sadly I don't have an HDMI monitor with sound so I only tested
the mini jack output.

Thanks,
Nicolas

===

Nicolas Saenz Julienne (9):
  staging: bcm2835-audio: unify FOURCC command definitions
  staging: bcm2835-audio: don't initialize memory twice
  staging: bcm2835-audio: reorder variable declarations & remove trivial
    comments
  staging: bcm2835-audio: use anonymous union in struct vc_audio_msg
  staging: bcm2835-audio: more generic probe function name
  ASoC: dt-bindings: bcm2835-rpi: add onboard audio bindings
  ARM: dts: bcm2835-rpi: add onboard audio device
  staging: vchiq_arm: add function to check if probe was successful
  staging: bcm2835-audio: check for VCHIQ during probe

 .../bindings/sound/brcm,bcm2835-audio.txt     | 15 +++++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |  5 +++
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 10 +----
 .../bcm2835-audio/bcm2835-vchiq.c             | 39 ++++++++-----------
 .../vc04_services/bcm2835-audio/bcm2835.c     | 30 ++++++++------
 .../bcm2835-audio/vc_vchi_audioserv_defs.h    |  6 ++-
 .../vc04_services/interface/vchi/vchi.h       |  3 ++
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  2 +
 .../interface/vchiq_arm/vchiq_arm.c           | 16 ++++++++
 .../interface/vchiq_arm/vchiq_arm.h           |  1 +
 .../interface/vchiq_arm/vchiq_if.h            |  4 ++
 .../interface/vchiq_arm/vchiq_shim.c          |  7 ++++
 12 files changed, 95 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt

-- 
2.19.1

