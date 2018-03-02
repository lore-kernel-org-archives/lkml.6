Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2196896-1520013729-2-16898589378737599303
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
    t=1520013728; b=jOmYXR/F4UDV5yauSJ1Lmkp3YpaupS/QVX8PFnPIHCjnIVT
    A/HHgXaPagI6V+EUyuc2lSrQKZ2qdJS8wlyEXP5PfgkPwsUMup5Z6RumJoDHov3s
    hgMz+gEVAs3uFHTkIwmfUwVZ4aAcSjOusiFow6hpyhI6FNisAJ0iwQCfakcw8wMg
    sy7lDkNtpU0fEpUm2jzHWa0qcL4zBlRYI/e+TTaSYPmM81KfQvkQwNg2jl9YjpH3
    6Q9xfEScWcywScIIo57HaHio7Jjpa9N3IeRnwIt4qi582OjduZN5oLua72AjOKb3
    EU6IzDgODN7q71/mVg6u/KRNR6N/fBc1vL7RItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:message-id
    :date:sender:list-id; s=arctest; t=1520013728; bh=Rb5hq9hn7n4yL4
    xL4QNShPafAb190MxftVHoSMK9yHQ=; b=Spc/2A8fQQ/ITddBsdkGerYoTImXec
    bfeVTchY3Mh7xJeAptL6U+7H7Ry+lNABTztqnEfqAORvXFjtXUfZdKXKAgRpqy8I
    EIx9X8B4MjURumK8qnhZObiQx6KI6oIf+JVMYClGmBENj8//zjXgYtXpGg2XY7E1
    hYVRawf4FwMXBFcfxPLY4z5bf0kVmgyRFwYPQRJRRi/hVKcStQ46ch8W007YFoUW
    YOBdXxAWz77lxU44UoID5v032dk47dXAKfZXv8+jGPlgizXVGuNlYxAQmbHrUtnN
    KhXveuql6z6nEFT9lhCUQ5ICdMLrDKHwaU1xLV5d5tQ/nGMkSXKyNDWQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=QulyIUdL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=QulyIUdL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424078AbeCBSCH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:02:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35206 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424042AbeCBSCG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 13:02:06 -0500
From: Mark Brown <broonie@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: Fix scatterlist elements size in spi_map_buf" to the spi tree
In-Reply-To: <20180302145509.24563-1-maxime.chevallier@bootlin.com>
Message-Id: <E1erp0N-0005Fv-JL@debutante>
Date: Fri, 02 Mar 2018 18:02:03 +0000
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   spi: Fix scatterlist elements size in spi_map_buf

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From ce99319a182fe766be67f96338386f3ec73e321c Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri, 2 Mar 2018 15:55:09 +0100
Subject: [PATCH] spi: Fix scatterlist elements size in spi_map_buf

When SPI transfers can be offloaded using DMA, the SPI core need to
build a scatterlist to make sure that the buffer to be transferred is
dma-able.

This patch fixes the scatterlist entry size computation in the case
where the maximum acceptable scatterlist entry supported by the DMA
controller is less than PAGE_SIZE, when the buffer is vmalloced.

For each entry, the actual size is given by the minimum between the
desc_len (which is the max buffer size supported by the DMA controller)
and the remaining buffer length until we cross a page boundary.

Fixes: 65598c13fd66 ("spi: Fix per-page mapping of unaligned vmalloc-ed buffer")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b33a727a0158..4153f959f28c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -779,8 +779,14 @@ static int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
 	for (i = 0; i < sgs; i++) {
 
 		if (vmalloced_buf || kmap_buf) {
-			min = min_t(size_t,
-				    len, desc_len - offset_in_page(buf));
+			/*
+			 * Next scatterlist entry size is the minimum between
+			 * the desc_len and the remaining buffer length that
+			 * fits in a page.
+			 */
+			min = min_t(size_t, desc_len,
+				    min_t(size_t, len,
+					  PAGE_SIZE - offset_in_page(buf)));
 			if (vmalloced_buf)
 				vm_page = vmalloc_to_page(buf);
 			else
-- 
2.16.2
