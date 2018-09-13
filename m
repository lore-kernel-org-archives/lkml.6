Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02873C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF9D2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jh7s/VHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF9D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeIMHSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:18:41 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:36600 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbeIMHSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:18:41 -0400
Received: by mail-pl1-f202.google.com with SMTP id w18-v6so1910927plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 19:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y+lqFgjfBWDSIKd36fnHL64GSJToWjw4TcaXPRFwfII=;
        b=Jh7s/VHB/3fScArZlz4IAzg0G2CTcknzXe0bNweFwHE3u06Me2j0C/Z6/v/8Zb0ccT
         4E0o7lCs7m4oJ0VI/sbKb4LHNCcU25yNLLUNcEzdDb+DNbMvXnrclsMxqfzf4G3JgfMH
         3Ipme7mCAjYW/Fvbv58FzOvPpa3A+oLP5q0ZAzc9J/4HfwGD8Sc/62gctt6WOrGojlRr
         3cr6k0e7WjSgBWwNlAlvFw7sw3FsiUB1+ghlw74w7PieCtdiBY2sdWc6F6SGKDjvZRo6
         PcxQ0xMBchOuIoGNNHlpdzrXEapKGaC/lWUc2ECuF/Mlqbu/1uAPLlszR8NCX2CNgxK7
         y6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y+lqFgjfBWDSIKd36fnHL64GSJToWjw4TcaXPRFwfII=;
        b=O8Ch7+8HRYJaNmE34fjYOJ0n9DSYMQu2tbkmVLZPZE8a9zbAYiU62APNS+bNJ8Gnco
         wI/uaPNWTM+jWhtUhx192MsTmVUvAe/9SJscIW1/TXxNB905z63BDzMbG19b5ZQHB9N+
         Mnnjf5deR7KxhMxqFgv9sSkv/IvXhhAczeI4pwpph9qYFF/GDTb7jjd9MSBURNV3M4Cl
         TWvOdD0b879xlHMGw3v6Hubwmm324OBMXejF/1hLCYDPOUkOKouhY/r4OHYUCRRTAusX
         Osk8dAoi/EuU511rVHDU2yRj0oIVppRDdPOKGL5VigeAv3rotzSQmRS6XzZ5RtT1mFLS
         Z7lQ==
X-Gm-Message-State: APzg51BWpK1NJLRyOlp9WKUl/Y573943L5ygIELIdI0Mq5g7OrcCWzZo
        YDUJmxcqoUDFb3qQX27xbfVNoD/RdMo=
X-Google-Smtp-Source: ANB0VdZAF3tAU/tOZbSxcJbJ+CG6vp5WeQRCip29nnoD/TGkhanxrjCQ0Rky0A7MyCNLchDTW/Ko8coK/ys=
X-Received: by 2002:a63:445e:: with SMTP id t30-v6mr307974pgk.102.1536804685008;
 Wed, 12 Sep 2018 19:11:25 -0700 (PDT)
Date:   Wed, 12 Sep 2018 19:11:13 -0700
In-Reply-To: <20180913021113.18150-1-badhri@google.com>
Message-Id: <20180913021113.18150-2-badhri@google.com>
Mime-Version: 1.0
References: <20180913021113.18150-1-badhri@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 2/2] typec: tcpm: Add option to maintain current limit at Vsafe5V
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        Badhri Jagan Sridharan <Badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hard reset, TCPM turns off the charging path.
The spec provides an option for Sink to either drop to vSafe5V or vSafe0V.

From USB_PD_R3_0
2.6.2 Sink Operation
..
Serious errors are handled by Hard Reset Signaling issued by either Port
Partner. A Hard Reset:
resets protocol as for a Soft Reset but also returns the power supply to
USB Default Operation (vSafe0V or vSafe5V output) in order to protect the
Sink.

Add a config option to tcpc_dev and let the device specific driver decide
what needs to be done.

Signed-off-by: Badhri Jagan Sridharan <Badhri@google.com>
---
 drivers/usb/typec/tcpm.c | 7 ++++++-
 include/linux/usb/tcpm.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index a4e0c027a2a9..350d1a7c4543 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -3269,7 +3269,12 @@ static void run_state_machine(struct tcpm_port *port)
 	case SNK_HARD_RESET_SINK_OFF:
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
-		tcpm_set_charge(port, false);
+		if (port->tcpc->config->vsafe_5v_hard_reset)
+			tcpm_set_current_limit(port,
+					       tcpm_get_current_limit(port),
+					       5000);
+		else
+			tcpm_set_charge(port, false);
 
 		if (port->tcpc->config->self_powered)
 			tcpm_set_roles(port, true, TYPEC_SINK, TYPEC_DEVICE);
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 50c74a77db55..c6e3ccecba70 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -90,6 +90,7 @@ struct tcpc_config {
 	enum typec_role default_role;
 	bool try_role_hw;	/* try.{src,snk} implemented in hardware */
 	bool self_powered;	/* port belongs to a self powered device */
+	bool vsafe_5v_hard_reset;	/* Maintain VSAFE5V during hard reset */
 
 	const struct typec_altmode_desc *alt_modes;
 };
-- 
2.19.0.397.gdd90340f6a-goog

