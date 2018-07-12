Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7196AC48F67
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4DE2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBrWeCe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4DE2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbeGLRcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:32:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39311 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeGLRcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:32:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2-v6so4099144pgq.6;
        Thu, 12 Jul 2018 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=280g+RGAhxopkf5zYfi9U7OBxHSGkQm3DuoAW1Gjzrg=;
        b=XBrWeCe7iriTKjWH74RhfDJup/h6x/k3BY/UPgE4D4zgI+xl3jLRxATMUhaTfCzS78
         rwaUUAQIpfuRgv0Qv4n7R/OdFaFaRwXkaYencr7o33HYlv1QS7hZeDZsAtl5IfeCnoPA
         80mb0hVEXJl/1X1LV78ae/3SbUioiGuQZYk+eJU/HK3toafmTVjvxQVOXC/44+TGm2+A
         0JRQiiCfOAvT0ZFgTHq+8Ui2ZjzebV5qUsiVnuiKmtCb7Ej5P4JWWIRbH8ubb/T1uV3L
         8zDuCKt5jftiP3eU5MviA7/UVnUSeM1pltOmZUKYGBp8QNVPPs0wc1KpMUfh5hD1S11R
         Bpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=280g+RGAhxopkf5zYfi9U7OBxHSGkQm3DuoAW1Gjzrg=;
        b=hmIsMGBt1BGNt7jv9qEgEjIETmOD8H6j7iuj43evwbVj7s7H2iLpFJcvFgGg/KnvNT
         b5+6kRt6E7yVTr5+TOlXStxstlgZ3m5zh1Xb9FflTekM4FdpaV45f2M2ldMlBRtDjX83
         TFyUjiv0N6fkD0/1xRYV5ZeRMqh5JH3/2pmifwloy8rmAXe5MAjzIf3faTBw5XHOxsA1
         /ITBc1yH4bY3HjqFQ8DcPdON3trMKLoj//lxvXWtW3hpTNKQX7STvlihcsrXFQuZ+4rK
         wdbVJky6kK8SZlOwA3eZVzJ+xPonqzChX6ABCTZHrkjp3nKc28ZiwpOhq9MjC0pjU/zA
         He7A==
X-Gm-Message-State: AOUpUlHjWt0LA/tBOIE5VBArh0/Y///TfmoSu25HD2dIMsm6qQ5KyLL3
        6AHY+ZgH2ZbCSQWOmq9IWSZDEfNd
X-Google-Smtp-Source: AAOMgpeZ4Ym40so6dXcTQuIh/HCbAVy4tlHIEtsn6phwVNN7cUof8XXZ1oSZPIBd+TFuRxECJdqAsw==
X-Received: by 2002:a62:d39b:: with SMTP id z27-v6mr3379033pfk.182.1531416141610;
        Thu, 12 Jul 2018 10:22:21 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id l27-v6sm2899061pfi.42.2018.07.12.10.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 10:22:20 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id A78DF200465; Fri, 13 Jul 2018 02:22:18 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        netdev@vger.kernel.org, j.vosburgh@gmail.com, vfalico@gmail.com,
        andy@greyhouse.net
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH/v2] bonding: Fix a typo in bonding.txt
Date:   Fri, 13 Jul 2018 02:21:57 +0900
Message-Id: <20180712172157.8551-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.18.0.96.ged843436dd49
In-Reply-To: <20180712160517.7382-1-standby24x7@gmail.com>
References: <20180712160517.7382-1-standby24x7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in bonding.txt

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/networking/bonding.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/bonding.txt b/Documentation/networking/bonding.txt
index c13214d073a4..d3e5dd26db12 100644
--- a/Documentation/networking/bonding.txt
+++ b/Documentation/networking/bonding.txt
@@ -1490,7 +1490,7 @@ To remove an ARP target:
 
 To configure the interval between learning packet transmits:
 # echo 12 > /sys/class/net/bond0/bonding/lp_interval
-	NOTE: the lp_inteval is the number of seconds between instances where
+	NOTE: the lp_interval is the number of seconds between instances where
 the bonding driver sends learning packets to each slaves peer switch.  The
 default interval is 1 second.
 
-- 
2.18.0.96.ged843436dd49

