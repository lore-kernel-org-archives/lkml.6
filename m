Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E5CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2AC20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hOM6r+zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeLZCCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:02:25 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57386 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLZCCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:02:24 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 21747B08
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Civ54mQNXk2C for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:02:23 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id E3105AD3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:02:22 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id v8so17811398ioh.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Xq1HBvnjFfNJNnWuxVn5ROpEAKyNRiGk+MUo14uJR8Y=;
        b=hOM6r+zxfYU/iuopS/1y9fR3NtHNxR8jw7w2S5C680fzJpXi0ItFBRCT5Rja4E5EO3
         PjsR8U+BlRV2b2IazgvUakttDKH9prjn25iBNV5RzkETBWe8AYe3MP4/S83S1ZKMojOJ
         udbWYC3zD8Xsq9rlhPvPIYqrJSJyxRlEyOvRxWs5Cbkl8FNNlufH5hVg30FBmzwV98cA
         Ri0z64yQpo94jIgQ+3OISsJjINv7IbxeLIQ3/5888oncoL8Wl0v6iZycNCg9Enw2fuYN
         UfyRpp/MsMEyAl5kP0zNSkuAU1GF75R/rFevZzPysFxRVuy1H4JCwxqqjdVTi8sQE5Su
         udkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xq1HBvnjFfNJNnWuxVn5ROpEAKyNRiGk+MUo14uJR8Y=;
        b=W2o1lja1oWbZyNZeDEWXeJoM6GkKtRBTjueqs0+UCsbR+HBsRXIUwOcoHAm58ggl6p
         fwR01ef3b7SCTq0LCNybhtkctG+cO4nLmg7HsLs0THKWDPJdBuISD52G+gOhCph2sdcs
         PnZIs/awTIvSO1b72h3p4UB4Y+Z3OgL40HKc6kOwnza+ufGKYvq8mU1HJHONe9PeC2aq
         gtilKxZN43+y7sO90rKDFzwe8vOGE+jah3NOM/LnEQb458iqfVKFUA0m4gzf/42pBDvX
         oHCi4jhBl+th0CsXsuIuDBvZjb2ASd4+182aV4HPdOfXQMHRZXwVvT8ntkDLsqyMpDBv
         EnIQ==
X-Gm-Message-State: AA+aEWaGC8a0PjivJLl+kb4AU+lPeLDsttUCT/cOc9zqFCmWX9dX9xRP
        uBpcA7y0U0lKV2kYPchh7141JJ9256DcR1rt0RsfYW3yyUNioKu8TAiodcryVRGbrlSC38mjEn/
        aHt1TUZVfDHswarHe5lNWf5ZKV92e
X-Received: by 2002:a24:458c:: with SMTP id c12mr11568999itd.27.1545789742140;
        Tue, 25 Dec 2018 18:02:22 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6ya1K9/5xUS9pmmnfiH2yYHpdKeFYDhfZHwOkl6UmZpboMtWY3TO+w/6LLC4HAmQ3FjCxbIw==
X-Received: by 2002:a24:458c:: with SMTP id c12mr11568995itd.27.1545789741892;
        Tue, 25 Dec 2018 18:02:21 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id l11sm15744186iob.24.2018.12.25.18.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:02:20 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: chipidea: add a check for the availability of next child
Date:   Tue, 25 Dec 2018 20:01:34 -0600
Message-Id: <20181226020134.71351-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_next_available_child returns NULL when no child nodes are found.
The fix checks its return value instead of assuming a child is found.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 880009987460..7dc987b4036a 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -250,6 +250,8 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	ulpi_node = of_get_child_by_name(pdev->dev.of_node, "ulpi");
 	if (ulpi_node) {
 		phy_node = of_get_next_available_child(ulpi_node, NULL);
+		if (!phy_node)
+			dev_err(&pdev->dev, "no child nodes found\n");
 		ci->hsic = of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
 		of_node_put(phy_node);
 	}
-- 
2.17.2 (Apple Git-113)

