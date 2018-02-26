Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AG47ELtyc3cnn6f62RAe+NVSbFvDALav9lbtfSFqcaY8R0oenwHf+OuTSGmCG2k9hJHN67BEfrUa
ARC-Seal: i=1; a=rsa-sha256; t=1519643883; cv=none;
        d=google.com; s=arc-20160816;
        b=1K5iOoCnIS7oalOHTfXFU9Uhy9abHIl+UuVzT6W4eriyJvR9rvIW7qMiy8OmdGHNHf
         u45rohYDwCQKtuJfang6o9RLjFMvUIgxeEqv/tYJCAFEDWk7Cxjqd7wHs/Mvm396n2H7
         7ZRgef9GOfxIrEYxHlf876suFconoH6INmnOuhfo0UpJFycsKrYhM8hh089RvKOC24H+
         iq3OBNippLZCTbDnleydugGVE7SxXPpQ4yX1uyVn0D2qlYKSELf81Vy/t3KFyZqkxGt9
         m4F6UJy82hB7NfTAkK0YZ+MzyHfgf4m1kkrPfEELjS1ol/rC38nwhaBKpdTOUl1BySMK
         z/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=AEvYV77/nhFWZ74ODK3iw2CyNbW0HSv9YhHt9aA6UT0=;
        b=fWvt3F3vFsHnNU8wCr8ZGZ3Xy24O1XUyhVgVW/IS48rVB52cJk9IuJXApDqvbz5Kxh
         rtRa340W1KsaEIygzzgyzmaKx330U636JSagyevXiAGy5fOOmQx+pAbFjbAbXCcPI6U4
         0qHotj0ha+ZZjR3gbNdOiOh1tHqchpLBRDcPuZZmfMUcf0nYFrHGbxsMaCxyFk74ZRIJ
         N/8G1BoW+JiF/DXFgQPzl93PYoFQB+izsTu+vEceipmE9Liv1BP3Vr/KkPRPLob93FbW
         U8xvvcrLO/sFAdSOmLQce8vzs3oQPpyuHvZ+POZV1wTIVWrk69Lfe08yJ+S0tl97H7UR
         DmvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=bY8Xef4F;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=bY8Xef4F;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Remove unnecessary printk for failed allocation" to the regmap tree
In-Reply-To: <56cba529-03eb-9088-3fea-8fbb50c355af@users.sourceforge.net>
Message-Id: <E1eqGnC-0005cx-9Z@debutante>
Date: Mon, 26 Feb 2018 11:18:02 +0000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593462104317777984?=
X-GMAIL-MSGID: =?utf-8?q?1593462104317777984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   regmap: Remove unnecessary printk for failed allocation

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

>From b4ecfec5ee3f282a4ac0876de332876fec9b488c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 22 Feb 2018 12:59:11 +0000
Subject: [PATCH] regmap: Remove unnecessary printk for failed allocation

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8fe6e08fa41e..707b0450ad72 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2050,10 +2050,9 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 			return -EINVAL;
 
 		wval = kmemdup(val, val_count * val_bytes, map->alloc_flags);
-		if (!wval) {
-			dev_err(map->dev, "Error in memory allocation\n");
+		if (!wval)
 			return -ENOMEM;
-		}
+
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(wval + i);
 
-- 
2.16.1
