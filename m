Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id skAYKaViHlvWVgAAmS7hNA
	; Mon, 11 Jun 2018 11:53:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8B01F607A4; Mon, 11 Jun 2018 11:53:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlSh9JmP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1BF9F60351;
	Mon, 11 Jun 2018 11:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BF9F60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933092AbeFKLxH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35606 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932906AbeFKLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so19793884lfc.2;
        Mon, 11 Jun 2018 04:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=abyK3A2mKywcTUrPgLsuv4slos5QLbpdCFieILCxkvQ=;
        b=YlSh9JmPGPlPuOKMClXVHzRXfdfPDoMIAqh2BOL2Qn34iyGmedOzWvRfCY6va2P6Wm
         a2YmS1GaozzRTQZNAWenx6/q6vlvc1PHV3kUdVff4r53NC0zDbRu34qQX3Lrj6VEpO21
         adCdr70vVkvECYa+eFranzC2XfzssY3Cv2ht4t6nS66GF5Jfd06Nsl0jcz8KpNP6Hn/h
         kOXFtYDiFR+8bvjdBssR9KmTCtl5wK5uUlLFczoKEX/3u5KcWiLEBZQ/b3GgnSlBXwZk
         98+wkF4kbz0J2IzMNikE71KlCo+gpfaLhTexDdxHJyJxBsVzEqp665ba9IerqWggkIBF
         8PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=abyK3A2mKywcTUrPgLsuv4slos5QLbpdCFieILCxkvQ=;
        b=Q/IJw+toYXevi0Cd9+Gt/LjVv+BdshINN1i7NNEvcws2Hpx33giB6yjyn6emdS/Mz1
         9UWIItCjHslOwjbo5usZG2oXGRSRCtXq1EmzxTshLkofX8mVRRxIUjmdfzMob7ZKX9b7
         L6w8+8mahP2OWHc7Vp3u+/4KMnA3Ki9cWNI6B/sYzU3NoOmc7/00dFByuKl1a14z6/0Y
         REo3s0wnY77FszMpKPLpbwdpMI+mrsEKZbFg7eILLWa/CKPPKl7Q0NQ/TdQOFyYEoG73
         CSyL+ntl/e6wKocqJkeGjWPk6Ss0T9ISG0yg2iTnW5fFxO9caJlTERNn0Y6U+Htkq593
         RxQA==
X-Gm-Message-State: APt69E1ZaYG1JgLfMn703hBY29CI0LPu2RLfuw6fjn7s0+tLqj83wQnm
        77Io9J2COVD78YJPd9NmD1h/LeRv
X-Google-Smtp-Source: ADUXVKLAVfhsVX6yT1ZD1qkrKazIZaXV6/i1aK0qiESDyEtv3Fvl+qP5PNdCUNLfqifjz9MoPY5oTA==
X-Received: by 2002:a19:274e:: with SMTP id n75-v6mr5220140lfn.14.1528717981350;
        Mon, 11 Jun 2018 04:53:01 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:52:59 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 05/24] serdev: Introduce modalias field
Date: Mon, 11 Jun 2018 13:52:21 +0200
Message-Id: <20180611115240.32606-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name of the driver to use with this device, or an alias for that name,
or an alias for the part.
Required for hardware that is neither an of_node nor part of the ACPI
table.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 include/linux/serdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 62f1b085a794..bb3b9599c652 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -54,6 +54,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
 	struct mutex write_lock;
+	char modalias[SERDEV_NAME_SIZE];
 };
 
 static inline struct serdev_device *to_serdev_device(struct device *d)
-- 
2.17.1
