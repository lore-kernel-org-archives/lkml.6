Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB90AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B097420878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B097420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbeGKMmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:42:14 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56060 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbeGKMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:12 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fdENd-00042U-LM; Wed, 11 Jul 2018 13:38:01 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] UAC3: Add Selectors and Processing Units.
Date:   Wed, 11 Jul 2018 13:37:50 +0100
Message-Id: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is motivated by the addition of Multi Function
Processing Units (MFPU) to an UAC3 topology where there could be
signal processing algorithims applied to the audio signal.

The MFPUs themself don't provide any useful control, they offer a 
description of what algorithims it supports and it is for Selector Units
to take the bypass control of the dry (unprocessed) signal and the modified
one. Moreover, Up/Down mixers may be needed in this topologies to control
which outputs of the logical output cluster from the MFPU are to be passed 
as the final modified audio signal.

These patches add support for Selector Units and Processing units for UAC3
and adds a couple fixes that I found while implemeting them:

 1) Defualt naming of the virtual terminals was not accurate due to codes
    overlap between the three UAC standards.
 2) UAC2 parsing of processing units was using UAC1 controls bitmap.

Based on: next-20180711

Jorge Sanjuan (5):
  ALSA: usb-audio: Add support for Selector Units in UAC3
  ALSA: usb-audio: Processing Unit controls parsing in UAC2
  ALSA: usb-audio: Add support for Processing Units in UAC3
  ALSA: usb-audio: Unify virtual type units type to UAC3 values
  ALSA: usb-audio: Tidy up logic for Processing Unit min/max values

 include/linux/usb/audio-v3.h   |  15 +++
 include/uapi/linux/usb/audio.h |  49 ++++++++--
 sound/usb/mixer.c              | 212 +++++++++++++++++++++++++++++++++--------
 3 files changed, 225 insertions(+), 51 deletions(-)

-- 
2.11.0

