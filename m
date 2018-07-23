Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D30ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A82B20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+Rjyo84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A82B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbeGWOVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34451 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388156AbeGWOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so9744023wme.1;
        Mon, 23 Jul 2018 06:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zCKdsHtXVLf2CBkcSFoTzZQ6PWRuNBt5KYiFA9DgkiM=;
        b=p+Rjyo84kz76M5ZrizuXjRJBhd7dGigPRunqMwaxUUTFSj8+Gbg/+21O5JFGZcdckk
         dFTHI+slVITlsqkKs0OUCwxp619mkTTGU5fUM7dg6vp+d+7KhA16IIp1uD/gwaAPu8KX
         GSz7INBhV5hbeS7cpGGiRTCUBC8JnpfXsL2LqmWMSiqs1cg4DAjYAx6cmRxScGsUe+uF
         /qKbnA0xy+6yIwNgdJfDAsREWXvjAdYDfWyOc5oZfPGuP/OQg+cIpN8BOSsRvmaOcYmK
         uo3LrOW4a6/pXnN4a37/aw4f3l4VLbZrhZomEIn8czimJSAQUjTIbQuXVEtP5+fUBDfC
         Frmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zCKdsHtXVLf2CBkcSFoTzZQ6PWRuNBt5KYiFA9DgkiM=;
        b=s4FAZz+QRdUjd0J0dX8Y8HEG7Kl3RF51rMreanfn5VscpPk0IjRl3AfUPOsXR4zEHb
         qsfn+A1A13TiNxl5pWcajPbpCj790SEiBLPHXGipDNSUSIXyq+AYsn4qrKMZJNpFGPWO
         Iq/x07eLVgsJ1MIFjxjZyp4ROj4BdIxQP59idZt89egk6SqkUcIE6n0OmgXdnsaCMnA4
         gK1gqS82bUyZfalyovBWq4monVKg6lGTBZ40wb+nsF6B0vE98jenVzavRbY+7ESSYtcC
         UTyK3hNTclHxMIiXN2roxTnIB80pfCEn4KxThiGqVC/mr/KKqShAEhVqi80FJluB7jGh
         f+Rg==
X-Gm-Message-State: AOUpUlGPA0AwLvTcSKtQy8N4m9OcmcS0nbqonf6Sa+ChqetMaCO/7eC8
        r7a6c9KTPoHbig/yExECRgU=
X-Google-Smtp-Source: AAOMgpcDqapOgkS3njeZiUQYAe1e4CoXAphDmXMFMxd96xq+EKUGdnbFQKfDcZ3/bK/SlFYHchs9ZA==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr7213039wmh.22.1532352037581;
        Mon, 23 Jul 2018 06:20:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:37 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/11] touchscreen: sun4i_ts: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:25 +0530
Message-Id: <20180723131954.30739-9-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/sun4i-ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index d2e14d9e5975..78960961a524 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -230,8 +230,8 @@ static ssize_t show_temp_label(struct device *dev,
 	return sprintf(buf, "SoC temperature\n");
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
-static DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL);
+static DEVICE_ATTR(temp1_input, 0444, show_temp, NULL);
+static DEVICE_ATTR(temp1_label, 0444, show_temp_label, NULL);
 
 static struct attribute *sun4i_ts_attrs[] = {
 	&dev_attr_temp1_input.attr,
-- 
2.17.1

