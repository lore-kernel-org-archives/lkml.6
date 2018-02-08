Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2982132-1518104576-2-6642521835673584122
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518104576; b=cr0d6yZuclHCUbblRLkhwSU8J8p99UBeK0td9KlHLAaZEn6
    Bk9KjUHjhcr9RT+92enEd439ZvZy5mdVET6K2rf5eR2z+fkaERxX1IWUjRPL69HT
    +pf8wOEixoAaC9CSb6neDbWmvS+TM1yVvmNyV2mW5EFgZYx7Q9n0CXzabnaExsYO
    vspAqajLSUQzIYlGqK0/EfnbYrPUJ+VvluZYA5xeaZ8EvbeQE93aRxiE2pU5REii
    HGRa697P0v10NcnaUJn7Feanl63dSg2EZg1SbFEh4zC7C1W2tZtlmNOjcLiWpE/L
    mlwJNQDtIh4s+DxjsyMv48uH+bzuNFlEgqkdQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:message-id
    :date:sender:list-id; s=arctest; t=1518104576; bh=MqiaXoeUp8zWvY
    cU0NvPg6Ys1wreynvU4PaF/I6WHsY=; b=r/gXlOTpftfwPWwJjK1RqKbArkVuYD
    W83wwvQS0XoF9rtINPwv6JityYWiVgk81g48x7Jb6JP17/Vv9GR7zgzbFayEGv1d
    +RvRc+patamfdJ+NmFv/GDsRAHgHoXF3X/+LwnZ8/FTkuqj7ipbCQyj3nYWyH14i
    fYHXlbMu0LNpowGocFT/T1yI65Kze1tEBOcX6I1skvp91ZV+xzNdY7n7bqKeL7wz
    kf0Skc2WrVH/dC8cOjvPt1UfjrLO821lT686OCqA2ooSSYDxpzP4PJ7Jh7q9jFgw
    ussvcnpgWYE9/9WokRw7cTm/vRG0xE4SOZLV7snzwmMWXj9e7aKU5f0Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=CvV1lW8A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=CvV1lW8A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeBHPlz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 10:41:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35446 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeBHPlw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 10:41:52 -0500
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regmap: Fix reversed bounds check in regmap_raw_write()" to the regmap tree
In-Reply-To: <20180208072344.GA18158@mwanda>
Message-Id: <E1ejoKa-0008W5-S4@debutante>
Date: Thu, 08 Feb 2018 15:41:48 +0000
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   regmap: Fix reversed bounds check in regmap_raw_write()

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

>From f00e71091ab92eba52122332586c6ecaa9cd1a56 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 8 Feb 2018 10:23:44 +0300
Subject: [PATCH] regmap: Fix reversed bounds check in regmap_raw_write()

We're supposed to be checking that "val_len" is not too large but
instead we check if it is smaller than the max.

The only function affected would be regmap_i2c_smbus_i2c_write() in
drivers/base/regmap/regmap-i2c.c.  Strangely that function has its own
limit check which returns an error if (count >= I2C_SMBUS_BLOCK_MAX) so
it doesn't look like it has ever been able to do anything except return
an error.

Fixes: c335931ed9d2 ("regmap: Add raw_write/read checks for max_raw_write/read sizes")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ee302ccdfbc8..453116fd4362 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1831,7 +1831,7 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
 		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
-	if (map->max_raw_write && map->max_raw_write > val_len)
+	if (map->max_raw_write && map->max_raw_write < val_len)
 		return -E2BIG;
 
 	map->lock(map->lock_arg);
-- 
2.15.1
