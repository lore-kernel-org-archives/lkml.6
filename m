Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F3EE6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F1620693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3nKpxtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F1620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeFLHtR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:49:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43971 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933474AbeFLHtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:49:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id n15-v6so34483732lfn.10;
        Tue, 12 Jun 2018 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LkcXpJqcxy5/ouv7xk/GJzXagHKGhZmj+NtUh8lJNpM=;
        b=F3nKpxtRgzYgIgzzp/8HQTENk+dbniSbofvvZx2fvQWoBfAYwt2gFUh86CrCu+xC0p
         pSmSAgcalSN2Z928qe9N041KrpSds3O1LLMo01XuBSQ9rCwDc5WrPRr6MUk2CocqJxTG
         30lw/tCWQClQd8gKH/aPYgOVkAWr1GI01f1n4JtEnksxnaFqzpHgSV0j6vslRyb8vXxa
         zJSlWorPTu0nF+NLTvE9fomWE+CDvS7dmdrHWNENlCirWFLO4+X42smxC32fkuYdIcR6
         319HDK4xuWGgEqjgqJzZ6leU+uUdFrEtoZUnUcLViPx0WgWgMVUNhbNYZLGJwb4FsQCE
         y/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LkcXpJqcxy5/ouv7xk/GJzXagHKGhZmj+NtUh8lJNpM=;
        b=oDtNjKXe6jd3oH/037neoBYE5BhZlTmYPPAK3ihqSwl4gMPhxVQBkFzB2pqseZX5qb
         4IqpvtdGWjc1LM7mpmKGPaLBmF26+MdEFnlTCJ355OsynYfqZMXwAfc99TxaySIEtqSW
         uu3iBNqBY2hsr14Zu1t/MNlPee/2/tqchxolnG5W2fT6KR/Gt23BdHbWg0fvvgIWqm4Q
         wEt8evb2NuLFcSTt0oH/Q7eXpD0wilProgw3D7q3ZdWbd3H4up6GkNggVmWUG1FWN4zd
         zMCFwlUkClbPEw/LCj1/1ief4m0j604t/NVxGZ3zcmh1atzZQsrZCeqiNyxF5/5gLjj2
         ALSw==
X-Gm-Message-State: APt69E3Bzc1iWsnhuL2xbc/1io9SVxi25AHZ9406dtieGIQg2+RHUgOK
        o+BWRfNS+pxY3CE+GWxYrj4=
X-Google-Smtp-Source: ADUXVKJ1MD7ZpNO1skHke3+NyVbHYMP3d6gAkesArrxvxvFHuvcQKUqmL0A6z07pmd3M9m8U+Ey0hw==
X-Received: by 2002:a19:ee06:: with SMTP id g6-v6mr1447241lfb.77.1528789753103;
        Tue, 12 Jun 2018 00:49:13 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id b65-v6sm62657lfe.80.2018.06.12.00.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 00:49:12 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc:     konrad.wilk@oracle.com, andr2000@gmail.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v5 2/3] Input: xen-kbdfront - fix multi-touch XenStore node's locations
Date:   Tue, 12 Jun 2018 10:48:55 +0300
Message-Id: <20180612074856.28451-3-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612074856.28451-1-andr2000@gmail.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

kbdif protocol describes multi-touch device parameters as a
part of frontend's XenBus configuration nodes while they
belong to backend's configuration. Fix this by reading the
parameters as defined by the protocol.

Fixes: 49aac8204da5 ("Input: xen-kbdfront - add multi-touch support")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/input/misc/xen-kbdfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index d91f3b1c5375..92d739649022 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -229,7 +229,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		}
 	}
 
-	touch = xenbus_read_unsigned(dev->nodename,
+	touch = xenbus_read_unsigned(dev->otherend,
 				     XENKBD_FIELD_FEAT_MTOUCH, 0);
 	if (touch) {
 		ret = xenbus_write(XBT_NIL, dev->nodename,
@@ -304,13 +304,13 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		if (!mtouch)
 			goto error_nomem;
 
-		num_cont = xenbus_read_unsigned(info->xbdev->nodename,
+		num_cont = xenbus_read_unsigned(info->xbdev->otherend,
 						XENKBD_FIELD_MT_NUM_CONTACTS,
 						1);
-		width = xenbus_read_unsigned(info->xbdev->nodename,
+		width = xenbus_read_unsigned(info->xbdev->otherend,
 					     XENKBD_FIELD_MT_WIDTH,
 					     XENFB_WIDTH);
-		height = xenbus_read_unsigned(info->xbdev->nodename,
+		height = xenbus_read_unsigned(info->xbdev->otherend,
 					      XENKBD_FIELD_MT_HEIGHT,
 					      XENFB_HEIGHT);
 
-- 
2.17.1

