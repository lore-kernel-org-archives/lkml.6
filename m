Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75300C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170A120841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUvBTc/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170A120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeIAMOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:14:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33907 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeIAMOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:14:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so6451656pgv.1;
        Sat, 01 Sep 2018 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UjSByF2RvQQrN4ksixjx+//iApigN4/jp3Md/nZ2+Ds=;
        b=RUvBTc/yXxxUbsBykj5KpSiGXIURQn7pVyl49KDzzaKMtpO4AgmUCj+oboOlH4m8GX
         CpURVGasldb4/1glC4eHxzXV1lTiWQf/32UGBBS1/3CSAzNqDenqMw/M7ki5VPQEgXTq
         vYy94s61nH78qYu5VxkPU4xFAJBhsG3cakskER7Wa4Xk9yFGKC1SORyLd0M2s+PRfxZf
         3F6Z91y/paTJDajkIZFwhhy2JVbUs/Iauv4xcT+U5byRTLW3WfjLSfjBccOemjl9HeeO
         2AV7ey6f1WnYDZqYO9jJ9MB+V7JyJrbCwjEjO5P463KbvEOT45sLCR2T8wwskl1fWrXB
         pOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UjSByF2RvQQrN4ksixjx+//iApigN4/jp3Md/nZ2+Ds=;
        b=L/hgyfNaeXQEo1qzEIp3bk1TCuKhK7c/j3g1tlIUVzqg8WGgYjrOxj/cTdSnmrgWqP
         PYrgWsr6aW0METGqhiPuj1td68VCJMKl4jWEYo7CtefZGK5hosdIPC6lPROKSs1r+18Q
         +uO8VXkgKZpcVcIRvZau49OXGanKYoq8rQrjMIoFAW8SIzkTVmU6Ask2J1HOuP+MZ2F8
         ApW80GjHdE3FOK0rJofOASc8cdaVPZIkmJHTGycRvealCZaD8KHXktINBeqALIUWEsle
         KcZny0waL+8OFT/wIHyyrPACb19JzHW5Gu2ujjfaLxzVuWfdEgI8TqZq9yTUQ0OlcFPv
         eMHg==
X-Gm-Message-State: APzg51BTy5BpDseyxyxXq8hawfBFmTPqXBfCQ+ZuFxM5qH46l36QfTBt
        +Ee7tsjAU3n9WhqalAyD7CQ=
X-Google-Smtp-Source: ANB0VdYS1mL10VRic0VrkiBQBOHcNM+c5Dh7EqxGF++7qRjTH08HZLIrkce9P4N0cP5+NbkBsfvm7w==
X-Received: by 2002:a63:291:: with SMTP id 139-v6mr17256791pgc.365.1535789022516;
        Sat, 01 Sep 2018 01:03:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4130:91db:5d72:621b])
        by smtp.gmail.com with ESMTPSA id c1-v6sm15696789pfi.142.2018.09.01.01.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 01:03:42 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org, mark.rutland@arm.com,
        bjorn@mork.no, viro@zeniv.linux.org.uk
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()
Date:   Sat,  1 Sep 2018 16:03:34 +0800
Message-Id: <20180901080334.15913-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wdm_in_callback() is a completion handler function for the USB driver.
So it should not sleep.

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index a0d284ef3f40..632a2bfabc08 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -458,7 +458,7 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
 
 	set_bit(WDM_RESPONDING, &desc->flags);
 	spin_unlock_irq(&desc->iuspin);
-	rv = usb_submit_urb(desc->response, GFP_KERNEL);
+	rv = usb_submit_urb(desc->response, GFP_ATOMIC);
 	spin_lock_irq(&desc->iuspin);
 	if (rv) {
 		dev_err(&desc->intf->dev,
-- 
2.17.0

