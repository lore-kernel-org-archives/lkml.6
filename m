Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BAFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F76120893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdofheyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F76120893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbeG0E3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:29:36 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43958 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeG0E3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:29:36 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so1678993plv.10;
        Thu, 26 Jul 2018 20:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=41J/SOVhxZEjw918E/K6mTpeFIBmuc1SeLyB24bZaiQ=;
        b=cdofheyrk2ZgTS7VyVFCKJVq55hIgwCqzRQu50aEntmfbDKWAo3+kNj86i+ZCmMhUt
         Zw9niCl6QDnRfGzL/2plKUQgqp03h+0l8V5S8oV/Rx9GJk29+zH2kKb4D9VIpYl+ob/O
         QxCyNy4DQxaK3GUm04GYGYfz2NjkbvIbS20lyVoHQFeFg+w6Dkq+2nOE9ysqMWmOBi7z
         KPhFRgGlvJz65oZGFolB7BX1JH+gdmcHXT3CXLeztrE2xlwKCB6BoHAmryPZDLGIl5Cq
         tun2CxbiP749oz/qJP2X9M8BocIYW304lYVOBTVHX+29uNKBBTSquZrFJUPo7mQCxRpC
         TbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=41J/SOVhxZEjw918E/K6mTpeFIBmuc1SeLyB24bZaiQ=;
        b=KLJ5SrXDuw+HgJqgKK2uBpjW47OL6M6VIv0WIQNPwekxtCaKsxWJLbWlbGDGpkCU+c
         M49iWhK5ZxvzV0eJaEvMJNQeewfqu2+X0Z4txeXcc1FRJ94ZGpE93yhPEis3rkoI+Fxg
         cstNq5n0CdRJ7cithkEv/VDHbdkO8MtncOsnp0qKSdyyIb677Za8iXx7yl1ATI7leTpO
         o3YzWm9SfwlKVVywWqkzZU1YFZKAwNWmiMV/UcPSKBqWL9fJNrO01oXpBNouJSz1SHeZ
         ELuAYM5/9T8c+hcz/nFeTMzALpTWOAalt8iT8GaM854iUZTGDjknzJvirv6v3xz3MU72
         fTxw==
X-Gm-Message-State: AOUpUlEcyt1J3YLaulND9JnnPStPpvg7/NvIMEbzQhd41axg5xIAg7m2
        gPAkT02yNPwxazt9PfOAc8/bjvyJ
X-Google-Smtp-Source: AAOMgpcfMfGYzFACllbSqT6VT5lFQzm8egzAf4cJbTZ2HBhTsCmGlEjCJiCCbFH9zkUi7qMR2DmnoA==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33-v6mr4243776pll.343.1532660993118;
        Thu, 26 Jul 2018 20:09:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id c12-v6sm6991302pfl.20.2018.07.26.20.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:09:52 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: pci: cx23885: Replace mdelay() with msleep() and usleep_range() in altera_ci_slot_reset()
Date:   Fri, 27 Jul 2018 11:09:46 +0800
Message-Id: <20180727030946.2886-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

altera_ci_slot_reset() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/cx23885/altera-ci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx23885/altera-ci.c b/drivers/media/pci/cx23885/altera-ci.c
index 70aec9bb7e95..62bc8049b320 100644
--- a/drivers/media/pci/cx23885/altera-ci.c
+++ b/drivers/media/pci/cx23885/altera-ci.c
@@ -346,7 +346,7 @@ static int altera_ci_slot_reset(struct dvb_ca_en50221 *en50221, int slot)
 	mutex_unlock(&inter->fpga_mutex);
 
 	for (;;) {
-		mdelay(50);
+		msleep(50);
 
 		mutex_lock(&inter->fpga_mutex);
 
-- 
2.17.0

