Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3370838-1520432137-2-13405996364018937076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520432136; b=eJsK75t1cEWjWpN8MGQ774tqt5YXHZs3sFcdu7S2bKmJ0hr
    YD5Ej0aCVQapGXTb+nXfkd5mKk/4RBXk3M/LqrzoKqfoL2E/WrK95s+IJHoH+CIe
    5xb9UJCSdg6ee3Vdd9B6/10Cup++Lv3m8q77VisyBOMbYOOIKr8lKLFVvWl1AA7p
    ItAlnFxBn1/APYWDSA4LKVsTDy77IEtNZJ9xrpDgH/BAAJ4jhj7J60ERwa4yrR25
    fuss4PXd1+KrWStTj0G0+Otmkxl/FZvs+1j20GVz3mWUsF8ezWsUSd213JuBLWsv
    YmkMe6OEv5ugyTy9Jy/z9qb/dnhOCd7rE7iKV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:message-id
    :date:sender:list-id; s=arctest; t=1520432136; bh=FdxB6C4BuuPlwD
    4vNiVF5D4MKmtGujIddKOnE0Dj3Ds=; b=PSnoMT5meOb1cQSr0+R8SYd4iwIPcW
    oK7Z6BhyVZUf8l/Jc0i1w9qsAw6RhTLXRde8Zm4B3Bsnl+OmMm6A8/NID78OqFhH
    3ERRsOV/MF0rXzVDMpDTo6tumA50d/IQRO98r5AlwBiSkNlkd7ExexRa+ekzF6ey
    lC+BOryGZ8FxdugN5Nv1ldy4Zp9xZlYOE8DxfT2SPnaIK70ttqZwclzOBHqZwciw
    Yy2F6GgDihbXN3LXayM/32klye7ngPE5hmOjaNggUDW8lvV6BNeaPXy/q+441Aqb
    fYovnFi8o1FNDSW3R1nQ8bY+/7oZQFNAzP+JeCiykmLi06+YUcHAXDbg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=AUux9iU/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=AUux9iU/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeCGOPc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 09:15:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50220 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754510AbeCGOP3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 09:15:29 -0500
From: Mark Brown <broonie@kernel.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "spi: Fix unregistration of controller with fixed SPI bus number" to the regulator tree
In-Reply-To: 
Message-Id: <E1etZqo-0001cw-Ee@debutante>
Date: Wed, 07 Mar 2018 14:15:26 +0000
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   spi: Fix unregistration of controller with fixed SPI bus number

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

>From 9fca7d15487654dab119d0868501db30f80ac46a Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Tue, 6 Mar 2018 17:47:22 +0200
Subject: [PATCH] spi: Fix unregistration of controller with fixed SPI bus
 number

Commit 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
ceased to unregister SPI buses with fixed bus numbers. Moreover this is
visible only if CONFIG_SPI_DEBUG=y is set or when trying to re-register
the same SPI controller.

rmmod spi_pxa2xx_platform (with CONFIG_SPI_DEBUG=y):
[   26.788362] spi_master spi1: attempting to delete unregistered controller [spi1]

modprobe spi_pxa2xx_platform:
[   37.883137] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:19.0/pxa2xx-spi.12/spi_master/spi1'
[   37.894984] CPU: 1 PID: 1467 Comm: modprobe Not tainted 4.16.0-rc4+ #21
[   37.902384] Call Trace:
...
[   38.122680] kobject_add_internal failed for spi1 with -EEXIST, don't try to register things with the same name in the same directory.
[   38.136154] WARNING: CPU: 1 PID: 1467 at lib/kobject.c:238 kobject_add_internal+0x2a5/0x2f0
...
[   38.513817] pxa2xx-spi pxa2xx-spi.12: problem registering spi master
[   38.521036] pxa2xx-spi: probe of pxa2xx-spi.12 failed with error -17

Fix this by not returning immediately from spi_unregister_controller() if
idr_find() doesn't find controller with given ID/bus number. It finds
only those controllers that were registered with dynamic SPI bus
numbers. Only conditional cleanup between dynamic and fixed bus numbers
is to remove allocated IDR.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b33a727a0158..e90fd442b3f0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2254,12 +2254,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	mutex_lock(&board_lock);
 	found = idr_find(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
-	if (found != ctlr) {
-		dev_dbg(&ctlr->dev,
-			"attempting to delete unregistered controller [%s]\n",
-			dev_name(&ctlr->dev));
-		return;
-	}
 	if (ctlr->queued) {
 		if (spi_destroy_queue(ctlr))
 			dev_err(&ctlr->dev, "queue remove failed\n");
@@ -2272,7 +2266,8 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	device_unregister(&ctlr->dev);
 	/* free bus id */
 	mutex_lock(&board_lock);
-	idr_remove(&spi_master_idr, id);
+	if (found == ctlr)
+		idr_remove(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
-- 
2.16.2
