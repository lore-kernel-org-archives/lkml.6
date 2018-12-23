Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6E6C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B26521905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uM7vIrg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeLWE6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:58:40 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40276 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLWE6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:58:38 -0500
Received: by mail-io1-f67.google.com with SMTP id a11so4375853ioq.7;
        Sat, 22 Dec 2018 20:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbV2rZQ67LuJPX6YUHnnKWTvJhORDui2wg3k/8TbKxY=;
        b=uM7vIrg1kODY4nh5lBOZezgmmNgNRj5OFh4MwhlaAbQO8BkMwZ9vzPt8j+SrKUmV/R
         wcc71DW91AgCH8rgOnKi1JF8TwLYWNr8diqzXJuaTBlzJ2Bupba0ZG3yR6spWDJDc6jT
         x/CYcp4Dkk5VJWcPtkNLI84H+ei2079kxjdyzy+r6DjbYZG6XuoHn+xh8jLGlaxva538
         Kzg9njR8cCcwtlstCSrZs5Od6oo8VCyZT91555y1HgFjZS6nbZvHgTDMkGDwn+1dP/d3
         udQzIji5/byY4epJdumAyaQTgwAp3M8hSONvvErls5aTKxBeggBTz61ioydKt8RAWja7
         73ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbV2rZQ67LuJPX6YUHnnKWTvJhORDui2wg3k/8TbKxY=;
        b=BkdGUksqAgHeLzTed/qY9M8H3q3GsPFOBNqam0sE3D2HQDPC2v4neCUVfcT7g5mOZn
         QKGfWHf+VN1fiO82mPwfzlDv3avy1wiS298PqKvUmJaoZ6gL6M8Ky/0ZYFiprj5a/1Ei
         obElyyFPIQxE2J6Tlokw6M7rHDXOk7hGnwFXS6WBbOJHhGCL0c+ULCjFqpqL9Yxh6zpI
         d7wPtMGsOIWhivFU1zO9jFgAnAt6QLrbRF/N6qs1GJb5qmJEdEEdBkOv8+1f/01iM91G
         6/qBLokf/ccewwQ3nZ3adJLb/ieGhMiuz5RwgByh3cg92w3hoyiIiqMzeUgFzxUeResc
         HXRw==
X-Gm-Message-State: AJcUukdWHSCoCR8pixncb5P1k2WdGcTj5ZSGvzAUdWu3KHxZh2qLHoQV
        /NJSxAR/iHGqjEIRGlikcik=
X-Google-Smtp-Source: ALg8bN5h5xy3arU6MQX/ghft3R+OOPcP+oPq+P2C/OygtNGjtaH5V8SZSx3T5m8o777D4wj6a87xkg==
X-Received: by 2002:a5e:c914:: with SMTP id z20mr5747178iol.72.1545541116919;
        Sat, 22 Dec 2018 20:58:36 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id 15sm8435378itv.11.2018.12.22.20.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 20:58:36 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH v2 4/4] staging: iio: adt7316: fix the dac write calculation
Date:   Sat, 22 Dec 2018 21:57:43 -0700
Message-Id: <20181223045743.10716-5-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181223045743.10716-1-jeremyfertic@gmail.com>
References: <20181223045743.10716-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lsb calculation is not masking the correct bits from the user input.
Subtract 1 from (1 << offset) to correctly set up the mask to be applied
to user input.

The lsb register stores its value starting at the bit 7 position.
adt7316_store_DAC() currently assumes the value is at the other end of the
register. Shift the lsb value before storing it in a new variable lsb_reg,
and write this variable to the lsb register.

Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index d7f3d68e525b..6f7891b567b9 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1431,7 +1431,7 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 				 int channel, const char *buf, size_t len)
 {
-	u8 msb, lsb, offset;
+	u8 msb, lsb, lsb_reg, offset;
 	u16 data;
 	int ret;
 
@@ -1449,9 +1449,13 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 		return -EINVAL;
 
 	if (chip->dac_bits > 8) {
-		lsb = data & (1 << offset);
+		lsb = data & ((1 << offset) - 1);
+		if (chip->dac_bits == 12)
+			lsb_reg = lsb << ADT7316_DA_12_BIT_LSB_SHIFT;
+		else
+			lsb_reg = lsb << ADT7316_DA_10_BIT_LSB_SHIFT;
 		ret = chip->bus.write(chip->bus.client,
-			ADT7316_DA_DATA_BASE + channel * 2, lsb);
+			ADT7316_DA_DATA_BASE + channel * 2, lsb_reg);
 		if (ret)
 			return -EIO;
 	}
-- 
2.19.1

