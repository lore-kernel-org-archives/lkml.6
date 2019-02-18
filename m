Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5872184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq4QMI9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403773AbfBRRXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:23:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41545 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391174AbfBRRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:22:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id u188so10387146qkh.8;
        Mon, 18 Feb 2019 09:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IoNRB2cfdbuPFshdLkMNMZVGu5zP0AIBtVMGQjiPoXY=;
        b=Lq4QMI9rRek+/9QcyzCqdapx2/WPV+8+Vv/x8/xRMkcc9v1GtMzkrCH0gxBMLHq/Q7
         g3QFb8POnQjW2AVYo5c/o5tj0B3qAyGFOquaQwEg1eID+0YhtxUCsogi7hqVCk93k5LO
         IkaMVD4r0v3RBjSNjCekkcoNiRPHIU0E9MAvKcK0pOPU3ZoIAA17kQogihqdFYk/5R5D
         IY6o68GivXqvPj9YcI3yzNEO+F7HT+nHv3iW4LaiP4nablIJ9XS3wXtUPRpI8mk97Plk
         fDQdU0VYiG3fAvnbgbf5kULwcYa7tFx9RCbJwOFNdL9hpaLMwP+3T8zZXYEYz0lOZRWy
         x6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IoNRB2cfdbuPFshdLkMNMZVGu5zP0AIBtVMGQjiPoXY=;
        b=X6epkZxi73xi3m3kwS+DFzdOQBXNSxW0kkaascVzOY535xfzGezL0K0L1d6kD4+tUF
         h7kjgUb9RyUaUB8L0BTaHB9nH2xIIR3YMjErWtWYi9P2C2ZMdKTWWLUNnO7Uf1gsDd+B
         J4596j4QOVCj4LfXdw26KgpeHNWGXC+2awcXa5E1RJ+9LyOFfCVQ60zgXoOLXRQaaRXd
         4REWxefY2hb9iQLSigfWE6SKKtS5JnX6z7hLufyaJmT8nSe/qMFaz83N0WvJ+ao28suB
         pxQCKXucyIu3vXWy7ykLrwVYPexzOF4s9zPZx3BY7ixOaceS0ZifSaV/7rcYc5aAbvxp
         FjOg==
X-Gm-Message-State: AHQUAuar4PBuy/PrihYnhFa8PQqALI6folMh8SZfZnG8rR8rhgDMWVO9
        wBqxzTFj0esTAoe1R9sApCI=
X-Google-Smtp-Source: AHgI3IawbGaSOlQENqHf85Fq9ZQ5P+0ya5DQmAQyl+Tz9vB9bhpODcwaKuCEiHUEQvjKtWaBFYg5GQ==
X-Received: by 2002:a05:620a:11b8:: with SMTP id c24mr17778520qkk.57.1550510577661;
        Mon, 18 Feb 2019 09:22:57 -0800 (PST)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v18sm6525275qkj.13.2019.02.18.09.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 09:22:57 -0800 (PST)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: [PATCH 3/5] iio:potentiostat:lmp91000: reduce line width and remove blank line
Date:   Mon, 18 Feb 2019 14:22:34 -0300
Message-Id: <20190218172236.7781-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break the line 258 in order fit the line width on 80 characters. Remove
the blank line 279, as the line before is also a blank line. Solve these
checkpath.el WARNING and CHECK:

- lmp91000.c:258: WARNING: line over 80 characters
- lmp91000.c:279: CHECK: Please don't use multiple blank lines

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index ca31be510940..6dba26121a62 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -255,8 +255,8 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 
 	regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
 	regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
-	regmap_write(data->regmap, LMP91000_REG_REFCN, LMP91000_REG_REFCN_EXT_REF
-					| LMP91000_REG_REFCN_50_ZERO);
+	regmap_write(data->regmap, LMP91000_REG_REFCN,
+		     LMP91000_REG_REFCN_EXT_REF	| LMP91000_REG_REFCN_50_ZERO);
 	regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
 
 	return 0;
@@ -276,7 +276,6 @@ static int lmp91000_buffer_cb(const void *val, void *private)
 static const struct iio_trigger_ops lmp91000_trigger_ops = {
 };
 
-
 static int lmp91000_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct lmp91000_data *data = iio_priv(indio_dev);
-- 
2.20.1

