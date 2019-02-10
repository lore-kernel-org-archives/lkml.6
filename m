Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9768C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECF620874
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgYAp9no"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBJRxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42881 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfBJRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so3375202oto.9;
        Sun, 10 Feb 2019 09:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exDgzfiqwA3z8lOpN/VUH5vzBnnYQ2SOMaSyGMBZROQ=;
        b=AgYAp9no8pvAvhahS4zyEYOHWK5zf+kFJSllL5DEUXl1fxLONkSRzYz4e30Z0xlMaV
         wfpgwhE5AK9LuE0/11ZRAf9Y6OKE81L+wgGo4AFfmqOj0rI+BZb9f3OzVoIB3niDuSt2
         o0bDBjXzHFpV8o/TL2pSRAtMR3AEhGIgQpP4gGBAhRgbCWn+1rgjUOveU4h4thWPNwdn
         nwTcYvzt9ODORTlV3z+NiFi3b0YoicrVfb3x3OypO8bMLZH/aLlJ5fpNIWZN/s6JIu3f
         1YlizvlIgdvTt/VlS23Q19yObJzYbQlySh3ioBHmdRXX+GiiDoY6ZBhyKdso13kyh7MK
         Uh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exDgzfiqwA3z8lOpN/VUH5vzBnnYQ2SOMaSyGMBZROQ=;
        b=jOGIkELMj2gmY+VTZpUR/dxQrnJqC2lCUdJHqpfCXUoBj6J2KNCKNG+heEFAgSlB3M
         XPysvUWi8xamNf4YqEHZcxSED/9UG8WmQsPCwq/YqmH57PxJocoaY8Wou1jH6xpBzjxt
         U5AZBBQus0mgc5YMHHZ/EVtPNW83Yv5Eo9ZLpeoTzgf92siTbJYnKAbpExZROQz50Oww
         rnnIS1IhqGcUEkQVDMiS2g3dHiWgACPpSg5/NbczClCqThpZKpzhGvGZJKi7zpQcoeon
         p6t6PFelto1wH9EcGhlJ4DZ3TIeZf5dxoqkPnkRaOjySOrJfgS5lfwphxhx40l7QfYkI
         NUUA==
X-Gm-Message-State: AHQUAubu+HcYY8doip8aS3k1pkUAAYKr5M2W+NVBX0NUtlbDXX0957UM
        uTAGzseFV/a/Qjd9YF++tDl28GsY
X-Google-Smtp-Source: AHgI3IYm7SbIUjsZ36F7ZxrQxeWde1DXAqNlFCXVt5TvxN78tG4vLheiH5pwd2DnQLuU4KNAifvPvw==
X-Received: by 2002:a9d:491e:: with SMTP id e30mr24798987otf.131.1549821200246;
        Sun, 10 Feb 2019 09:53:20 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:19 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 03/16] staging: fsl-dpaa2: ethsw: Check bridge port flags during set
Date:   Sun, 10 Feb 2019 09:50:52 -0800
Message-Id: <20190210175105.31629-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
have ethsw check that the bridge port flags that are being set are
supported.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e559f4c25cf7..6228c4375835 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -680,8 +680,11 @@ static int port_attr_br_flags_set(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err = 0;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans)) {
+		if (flags & ~(BR_LEARNING | BR_FLOOD))
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	/* Learning is enabled per switch */
 	err = ethsw_set_learning(port_priv->ethsw_data, flags & BR_LEARNING);
-- 
2.19.1

