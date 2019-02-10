Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFF1C4151A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5DE2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjOg8Ys1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBJXkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:40:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44001 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfBJXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:40:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so113028ota.10;
        Sun, 10 Feb 2019 15:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bK6KJ8PbptzY6Cxty2elvsR4uDi55jXHgyWEWfvoolA=;
        b=PjOg8Ys1V2tfMNGxzaW552XSjpEB3uRFYjoUcPjFY1FYTQoeNyXhAYw3WjcM2JNhwa
         0l4Dr4zC3i4L7avSCEHyUUUq7ydlAX1HNmSHbS4tzNInxGMsZ4M9907Ovu4pO/nGOt9E
         N+vywnyxPCjTXinJ/sYoK+WE0o4sgDak4gNW0djDqX2KI0qO+sMpF6aSBDrZkCzldO/k
         jZcyRVV0X2OkGGz1i8r7gh+DfvnmCkE9ioJtb0pf4CfxMHfj/cqI0LoFNwAtm9tdZk8r
         SioU7yFdBFxkGtFjkxFnYXFPfEzNT32lzENm7T2yHc2vyRP2a44zltOrZzdsDT1oYiVA
         EMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bK6KJ8PbptzY6Cxty2elvsR4uDi55jXHgyWEWfvoolA=;
        b=cGDEWbWivXoXYxAlOUIfeuciuJxUY3r7fGZqB7pntrsEA6iqIAunu+SjsQnTcn7QXx
         bgS2NzrCo4+zHSscHDskpdR+luX9/VjVorXuTN8nhEwv3EAaOPPwzKgqFgmH1xuZoPxe
         +YdV6n5P/cH4SQvHxxdcUWd0a+/+MPxkSP270l+owATy+1ctn54l1JWJU9gIPp4qt66M
         9+mfu/5sxzckyZlQIOXP6r50ODP3QU/N0439wC0wWXdjfifXLohMtkvShB8Q42GIMrzz
         CMkKw+pdBcfDgcTB28CZ1EuirUkLO8yPT6afqbr/rNCrLlH3Zc/nLWXUWXbwG9W7TRnT
         KNjA==
X-Gm-Message-State: AHQUAuaONoFnrsPjlf8+q4LjsVlWnM5CNV+XVwSWScPLLtOoYVfWpHuc
        AN3NQEPMNrvpAJv9qi8yGGt/5BBL
X-Google-Smtp-Source: AHgI3IYUKc1aVqQs35S6cxRtPN0hL5C5PDYbcnQMf/CNL+9Kam24TAb1OGmd7DCI0gepChmkXReDGA==
X-Received: by 2002:a9d:67cf:: with SMTP id c15mr23672252otn.38.1549842021789;
        Sun, 10 Feb 2019 15:40:21 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v3sm4944269oib.57.2019.02.10.15.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:40:21 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 4/9] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Sun, 10 Feb 2019 15:40:02 -0800
Message-Id: <20190210234007.16173-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
mlxsw_sp_port_attr_{set,get} calls.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 95e37de3e48f..c6d7bb70e8f2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3443,6 +3443,26 @@ mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net_device *vxlan_dev,
 	}
 }
 
+static int
+mlxsw_sp_switchdev_port_attr_event(unsigned long event, struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err = -EOPNOTSUPP;
+
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = mlxsw_sp_port_attr_set(dev, port_attr_info->attr,
+					     port_attr_info->trans);
+		break;
+	case SWITCHDEV_PORT_ATTR_GET:
+		err = mlxsw_sp_port_attr_get(dev, port_attr_info->attr);
+		break;
+	}
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 					     unsigned long event, void *ptr)
 {
@@ -3466,6 +3486,9 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+	case SWITCHDEV_PORT_ATTR_GET:
+		return mlxsw_sp_switchdev_port_attr_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

