Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1AECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6042086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw2//KsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6042086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeGUO2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33898 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeGUO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so9080082pgv.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMrz5T2+pyh6QUoBFvF5dt/tuQ53TEyQx+NdnoSXbbE=;
        b=Bw2//KsM3+3w/PPUPzukBIIzFoKqoncEO86vBnywoxIz1C0RneiQ2aWTtAaygGNy7M
         kOHZof9nigkjTU8XiwzvrL/nYy4ZHFqG6xyKXIiNkhzZnTyiBgJIACd9B6EH4fS10BhI
         4rJzzyUSOlRbwfpoCuqLWbzblQpRGqtrkzepPBCA8FFqN9+Bqcm9PVW7j3BPpACVQXSm
         BOQsdHUxjmH6iAbWAXnrDNaDRMh7PzXst4cHpP+aY1MANjnLH66EoHreKXhixYAd42rI
         XqTEIgvcnKPueOzMwapyCNM19wfSIpF5o/bAQQBe52CiiLfEd2jVM6tNc7kOBkQiepX3
         ZtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aMrz5T2+pyh6QUoBFvF5dt/tuQ53TEyQx+NdnoSXbbE=;
        b=WeSrEAHEKPBzT+HgUXMPY1yDPHsFHYM+cU9mUK4RFfS34KKVN2NcEmH3bkKpgDn1I0
         zJz9RmQVVmc6KDONzQMQ61Oj89IOh6z1bvpIAkxUjW72sffu+x/YZNMiC0y9FpMjmdH7
         1+hTc+V9R4tl02MXqOcVPemhtVlFEUboMs14tNTa7amfjuLULZ3bQ5+CH+ub5RSrV6Ep
         mn5IFyc9hla3Snizv6ntcXXnnUUU7Gv9AvuvzpTqqyrrcWdNbln8ZXwwJ32KWANTcEVj
         zvAWoFpbQBpRrbmpN/RaMZF5JISnEFhpHqPJeuRPL5eB+Zs3y65kOAE4aKkOTBxG9nyx
         Cqyw==
X-Gm-Message-State: AOUpUlHwAExFBZQDYktrRWwqUb97CWBtuZ6sa+Gp+EBkij+VJlYfEYNr
        EVN1E9zdAmQJXzGBnZCIfDY=
X-Google-Smtp-Source: AAOMgpdLK1Jk8gMcxStMWcan6pr6kQa/rye9lUA9CXwIo728pdMskOMAJNcUUAWY4cYf3aYKCEe4WQ==
X-Received: by 2002:a63:175b:: with SMTP id 27-v6mr5603755pgx.31.1532180121660;
        Sat, 21 Jul 2018 06:35:21 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:21 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/14] staging: gasket: remove duplicate call to retrieve device callback
Date:   Sat, 21 Jul 2018 06:34:55 -0700
Message-Id: <20180721133507.95599-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_handle_ioctl() calls gasket_get_ioctl_permissions_cb() twice;
simplify the code and avoid duplicated work by fetching the callback
pointer only once.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 2e2c9b997093b..dbe9fdef0c268 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -55,14 +55,15 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 {
 	struct gasket_dev *gasket_dev;
 	unsigned long arg = (unsigned long)argp;
+	gasket_ioctl_permissions_cb_t ioctl_permissions_cb;
 	int retval;
 
 	gasket_dev = (struct gasket_dev *)filp->private_data;
 	trace_gasket_ioctl_entry(gasket_dev->dev_info.name, cmd);
 
-	if (gasket_get_ioctl_permissions_cb(gasket_dev)) {
-		retval = gasket_get_ioctl_permissions_cb(gasket_dev)(
-			filp, cmd, argp);
+	ioctl_permissions_cb = gasket_get_ioctl_permissions_cb(gasket_dev);
+	if (ioctl_permissions_cb) {
+		retval = ioctl_permissions_cb(filp, cmd, argp);
 		if (retval < 0) {
 			trace_gasket_ioctl_exit(-EPERM);
 			return retval;
-- 
2.18.0.233.g985f88cf7e-goog

