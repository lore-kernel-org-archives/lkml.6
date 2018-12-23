Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D22C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25BB218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8/q6CH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeLWE6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:58:40 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40273 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeLWE6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:58:33 -0500
Received: by mail-io1-f67.google.com with SMTP id a11so4375794ioq.7;
        Sat, 22 Dec 2018 20:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QObNkapVO/i8shFczuk2z27Jj/GGsaFAwRKXUgysxBo=;
        b=N8/q6CH6zKitObX3LEBwNAVUb/BA3iShzDJM+kbxSZm5S7zpuwqa9wcsTAfssIFQ/X
         EO4cuqBdC8MnazvUd668j3a6oL/cKq0rYJW+pY92iLNi/nS+EI2Jd0WcnKOyLgc3Wmwt
         fvBI8Zs3uPHBNPsxqLJrJEaFwR/NxcH6T9R+FW6S5YNGHhF5wSNb6zi8okfaK/hwsNHs
         Hp4H4B9mtZpmpCK2/KZPj59ctKIZk7wv0A7ICSc2Oa0xcQNaTs0cavPTTZZnFyblBjUJ
         Xe4PFshyIXoiMtJZp/h6rbO4qQN0IVr8oYW5m5UozXxY6PTg081wGFwXjz1zjFs0+bu2
         Os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QObNkapVO/i8shFczuk2z27Jj/GGsaFAwRKXUgysxBo=;
        b=Q1V/inqjGB+tFFO2FydBBdFpckpo+n4T3WBMZ8VY5p7LP1RsEaOYwR2RHBzxNwtJHU
         dppELaKx96CLrpMgjsUwjVEkYUsv0vUDm7l8bP+oXNU7jVHR0yIv9VrA9adcCHBz4ksO
         sksG19OWvjNxrNynT2x9qjI+YHe3xnvvU+EX4yyMnEFycBAx3UAz8jG3e+6RAl6BRtJQ
         qyVerWPOruehFRR2Nr3L7vP2Ejmwhiy7UfNdi6N6s84/FurG4F8KrjGaCxpu53scyiqF
         wqhJv0kluaXxw4AZPySNtSjCBnVyoEXuFVLoZ7bxa7+2Ldxu/eiPA+Z3iP8dH0L7lL2h
         WsCQ==
X-Gm-Message-State: AJcUukdc01KithhihOKpr4RMEeN4QEsKi3HKfZ7hUyPreUvXKyxt9Izd
        Hu1ZpllZX3zqmWYPO90WERo=
X-Google-Smtp-Source: ALg8bN6aeCdERqkvq54GDfTOD8A3q2ws72cWC6MG+sA/NghGC448PTlzuNGEUChJpgC9+3e692gnkQ==
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr5628833iom.7.1545541111980;
        Sat, 22 Dec 2018 20:58:31 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id 15sm8435378itv.11.2018.12.22.20.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 20:58:31 -0800 (PST)
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
Subject: [PATCH v2 3/4] staging: iio: adt7316: fix the dac read calculation
Date:   Sat, 22 Dec 2018 21:57:42 -0700
Message-Id: <20181223045743.10716-4-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181223045743.10716-1-jeremyfertic@gmail.com>
References: <20181223045743.10716-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation of the current dac value is using the wrong bits of the
dac lsb register. Create two macros to shift the lsb register value into
lsb position, depending on whether the dac is 10 or 12 bit. Initialize
data to 0 so, with an 8 bit dac, the msb register value can be bitwise
ORed with data.

Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 80cc3420036b..d7f3d68e525b 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -47,6 +47,8 @@
 #define ADT7516_MSB_AIN3		0xA
 #define ADT7516_MSB_AIN4		0xB
 #define ADT7316_DA_DATA_BASE		0x10
+#define ADT7316_DA_10_BIT_LSB_SHIFT	6
+#define ADT7316_DA_12_BIT_LSB_SHIFT	4
 #define ADT7316_DA_MSB_DATA_REGS	4
 #define ADT7316_LSB_DAC_A		0x10
 #define ADT7316_MSB_DAC_A		0x11
@@ -1392,7 +1394,7 @@ static IIO_DEVICE_ATTR(ex_analog_temp_offset, 0644,
 static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 				int channel, char *buf)
 {
-	u16 data;
+	u16 data = 0;
 	u8 msb, lsb, offset;
 	int ret;
 
@@ -1417,7 +1419,11 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 	if (ret)
 		return -EIO;
 
-	data = (msb << offset) + (lsb & ((1 << offset) - 1));
+	if (chip->dac_bits == 12)
+		data = lsb >> ADT7316_DA_12_BIT_LSB_SHIFT;
+	else if (chip->dac_bits == 10)
+		data = lsb >> ADT7316_DA_10_BIT_LSB_SHIFT;
+	data |= msb << offset;
 
 	return sprintf(buf, "%d\n", data);
 }
-- 
2.19.1

