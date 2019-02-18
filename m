Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77307C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1BE21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/2zmTJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfBRTMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42245 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfBRTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id n74so9028545pfi.9;
        Mon, 18 Feb 2019 11:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFyxx3coigLXIUnYrMNDcJ8yS3ex13/5C2k6HQrWOzQ=;
        b=j/2zmTJId//3kAJHI4zqwJNlTgSIlBOaeR9MScVESdrnORq1CO8/zgxGVb3riMldIt
         bteltu/2LuE2xTWm36jS+AMfD1Ylf4YOoqStlcJmJQfwV6TRNAiKFziimhwnFjzRNo/k
         OjvLOFqBHp64Io8XqQVsW+2H2UdOQPupazwLhgAGqQm3cUW2qNgw9UA7M4z/DB2Qbut9
         S5YA/89qAPoCFz62mbzrnRLqYSVGAKSHrwlFQ+Kv6QMixPl52x+xq5HopS0HNrBh0n4m
         KeJVEHELKyMf5LvNvgb4J3x12/Is19UTp7r/Nj5CCGLBOPUaquxdIyEmixKQJigB61zL
         uJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFyxx3coigLXIUnYrMNDcJ8yS3ex13/5C2k6HQrWOzQ=;
        b=U+Whf7WaAb7xhlHtnEHBPjoVfMbXwdH+GzU7zP7Q2/0rQ6K014B8IUKa8Rr4od3eUL
         FfotE4DlmscrVqPxgAKowhNwRJeMA0/3FJc4xo++LKPWOjSUl7/SZhkzbRbX9nN7bdl5
         zDaVV80PTNVDSosi119qPEGDIPmLsBcp6OPIaIe8oVHtI71N8GzFP3aG3XEQLCkUnuk7
         9Jv2LHRSxJSMV7KXmqqzsT1b6bqR3PQl8EBTVQMknchRkVCPhGPCnfqBm6VJdYuc1uLH
         5dpdjBDGFoARu5lHeLT9qeHsTZ9594Z7pUT9akX6OrNRNjPeclPkTVloGyryOMdOwDK8
         K7Wg==
X-Gm-Message-State: AHQUAuY8JX1XVfzA3jgkXZmkv+1zdFHsrTzHu98m5XEEW+YrxjVYrqqK
        i2xvX9fS0rOokCaBAzJFqbA3z2EF
X-Google-Smtp-Source: AHgI3IbUj5laPIxoU+n3JTaSdLFz0kRUxtnOKSIwsiVL9d/Ppq6eO+4JPq+nTTfgNXJKO8rj7nf4nw==
X-Received: by 2002:a63:ed0b:: with SMTP id d11mr6249465pgi.435.1550517132457;
        Mon, 18 Feb 2019 11:12:12 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:11 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()
Date:   Mon, 18 Feb 2019 11:11:39 -0800
Message-Id: <20190218191141.3729-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use goto to avoid repeating resource deallocation code.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3d520d3b2da4..d4f5e180e1ee 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -78,9 +78,8 @@ static int qoriq_tmu_get_sensor_id(void)
 			"#thermal-sensor-cells",
 			0, &sensor_specs);
 	if (ret) {
-		of_node_put(np);
-		of_node_put(sensor_np);
-		return ret;
+		id = ret;
+		goto out;
 	}
 
 	if (sensor_specs.args_count >= 1) {
@@ -91,7 +90,7 @@ static int qoriq_tmu_get_sensor_id(void)
 	} else {
 		id = 0;
 	}
-
+out:
 	of_node_put(np);
 	of_node_put(sensor_np);
 
-- 
2.20.1

