Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2974C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B710E245F6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B710E245F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbeGDKQD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:16:03 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43565 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbeGDKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:16:01 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C4328C001C;
        Wed,  4 Jul 2018 10:16:01 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, ysato@users.sourceforge.jp,
        dalias@libc.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] sh: Remove soc_camera from defconfigs
Date:   Wed,  4 Jul 2018 12:15:37 +0200
Message-Id: <1530699346-3235-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,
   this series removes the last occurrencies of soc_camera from arch/sh, this
time hopefully for real :)

I have updated defconfigs of the following boards to the last v4.18-rc2:
- Migo-R
- Ecovec24
- SE7724
- AP325RXA

and then enabled in defconfigs the new CEU driver with the associated image
sensor and video decoder driver.

Finally, I removed a stale include from Migo-R board file to which you pointed
me.

Boot-tested on Migo-R, compile tested only for other platforms.

As usual, I'll let you pick this patches up, as this is work sparkled from
multimedia related issues, or either have them get in though the SH
maintainers tree if they prefer to.

Thanks
   j

Jacopo Mondi (9):
  sh: defconfig: migor: Update defconfig
  sh: defconfig: migor: Enable CEU and sensor drivers
  sh: defconfig: ecovec: Update defconfig
  sh: defconfig: ecovec: Enable CEU and video drivers
  sh: defconfig: se7724: Update defconfig
  sh: defconfig: se7724: Enable CEU and sensor driver
  sh: defconfig: ap325rxa: Update defconfig
  sh: defconfig: ap325rxa: Enable CEU and sensor driver
  sh: migor: Remove stale soc_camera include

 arch/sh/boards/mach-migor/setup.c  |  1 -
 arch/sh/configs/ap325rxa_defconfig | 29 +++++++----------------------
 arch/sh/configs/ecovec24_defconfig | 35 ++++++++---------------------------
 arch/sh/configs/migor_defconfig    | 31 ++++++++-----------------------
 arch/sh/configs/se7724_defconfig   | 30 ++++++------------------------
 5 files changed, 29 insertions(+), 97 deletions(-)

--
2.7.4

