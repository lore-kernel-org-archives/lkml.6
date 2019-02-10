Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB0FC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633B620874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMspBbhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBJRxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40002 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfBJRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so13890697oth.7;
        Sun, 10 Feb 2019 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRaNPPzM96oGSGlTiQdvEvb1VbhoN7y90hwdqDXlGIw=;
        b=YMspBbhkiCZVIRUzHRVdS6460kq5AxFn+bI5KvcOAFT+6deQTvZeiPcxEgCIMvneBi
         qYCSK7g4SrifAI4MfUzSN3Ia+fuu+b+xMzEziKJ4a6vh+fIAz+r6WLPbWSY712nGvo+L
         FuizCI/l2o4E4uDTumBAiIQYQR/dXX6T+MdL40RToqqiJgBScvbQttFPcH81haBW2Gn/
         wGk5KKu8Daj0CkbyeXdzGhXHP+CEaLpWegv77oRJlWo0MoWUF9QEhLKNLWWOmHm0uZb1
         ZdwYJZ6o/tbsY3DowcZQKXhJ73L79wpCGoaT0DY+qfQV5J6HA56wAkXBZGHOLi0lcGk4
         XNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRaNPPzM96oGSGlTiQdvEvb1VbhoN7y90hwdqDXlGIw=;
        b=KmKqAfNzxUAd1Vwo3Mi1TDNTtjzCCKIft47XQ+WHsab/+X+G/H5yG6MBIv1xH5nNom
         hbLrUnmKwkzkaGPACBakaXE+pJX5N3LMYYJ3HKnYuzuEWEgWWpmP+DjzscBIc43Cw6VU
         5DvPfuEzldjWyCi5Nnca1wgIoDrJUAjruksSaMYln4rkORaIFuS0tJzRqGVY+xVPCILq
         1S7Ys7fU64EM1s1CAE2hwl3TyXwUXYrAo27vjvVoyyRB/mCxVp27XDt+OHTCF344qJSJ
         F7JOVz4XA+G47h21GVdBMV78ribp4sO058no+eIgmS3DAgGKrUGuypoZ6KHIpwq5uP6F
         KWhg==
X-Gm-Message-State: AHQUAub6B61sh/r4nTfURG0MMMBrM78L+g39e8wDk47Kg3i8PMN74qXY
        wVGwOtSmPuqoq1L8AZacCh70P7X+
X-Google-Smtp-Source: AHgI3IbnDuaexYvhLjmaWPEhKYT4hpGUxG/93QSOD9P7QbL46Z4DPfDsD3cGDuMcfme2oZrUqQIrEw==
X-Received: by 2002:a9d:4a87:: with SMTP id i7mr24377964otf.178.1549821217181;
        Sun, 10 Feb 2019 09:53:37 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:36 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 12/16] mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
Date:   Sun, 10 Feb 2019 09:51:01 -0800
Message-Id: <20190210175105.31629-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will change the way we communicate getting or setting
a port's attribute and use a blocking notifier to perform those tasks.

Prepare mlxsw to support receiving notifier events targeting
SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
mlxsw_sp_port_attr_set() call.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 6b09d68671cf..39a99db040bd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3410,6 +3410,20 @@ mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net_device *vxlan_dev,
 	}
 }
 
+static int
+mlxsw_sp_switchdev_port_attr_set_event(unsigned long event,
+		struct net_device *dev,
+		struct switchdev_notifier_port_attr_info *port_attr_info)
+{
+	int err;
+
+	err = mlxsw_sp_port_attr_set(dev, port_attr_info->attr,
+				     port_attr_info->trans);
+
+	port_attr_info->handled = true;
+	return notifier_from_errno(err);
+}
+
 static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 					     unsigned long event, void *ptr)
 {
@@ -3433,6 +3447,8 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 							mlxsw_sp_port_dev_check,
 							mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
+	case SWITCHDEV_PORT_ATTR_SET:
+		return mlxsw_sp_switchdev_port_attr_set_event(event, dev, ptr);
 	}
 
 	return NOTIFY_DONE;
-- 
2.19.1

