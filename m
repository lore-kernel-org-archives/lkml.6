Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C603C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66452218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cPgOYknW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeLUHHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:07:47 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:48632 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUHHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:07:47 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 8C9A1D1C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:07:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5dhhOFunfLrj for <linux-kernel@vger.kernel.org>;
        Fri, 21 Dec 2018 01:07:45 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 5DAC8CF7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:07:45 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id k4so3575930ioc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pGIPypqT2PiUODlArqmI2NTe3ZsH7Y81qX+Z5Er/VLk=;
        b=cPgOYknW7lcmF3E9I/V+nQp8JLwrCVe4ohunmWTmALIc3tKSDcSUK8GypNoaNOKbIA
         w1b+XPuXpsZHYwLiKjLlIqR5KU+k/onHZl2/AEmATU8ST5q3RQJ9zKPKDyVe0Z3lzV3b
         vG/lS0WYwxMRkQFlUHiScdhCQHdohS8jmPZm+1v7dF0VrYP5mQ0RADxiCmvhwb8uLMQb
         CxgCuOi/lTrYseWBWRM7A0+6gYjVLoKNNISfr8JiT1nuakAQSiVF5WRYRAvLQnog5P95
         cWgl1fA5hV4UV01ELrwsM9Co7cGbsWqs9U4uKm4eT7IxbwWOAkuI2x6oW4NcI885BtmS
         Ky4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pGIPypqT2PiUODlArqmI2NTe3ZsH7Y81qX+Z5Er/VLk=;
        b=JxNbnjhk/9FRKDaFNpyjmBAeiZ0ETU51yKDjgTuduD/mrL8kEpQAOKXSDbo9+uvcTt
         91fteNlaDg4LheW0NgViWAFEGBwL51wynkE/ZZ5yEam/WGeThwQyVZQc6ZyZ8pQA1C/E
         ejLvpTOfjSCsHuJ4I1owXdurZ5P3d3X7S7suORyLs9WDEodqadsvelMGE5AGzOV+AaPd
         JGXsy5hYSJqISVxzczkzm5uynu6aV13DN2I84rDjYVzcuAHMQ6TJdguof5AFkh4zmCRl
         n3I2PEQHmpf8UCEe09gOe4gQZMw4tdm0K04zx/BtwwPdmtxLa/EUMDE/U5S49yBj20xd
         poMg==
X-Gm-Message-State: AJcUukeoXsMhgX/TAT30L0QXBXCURWBHqkLM607CR7zCjnfIZYLjxq6T
        eaJQAIClYsXzlj48xxUcRY216gnOHDForHXJlFmOFkkP15EtDVZgABkvDB8i+NiaS9At0MaZqg2
        r/Hb7F0iKBhp82AioKdJMTFiiwEY7
X-Received: by 2002:a5d:8ac6:: with SMTP id e6mr759405iot.235.1545376065004;
        Thu, 20 Dec 2018 23:07:45 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5vayve99OcQ7newd/X4N8/q5FufymkOlrt0MYoKymu3fjU/iI1zdtz8p4Hedvr0QLorE6r4w==
X-Received: by 2002:a5d:8ac6:: with SMTP id e6mr759400iot.235.1545376064681;
        Thu, 20 Dec 2018 23:07:44 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-23.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.23])
        by smtp.gmail.com with ESMTPSA id z133sm5820625itb.36.2018.12.20.23.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 23:07:43 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: mt312: fix a missing check of mt312 reset
Date:   Fri, 21 Dec 2018 01:07:20 -0600
Message-Id: <20181221070722.60234-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt312_reset() may fail. Although it is called in the end of
mt312_set_frontend(), we better check its status and return its error
code upstream instead of 0.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/media/dvb-frontends/mt312.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/mt312.c b/drivers/media/dvb-frontends/mt312.c
index 03e74a729168..bfbb879469f2 100644
--- a/drivers/media/dvb-frontends/mt312.c
+++ b/drivers/media/dvb-frontends/mt312.c
@@ -645,7 +645,9 @@ static int mt312_set_frontend(struct dvb_frontend *fe)
 	if (ret < 0)
 		return ret;
 
-	mt312_reset(state, 0);
+	ret = mt312_reset(state, 0);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.17.2 (Apple Git-113)

