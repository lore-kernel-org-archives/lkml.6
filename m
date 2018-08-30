Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F52C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C51E2083C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkGE2q7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C51E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeHaCkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41358 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaCkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so8565008ljy.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M3yi/b50a0XY795tJCMctb4VXUPgSddhVl6uXEIoobA=;
        b=XkGE2q7wmFkqBx8xc0CG5vLbzZalOIzfNsdRGVcTD2mPyZ+GxY1FUQ96mqbu6GoGn0
         kjDjV9HrsIi0pkdTInv92lT38NVMB3hhe6jZEAufXvuKggOsY5LBAdMltqL4nmpLFcvZ
         yuW/9/e/3FMiscDDYCh3GcoNmGtoChhMisHfp/SYFRconrvRZZn7uNupSrw02eOoKax1
         f71PmKE7De5zTG/IaxwVz9ErGMf08NE4Rufe7xBPRzV25e47LS5Z5ZrsipyPtxdvl9iM
         kHgv4YzW4pAotcAK99yV16iBIZ+uSkdMb9uedW6hpFSccfkL23onxmydAyPRE/ljJFak
         syFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M3yi/b50a0XY795tJCMctb4VXUPgSddhVl6uXEIoobA=;
        b=VItZKoAZI9HkJzCR/1SZ/qqS02Bje1yt7T+Je/CPicj1YppfWvUuQc24jO26B+e0I8
         TvyaMce3xEQieORF2+asIyc2oxuZJlhap3f0llMkutdHyJpgsDLqeng0BLsou/9US9Z4
         AjAItMIN9dDZ5fgtKxQwU91UUPgOEfoeL3XntsRMm/RbZsQ9CvO/Arrn/vH6c0Lx9f+B
         4uLuEXr2Zhb6/dr2tNC3ICMUECXPMx1E6EOZgZo0pGsa+/oh0L1AW+J/OzLK369L4len
         RAfCo8PL71+OXrEiHNaMMdXtr758j5qNNEfMLuH/inL9eWNXBeKzaKWsltaLU5wPteAp
         C6EQ==
X-Gm-Message-State: APzg51BNKRODuglWYt5taOlXV1lI1x3hK1yGwAxKQ8/e9SbQl3uts4b9
        KXMOb35LE/fvxWOJnMTG3zHOrYcT7pQ=
X-Google-Smtp-Source: ANB0VdbH6vrl98ro20Qb1fQeP5xk4NCZeOlhNOhdwtYLw251kxN7t7sva4UK8IE4dLpNjZmwRhUBPA==
X-Received: by 2002:a2e:5617:: with SMTP id k23-v6mr8320166ljb.86.1535668544326;
        Thu, 30 Aug 2018 15:35:44 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:43 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: [PATCH 15/23] lvm: device mapper: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:21 +0300
Message-Id: <20180830223429.30051-16-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
---
 drivers/md/dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 20f7e4ef5342..0f0f8547106d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1653,7 +1653,7 @@ static blk_qc_t __process_bio(struct mapped_device *md,
 		 * Defend against IO still getting in during teardown
 		 * - as was seen for a time with nvme-fcloop
 		 */
-		if (unlikely(WARN_ON_ONCE(!ti || !dm_target_is_valid(ti)))) {
+		if (WARN_ON_ONCE(!ti || !dm_target_is_valid(ti))) {
 			error = -EIO;
 			goto out;
 		}
-- 
2.17.1

