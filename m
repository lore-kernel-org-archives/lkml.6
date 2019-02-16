Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE37C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7E4222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO/B0s9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404689AbfBPE4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:56:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44648 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394643AbfBPE4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:56:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id g1so20099802otj.11;
        Fri, 15 Feb 2019 20:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bK6KJ8PbptzY6Cxty2elvsR4uDi55jXHgyWEWfvoolA=;
        b=TO/B0s9tQc1H7B9aD1PXwx/igb/dq+E+rL+tpEKjJXWduMWiW2Ft3S2+UPpIm/wFWu
         nfX87pj8aew0tTw3Tzsykl1KcJoeHok370bvbB+davuFfcmvdCzgidtCI20lQfDsjV15
         cOizoUAp9R3Qb5iu4mrxZZ/bG/dRdeuuPIe4Cb+3ADxfpPUZcjaA87kTb+u8c3L9oDGK
         uX+iyFeTOtgqe7TwoDxsmv5igeWxN/X78uhBT/7rFhGId5VVsoMpfOsQ0AzMkjQ/HC4U
         IzTL3AR1xCEPa3EK8blsnRbzbOzu8sTZNh+38m3/ec7ywq6YQ4gaZ9hORYN8lO/ZGGLw
         6dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bK6KJ8PbptzY6Cxty2elvsR4uDi55jXHgyWEWfvoolA=;
        b=EocQHHqzUYSlwklXonpPS6NtpzdOU8DKVaMJoESTU7sxPMCk3SOiMNIIEVjx9hmLqy
         ch0/jS7hkgCVjVbXgXYkhrEq3pSu8paYMnR0Bt6esVWpfh0b7/QgqpPnWYYUGNBtrNhB
         gP4S/ytcsjogGsLaND+upTJEgXOTrc1o5QtxKAGQLIhrHubwdNICUp1AEIMlU3DwYMo0
         UZ1j2NDtmkG+b0nltYoebZDwoiNKG+R0S3ecWi55BpLm51wNrTU2XzrMGF0235NMDViK
         wPZLsk8UP2Zu38Une5phq0vGy4uEznFNKMkxc1/HbhxyuZbo6QuwBW+UWWHAXE9MRyEo
         Dnsw==
X-Gm-Message-State: AHQUAuZZq04Vgm7cgXQbULAlVxYRsbkL/MmekXuMZZrQuHvnNMonb2/E
        uySrJNBtOeNUKXpjwqO1r9OYfHVJ
X-Google-Smtp-Source: AHgI3IaGy/BnT8tPXgegzohYuF+GJA6uGOBqb0cDwQU2HFz8xWMEsl7ZaDQAedeBsbIfauSp1GbAyg==
X-Received: by 2002:aca:4d49:: with SMTP id a70mr8047290oib.135.1550292970762;
        Fri, 15 Feb 2019 20:56:10 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id j88sm3209480otj.47.2019.02.15.20.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 20:56:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 4/9] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
Date:   Fri, 15 Feb 2019 20:55:51 -0800
Message-Id: <20190216045556.3514-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190216045556.3514-1-f.fainelli@gmail.com>
References: <20190216045556.3514-1-f.fainelli@gmail.com>
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

