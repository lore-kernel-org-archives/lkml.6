Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB05C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F4C208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20150623.gappssmtp.com header.i=@waldekranz-com.20150623.gappssmtp.com header.b="B71Y8ZMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F4C208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391956AbeHPSY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:24:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35101 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbeHPSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:24:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id f18-v6so3702692lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization;
        bh=D8BtE1hNRozBYEn0QXG4kCz0VNciC9HqH3UUQtgLRdg=;
        b=B71Y8ZMbDaF/MsaP265n46xSFAesim2qq442tLL4w0lhae1kiq08cDUnCIbl8H8ZGM
         l/b/kA3/xx7ampzeeQopUSMtNh8kjMm4rfXEJs3i0rNVTh/spBPaFdA9DM0l0Eo9jnTU
         /7J/KtATmiYnMCPzWQoKUvcUvzF05c5aJfNpomjcEzntYsShOc8C5pxYV5Dtf79YoB9M
         zVRc72g1kLdg7r13/cjGA6BsFP3b/TCyzzRgi68/PzoJiFh0jCGttP/3JFbROUOlcEPm
         olSa8EXt0J+XXUV2y3GxmbbhKeOB2sany8gdSwusKGNfYgP5OXjkzFReRftFZLAkIbgw
         qFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=D8BtE1hNRozBYEn0QXG4kCz0VNciC9HqH3UUQtgLRdg=;
        b=F5Rt4o2hxf44BDh/gDjvcf9lgxmqCSErUg+TK7Uqpje1mlWjap/OhsjuEipZSFToxC
         k9HVnm5lFR0UBj5GemaGtszO6hjX90Lv8IogUJwhJlHIXCeuf/9qvp9v6abbCIQnHyWw
         8UCthredXigzOp+pZ2bZGadj8YxBCyok5DmmeC5WPahGsz2jo3puwh1oyIIN4q0BYSwp
         RhDDpJiqDGnWr7ndQKhaLjaD/IQDHHxAH+2Mh6st/WvXYkSaGpirj/VuExgDgziCQjCi
         Ou1IBRDulpW83z0WNgO9vC5aKZni30KM520oakxGT1OGRIC/Ln9UPyddnV3C9E8aOWuZ
         HcuA==
X-Gm-Message-State: AOUpUlFtWULh21bOqDjaAZtpJVzXlw4yl3dxH+kXxTWyr9nepgj0A9VL
        3rUDzTah86yUI1+1LBilBvupxA==
X-Google-Smtp-Source: AA+uWPxgXteP4nOSYuqEvMODixUQE84b5HEtf9fd5YU/fQPpT0sLsW5QGl8GLguhDCbw+oqEW5HKhA==
X-Received: by 2002:a19:5d54:: with SMTP id p20-v6mr19270418lfj.143.1534433117934;
        Thu, 16 Aug 2018 08:25:17 -0700 (PDT)
Received: from wkz-wmo.labs.westermo.se (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id b14-v6sm4948262lfa.62.2018.08.16.08.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 08:25:17 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     <netdev@vger.kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "GitAuthor: Tobias Waldekranz" <tobias@waldekranz.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] net: phy: add tracepoints
Date:   Thu, 16 Aug 2018 17:24:48 +0200
Message-Id: <20180816152452.7834-1-tobias@waldekranz.com>
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
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
v1 -> v2:
   * Actually include the entire patch, based on current net-next.
   * Pretty print the PHY's state according to Steven's suggestion.
---
 drivers/net/phy/phy.c      |   8 ++-
 include/trace/events/phy.h | 100 +++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/phy.h

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 1ee25877c4d1..74fc7151802c 100644
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
@@ -783,6 +786,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	if (PHY_HALTED == phydev->state)
 		return IRQ_NONE;		/* It can't be ours.  */
 
+	trace_phy_interrupt(irq, phydev);
 	return phy_change(phydev);
 }
 
@@ -1114,10 +1118,12 @@ void phy_state_machine(struct work_struct *work)
 	if (err < 0)
 		phy_error(phydev);
 
-	if (old_state != phydev->state)
+	if (old_state != phydev->state) {
+		trace_phy_state_change(phydev, old_state);
 		phydev_dbg(phydev, "PHY state change %s -> %s\n",
 			   phy_state_to_str(old_state),
 			   phy_state_to_str(phydev->state));
+	}
 
 	/* Only re-schedule a PHY state machine change if we are polling the
 	 * PHY, if PHY_IGNORE_INTERRUPT is set, then we will be moving
diff --git a/include/trace/events/phy.h b/include/trace/events/phy.h
new file mode 100644
index 000000000000..c5a0c5739d4a
--- /dev/null
+++ b/include/trace/events/phy.h
@@ -0,0 +1,100 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM phy
+
+#if !defined(_TRACE_PHY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PHY_H
+
+#include <linux/tracepoint.h>
+
+#define PHY_STATE_ENUMS \
+        EM( DOWN )      \
+        EM( STARTING )  \
+        EM( READY )     \
+        EM( PENDING )   \
+        EM( UP )        \
+        EM( AN )        \
+        EM( RUNNING )   \
+        EM( NOLINK )    \
+        EM( FORCING )   \
+        EM( CHANGELINK )\
+        EM( HALTED )    \
+        EMe(RESUMING)
+
+#undef EM
+#undef EMe
+
+#define EM(a) TRACE_DEFINE_ENUM( PHY_##a );
+#define EMe(a) TRACE_DEFINE_ENUM( PHY_##a );
+
+PHY_STATE_ENUMS
+
+#undef EM
+#undef EMe
+
+#define EM(a) { PHY_##a, #a },
+#define EMe(a) { PHY_##a, #a }
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
+	    TP_printk("phy-%d-irq irq=%d ifname=%-.16s state=%s",
+		      __entry->addr,
+		      __entry->irq,
+		      __entry->ifname,
+		      __print_symbolic(__entry->state, PHY_STATE_ENUMS)
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
+	    TP_printk("phy-%d-change ifname=%-.16s old_state=%s state=%s",
+		      __entry->addr,
+		      __entry->ifname,
+		      __print_symbolic(__entry->old_state, PHY_STATE_ENUMS),
+		      __print_symbolic(__entry->state, PHY_STATE_ENUMS)
+		    )
+	);
+
+#undef EM
+#undef EMe
+#undef PHY_STATE_ENUMS
+
+#endif /* _TRACE_PHY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

