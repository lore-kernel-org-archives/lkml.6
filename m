Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D380C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C0320894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLsxkh/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C0320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbeGaWH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeGaWH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so9632093pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIGUlgY1QFpupKOy+F9cvhUF9oklolNddg9XoLGYG5E=;
        b=MLsxkh/P7x4+4FvwSipMyUrKoindhk9JRLUNKiyx1BftISdhiIMUYM5y9zKYdMp7e0
         kPt6m5RcPh2R6X3fecJGTGYgFmiAljkMkNeWGfN1HqK2k3cfRPWLhQapiG4k2NqNSJs2
         M++6tfZ26ciY0VuIgL64NzunfA1GDsKJA4t1hnwkJyYb62nK1Xfc0btLV9MBHv4WuS8d
         RSFtUouGYWiuMuRClD4R2oxEwZTqXOgj+AuxJvJZzMe2whVlcO6DkZSvNbfHqI5ubJlE
         KE2ETvtLRG6CLPn6Ruti4wVX/lU7J6QFe/U5W8wj6vooBE6tRYHJE3d7bkG9zLhnT1ZZ
         5L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIGUlgY1QFpupKOy+F9cvhUF9oklolNddg9XoLGYG5E=;
        b=l8HKehOnbzikB1wR/LdPbHeV1BsyDE7TM6TY5mSSxMNuz5Dl1apfvXyuRmSklapXVj
         qO9OOAESUIFx0Cwl0LpxvNh/f/m558p1MS1b9Mpww7DOjXEFeCzupFpOGVRjyEnf/mA9
         UxXN7Gk3c6V26pO6yYZwZNGq63ohdYwPftyZPvSrVv92xC0l/Sgr0Ja3aFldWoGhdOWF
         ujHsMPVjFa8iD/vAZt2ptSzNwmD+zbHOzmZPNEiSNdJzwMBJVl0QM6lUUbbVI30g/Qp0
         Vfg3U/zocdlXrh2X7fVT/8+GitBslAdBSUfFhQcsV67gmauBXd/L/t4qB6eEr70uRFUn
         SRyQ==
X-Gm-Message-State: AOUpUlEpvg1emzO79enDBg9wR/7rOcz2smTH1Vz/EGWs5EEB1JEf0FGz
        rsjr2C4l3/jrm5L2QhW2elc=
X-Google-Smtp-Source: AAOMgpeKeYvin5rr4jxJGoEj5VChjYBWJiF8khy2UeiMaV/oIYR7WLmke7IVzV3SxIppdCsagtTFAQ==
X-Received: by 2002:a63:460d:: with SMTP id t13-v6mr21607272pga.201.1533068724726;
        Tue, 31 Jul 2018 13:25:24 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:24 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 13/15] staging: gasket: core: use bool type for ns_capable result
Date:   Tue, 31 Jul 2018 13:24:46 -0700
Message-Id: <20180731202448.229487-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731202448.229487-1-toddpoynor@gmail.com>
References: <20180731202448.229487-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

When gasket core was converted from using capable() to use ns_capable()
instead, the type of the variable holding the result should have been
converted from int to bool.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 44344528cd88..f76f4a0ecbac 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1191,7 +1191,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	struct gasket_cdev_info *dev_info =
 	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
-	int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
+	bool is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
 
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
@@ -1270,7 +1270,7 @@ static int gasket_release(struct inode *inode, struct file *file)
 	struct gasket_cdev_info *dev_info =
 		container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
-	int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
+	bool is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
 
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
-- 
2.18.0.345.g5c9ce644c3-goog

