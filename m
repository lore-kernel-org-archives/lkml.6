Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42EE3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030982086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030982086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933509AbeFLOcZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:32:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49581 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754312AbeFLOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:32:22 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fSkLK-0000OB-HG; Tue, 12 Jun 2018 15:32:18 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ruslan.bilovol@gmail.com
Subject: [PATCH 0/2] ALSA: usb-audio: Insertion Control for BADD Adaptors.
Date:   Tue, 12 Jun 2018 15:31:59 +0100
Message-Id: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Insertion Control for BADD devices (subset of UAC3).

This control is only pressent in the HEADSET ADAPTER BADD profile. The USB interrupt pipe
shall be present for this profile so the status pipe creation should also happen for BADD
devices.

Also, the bi-directional type codes have been defined so they can be used as inferred values
for the Input and Output terminals for this adapter profile.

-- 
Based on tag: next-20180612

Jorge Sanjuan (2):
  ALSA: usb-audio: Add bi-directional terminal types.
  ALSA: usb-audio: UAC3. Add insertion control for BADD.

 include/uapi/linux/usb/audio.h |  8 ++++++++
 sound/usb/mixer.c              | 45 ++++++++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.11.0

