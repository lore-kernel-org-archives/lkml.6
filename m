Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED112C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9E0214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCQLr7Pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9E0214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeLFDCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:02:36 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:42117 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbeLFDCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:02:35 -0500
Received: by mail-it1-f202.google.com with SMTP id g7so18798065itg.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tgeoai6qROX/FycIiL2qS00+BtuAbpq6RoiZsk3K9oU=;
        b=YCQLr7PqopA8tHRGeAQutUuoq6u8FT+YsKGe2SnaTG7CVWtKPD3behiT4zOmPlH0Hb
         UA8lxYK/A8dR5ALbYlVp/n+2/VtwQdte43IXtB+rg5q9ywVMogDxqj21TJWCrC46mEQj
         zyW8qPdN4DFJCG47vyKfLf4Ms4OY2e/ByeqMXjYp18Fpgz/xEErqL+dUOKL5npl64eoN
         Xpk3hEVxj+5biE06YPi+kkW4IJ/OE7gfXl734pd21Oz0vpTOqw7DuMTVBLtO55Kf/55S
         nO+DUunRGWy47W01sO8VZlcSOt9sxdIVQeoff2Yec8MlOGAUw4vRLsx7P5vLvmuUT1In
         uK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tgeoai6qROX/FycIiL2qS00+BtuAbpq6RoiZsk3K9oU=;
        b=bHFL2rD5WEeACNlIf9yv9rRiUPoGpeBYO8TcxZiIBVyQ4cOuiktA2ti432sO1dEwJl
         LZyJ6WgVA4CJPHR6nBa5rseuqp4Bo4wA0jsPR9ifTwFErHvDaPX3+vwrA3NTGN6+//ld
         2M0l9wdq6n7FnxOy77aQ/BRQDAANeKGVql+mfDbhy/ndLCqucnWjEXzlqbNtjTN3DxzY
         fe04i0zQJB/VbBfygY9bz+85h75UeiT/KIpE87iFKd+bK+8BMUAaWFT9waR9aFFUt9wp
         Ythc7lVnVN8wG2ZmyChqKisVm3B2sHEaglWTgA/hD1O7raTzPO8DqO1NtFw18QwOBWtt
         BtZw==
X-Gm-Message-State: AA+aEWZE1OthyH0HiDVdqBhhyXqAeZmiP5/j3+S2pQ/rCnis9FMlhAOb
        kNJMEkvzVtgKTUwfO7ZYKJvjd1UNEQ3e
X-Google-Smtp-Source: AFSGD/Ww592CVXXfU+pAo96L+/WmomUZ80os/hvomtYHsLrhIYP8ZwtGp3yYlp44Ocjd3WrsXgG+HiEDe+dJ
X-Received: by 2002:a24:134b:: with SMTP id 72mr14549680itz.15.1544065354711;
 Wed, 05 Dec 2018 19:02:34 -0800 (PST)
Date:   Thu,  6 Dec 2018 11:02:27 +0800
Message-Id: <20181206030227.9507-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO selection
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current matching rules ensure that the voltage range of selected Source
Capability is entirely within the range defined in one of the Sink
Capabilities. This is reasonable but not practical because Sink may not
support wide range of voltage when sinking power while Source could
advertise its capabilities in raletively wider range. For example, a
Source PDO advertising 3.3V-11V@3A (9V Prog of Fixed Nominal Voltage)
will not be selected if the Sink requires 5V-12V@3A PPS power. However,
the Sink could work well if the requested voltage range in RDOs is
5V-11V@3A.

To improve the usability, change the matching rules to what listed
below:
a. The Source PDO is selectable if any portion of the voltage range
   overlaps one of the Sink PDO's voltage range.
b. The maximum operational voltage will be the lower one between the
   selected Source PDO and the matching Sink PDO.
c. The maximum power will be the maximum operational voltage times the
   maximum current defined in the selected Source PDO
d. Select the Source PDO with the highest maximum power

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3620efee2688..3001df7bd602 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2213,7 +2213,8 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 	unsigned int i, j, max_mw = 0, max_mv = 0;
 	unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
 	unsigned int min_snk_mv, max_snk_mv;
-	u32 pdo;
+	unsigned int max_op_mv;
+	u32 pdo, src, snk;
 	unsigned int src_pdo = 0, snk_pdo = 0;
 
 	/*
@@ -2263,16 +2264,18 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 					continue;
 				}
 
-				if (max_src_mv <= max_snk_mv &&
-				    min_src_mv >= min_snk_mv) {
+				if (min_src_mv <= max_snk_mv &&
+				    max_src_mv >= min_snk_mv) {
+					max_op_mv = min(max_src_mv, max_snk_mv);
+					src_mw = (max_op_mv * src_ma) / 1000;
 					/* Prefer higher voltages if available */
 					if ((src_mw == max_mw &&
-					     min_src_mv > max_mv) ||
+					     max_op_mv > max_mv) ||
 					    src_mw > max_mw) {
 						src_pdo = i;
 						snk_pdo = j;
 						max_mw = src_mw;
-						max_mv = max_src_mv;
+						max_mv = max_op_mv;
 					}
 				}
 			}
@@ -2285,14 +2288,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 	}
 
 	if (src_pdo) {
-		pdo = port->source_caps[src_pdo];
-
-		port->pps_data.min_volt = pdo_pps_apdo_min_voltage(pdo);
-		port->pps_data.max_volt = pdo_pps_apdo_max_voltage(pdo);
-		port->pps_data.max_curr =
-			min_pps_apdo_current(pdo, port->snk_pdo[snk_pdo]);
+		src = port->source_caps[src_pdo];
+		snk = port->snk_pdo[snk_pdo];
+
+		port->pps_data.min_volt = max(pdo_pps_apdo_min_voltage(src),
+					      pdo_pps_apdo_min_voltage(snk));
+		port->pps_data.max_volt = min(pdo_pps_apdo_max_voltage(src),
+					      pdo_pps_apdo_max_voltage(snk));
+		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
 		port->pps_data.out_volt =
-			min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
+			min(port->pps_data.max_volt, port->pps_data.out_volt);
 		port->pps_data.op_curr =
 			min(port->pps_data.max_curr, port->pps_data.op_curr);
 	}
-- 
2.20.0.rc2.403.gdbc3b29805-goog

