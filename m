Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F01C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D337E2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhTDxa2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D337E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeJBCYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:24:32 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:40280 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJBCYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:24:31 -0400
Received: by mail-it1-f202.google.com with SMTP id z136-v6so3374076itc.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VsLpWLkkiWqIuUFM4cLoN5CQTLtydc9ja3E5Z5HjjMo=;
        b=OhTDxa2w4uKZrFOJYCTbu1Js7iVsgCZLRI2l23x7cZqEM9KIS9mcwBoYBcE6/trGC1
         zR+IUmS+0Rj7WMKpcrb4V0aUC1JFAaZPR9CFR6/Mjk294vOBn7zehciDUghBsx1nIhRc
         IqOVKmsqo9AUATaOxTc/dIri3eY/7YuHVZHdZZANJ9+58WfL7EqXBEeZTQrdbnEEIZqz
         viHfQTC+nCbSJp2hSJvvee+FSrCqSjpBSapslACPi5MhszLwBaGxdgOD92xDzP6tZ+u+
         OIiw2All8WURgaJGYkqvBGMA2F3woPsI7uJ282x3zS90aVFGBBKUGCHbB9NgDJAhff6j
         RORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VsLpWLkkiWqIuUFM4cLoN5CQTLtydc9ja3E5Z5HjjMo=;
        b=sH2waa+QWg2YvdCaj3+EtfhaBQsoPDRyKjHA37PTGVK0hqfxRHbjiPMZE6rBIRpjrm
         3RZ667w9c2zb5GnvJuYLoqt6XuMHQxDGYZUAQ7b84mH/aPMy9jcC5Ix0FieR03LsIbd0
         jVSo5Dlnew8mnStwVW/hl26r9ualtzQwfL0C7GXcQgRUYlmPvLribP9Q2duo26dFY9nK
         RhsnGDzymdFPKHx6PGdffTn3fWAc2tYWwnudi3mKEThq2ft0F662sb5+zhBBFRA1AkEJ
         wFaWTbqxqOh/UoU1+Y0nSgLXO11OuzA8Iz8Oh402lNTbtE3CK0PDIQnFBMR06IE6sYwY
         Iwgw==
X-Gm-Message-State: ABuFfogAblb/Ek2LFzYMTGsbcnIAghNJdubxVwpjtOxrvkbYDqsdBHzm
        UJ7SnDtP37CnxaOObxWrcRy45BRsdkg=
X-Google-Smtp-Source: ACcGV6366npxgpbP4UaXLJOMQTHar9EKGuQtigsEM5rXryITRI0dM3Y+vR0A0d0v1JrYLV0lu1omCXcxIcI=
X-Received: by 2002:a24:7f05:: with SMTP id r5-v6mr5336500itc.2.1538423110363;
 Mon, 01 Oct 2018 12:45:10 -0700 (PDT)
Date:   Mon,  1 Oct 2018 12:45:00 -0700
In-Reply-To: <20181001194501.58338-1-badhri@google.com>
Message-Id: <20181001194501.58338-2-badhri@google.com>
Mime-Version: 1.0
References: <20181001194501.58338-1-badhri@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 2/3] usb: typec: tcpm: Do not disconnect link for self
 powered devices
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Li Jun <jun.li@nxp.com>,
        linux@roeck-us.net, jackp@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During HARD_RESET the data link is disconnected.
For self powered device, the spec is advising against doing that.

From USB_PD_R3_0
7.1.5 Response to Hard Resets
Device operation during and after a Hard Reset is defined as follows:
Self-powered devices Should Not disconnect from USB during a Hard Reset
(see Section 9.1.2).
Bus powered devices will disconnect from USB during a Hard Reset due to the
loss of their power source.

Tackle this by letting TCPM know whether the device is self or bus powered.

This overcomes unnecessary port disconnections from hard reset.
Also, speeds up the enumeration time when connected to Type-A ports.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---------
Version history:
V3:
Rebase on top of usb-next

V2:
Based on feedback from heikki.krogerus@linux.intel.com
- self_powered added to the struct tcpm_port which is populated from
  a. "connector" node of the device tree in tcpm_fw_get_caps()
  b. "self_powered" node of the tcpc_config in tcpm_copy_caps

Based on feedbase from linux@roeck-us.net
- Code was refactored
- SRC_HARD_RESET_VBUS_OFF sets the link state to false based
  on self_powered flag

V1 located here:
https://lkml.org/lkml/2018/9/13/94
---
 drivers/usb/typec/tcpm/tcpm.c | 12 ++++++++++--
 include/linux/usb/tcpm.h      |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4f1f4215f3d6..c3ac0e46106b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -317,6 +317,9 @@ struct tcpm_port {
 	/* Deadline in jiffies to exit src_try_wait state */
 	unsigned long max_wait;
 
+	/* port belongs to a self powered device */
+	bool self_powered;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -3257,7 +3260,8 @@ static void run_state_machine(struct tcpm_port *port)
 	case SRC_HARD_RESET_VBUS_OFF:
 		tcpm_set_vconn(port, true);
 		tcpm_set_vbus(port, false);
-		tcpm_set_roles(port, false, TYPEC_SOURCE, TYPEC_HOST);
+		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
+			       TYPEC_HOST);
 		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
 		break;
 	case SRC_HARD_RESET_VBUS_ON:
@@ -3270,7 +3274,8 @@ static void run_state_machine(struct tcpm_port *port)
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		tcpm_set_charge(port, false);
-		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
+		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
+			       TYPEC_DEVICE);
 		/*
 		 * VBUS may or may not toggle, depending on the adapter.
 		 * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
@@ -4409,6 +4414,8 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		return -EINVAL;
 	port->operating_snk_mw = mw / 1000;
 
+	port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
+
 	return 0;
 }
 
@@ -4717,6 +4724,7 @@ static int tcpm_copy_caps(struct tcpm_port *port,
 	port->typec_caps.prefer_role = tcfg->default_role;
 	port->typec_caps.type = tcfg->type;
 	port->typec_caps.data = tcfg->data;
+	port->self_powered = port->tcpc->config->self_powered;
 
 	return 0;
 }
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 7e7fbfb84e8e..50c74a77db55 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -89,6 +89,7 @@ struct tcpc_config {
 	enum typec_port_data data;
 	enum typec_role default_role;
 	bool try_role_hw;	/* try.{src,snk} implemented in hardware */
+	bool self_powered;	/* port belongs to a self powered device */
 
 	const struct typec_altmode_desc *alt_modes;
 };
-- 
2.19.0.605.g01d371f741-goog

