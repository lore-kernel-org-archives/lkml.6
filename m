Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +vZyCj9jHlu+XQAAmS7hNA
	; Mon, 11 Jun 2018 11:56:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2008A607BB; Mon, 11 Jun 2018 11:56:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvoAGsku"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A929C60792;
	Mon, 11 Jun 2018 11:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A929C60792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933266AbeFKL4F (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:56:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34153 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933096AbeFKLxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:20 -0400
Received: by mail-lf0-f65.google.com with SMTP id o9-v6so30096826lfk.1;
        Mon, 11 Jun 2018 04:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I2WzLK/CcGerSJKc4iq/J/wMFOoFGreiIkSyFJWu+zE=;
        b=WvoAGsku5Ui0bEtWkqQZiJH42IKWeTTUVMKKMC5gekNOU/dLfAGz2BI2nutTEY9cwY
         a+XgvTAb5RYvsoxbzstqg8PaVxgTcCpmDjAnQ76F5hd0KUuJGFxkYQIq7qERbzCOBhNg
         8RzMiI84DBh4ksGIdyTL9ge+dlXaXO1ORHVNuKheMvlHjY790sr2KtwBpeOk04J/LGnL
         wGVQdS3PqjVdy5KC9un7KAxeyfLLumuxcZU+SIDWKLf2rdntEopCsNU54hRnt8IgsiVK
         mYt/1y1zL67+zrW1UKzPIltx5pGPRHoUm3wpPxCa6s/IeE1YrJqWus2hfZg8MBWnLJLX
         R8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I2WzLK/CcGerSJKc4iq/J/wMFOoFGreiIkSyFJWu+zE=;
        b=jMleC4u+5ZOziYyReeOM7nfHpRxHdwSbAcGuS2xpaYY5RBwgG6yQD0H3mjLoUc8h6o
         vzss+uYA4M1IZtPkfMt/aIewfixK9w/H5coM6662ZXVNUQktYhCjaUcivrCHAyt2s1R7
         +9ezLd6yoY14fvw9Yu26Fyegvb7OdoI2oZSK6mviye4PIpV59J8nkTPiskJVeJ32CbdX
         Ff2cmtjZGyD7gm+W6qyYsQqVhb/qK7Us5G0ljyOjB5Wi0iQBIou/S9gVoDx/WvEsbLGF
         NCifRAc+xWYZAcT5jnfhAv1LcOIV/uJkheHVN6jKUY9ITBuuY0BUxEgjWXw2v0VhmbSj
         quLg==
X-Gm-Message-State: APt69E0JQkbZapcc4mPCvzrlw2NOJA37u3I0OIglp+0YQS6w6/d0F9dw
        pnQxqbgCXcUllwFAVynt4aQJ+kEy
X-Google-Smtp-Source: ADUXVKK5EOzDaGg9bVWUcymtdo7HZN78WvJm41eFmYK3s/iObx7yhmL5AxcqBI/sEYX3ETHE4/8prQ==
X-Received: by 2002:a2e:3112:: with SMTP id x18-v6mr11136100ljx.107.1528717998450;
        Mon, 11 Jun 2018 04:53:18 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:17 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 14/24] mfd: rave-sp: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 13:52:30 +0200
Message-Id: <20180611115240.32606-15-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export serdev table to the module header, allowing module autoload via
udev/modprobe.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mfd/rave-sp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 5c858e784a89..c0ecfbc16dca 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -694,12 +694,19 @@ static int rave_sp_probe(struct serdev_device *serdev)
 
 MODULE_DEVICE_TABLE(of, rave_sp_dt_ids);
 
+static struct serdev_device_id rave_sp_serdev_id[] = {
+	{ "rave-sp", },
+	{}
+};
+MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
+
 static struct serdev_device_driver rave_sp_drv = {
 	.probe			= rave_sp_probe,
 	.driver = {
 		.name		= "rave-sp",
 		.of_match_table	= rave_sp_dt_ids,
 	},
+	.id_table = rave_sp_serdev_id,
 };
 module_serdev_device_driver(rave_sp_drv);
 
-- 
2.17.1
