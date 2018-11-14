Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8350FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434A322419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPdUUa5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434A322419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeKOF4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:56:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40276 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeKOF4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:56:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so15189459lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=2i/cvADGYocfL81BkmfaGmckzFboR8oiOqfGNWB2BEU=;
        b=hPdUUa5a6658NO/0Z9O4guxOuO8sGX/hi3uSF+31V3Yd5tGPvcw0wbvyiuq9lYyop4
         e2s4dQtaKn04Q0du+HqJviD7AzMAgXSWNwUYWQfKO/awWvC/UhBfIeRh3kAuiZhR9YmU
         IznQRFkZVOlZJI1lja/1LRooMCmL3Sl275NXtIr0QBJpiAb8dixZWNpgou022oKiKyeo
         i/SqVN8VXeIS1dU4tFlqn2XYDWdqVHk4SmWTGFLguJk7ek5WGNuqx8tDYSlGwXmj/uU/
         0yHTP8//mtoUbLhEtjKgQBLOIMMzGibqxbzGFkUZdOcvAuhD5wYaa4DW8qdx1irjnkfz
         xnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=2i/cvADGYocfL81BkmfaGmckzFboR8oiOqfGNWB2BEU=;
        b=FZPlEVW7KhUHnU90OQMzoPDGqC64YXKQ3EzcAskbHTY1pSSJUGtCwLYoOAWqPh3ddN
         7dUInGx6/9CzvmTRSw3DDksqeiBul9krGhySX773e9dYwLoykyDK+Qhr2UFrHVnYQnyZ
         VXL5rVVDYLsBpceCJDjTmz5tVTBqss9rFuBkr8dtb5uT8uWd4xzo70YT1NqGMIt/BfT7
         jbye4Ds1mmie6GYE7Ap4nn7dhSwSsBWyV6mRZ7/RLcdtCWbkgWFFep2G7Ps6J3Vm8oYF
         1U3GvraxZ7E6egAbMLSbaoHqZUwZ1ZNLYJT90u9p6KwdqJKGyUohzrPiLAu22roaCjz1
         8WRQ==
X-Gm-Message-State: AGRZ1gLAqjT+OCFnHnLUIbsCIBInX6v9J/ofIyMt15LOxX4517GRuJWn
        6OjfMprMP1MGFJCdqNRgn28=
X-Google-Smtp-Source: AJdET5eCOCW+AO8030Hp+TY5etir27KymE1ohTytpC2BO3MJy4vQYfvVN+lFHiu02dNUju++7h/x9A==
X-Received: by 2002:a2e:5dd9:: with SMTP id v86-v6mr2049015lje.86.1542225108048;
        Wed, 14 Nov 2018 11:51:48 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 26-v6sm478152ljb.16.2018.11.14.11.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 11:51:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gN1CS-00028J-NF; Wed, 14 Nov 2018 20:51:44 +0100
Date:   Wed, 14 Nov 2018 20:51:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS fixes for v4.20-rc3 (take 2)
Message-ID: <20181114195144.GA7982@localhost>
Reply-To: 20181114150634.GA19442@localhost
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please ignore my previous pull request for GNSS fixes and consider this one
instead.

I've now asked Stephen to include the GNSS tree in linux-next, and he
immediately spotted the missing Sign-offs. I was too focused on how best to
split the gnss and serdev patches and handle their dependency that I even
forgot to post the GNSS patches to the list after setting up the new tree
(hence the diff below).

Hopefully back in my usual routine after this.

Johan


The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-4.20-rc3

for you to fetch changes up to 1decef370456870bf448a565be95db636428e106:

  gnss: sirf: fix synchronous write timeout (2018-11-14 20:37:41 +0100)

----------------------------------------------------------------
GNSS fixes for v4.20-rc3

The two serdev drivers were using the wrong timeout argument when
expecting the serdev_device_write() helper to wait indefinitely,
something which could result in incomplete writes when the controller
write buffer was getting full.

Signed-off-by: Johan Hovold <johan@kernel.org>

----------------------------------------------------------------
Johan Hovold (2):
      gnss: serial: fix synchronous write timeout
      gnss: sirf: fix synchronous write timeout

 drivers/gnss/serial.c | 3 ++-
 drivers/gnss/sirf.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index b01ba4438501..31e891f00175 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 
@@ -63,7 +64,7 @@ static int gnss_serial_write_raw(struct gnss_device *gdev,
 	int ret;
 
 	/* write is only buffered synchronously */
-	ret = serdev_device_write(serdev, buf, count, 0);
+	ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 79cb98950013..71d014edd167 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -16,6 +16,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sched.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
@@ -83,7 +84,7 @@ static int sirf_write_raw(struct gnss_device *gdev, const unsigned char *buf,
 	int ret;
 
 	/* write is only buffered synchronously */
-	ret = serdev_device_write(serdev, buf, count, 0);
+	ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
 	if (ret < 0)
 		return ret;
 
