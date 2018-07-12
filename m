Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB83FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0B3208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0B3208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeGLLLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:11:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35527 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbeGLLLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:53 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdZMy-00068Y-Rt; Thu, 12 Jul 2018 13:02:44 +0200
Received: from mfe by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdZMy-00014Z-1K; Thu, 12 Jul 2018 13:02:44 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Re-Enable support to disable switch regulators
Date:   Thu, 12 Jul 2018 13:02:38 +0200
Message-Id: <20180712110240.3006-1-m.felsch@pengutronix.de>
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
regressions with older kernels.

The property allows the user to decide if the switch regulators should
be disabled in real or if it is a 'simulated' disabling. By 'simulated'
I mean that the regulator-fw think it is disabled but the switch keeps
on in real.

Since the revert patch is on Marks regulator repo, my patches are based
on his repo too.

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
  dt-bindings: pfuze100: add optional pfuze-disable-sw binding
  regulator: pfuze100: add support to en-/disable switch regulators

 .../bindings/regulator/pfuze100.txt           |  8 ++++++
 drivers/regulator/pfuze100-regulator.c        | 26 +++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.18.0

