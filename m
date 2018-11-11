Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C175AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE2F20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE2F20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbeKLFsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51062 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729606AbeKLFsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:30 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvso-0000lK-R9; Sun, 11 Nov 2018 19:58:59 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001lE-MW; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Fabian Frederick" <fabf@skynet.be>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.496358053@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 278/366] can: constify of_device_id array
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Fabian Frederick <fabf@skynet.be>

commit 486e957033623656298a07c39a8bf2fd81db285b upstream.

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/cc770/cc770_platform.c     | 2 +-
 drivers/net/can/grcan.c                    | 2 +-
 drivers/net/can/mscan/mpc5xxx_can.c        | 2 +-
 drivers/net/can/sja1000/sja1000_platform.c | 2 +-
 drivers/net/can/xilinx_can.c               | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -254,7 +254,7 @@ static int cc770_platform_remove(struct
 	return 0;
 }
 
-static struct of_device_id cc770_platform_table[] = {
+static const struct of_device_id cc770_platform_table[] = {
 	{.compatible = "bosch,cc770"}, /* CC770 from Bosch */
 	{.compatible = "intc,82527"},  /* AN82527 from Intel CP */
 	{},
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1725,7 +1725,7 @@ static int grcan_remove(struct platform_
 	return 0;
 }
 
-static struct of_device_id grcan_match[] = {
+static const struct of_device_id grcan_match[] = {
 	{.name = "GAISLER_GRCAN"},
 	{.name = "01_03d"},
 	{.name = "GAISLER_GRHCAN"},
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -43,7 +43,7 @@ struct mpc5xxx_can_data {
 };
 
 #ifdef CONFIG_PPC_MPC52xx
-static struct of_device_id mpc52xx_cdm_ids[] = {
+static const struct of_device_id mpc52xx_cdm_ids[] = {
 	{ .compatible = "fsl,mpc5200-cdm", },
 	{}
 };
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -242,7 +242,7 @@ static int sp_remove(struct platform_dev
 	return 0;
 }
 
-static struct of_device_id sp_of_table[] = {
+static const struct of_device_id sp_of_table[] = {
 	{.compatible = "nxp,sja1000"},
 	{},
 };
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1184,7 +1184,7 @@ static int xcan_remove(struct platform_d
 }
 
 /* Match table for OF platform binding */
-static struct of_device_id xcan_of_match[] = {
+static const struct of_device_id xcan_of_match[] = {
 	{ .compatible = "xlnx,zynq-can-1.0", },
 	{ .compatible = "xlnx,axi-can-1.00.a", },
 	{ /* end of list */ },

