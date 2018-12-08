Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43F9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684CE20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X404tw4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684CE20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLHPQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:16:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44899 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLHPQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:16:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so3174841pls.11;
        Sat, 08 Dec 2018 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sx7bEFL8SVo2GNwtK9DKmgT5Sowc26cvdGR4sApF5j4=;
        b=X404tw4nsn6BtgV2j+dnytQ+5lGZs9FoLv7seQHXeECasuJG9h7hNVL5SvbomcY8sm
         OCclwrkppJp8zXaNDkzHu71Bovpqfh+opBkiZZVKLMSfF/E5tHZKYMI5yDP8oKL5wQOK
         BguDDEfRjsZlEThBxtY5jSGp5fmLliYrBgCp3bL0eVKnCaacmTk3XQV/LHB7S+3QPZEO
         JDZmLDP9f7BOXpJcFIlPA25c4voTB5EKLSeGF+7gquC75tZP+fL6N5C3LjgaZ4O2Wkrn
         qk1aYQoqWbdCtaYgFeqSci+14XyrGwTIfYtEZxT3+kUjhqcwMnA2LXkrh9gVYEIiT5Kn
         FsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=sx7bEFL8SVo2GNwtK9DKmgT5Sowc26cvdGR4sApF5j4=;
        b=lrU5xvJERgklQt8goFDxvJ+WocurLHkTLr6t+wAZev4FodazKCmmnbY5MsxxjmnY0d
         3Y18ocbhdp2GusNxflD4ieZhlVNlFh40VxbjKVvHxsdMpDLePBSc36xg81X3h9YPcijA
         jds+g/DFnbOR1XMn697We4XPnmcTxgLg8zRoJFVdWYbx7SdN5KJekr4kbg/F9pXlwmEW
         FljcY40lAi6F4nweP/0Kl8+xbcEkyktvDGZP8l6KRrbTM++0YRKYxGtBxdP8akqoWnBf
         +zCgYmBC5dU6ZY/pykvSCUJ3gvX3rhU4OaxTdij0xd3vQWjunTWS3laIU98wM2cfL6IU
         klNA==
X-Gm-Message-State: AA+aEWZKFYX1JRsph3kimX15uu42b69Ya55o5yJAGpd9pm8608RRGyIY
        uvWToao5vXBZWgAWGEhAKJ0=
X-Google-Smtp-Source: AFSGD/WB4BoSFGXDYDvhXSLH1+9stSaJcEg6mQU1WUiK1KpnYe2HkqdRUXaMzUcfB19ce5rInMBnsA==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr5907021plt.98.1544282214763;
        Sat, 08 Dec 2018 07:16:54 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.153])
        by smtp.gmail.com with ESMTPSA id e23sm9774091pfh.68.2018.12.08.07.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 07:16:54 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, shreeya.patel23498@gmail.com
Subject: [PATCH v3 3/3] Staging: iio: adt7316: Add a dev_err() message
Date:   Sat,  8 Dec 2018 20:46:38 +0530
Message-Id: <20181208151638.8759-4-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
References: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dev_err() message "failed to request irq" for describing
what went wrong when an error contition is statisfied.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 97dd48153293..e3eb8ad06403 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1832,8 +1832,11 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
 					NULL, adt7316_event_handler,
 					irq_type | IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
-	if (ret)
+	if (ret) {
+		dev_err(&indio_dev->dev, "failed to request irq %d\n",
+			chip->bus.irq);
 		return ret;
+	}
 
 	if (irq_type & IRQF_TRIGGER_HIGH)
 		chip->config1 |= ADT7316_INT_POLARITY;
-- 
2.17.1

