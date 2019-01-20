Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F67C7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F333B2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgDwbkR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfATQ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:56:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42887 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfATQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:56:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so8334851pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 08:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8EZNNg+VNHHRpR48k+zuw9g6APnhSIOQmgbsxZrYUKI=;
        b=lgDwbkR/aV+0vQPdwDyC9Pkpe4GNOnQCFF6GKbbIfANXVV2SEWLSl8zQGKl1seLlBT
         Ju62ALzE3BC1abyLD55Ncm5Mu96VpgsxoCnGtUagcBCTlcl57Z6cLj8GRJRINoqyLJCO
         e+usjHBxN/3Jg1WYwu75Rgb6hqR5O4FXXaIFeVDjqCunFJnmwt8OEGcsc8N7cy3IfoGL
         8kCOyhV+QewblFrp89Ww0RUbWTt+9Fy6JRmt47YnXHE3sQn+B34M1U0JlI7kq4X9ksyT
         JHJHvUbe1rO/n+4rwZy2yItn5YFZnGLIXHAhzN+qWDvpbku3cr8ncpO4W28HwbW79stQ
         fCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8EZNNg+VNHHRpR48k+zuw9g6APnhSIOQmgbsxZrYUKI=;
        b=hmcYNIaHYGC/bfmt69tfuXtb3TXC/CQJWL7hqecAbIZXZVV1qasb/tgHd+7Zl9pNB3
         iu2j/Z3f7bQz9WQCr/KHfagMhBZ+afEqBYCfea3C3tl9MIzmI8rZgNBLZ6rGybPZQr67
         gjtrAWcJTzAZaR/HPJqG2rOSnqQ5h4QR/NyvYBPOY4rTwTqv/FtQK76H7dCFocbxyvvG
         ZP6wKcA2t9bOWOumTm+rkNGgmn7mf/nQhumPcZfNH82486WOHpivrl3IvHNMcxWssbaU
         pTd+TQRqg+6jILYk6UpClYIgIaQw90zpIh3i7k9M3becDrW2vl4+kAwcwIh9B9ZMSapy
         lCzQ==
X-Gm-Message-State: AJcUuke3v4Rz0MUh1jtksP74k3GAdSuyXECXfKQ5vNR0ivSGNqw2fA8g
        2ZcNaGHyGz1pfYgPr7NpJBDQ0zTDmk8=
X-Google-Smtp-Source: ALg8bN7s3HZzY8nY1Ql7T+O7SInJLThRp3yS4bUG4SWlJV6f13tzK/cZ3kBdRbCI9vaYWQUg6vyE/A==
X-Received: by 2002:a62:37c3:: with SMTP id e186mr27352557pfa.251.1548003378527;
        Sun, 20 Jan 2019 08:56:18 -0800 (PST)
Received: from bhar12345-VirtualBox ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id u137sm19375935pfc.140.2019.01.20.08.56.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Jan 2019 08:56:18 -0800 (PST)
Date:   Sun, 20 Jan 2019 22:26:13 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: replace ---help--- with help in Kconfig
Message-ID: <20190120165613.GA23274@bhar.linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: prefer 'help' over '---help---' for new help texts

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/wlan-ng/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/Kconfig b/drivers/staging/wlan-ng/Kconfig
index 426d4ef..9723801 100644
--- a/drivers/staging/wlan-ng/Kconfig
+++ b/drivers/staging/wlan-ng/Kconfig
@@ -4,7 +4,7 @@ config PRISM2_USB
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	default n
-	---help---
+	help
 	  This is the wlan-ng prism 2.5/3 USB driver for a wide range of
 	  old USB wireless devices.
 
-- 
2.7.4

