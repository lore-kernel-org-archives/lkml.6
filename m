Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8508EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A01E2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHOyuGCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A01E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754369AbeFLMqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:46:44 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39351 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbeFLMqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:46:42 -0400
Received: by mail-lf0-f68.google.com with SMTP id t134-v6so35807756lff.6;
        Tue, 12 Jun 2018 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=pJjSA50iRw8SLe0S+usgvRDyFXFk54BMK3wa4Qk93iM=;
        b=OHOyuGCsx6SxiQfx7PuUReHn6G4nAAN4bLw6cS2qdCwDmwKx3mYi3buJfoE2Ym09EH
         ZTi5zT7PdoPG4qghjxw6+IMc5iL8PA3PgxyYBpelybbxRmGJABduuTJ6eve6bPDJdN33
         UZWIhaMNZrMaCxgQ8NP/ZmnNfQN3TLgORZuJ+tAZGFDde3egl2tqr+CV98bp0lq+Arhh
         frGJUWfHhI1PROzuE6hOXkV289MhQVp8aikAFdLmOh5e//ASRwwx2Hkt4ieAVJINwpcF
         SsbJ8GEHp88uDs/PDfMpRIivPj6iBpcXd3OcTqQLI/tgUD/C01jgaULezazGQz/zAS2i
         vcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=pJjSA50iRw8SLe0S+usgvRDyFXFk54BMK3wa4Qk93iM=;
        b=ABgtFdszQs62Zy37ihbMwMUVrXMvdaB1oiU5PsN4dV6c8PARHkCM1FbBpMlIVMrda7
         rNcTwC7avX+zC8IZU6w+0DlR1CVpwd5WvhBoqorYYygroyE4Fw0aP5dAzVo75Xg0OfC+
         dnkqsqb0uSMk6j3tNN7bWL5Mamumyjqr/5XzGsWJ9BV4wSgHym6y8dh121vxCTG1t8bG
         Un5UUzgN6xbio9M5y6Zq9YBZNNoeOqop1/QsLD81H93cyXpMQHWvEQt0E3ohy9x6Geww
         M0T8oePRv5HFkYZTpI9vDXn/6GCSeRbw51DHZLTSfjNho8qEGowL0b0n0j1uJXWC51H8
         w4uQ==
X-Gm-Message-State: APt69E3db2iEy+IqFEb6qi5fU1LtcxbFAYxNdF3Sy2puntYLMnHAkw1r
        4cgafMwAy517+D+je/6iMwE=
X-Google-Smtp-Source: ADUXVKJ3RRBt8TBxZ5/zxzhdIsMppSmlOc+985G6dSzTf7Wqs0FNlNWIALbpZm4nrr07Ysh66qAlFw==
X-Received: by 2002:a19:c452:: with SMTP id u79-v6mr144128lff.5.1528807600757;
        Tue, 12 Jun 2018 05:46:40 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id h24-v6sm13981lfc.63.2018.06.12.05.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 05:46:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@xi.terra>)
        id 1fSigj-0001hY-J6; Tue, 12 Jun 2018 14:46:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Denis Kirjanov <kirjanov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: [PATCH 1/2] EDAC: fix memleak in module init error path
Date:   Tue, 12 Jun 2018 14:43:34 +0200
Message-Id: <20180612124335.6420-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to use put_device() to free the initialised struct device so
that resources managed by driver core also gets released in the event of
a registration failure.

Fixes: de3910eb79ac ("edac: change the mem allocation scheme to make Documentation/kobject.txt happy")
Fixes: 2d56b109e3a5 ("EDAC: Handle error path in edac_mc_sysfs_init() properly")
Cc: stable <stable@vger.kernel.org>     # 3.6
Cc: Denis Kirjanov <kirjanov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/edac/edac_mc_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 7481955160a4..20374b8248f0 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -1075,14 +1075,14 @@ int __init edac_mc_sysfs_init(void)
 
 	err = device_add(mci_pdev);
 	if (err < 0)
-		goto out_dev_free;
+		goto out_put_device;
 
 	edac_dbg(0, "device %s created\n", dev_name(mci_pdev));
 
 	return 0;
 
- out_dev_free:
-	kfree(mci_pdev);
+ out_put_device:
+	put_device(mci_pdev);
  out:
 	return err;
 }
-- 
2.17.1

