Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5533620779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5533620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbeGWIsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:48:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60247 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387992AbeGWIrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:47:55 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fhVZT-0007um-Mf; Mon, 23 Jul 2018 09:47:55 +0200
Received: from mfe by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <mfe@pengutronix.de>)
        id 1fhVZS-0007la-IX; Mon, 23 Jul 2018 09:47:54 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     fabio.estevam@nxp.com, devicetree@vger.kernel.org,
        kernel@pengutronix.de, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Re-Enable support to disable switch regulators
Date:   Mon, 23 Jul 2018 09:47:45 +0200
Message-Id: <20180723074747.9328-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.18.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Anson had added the support to disable the switched regulators, but
there were regressions [1] with old dtb's, so the commit was reverted [2].
At all, the support to disable the switch regulators seems to me to be a
good feature. But we have to add a special dt-property to avoid
regressions with older kernels. The property allows the user to decide if
the switch regulators should be disabled or not.

Since the revert patch is on Marks regulator repo, my patches are based
on his repo too. Each commit has a changelog, so I ommit it here. I
tested it on a custom board.

Used Kernel:
Repo:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
Branch:
regulator/for-4.19

Regards,
Marco

[1] https://patchwork.kernel.org/patch/10490381/
[2] https://patchwork.kernel.org/patch/10500333/

Marco Felsch (2):
  dt-bindings: pfuze100: add optional disable switch-regulators binding
  regulator: pfuze100: add support to en-/disable switch regulators

 .../bindings/regulator/pfuze100.txt           |  9 +++++
 drivers/regulator/pfuze100-regulator.c        | 36 +++++++++++++++++++
 2 files changed, 45 insertions(+)

-- 
2.18.0

