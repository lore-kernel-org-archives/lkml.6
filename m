Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 48AAAC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C4C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL+0ZukT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C4C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeFLEtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:49:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36878 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbeFLEte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:49:34 -0400
Received: by mail-pf0-f196.google.com with SMTP id y5-v6so10518609pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 21:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ABut3WyfB32XXgI2ts3QVbAXkB45WYkftyc0MYpM7JQ=;
        b=tL+0ZukT00pT9P3iPYUlqyz/WPNmfYloJlr3r8Y2cRF+x2I8VKmcn9fhW3nKUuo+0j
         cDml2WbtZ26yPGSr+oHUnyHT4MxewOr3JhrucQ/dMQ/sCE48XZ6ezHdZuD7mbg783LV7
         amGY1FbxBMb5gtSlmQFGP7pyLWIS3IjAVo5ilQ2UDTaTV+6CUBZT4RRk6V+Wl1QxcCAr
         0IVV4uj9VBdFM1+yMaaEu5bRa3sIYAWG2e+DW3HCv8eVSGns6pEqbS9Gez1k8hPM1QMI
         yY4RzregMdcnjheafS1QHuzHYT4Iyh0RbniwbkAQOC7TYJWdfWkgae2Xyxbl7Vx2AP+7
         vJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ABut3WyfB32XXgI2ts3QVbAXkB45WYkftyc0MYpM7JQ=;
        b=Mj/ieCc2DFfrPlq4G2O+RaOhJNsCMce99NbI2vAjJsq3wuSC08A4c972IWfb63LzUA
         /6rK5CvPL+zTA1OGqilb+41oDw/PH7alg4G+F0CjNdxZhcVWaBrvVDnaPfDIlWk142jx
         uryLhFod7Zw0tDBwU6jBcMTOMPGf5uaXR9h6zlxuxbaR8Uo/rK4yfhLOhgLJtL8RZI7J
         vc/MCu5BCTMGrDVxwrTU+da3mpJQozc9ek5u2zoeeYOcUDJTKjOqvDwZxsFvQDd3TGY2
         z35bDeYSrrssb5lIDXV6BTK6GG/VV5oVc2Js0/U07jts3ZUub7HXb50vyyBQHWH7+AHM
         Onng==
X-Gm-Message-State: APt69E1IiBxzzEaBC9G+E4ZDvNtmbZXZ9JOEzo3WbZpT1lNukRecNw5d
        DHWSStlzX1s9aRsS34AeRXU=
X-Google-Smtp-Source: ADUXVKIFlpelSqC+64dR66ikUi0LQwpAi5MFpNwffe18NLnNXB1zCnN6XV/NIGCw9Q8G9JYC7G8lAw==
X-Received: by 2002:a62:494f:: with SMTP id w76-v6mr2160069pfa.152.1528778974117;
        Mon, 11 Jun 2018 21:49:34 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id r79-v6sm82087904pfe.115.2018.06.11.21.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:49:33 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neilb@suse.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: lustre: add error handling for try_module_get
Date:   Tue, 12 Jun 2018 12:49:26 +0800
Message-Id: <1528778968-42225-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When try_module_get fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling try_module_get.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
index 7086678..72a42bd 100644
--- a/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
+++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
@@ -2422,7 +2422,10 @@ ksocknal_base_startup(void)
 
 	/* flag lists/ptrs/locks initialised */
 	ksocknal_data.ksnd_init = SOCKNAL_INIT_DATA;
-	try_module_get(THIS_MODULE);
+	if (!try_module_get(THIS_MODULE)) {
+		CERROR("%s: cannot get module\n", __func__);
+		goto failed;
+	}
 
 	ksocknal_data.ksnd_sched_info = cfs_percpt_alloc(lnet_cpt_table(),
 							 sizeof(*info));
-- 
2.7.4

