Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B679C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1D020675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj8GG7wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfBVWCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:02:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42926 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:02:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so1686608pfi.9;
        Fri, 22 Feb 2019 14:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lIsPkHHzCVLPY04ei/Yux6FtF0E04kMaRTF2O0M8+Ak=;
        b=Kj8GG7wtGVsQ+SdHNHrv3fJhcpeZJZk3uvn0S+MmyQnESLioA0Y6fAldTuWUo+Nl0b
         E3msRvSd8rkyAjocgKJlXlrPoYqVc5/R8/S+R+Q+JpqUpmqAKh4+SlJKukfAhWN7rS70
         6AyoMEgiHdOqv9d5EfnzfzDWnfcw76sOB9yJH75zqCCxVWhUWXkdLOf+bOngAsxpOQO9
         ztZx8QqmFmT1U1SwhHkj+1V0T/lwFMmFDhvyuhy5gV1fXJaFMIN2rCxWnIEHN775HmKt
         7coH7dmmvQKU36V+iMAsm7polQNpCa28hEJctUCnlYocAOOnsLtoSz3yHLNnU1zROvQC
         KgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lIsPkHHzCVLPY04ei/Yux6FtF0E04kMaRTF2O0M8+Ak=;
        b=RRqIOd18FIPrdW7zsjYMSGbwOVIgP4SnirdXbPBi9vAHlQgZGa3yJn9ZpIwIME2FmN
         BloQ91TjgHV30BSk8WtqAxf4/irIK3KwdQxZ695HuaTyRqaYax7om/+xuqzOboWATDW5
         5bihAuMJx8e/ksGhW/+hZXI94r5Y3E1Y3fciGQ4WqOW3eXUozwdyAHzaZChSCdCNrHxC
         7mPVYIE5UEMhp5pm6qskYttKgdCNSYOzpJq8gIulFhcWApoRnmT1T0zqbSl2qZQQ8YhW
         MJOwNB7EO3KKEdTYPvFVDxg+jFyf+awkHJHRI1ROCU2q/pOjlYu5h3sOxbSafeAYI/Gw
         VmOA==
X-Gm-Message-State: AHQUAuYxZPvVnx1ZxtgLVVkHEs1vbgdcd0QDjbbJEmqZ/h2EWNDHcoz/
        fo7Szb2cDb9VtjAhIpQKHZvtIat7
X-Google-Smtp-Source: AHgI3IadXD3C+YpxA+ccflJwJX6ExXlttvn+H/pw2hQT0a11TjL8CX3qHPwItNFC1o92zT1I+ADc8g==
X-Received: by 2002:a65:51ca:: with SMTP id i10mr5843915pgq.371.1550872942449;
        Fri, 22 Feb 2019 14:02:22 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n6sm2906768pgv.86.2019.02.22.14.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:02:21 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list:DPAA2 ETHERNET SWITCH DRIVER),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Subject: [PATCH net] staging: fsl-dpaa2: ethsw: Add missing netdevice check
Date:   Fri, 22 Feb 2019 14:02:14 -0800
Message-Id: <20190222220214.25401-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

port_switchdev_event() does not check that the target network device is
actually backed by the ethsw driver, this could be problematic in a
stacked environment case.

Fixes: 44baaa43d7cc ("staging: fsl-dpaa2/ethsw: Add Freescale DPAA2 Ethernet Switch driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index daabaceeea52..2edd82f5229a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1047,6 +1047,9 @@ static int port_switchdev_event(struct notifier_block *unused,
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
 
+	if (!ethsw_port_dev_check(dev))
+		return NOTIFY_DONE;
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
-- 
2.17.1

