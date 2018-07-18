Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35815ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA00A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SVHmtITm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA00A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeGRNHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:07:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50764 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeGRNHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=O152ACuAPDz3ZpC1NOcyvtjowS9ujN55kct1cuBuXZs=; b=SVHmtITmJBQ2
        cdCcSpDY4t5SQPsJMrCB3GGs8Q3I3tncDRK5M9NNWvhmKgTm47kA92n6tEJvfQK1j4MB38feSlebH
        lrUh47TXyIeSM2Nh6BPmcyfcRZdUm4MVyQroseE4p8HmmrqnYzmYnLK1Dg7CQyxEHkgcsy66Il/ec
        TOgoc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflaM-0003WN-HB; Wed, 18 Jul 2018 12:29:38 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflaM-0007Sj-2K; Wed, 18 Jul 2018 13:29:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd9571mwv: Document "backup_mode" sysfs file" to the regulator tree
In-Reply-To:  <20180716153052.1830-4-geert+renesas@glider.be>
Message-Id: <E1fflaM-0007Sj-2K@debutante>
Date:   Wed, 18 Jul 2018 13:29:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd9571mwv: Document "backup_mode" sysfs file

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From cf18fd01466d59263c615165341684a055206dd5 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 16 Jul 2018 17:30:52 +0200
Subject: [PATCH] regulator: bd9571mwv: Document "backup_mode" sysfs file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/sysfs-driver-bd9571mwv-regulator  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator

diff --git a/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
new file mode 100644
index 000000000000..4d63a7904b94
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
@@ -0,0 +1,27 @@
+What:		/sys/bus/i2c/devices/.../bd9571mwv-regulator.*.auto/backup_mode
+Date:		Jul 2018
+KernelVersion:	4.19
+Contact:	Geert Uytterhoeven <geert+renesas@glider.be>
+Description:	Read/write the current state of DDR Backup Mode, which controls
+		if DDR power rails will be kept powered during system suspend.
+		("on"/"1" = enabled, "off"/"0" = disabled).
+		Two types of power switches (or control signals) can be used:
+		  A. With a momentary power switch (or pulse signal), DDR
+		     Backup Mode is enabled by default when available, as the
+		     PMIC will be configured only during system suspend.
+		  B. With a toggle power switch (or level signal), the
+		     following steps must be followed exactly:
+		       1. Configure PMIC for backup mode, to change the role of
+			  the accessory power switch from a power switch to a
+			  wake-up switch,
+		       2. Switch accessory power switch off, to prepare for
+			  system suspend, which is a manual step not controlled
+			  by software,
+		       3. Suspend system,
+		       4. Switch accessory power switch on, to resume the
+			  system.
+		     DDR Backup Mode must be explicitly enabled by the user,
+		     to invoke step 1.
+		See also Documentation/devicetree/bindings/mfd/bd9571mwv.txt.
+Users:		User space applications for embedded boards equipped with a
+		BD9571MWV PMIC.
-- 
2.18.0

