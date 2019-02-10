Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1932AC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C77213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfBJRbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:31:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:33877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfBJRbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:31:34 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAgzj-1gn8Jf3ZFL-00Bpv6; Sun, 10
 Feb 2019 18:31:28 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mmc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: spi: Fix card detection during probe
Date:   Sun, 10 Feb 2019 18:31:07 +0100
Message-Id: <20190210173109.12602-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lTnfJ72xxJwBYH6HjhsfQZfpJzM1pWmt4VDjd3zUb4wYRTvTclr
 8xcw8YocB2eNqX0zNZnAlSC0icW/UYClH29Vk9pNAJ2CRRSkwf4u5pqYo4dBAmQQ0KXm2m9
 lcYbWNTBpG5sSdvuPQQjWxoN8HhYBMmU2O4Xtd89Tul3FrL/Svq00dbkLRg5gKv1MfuVF+c
 uRdpGRtmSAJar3iK/tYZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Td9dNsL2Z9c=:ygsoYS6lSMx9b0S6ac75sL
 Vdu+NqEDj+rE+cVHb7FQ/kL6S4TAtZUv+QVRy9RfCwdqSXNchPZkixixDbS9H7NGVfHqPUKGb
 rykOAkn+zObDTA01k0I0ChQS5tys6I2q+PxGQbKgihjqMc9wZrZr+VE9ZoCWXVY6ABvtfqxm/
 A9efGCaMHWqyJLNGsX3wV9LEw/Mry2ixKP69PPsFnBTg7PpbwgI8Bu+YrKK7A+KNM2VEfj3CA
 njUCHYjAiFWHJLB0UZHG3TymJ5xIvjPy/DTTS39L/iSLhbUV0xE0qOzBCrL3kVEoMFH2hy4bI
 QS9Geg213zkAxWvw3yRxZWldGTie4r2/91ZsrfrB3n7NadWUuU8x1tdeXl0Y4qSWXS0TpqDWw
 9EHeac2AnqIOxyoZBpGDXpngss3URkwSCYLDaph+g3F9rioYGG+GPNdzrReEwaMWHk1KdcXoP
 fcXmzY9IQvCE3Ym/H85cHqK0AfTcAl0Q1vMqDQe6vcvhHFCcvk3Ov5YSMQem0GSBQpHFFEAZt
 n3fK+4GkJBbSsHpO0xWU8e9BRm3BElWK3tjAuk3OweA0tEzrSFNwIGEbQAS4Y416uQNfYv/5b
 eNQql+hzKeTrmT7dlgqzQcPLG8k6PFu+735Nk2HiQ6M7oKBfEkDVobtfDYJmISFsAlZ/IdvbK
 NYSEmzc4W/d+C72jw8LYPIVHoGLneadxCT73poET9TgRY8nmC2eN1ou5/vFJh8nRtmDo/nrY/
 sPUUbIARrIp7zd/ueCv/zwkPD8H55b1sQGB0vqylnKRVxovq4A9JODu+de5+xh6C3Va42h8o0
 e1jdV6GeFUhST2AY2TDlAS4+Lzld65aU9e6drjfJtL/PWsc2/jNCO+cza2Di0305uQF0Io2S7
 YLYWu5ncLb5KiOFLacgJS+csty5WwEmdxdAuUUSkGH6NsWOOq2ZRlLj3lXK71EzrtwWTbAS+T
 GiOl96hsgqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the mmc_spi driver with a card-detect pin, I noticed that the
card was not detected immediately after probe, but only after it was
unplugged and plugged back in (and the CD IRQ fired).

The call tree looks something like this:

mmc_spi_probe
  mmc_add_host
    mmc_start_host
      _mmc_detect_change
        mmc_schedule_delayed_work(&host->detect, 0)
          mmc_rescan
            host->bus_ops->detect(host)
              mmc_detect
                _mmc_detect_card_removed
                  host->ops->get_cd(host)
                    mmc_gpio_get_cd -> -ENOSYS (ctx->cd_gpio not set)
  mmc_gpiod_request_cd
    ctx->cd_gpio = desc

To fix this issue, call mmc_detect_change after the card-detect GPIO/IRQ
is registered.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 drivers/mmc/host/mmc_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 10ba46b728e8..8ade14fb2148 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1450,6 +1450,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 		mmc->caps &= ~MMC_CAP_NEEDS_POLL;
 		mmc_gpiod_request_cd_irq(mmc);
 	}
+	mmc_detect_change(mmc, 0);
 
 	/* Index 1 is write protect/read only */
 	status = mmc_gpiod_request_ro(mmc, NULL, 1, false, 0, NULL);
-- 
2.20.1

