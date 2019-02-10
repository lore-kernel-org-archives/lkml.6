Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D57C282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7A2173C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaBWKmWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBJRxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:53:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39976 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBJRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:53:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so13890070oth.7;
        Sun, 10 Feb 2019 09:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zl/HyELvG6PMVqnH30RIyCX+2L6jJFk32RBdmwKy5nw=;
        b=eaBWKmWU5SyOKj+LbsSWwDOhrBiQ2cqf21r3RepMklKAjTufvG1hTlZfeWTOb+XEb9
         X3Jld52sQ88uD4NfzVXXQg927esA5dZ4ZGove6VQSzRAaZVXQ+3zgJDgOqDGuw+Q1isR
         7eeJuJVvz/PrZLTeBPORVmzp/DPE7CazevMkRMOQ0Mt4LAo0vqtkUB8O3MlhA1qE1ioM
         JRNTKtutzN6F8kGnf/6CkTaVsV4y3KzPexLCEx4ufXtH0EXO+IbB0AATN9/LViqr4EGq
         IChZbcSsDfr/DdjutvJ1IwbaAn7eah1SV6fdn25L3GCnv7GGyit1jPtzfb79dwrSeAHy
         Rr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zl/HyELvG6PMVqnH30RIyCX+2L6jJFk32RBdmwKy5nw=;
        b=VZ9yoYaO/7dDKm5mQYw3leVNg7PCgorwhAKXN8UnBZ0ZgfoJ289awyPnIkcHayTbl6
         KGxXPFZxgtgBx3ESo3YJKC1hbNoBseJ9IdhG+wBt2fZQwwr55MtXaRlA1lc1V0iJE1OK
         JqqlJ+JbLt9EtdsiC0e7q6BpTYVogAH5pQIkw/vk4Em6Z22TaYPu2yeUQCQU/ZagS28y
         omkE1LE9BGaHhue3MDodwcEUEdCkbXI2PDr+YvSQgrRjU+OvlgTHTVGh62e+gZDPdX3H
         hVW3udCaarQdTJaUMhbYAUjQu7Lda3y8EhoxC9WSDud8zQFHyZxF7XgfXjzXIZQxlUDM
         QUbw==
X-Gm-Message-State: AHQUAuZfDrdRMT40gNdOxWQpbn4seqI9+IBjj7Z8dUt4W/D7Yi3pIBAB
        tJfQjOVLhypUoatHGu2mab3xV7jv
X-Google-Smtp-Source: AHgI3IYaa3rxlAqDUJi2c/r4ohl+9myzYVyr2o5t7r/G0iAx2+nBrV5+uTosTYviuDhE7H7hmdy6Mg==
X-Received: by 2002:a05:6830:1609:: with SMTP id g9mr10421755otr.254.1549821198322;
        Sun, 10 Feb 2019 09:53:18 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id n9sm3156425otq.14.2019.02.10.09.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 09:53:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 02/16] mlxsw: spectrum: Check bridge flags during prepare phase
Date:   Sun, 10 Feb 2019 09:50:51 -0800
Message-Id: <20190210175105.31629-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute identifier.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 95e37de3e48f..468a6d513074 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -623,8 +623,11 @@ static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	struct mlxsw_sp_bridge_port *bridge_port;
 	int err;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans)) {
+		if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	bridge_port = mlxsw_sp_bridge_port_find(mlxsw_sp_port->mlxsw_sp->bridge,
 						orig_dev);
-- 
2.19.1

