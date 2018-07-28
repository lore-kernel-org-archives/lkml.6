Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA685C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF7820862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QygouOaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF7820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeG1Gr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 02:47:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46745 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeG1Gr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 02:47:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so4344732pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+jUdHgKmDhMvYw9eWVnP3Moz5FAbaIHJlG86mjvcgs=;
        b=QygouOaKzPSm03hNXsgAA9J5Hk5KMcE+n8zeeekDfRMkGtYwsDBqWPQNaNp0Pp7z7T
         hpHHk8LOX3qsSpXTdzyv4F/6wQsm8JKxces6KLOk2trc7heQPtvUTDiBVFpgrKLWMhrT
         DJ5+VkUoBwuPEo1YonKkuxMpGJL/Re5NrdfVzlYbqSTDWCa7sHhWM7mXIEa4x78TrL7D
         +5Ze+D0TI3LupM4nC89mdzTXNHYY2/9VJlHjaLGJfMKxHVUcDZxMQYSFMEqKZN94RyeP
         49kFfv22TYgTYCE1tgNF5alv6pBKraB8Yxe5Cnjoe+EInw4VyHNH2RIxluvZLARvVabl
         AzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+jUdHgKmDhMvYw9eWVnP3Moz5FAbaIHJlG86mjvcgs=;
        b=XZHKiAlSEa8bqVKa5lBSFnGc5I3A2WN/A7gVk8t3l0JQIAp6JynFTeXivrAjXN4h1h
         K2/6+SPTCUWhLiRB+M040LQDdOWUoQDE+8gXPGdFzXC2jc2yM2OS83NoM0JolcF3j47C
         0y2SKbKM/XLSNkdhasvNcpTIABWa6khHQVduDyIt8FtvH+//sxlRmRBbDUwqfAWgfkZy
         Qyl2iSAcMjH36JPEevH3LNm2Xlq/aJBh1KspnpNOKu01X3mx1FmS6DJ5R7yPW5gBTnjg
         C2/jjpdzItQZ1U1SmpVpMkW7hU2/HLq/d+hzfkAp/jJqh1b0veHCqXqCkdMwvLty+B35
         Dt0w==
X-Gm-Message-State: AOUpUlH6Ty7LInFxGJKkSipRiuxcmmgWBF9KLyvmAou2sVDETPB83aDT
        VhGuYsPJUAnMjln4YxAFsmc=
X-Google-Smtp-Source: AAOMgpdiBFvdByucMTdbCfXw4TJ5EMbgv953pbKVJZU3smjC9/rHReEAzRa5F75evrBvrb3I8mEfxg==
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr8464873pge.75.1532755342279;
        Fri, 27 Jul 2018 22:22:22 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id y85-v6sm8837195pfa.170.2018.07.27.22.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 22:22:21 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 2/5] staging: gasket: apex: fixup undefined PCI class
Date:   Fri, 27 Jul 2018 22:21:57 -0700
Message-Id: <20180728052200.228796-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180728052200.228796-1-toddpoynor@gmail.com>
References: <20180728052200.228796-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Apex chips with class 0 (PCI_CLASS_NOT_DEFINED) fixed up to
PCI_CLASS_SYSTEM_OTHER to enable PCI resource assignments.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 73fc2683a834d..ab466d49608a7 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -739,3 +739,10 @@ static ssize_t sysfs_show(
 	gasket_sysfs_put_device_data(device, gasket_dev);
 	return ret;
 }
+
+static void apex_pci_fixup_class(struct pci_dev *pdev)
+{
+	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(APEX_PCI_VENDOR_ID, APEX_PCI_DEVICE_ID,
+			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
-- 
2.18.0.345.g5c9ce644c3-goog

