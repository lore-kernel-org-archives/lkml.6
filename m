Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5A3C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE7F206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sE+oeyJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE7F206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeI2GNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:13:30 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49915 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeI2GN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:13:29 -0400
Received: by mail-pf1-f201.google.com with SMTP id a4-v6so8946624pfi.16
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bkui6iSebkHx1Pu/R15EYWWA4zHQ+9B38oYC3sD//6o=;
        b=sE+oeyJY30ic3FHYY+smQoR4/jYzJ2E91PND7YCl1IM8oyvJ4+dt555MSulAOaCSCQ
         Vpzel0v4GlyCyaaF5iRF18oJjU5VKq1Le5GuocdGXzZB4IWmgvn9JG3pzfRjHT5ElM5u
         vU+LSVOGdk/fwrDFd7YshAvq68QMH1+h2KFySeIgLoQrwsd6qo7S9Y0FPS1z3ij0u7iK
         e31bXTezWAaUdDo6r1f1+gaIlYT/SLskoNXzcq/alL8+tFP5yYkceiGjHVAtlNSJCgnU
         i8YBf9cpDeHT+RsHBTCDY17WfFy4oGs+chVfFYjnTWCVrRRJRwKuVVN5lgyA1Pfb5mgv
         Wsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bkui6iSebkHx1Pu/R15EYWWA4zHQ+9B38oYC3sD//6o=;
        b=EIMVJ9dyPg+C1LKXdu7SVPr74FKDuGvLn40A0V/bEFvuylT+agl1RKcT7AnDP3ClAB
         kfwfW/ESZ2XaZ/LwcqoflB0NM19SjoCR7930MJWnaDO58rZ/hs2oXij3+AhoT1Sj2+BJ
         Lyp8P+9Te7rxxdS/Oeh4fkuKasEFhakMWRV95tABopIm79Fa3pP8jA205rnZSDrfWa+z
         S+ILMXD+r8kbvn6Khs7E6eO2l71NaxLnu52AokC2f2MA8ax+Ga1l3ZkbbrKlSx5hgSog
         gL57bKst7l/n8BL0iYnGEcqM/Mme7UDxzqQKqAz82E196HoSq6BKFy/fg6IZdTLK7+hr
         1Vmg==
X-Gm-Message-State: ABuFfoiLGNiyIHqANvDAg1BmG6R38hAXT6fud2JJvOjOlQ1p1vmfkCVY
        UTF3ZFh3OFjD/DzWgX9ILINUcZPV/8w=
X-Google-Smtp-Source: ACcGV63VsFcMFj6qWgBSoJ8TfgCgV94sjrDU4D70rZl0WZ5qlmMR6GHI5OABlcJmgjaFuvRvjEB2V+fKOqQ=
X-Received: by 2002:a65:60cc:: with SMTP id r12-v6mr794209pgv.78.1538178443346;
 Fri, 28 Sep 2018 16:47:23 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:47:03 -0700
In-Reply-To: <20180928234703.15970-1-badhri@google.com>
Message-Id: <20180928234703.15970-3-badhri@google.com>
Mime-Version: 1.0
References: <20180928234703.15970-1-badhri@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 3/3] [PATCH v2 3/3] usb: typec: tcpm: charge current handling
 for sink during hard reset
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
Changes in V2:
Based on feedback of jackp@codeaurora.org
- vsafe_5v_hard_reset flag from tcpc_config is removed
- Patch only differentiates between pd port partner and non-pd port
partner

V1 version of the patch is here:
https://lkml.org/lkml/2018/9/14/11
---
 drivers/usb/typec/tcpm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index c3ac0e46106b4..c25a69922ee6a 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
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

