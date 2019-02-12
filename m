Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57E1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A80217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/+z7oNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfBLQO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:14:57 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50453 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfBLQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:14:57 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so8546921iti.0;
        Tue, 12 Feb 2019 08:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=axEcvJzeXznlk51dxtC6r6Qo6PPKSpBSyiz7rvfAu8o=;
        b=l/+z7oNBRVNLKLmjf8o0aY+XHabjVFUtvtRSMhZaaVBPgLyVhfgvykAGKUc4fiDFld
         BZPKcKKvvkmonBQ1zt7TI39voV/BZ6ZAFR7Lcf6uX2s4avA54YrYmdtsgxF/IhG/xILN
         y3PZXiDkIGHJdbGU59+0hSpC3TRVoWIhn97/SWu/CgrtQqcpXIbifFxRF1RoIA2h15Fh
         R7jOkrT13r6M+UMFFJcv/1c8VekCk65OARu/6279rpWWwEWIMlWOnjayM6YWBDALhcos
         TU1UnqqrBCrnzizdDRWnQYqWt1tijeMNhmo1Ul6ME3swJaPI9bPr6muV+DBPwwxAYjlH
         /Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=axEcvJzeXznlk51dxtC6r6Qo6PPKSpBSyiz7rvfAu8o=;
        b=PLddql69M6xqhuLEXrjfHRBvpP6rBakNYqqHNL9XmYxUPKdze4/7i/iDcBCQg070wB
         STThS3clO/CzZqHjmdiSOIQpqGXoLJ08fYklOo245tUyX/ZJYnUppIZygzlknpSZIvL8
         BbzNoEYCIPP3HcWJOzafF3oqeHsu9Zlpkc2QgApxnTVgqlUX+19MgAduDtTZJbcYDo3g
         Ld3u4wNF/Ifppbt7sRbKSsCXUVm1gg7HgbDXJd4XNdcm01rPX622vBeqOedf+rz5YdJJ
         rBBePNHv+UWkubh/Pbn5TqW0yLmXwSo8lD+7vEZpBn0toY3lxP9t9JULCWxaaUaDjYGA
         cg5g==
X-Gm-Message-State: AHQUAubzY94HDUZgeLEBypKPQST2Xi7F272s1Dg+h3P0sdoslAw9Wwtb
        wcbGxyAg8CEVpvlCVYCVCuGZQeyc
X-Google-Smtp-Source: AHgI3IYKawiImUQuWrJmM3SvJ6pwxCPLYmakAO4lEhqn/hsyq1TCBpzCb9L0SqFi+nl0NQtWcoOELw==
X-Received: by 2002:a5d:859a:: with SMTP id f26mr2487663ioj.150.1549988096506;
        Tue, 12 Feb 2019 08:14:56 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id g62sm300701itg.11.2019.02.12.08.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:14:55 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: ds2782: fix possible use-after-free on remove
Date:   Tue, 12 Feb 2019 11:14:50 -0500
Message-Id: <20190212161450.17167-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In remove(), use cancel_delayed_work_sync() to cancel the
delayed work. Otherwise there's a chance that this work
will continue to run until after the device has been removed.

While we're here, fix the deallocation order in remove(),
to correspond to the inverse of the probe() allocation
order. This guarantees that any remaining work can run
to completion with all driver structures still intact.

This issue was detected with the help of Coccinelle.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/power/supply/ds2782_battery.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index 019c58493e3d..5853a66ff246 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -321,15 +321,14 @@ static int ds278x_battery_remove(struct i2c_client *client)
 	struct ds278x_info *info = i2c_get_clientdata(client);
 
 	power_supply_unregister(info->battery);
+	cancel_delayed_work_sync(&info->bat_work);
 	kfree(info->battery_desc.name);
+	kfree(info);
 
 	mutex_lock(&battery_lock);
 	idr_remove(&battery_id, info->id);
 	mutex_unlock(&battery_lock);
 
-	cancel_delayed_work(&info->bat_work);
-
-	kfree(info);
 	return 0;
 }
 
-- 
2.17.1

