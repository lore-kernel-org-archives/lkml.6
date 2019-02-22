Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5660207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rz/IOuxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfBVEJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:09:47 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37481 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBVEJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 23:09:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so811686otp.4;
        Thu, 21 Feb 2019 20:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hA0RaDSzpjwvtz0nSJ4G4w3181lotehF1hftLxCAX8=;
        b=rz/IOuxQoE5tTPwE0Z5PVA38BdYg9uAuCi/jSyQmXnxqoUuG1HSIrAnzPaO0vZikNJ
         5pWHugUc3VNw206wONd/VqzpZ6EozwbdeQfM/T+Uo4OFEM3ZVuVN9htDTfnU4oAZYjvM
         EKOTF3JAQ0Y4NieBTntLwyH8kq1WlF5z5qMtYOXWW1pDk4Lj5L5iMmMcSeFvPgk5OejN
         3i44gdfqZud1nGWKuQvazPJGv/+ji98kBrIrI4YtgakL4UM11Ruq3YhawT6bi0M5fXMS
         dZh05FJyuw5X45d+7pX/pUhP5yYgRc+02wm5y2IklcuAjGVfC7TI4z0dmtzXRzoI+b5p
         iXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hA0RaDSzpjwvtz0nSJ4G4w3181lotehF1hftLxCAX8=;
        b=IUlWfMRlWurAzvUxRi/7rf/LDhvQXuRNO9u8gy6RUviZqc/S78pHUzPts53Zvhr+9e
         PLHe/PTN+xfcmov0hk5iNRMAR5hwx0OLFd69Rconiu6MJpUsffCRkT6iaQywHoMtapIO
         SEydGJkLZDlFo4x7qDmTtssibr4hJgggp6OpC8OR6igJKmI+yJ66SKmqRzpLcS9FYuLU
         A/qcmEHp940ox3ePFhYxS+Myh58UAJOLi77Lxvt8FK1k6PgNrNz5KsmLcqNPwgC+JS20
         clwDWM7/efKow3aoECQG5aZIMUZJW4oZCIKmabDJSJ8Xn7GHDQ69/VBAIQcWnDlcjy6h
         5u6w==
X-Gm-Message-State: AHQUAubUIvqbAZkCwypuNbIrO5TarGcvlnZeYdlXZGuMsKUmnYKgGlbI
        0FGSg2UpuJV0ha/ZsfJ+Q9VYwGp6
X-Google-Smtp-Source: AHgI3Ia6STFGMP65D24Jt0snDUTrJezW37GpPJlOQGpC/3awrKWCStNaxetzM2EO2TzKFKLhwHUnsg==
X-Received: by 2002:a05:6830:d8:: with SMTP id x24mr1335217oto.352.1550808585597;
        Thu, 21 Feb 2019 20:09:45 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id r1sm167836otk.48.2019.02.21.20.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 20:09:44 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/4] mlxsw: spectrum: Avoid -Wformat-truncation warnings
Date:   Thu, 21 Feb 2019 20:09:26 -0800
Message-Id: <20190222040929.16657-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222040929.16657-1-f.fainelli@gmail.com>
References: <20190222040929.16657-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give precision identifiers to the two snprintf() formatting the priority
and TC strings to avoid producing these two warnings:

drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function
'mlxsw_sp_port_get_prio_strings':
drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2132:37: warning: '%d'
directive output may be truncated writing between 1 and 3 bytes into a
region of size between 0 and 31 [-Wformat-truncation=]
   snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
                                     ^~
drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2132:3: note: 'snprintf'
output between 3 and 36 bytes into a destination of size 32
   snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     mlxsw_sp_port_hw_prio_stats[i].str, prio);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function
'mlxsw_sp_port_get_tc_strings':
drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2143:37: warning: '%d'
directive output may be truncated writing between 1 and 11 bytes into a
region of size between 0 and 31 [-Wformat-truncation=]
   snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
                                     ^~
drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2143:3: note: 'snprintf'
output between 3 and 44 bytes into a destination of size 32
   snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     mlxsw_sp_port_hw_tc_stats[i].str, tc);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index f018b0607dac..5f6962da8877 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2129,7 +2129,7 @@ static void mlxsw_sp_port_get_prio_strings(u8 **p, int prio)
 	int i;
 
 	for (i = 0; i < MLXSW_SP_PORT_HW_PRIO_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
+		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
 			 mlxsw_sp_port_hw_prio_stats[i].str, prio);
 		*p += ETH_GSTRING_LEN;
 	}
@@ -2140,7 +2140,7 @@ static void mlxsw_sp_port_get_tc_strings(u8 **p, int tc)
 	int i;
 
 	for (i = 0; i < MLXSW_SP_PORT_HW_TC_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
+		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
 			 mlxsw_sp_port_hw_tc_stats[i].str, tc);
 		*p += ETH_GSTRING_LEN;
 	}
-- 
2.19.1

