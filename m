Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD59C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CB620656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfANBZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 20:25:53 -0500
Received: from muru.com ([72.249.23.125]:33516 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfANBZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 20:25:52 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8420A8139;
        Mon, 14 Jan 2019 01:25:58 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH 0/3] serdev support for n_gsm
Date:   Sun, 13 Jan 2019 17:25:25 -0800
Message-Id: <20190114012528.2367-1-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a series of patches to add initial serdev support to n_gsm
TS 27.010 line discipline.

This allows handling vendor specific protocols on top of TS 27.010 and
allows creating simple serdev drivers where it makes sense. So far I've
tested it with droid 4 for it's modem to provide char devices for AT
ports, modem PM support, and serdev drivers for GNSS and Alsa ASoC.

I'll be posting the related MFD, GNSS and Alsa ASoC drivers separately.
For reference, the MFD driver is at [0], the GNSS driver at [1], and
the Alsa ASoC driver at [2] below.

Regards,

Tony


[0] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/tree/drivers/mfd/motorola-mdm.c?h=droid4-pending-mdm-v4.20
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/tree/drivers/gnss/motmdm.c?h=droid4-pending-mdm-v4.20
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/tree/sound/soc/codecs/motmdm.c?h=droid4-pending-mdm-v4.20


Tony Lindgren (3):
  tty: n_gsm: Add copy_config() and gsm_config() to prepare for serdev
  n_gsm: Constify u8 and unsigned char usage
  tty: n_gsm: Add support for serdev drivers

 drivers/tty/n_gsm.c        | 548 +++++++++++++++++++++++++++++--------
 include/linux/serdev-gsm.h | 227 +++++++++++++++
 2 files changed, 663 insertions(+), 112 deletions(-)
 create mode 100644 include/linux/serdev-gsm.h

-- 
2.20.1
