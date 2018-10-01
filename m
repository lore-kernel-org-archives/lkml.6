Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A08C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FBE2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpqKwe5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FBE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeJBCYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:24:35 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44087 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJBCYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:24:34 -0400
Received: by mail-pg1-f202.google.com with SMTP id h9-v6so7567627pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QnL/wTVd8g+QQeeekaKssRaFgYtQTuUuTzrOIXl9vSk=;
        b=dpqKwe5Jx6HO0cUzvwv0H7tzvpV3wpkeNtz/Ke092GpEnNuuOikG2YlGK0AHPileSq
         lXd1DzNXvtw/eJItv146cxyedGJxyOkan/mUQiiHNdBN/zfHG+PI1i3vCTgM0rxscIX+
         Odj5CK5qqOI0YdMP7xmRWpRzJGJjpQZX8C0G1yB4ysJgcJ7JKz5IS8HOQvGrxSZV+7nT
         7e4ztgfS5x9SHICPTqgIQpXfp22QixU8mI9uwhsNxtLcB20byNYUExTIUXCxwK1lphu+
         NrkLwJr+CDpBrr+opME9s2rOdSCCl/n/7SuXJl4LMbPRYxqicfaamUGw+7UJUu9ImuC2
         ofKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QnL/wTVd8g+QQeeekaKssRaFgYtQTuUuTzrOIXl9vSk=;
        b=qf8K2UmJHtc6BWG8Z6awdkx2ADNhYh5/OnvxgaX9HB1+AecTkL4y5DqpkFuRcmHsni
         ROuWGHvRyInGSGb1YyKczJNAkL5WM1am2JP7PKUgM/nf1H46HZUCDpoVZTPu5KqZaVLl
         cHKdbRPjINlT57IgLxbsXPlwR4VFtJNq6UGbAqtxK7ME9MNwBCtT2xEfUMucDOhvIwbd
         lCut7vVh64IPpUd+l+NZH10m0CJnnoYwTCNU5ufthrCa0hkSnfLLzpcKnsxGqenI+qgK
         xhHyvZ75sHCYjw2BcshzBziWjZYyKzx88Jt/iBQFkAp30Rp0M46ERGF6hCbdTW1RH/ST
         wDYA==
X-Gm-Message-State: ABuFfogM/GC8JEpklqqRef+m4MA8+sq0VA6CPhZ4vTwMBqfWOdOLtvSx
        iiVyKQRRBzkETbUcxQ9NlKgGSE4kMKk=
X-Google-Smtp-Source: ACcGV60qsdXK9rO3A9sY2pXzzAk/S0SH0TV+mpPlUa2AYv0/Arbuk5qof6QLcwgxy129G1i2UOIikyd1XsY=
X-Received: by 2002:a62:9c8d:: with SMTP id u13-v6mr2959384pfk.41.1538423113792;
 Mon, 01 Oct 2018 12:45:13 -0700 (PDT)
Date:   Mon,  1 Oct 2018 12:45:01 -0700
In-Reply-To: <20181001194501.58338-1-badhri@google.com>
Message-Id: <20181001194501.58338-3-badhri@google.com>
Mime-Version: 1.0
References: <20181001194501.58338-1-badhri@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 3/3] usb: typec: tcpm: charge current handling for sink
 during hard reset
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

During the initial connect to a non-pd port, sink would hard reset
twice before deeming that the port partner is non-pd. TCPM sets the
the charge path to false during the hard reset. This causes unnecessary
connects/disconnects of charge path and makes port take longer to
charge from the non-pd ports. Avoid this by not setting the charge path
to false unless the partner has already identified to be pd capable.

When partner is a pd port, set the charge path to false in
SNK_HARD_RESET_SINK_OFF. Set the current limits to default value based
of CC pull up and resume the charge path when port enters
SNK_HARD_RESET_SINK_ON.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

--------
Changes in V3:
Rebase on top of usb-next

Changes in V2:
Based on feedback of jackp@codeaurora.org
- vsafe_5v_hard_reset flag from tcpc_config is removed
- Patch only differentiates between pd port partner and non-pd port
partner

V1 version of the patch is here:
https://lkml.org/lkml/2018/9/14/11
---
 drivers/usb/typec/tcpm/tcpm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c3ac0e46106b..c25a69922ee6 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3273,7 +3273,8 @@ static void run_state_machine(struct tcpm_port *port)
 	case SNK_HARD_RESET_SINK_OFF:
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
-		tcpm_set_charge(port, false);
+		if (port->pd_capable)
+			tcpm_set_charge(port, false);
 		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
 			       TYPEC_DEVICE);
 		/*
@@ -3305,6 +3306,12 @@ static void run_state_machine(struct tcpm_port *port)
 		 * Similar, dual-mode ports in source mode should transition
 		 * to PE_SNK_Transition_to_default.
 		 */
+		if (port->pd_capable) {
+			tcpm_set_current_limit(port,
+					       tcpm_get_current_limit(port),
+					       5000);
+			tcpm_set_charge(port, true);
+		}
 		tcpm_set_attached_state(port, true);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
-- 
2.19.0.605.g01d371f741-goog

