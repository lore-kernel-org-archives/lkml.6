Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DC6C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8D720868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jat6r0tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfAEP66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 10:58:58 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:43002 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfAEP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 10:58:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id A0FFA937
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 15:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XBK-b5AVKHMa for <linux-kernel@vger.kernel.org>;
        Sat,  5 Jan 2019 09:58:56 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 79FDA9F0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 09:58:56 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id h7so44895564iof.19
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 07:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X7enExX/vzh0gYwePm77rKq+5Vt7Z3N+wAAXZCYHOnU=;
        b=jat6r0tZHwwhLCNVLS8I4sZ1pC0EfUzLjGD6TnDCJWtXZweG3DAi5upZGotcfDh6z7
         +C5A9xEM8lCiSLTtgLFqMZ1gVaxyt6l8pH55KQfJSsEHjW1HqmsqAagTj4nSzr8rRL0C
         8ILmtgftVs7ziNWMK7OrZsbHPDgscRZYOV6Xov+b/JGUxuHsoQ0EiuHENTeIOVywFhAE
         D4PqJ6oDm07fbFnPu1IwxptTIh+z3FjxcpLDxAEi8nUnK9gxCySDPjxpNYBdWafO7nLK
         GE9whJWJZnXE0p/69qgN/yWkop8H4Vj4mvoTEYDzWfGvPsCMSKf8NKYmitk7IEqC2lHP
         Vs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X7enExX/vzh0gYwePm77rKq+5Vt7Z3N+wAAXZCYHOnU=;
        b=aZzP6+2z1PVDoVs2YO9pP7HC1GQxEXj139WJQS9dQ63LKG++uiN+GKS7RcVZdXRGDv
         HPXOVn+dFvXwaHcE7N6o+Vx5w5bkBPvRR17T+WnTgNqo+u3yz68OKwApUwH2lQPxvQZC
         N9Mgcstyc8qUj+oOZumNgEqdkGWIR3XLBpMK56zO0OF3sPappzfR6DFBv9g7YAfK+mW5
         seGmRjzxlXmxEJYPwbHRTSJSMLF9Ke2WxNoVBeVPJXfCp81PnsICgz2nd1tzX1Wn9Qy+
         vMRbC2lo/vRtJTXHfv3d6yVRNh9neJGSmYjEyMlSjYIc8wd+83lZgAcMrDaGczNWLkUG
         GcOw==
X-Gm-Message-State: AJcUukeGoZe/cjF7Bgy/szzZ7kieH/XtCzohcM6yylnhn4ZvPICsQBMC
        z95YbGls/G3hY2mglVC7uEudSRcEDarQCZzbqIjf2YvNL9Sr3KC/Gu/4nD5J1tfEx56JJUZt3Gi
        FhzKStC7UZyj42NtFQZNpSgmwvcgp
X-Received: by 2002:a6b:39c6:: with SMTP id g189mr36392759ioa.255.1546703936035;
        Sat, 05 Jan 2019 07:58:56 -0800 (PST)
X-Google-Smtp-Source: ALg8bN55JOBb96GTCq/t/ov+xBcGR7rJB+6h1A++IOwdRoo9lv8K24ehQTdmr2itqN5hOSuJZ3/dXA==
X-Received: by 2002:a6b:39c6:: with SMTP id g189mr36392750ioa.255.1546703935797;
        Sat, 05 Jan 2019 07:58:55 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id v189sm1991550itb.42.2019.01.05.07.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 07:58:55 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [V2] usb: chipidea: add a check for the availability of next child
Date:   Sat,  5 Jan 2019 09:58:47 -0600
Message-Id: <20190105155847.3091-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_next_available_child returns NULL when no child nodes are found.
The fix checks its return value instead of assuming a child is found.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 880009987460..813673eee815 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -250,6 +250,10 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	ulpi_node = of_get_child_by_name(pdev->dev.of_node, "ulpi");
 	if (ulpi_node) {
 		phy_node = of_get_next_available_child(ulpi_node, NULL);
+		if (!phy_node) {
+			ret = -EINVAL;
+			goto err_mux;
+		}
 		ci->hsic = of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
 		of_node_put(phy_node);
 	}
-- 
2.17.1

