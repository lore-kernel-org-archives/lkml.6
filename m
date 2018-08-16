Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEFDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09D52148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20150623.gappssmtp.com header.i=@waldekranz-com.20150623.gappssmtp.com header.b="AuLjc1VP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09D52148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390531AbeHPMbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:31:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37015 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbeHPMbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:31:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so3133543ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization;
        bh=1g4W4DPaKo8EPB3Yox5xayg40Vuqf10sRmiBShKv2lk=;
        b=AuLjc1VPGEFjCod4WjjxF2SP8PILZWQsbrohXnNsN65tzephB07/AScQv1hWE4wpbA
         aYx3/6Se+sMxFO/OUV+pvQDHbjunkLqA1qNPB1Ubt9LzEBcslTEPS1BbJtUSOpJiB6zb
         OYKn3Tz+S7EGtKN4ajhOXD7GkKhOGxfGJl0Ua3GdwzmDC0uiyY7T+gYbTr5rwYuf7qkL
         tx62FnGkWH70W6Xic3d/94r2QOEAXe2YpbW3t/vXVOsC8R52bZ1XND9ef9yGwWGeniXQ
         0+VkfZXpQTRPJvkw3EO+wB+HYIolXQyqhtfW24GDdPohFpt+O27VEDi5Dz+NonFFTdio
         lz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=1g4W4DPaKo8EPB3Yox5xayg40Vuqf10sRmiBShKv2lk=;
        b=YjebC9CkcdfxdaYkn8NTPfjKzEZOp/tFXxHSstRheClB3EtdWFC9QgVRv2u6eiWxgR
         kLdFGZCApST0TVHhq0aMFYZFd1wGJOKihRUjbzgT++kXJtDuSxnEoHpuefBqDAVNXno3
         WnEfdmctXknV2T8Qdlc3tcpauZqJeAtyVnQvToV3Mx1F/MJtBOvUoGYzVJQI38HiAlis
         Xg6AEOZczxtrprrHEvPgUMWU8iaHqb1zDciwrDvuVgkl30juETFohA7llAgZpRj9hjZN
         nujZt/imQ/2y4aGlwYQ7gyxeBb3c7Qzjr1pY8H6Apw6DXM27YZU77t5OfVypgA9JLoIq
         KiyQ==
X-Gm-Message-State: AOUpUlF1oaeVjKRN4N4queHz0EJZI0omiz/RdPuWTwjH25fD2nk8xaZb
        xWDXcn/eDSkBxMXBoUeW4MdX9Q==
X-Google-Smtp-Source: AA+uWPxZelV1QGSD5lRgOSr4KWre3MO8QmzqFT+xTfq/2e2MezGNLx48nSFTqYHaso2OdNv2vCv3hg==
X-Received: by 2002:a2e:2096:: with SMTP id g22-v6mr4176691lji.37.1534412059468;
        Thu, 16 Aug 2018 02:34:19 -0700 (PDT)
Received: from wkz-wmo.labs.westermo.se (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id q85-v6sm4983138lfg.20.2018.08.16.02.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 02:34:18 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     tobias@waldekranz.com
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY)
Subject: [PATCH] net: phy: add tracepoints
Date:   Thu, 16 Aug 2018 11:34:15 +0200
Message-Id: <20180816093418.2621-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.17.1
Organization: Westermo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two tracepoints for now:

   * `phy_interrupt` Pretty self-explanatory.

   * `phy_state_change` Whenever the PHY's state machine is run, trace
     the old and the new state.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/phy/phy.c      |  4 +++
 include/trace/events/phy.h | 68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 include/trace/events/phy.h

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9aabfa1a455a..8d22926f3962 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -38,6 +38,9 @@
 
 #include <asm/irq.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/phy.h>
+
 #define PHY_STATE_STR(_state)			\
 	case PHY_##_state:			\
 		return __stringify(_state);	\
@@ -1039,6 +1042,7 @@ void phy_state_machine(struct work_struct *work)
 	if (err < 0)
 		phy_error(phydev);
 
+        trace_phy_state_change(phydev, old_state);
 	if (old_state != phydev->state)
 		phydev_dbg(phydev, "PHY state change %s -> %s\n",
 			   phy_state_to_str(old_state),
diff --git a/include/trace/events/phy.h b/include/trace/events/phy.h
new file mode 100644
index 000000000000..7ba6c0dda47e
--- /dev/null
+++ b/include/trace/events/phy.h
@@ -0,0 +1,68 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM phy
+
+#if !defined(_TRACE_PHY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PHY_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(phy_interrupt,
+	    TP_PROTO(int irq, struct phy_device *phydev),
+	    TP_ARGS(irq, phydev),
+	    TP_STRUCT__entry(
+		    __field(int, irq)
+		    __field(int, addr)
+		    __field(int, state)
+		    __array(char, ifname, IFNAMSIZ)
+		    ),
+	    TP_fast_assign(
+		    __entry->irq = irq;
+		    __entry->addr = phydev->mdio.addr;
+		    __entry->state = phydev->state;
+		    if (phydev->attached_dev)
+			    memcpy(__entry->ifname,
+				   netdev_name(phydev->attached_dev),
+				   IFNAMSIZ);
+		    else
+			    memset(__entry->ifname, 0, IFNAMSIZ);
+		    ),
+	    TP_printk("phy-%d-irq irq=%d ifname=%16s state=%d",
+		      __entry->addr,
+		      __entry->irq,
+		      __entry->ifname,
+		      __entry->state
+		    )
+	);
+
+TRACE_EVENT(phy_state_change,
+	    TP_PROTO(struct phy_device *phydev, enum phy_state old_state),
+	    TP_ARGS(phydev, old_state),
+	    TP_STRUCT__entry(
+		    __field(int, addr)
+		    __field(int, state)
+		    __field(int, old_state)
+		    __array(char, ifname, IFNAMSIZ)
+		    ),
+	    TP_fast_assign(
+		    __entry->addr = phydev->mdio.addr;
+		    __entry->state = phydev->state;
+		    __entry->old_state = old_state;
+		    if (phydev->attached_dev)
+			    memcpy(__entry->ifname,
+				   netdev_name(phydev->attached_dev),
+				   IFNAMSIZ);
+		    else
+			    memset(__entry->ifname, 0, IFNAMSIZ);
+		    ),
+	    TP_printk("phy-%d-change ifname=%16s old_state=%d state=%d",
+		      __entry->addr,
+		      __entry->ifname,
+		      __entry->old_state,
+		      __entry->state
+		    )
+	);
+
+#endif /* _TRACE_PHY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

