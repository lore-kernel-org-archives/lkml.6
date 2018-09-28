Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED70C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2360E2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTZVld6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2360E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeI2GNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:13:20 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:50458 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeI2GNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:13:19 -0400
Received: by mail-io1-f74.google.com with SMTP id z25-v6so7406811iog.17
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VGBPC0+5MfgBeTwcQV7UNeHMjUpPM219+NLcZ6XjGzQ=;
        b=TTZVld6gH0rnDFS07wFl5BIabshz9wyHmQX1fIo59S4A+1ZXrwnvYEpoZEVoGLJKwN
         h7+ESC88kRrkaSfL3Dc0xlaE71v5ySVTtrWmUlM3xyOqs0HRhtLL7Gfne+VRIzN7b628
         XVO4ud+Oo9zx3HNKIhBgGDm9YHyFduIHOK1+5f0BpDYT5p5QLr6xp0fDzoi+QtZ9bLWs
         YtjFDVFlhdd7WGTPJ2Adl9Gf04C2I7a8Ic6ggHu/tAY7UPDIyoGqz9eI3e1ndnWGGoh0
         Mru1l5vNV/mM+GaC4xgTmltnav6sAlj2zH++dtep0hkYnXIBuhEMdcFfoYTNx2KhaUYx
         M6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VGBPC0+5MfgBeTwcQV7UNeHMjUpPM219+NLcZ6XjGzQ=;
        b=ZGCMFPPoH9fSMBA0OnJPG7RF18kMYpTlGYUjr7pPhEjeDdaTQS5xaZmqli3GeI2dqi
         Wz16meDYuvsbTTpVzeHanlqF6hbFjAQYWORTjfP92jkT8Pa0LzTyxWX/3rRjwQfqYHwC
         0CS4jue0oZxUgVSjKbitRMPkSEkwma5gP+boZZnpHsLvkcoHlAeZIAF82DppP6wDZex7
         Umy3p68P3HxKoGvhk+Ix1qm0T0CPSWvzcqlY8L/AUt9c8qHF5YZxU6uas9keuPv46ldQ
         KCpHmyBKX1XlomQt8qD3S3juJqD3FoKfEIe45OsnzATReiBS0zbjigvVAo8gyGW9eXFB
         NPMw==
X-Gm-Message-State: ABuFfoh1C07T1z5fjPuEVdEciBmWdapyuHLT2wzCp5QSqKTByHqc2J9U
        IJwYxoeCksGE47bJc7phF9orva2jxkk=
X-Google-Smtp-Source: ACcGV61EoIXoXQ3l/UoDyCC1vOcEIp5oOqNhIgZlbcfMkBRfrbWhNhCXjp8uaFVRUKwFqpCELVuJmRi1MC8=
X-Received: by 2002:a24:2414:: with SMTP id f20-v6mr3495212ita.0.1538178433353;
 Fri, 28 Sep 2018 16:47:13 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:47:02 -0700
In-Reply-To: <20180928234703.15970-1-badhri@google.com>
Message-Id: <20180928234703.15970-2-badhri@google.com>
Mime-Version: 1.0
References: <20180928234703.15970-1-badhri@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 2/3] [PATCH v2 2/3] usb: typec: tcpm: Do not disconnect link
 for self powered devices
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Li Jun <jun.li@nxp.com>,
        linux@roeck-us.net
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
 drivers/usb/typec/tcpm.c | 12 ++++++++++--
 include/linux/usb/tcpm.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 4f1f4215f3d6e..c3ac0e46106b4 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
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
index 7e7fbfb84e8e3..50c74a77db55c 100644
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

