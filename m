Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7223B206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiSNksgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7223B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395089AbeKVXN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:13:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43539 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeKVXN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:13:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so1895810pfk.10;
        Thu, 22 Nov 2018 04:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DYTqiSApdAitIqqDtZ+LJ7SQbtFQjRnVsdcjxxNatt0=;
        b=IiSNksgR+zaEyWJ6ESKEA+kTJ7wzUIN+X99ig0EpWr6gseAnWPu08mh9PDln+1jOY+
         TNPUwcNyc3FZaaYeees3UUJydZLYJ/HQzDp6YsvBcLm90bdMSSP0gCcOhFaq+mP7Jkhd
         wtm/qkqQRsheAKjB0gYMpQMB0j1tqH39j8umv58f2gYaymVVFWHLt+3eqn39WaHG+hbD
         HsRxp5LRYM2gG9neuA1fWOoTlI+/VZnSsVw0LpwCvUh/ax0AwsI9WFiq7xxO4SMc7nj6
         H4gcbDAmYAhBzT/oWvZerNKins7+wwAlYQ16ctQ/qbOH7mY0KX0EFYZpQJnXvzAq4HZD
         H0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DYTqiSApdAitIqqDtZ+LJ7SQbtFQjRnVsdcjxxNatt0=;
        b=jBMJebjRgdQxiTnxr3z0U0sYHejTwVTKU58X/uGrFfwRQQq1YGntKivHzazzTfEkkR
         4wmAibl+Wof0TiGSuBZDrHum0Lgs08wvt/rys5KFVwaftN9qTKsDMfBLODSRSm5pcD3i
         znCKD2Cxv3G00wBGs2GjO7lsoblsnVtj9Cqlz6E/saRqamGsj4XYmwhVAjuCNj5Qq1+1
         8A2KVhYMOjSV+7lkan9KSsFKNvDhylWP2QPGXAAfgm5eShNiS9a5lH+apiWaXU8XUMy+
         V5hvUNtos3Od4AyEQYE87PW6TYaHtC+lD03fyZnRplRndDWpkjV7TN2+GX4/Gm0DsSy9
         b+3Q==
X-Gm-Message-State: AA+aEWYPlHkr/6qiSXtmjaqqa2x71kWTnHl+yUKRqWLtz60ZwB/tljeP
        t+GeTOj/j8J+I2ftVVcUeDA=
X-Google-Smtp-Source: AFSGD/UethZ0J/z8w6gNLa8vCkw1R7MwnviL+B/qJQpYmouOHayKGNKGkJjiTTMTaDpsV/QPmtcpMQ==
X-Received: by 2002:a63:2586:: with SMTP id l128mr10035151pgl.104.1542890086124;
        Thu, 22 Nov 2018 04:34:46 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g2sm9917446pfi.95.2018.11.22.04.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 04:34:45 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, yuehaibing@huawei.com,
        sergei.shtylyov@cogentembedded.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] net: amd: add missing of_node_put()
Date:   Thu, 22 Nov 2018 07:34:41 -0500
Message-Id: <20181122123441.24331-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-update changelog
---
 drivers/net/ethernet/amd/sunlance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index b4fc0ed5bce8..9d4899826823 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1419,7 +1419,7 @@ static int sparc_lance_probe_one(struct platform_device *op,
 
 			prop = of_get_property(nd, "tpe-link-test?", NULL);
 			if (!prop)
-				goto no_link_test;
+				goto node_put;
 
 			if (strcmp(prop, "true")) {
 				printk(KERN_NOTICE "SunLance: warning: overriding option "
@@ -1428,6 +1428,8 @@ static int sparc_lance_probe_one(struct platform_device *op,
 				       "to ecd@skynet.be\n");
 				auxio_set_lte(AUXIO_LTE_ON);
 			}
+node_put:
+			of_node_put(nd);
 no_link_test:
 			lp->auto_select = 1;
 			lp->tpe = 0;
-- 
2.17.0

