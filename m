Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3EFECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD1020856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnkS5ef5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD1020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeGUNuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39409 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeGUNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so9026563pgs.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMrz5T2+pyh6QUoBFvF5dt/tuQ53TEyQx+NdnoSXbbE=;
        b=GnkS5ef5c42FHlDqD39MBSx1MX+WPq6iN8UIjXJDWuoP/EnLfwSgKTUDwDKOmzMmfy
         Nn43o8SD5cgze6hkoW+NxapxVp1OC6eslMwvr/q+spMWPRR8gO3KIAwWvtq+9VYBFUL+
         DQa59IujRr5OVbHCLaGHEHvx1jGHvbdM74fZGI0/M3UAayHmvYvJbos68pWyfB6/ff5v
         dOEmLmwDEa02W7v66ajMZgigWniJsAeDt3fK7hm+ALcBeyEMXuEawAy9ZSGUi3DUruR2
         Df3+1LRt9kDfL418FV0DePI+NAMqE8ofDE5RXG2+OngrrjysOI8B3uU7svYhNAFEnPXa
         K/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aMrz5T2+pyh6QUoBFvF5dt/tuQ53TEyQx+NdnoSXbbE=;
        b=Vzao9kxBxwViClceZGvsDEpBUNiInvG6PWhsCPdG362Sl63Q7obN+jXSWPQqn2+zYK
         /A4O6UHNAU7DEcmRSlCbXBMp7JU7l6iVdG+aH9uYmO7CXxCF+JoI8P2i9NbN3Txkt+PT
         qRQ6bXMG0vY0lWoozbkPDaAZhAGKS0SKhY45wGx/YO+0vwq6RZnYPUfWhaK5uraFEzOs
         0syXFNloZ7DrKHVjUaqTPpDZGyt7SXDP8NQLPLpXkJOdt+RizuxX4GdtRNDkcA92yv6c
         ++soPzI9Z+lNnWkvYVM0h1QqDhX8+sa2Mg6kXVOl2Xlhawr5Yy0Eob6YkIy/Rn+MVkUZ
         7Y0w==
X-Gm-Message-State: AOUpUlFJZKqXS6U0FrYh5pKVYLLucO9y03+EqkrnwpGYwGMl2Hw2S37E
        2QG9xZaDw6HE3Y+tzZVl/jc=
X-Google-Smtp-Source: AAOMgpeAn2ui5GIsLkaUEdLvZwdrNyOJhiCV08CLUskZhYyRJHxc0pfsAEF4WT7DyLZijKMyeBMziQ==
X-Received: by 2002:a63:1e08:: with SMTP id e8-v6mr5504715pge.281.1532177856760;
        Sat, 21 Jul 2018 05:57:36 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:36 -0700 (PDT)
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
Date:   Sat, 21 Jul 2018 05:56:43 -0700
Message-Id: <20180721125713.88501-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
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

