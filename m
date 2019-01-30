Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40713C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F359220989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKbOESJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfA3Duk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:50:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46442 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfA3Duk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:50:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id y20so24774737qtm.13;
        Tue, 29 Jan 2019 19:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=GEyOHCwVPYw7HStNlmnz7HDoR38M6hlikqiPdfmFD4w=;
        b=LKbOESJGHJXEiXAcUv+UNvpCagovxMg5SaJbfvxpg6laG+BEK1iXVqv0iDHWTKcqzx
         wfSHn3J6+LmzgONYk2W+4u3Tz36XQ4fu02p5JywbmGQuL0a8DMrHcSiqQXjChzneqlN9
         sBJKtZ63G/Bf3d7HFMPbheE1ZcMNY4+k5VQH/3LQw6qCBvLKO8RCNAPQPPBMeLVGIQDH
         4lQXClvkZzZT3zZpA2sooPAtsuXu/1S+X1uB9Kp7sPUJ4z0BTH85G5EPfVOYHAAyeDcH
         84tY6MjDdMKwVlN62E4OTG5LTnIRclRmSa6G79vCRPbrT9xMqlDEx5mFkP6Mc1eMQiKi
         T85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=GEyOHCwVPYw7HStNlmnz7HDoR38M6hlikqiPdfmFD4w=;
        b=ENe/8FNkgK/dw26j2ne2M3uX7qqQ9jONfT2g/UwFsg3ANGmPHkzIzSbiq9joK2Hlwl
         wfruJpx0f1AHq0aeV/oTV6BJdsDkgWhEtMj0YRVaECRAGpwXetuHfwwTWFrWsUGC6Yya
         ncmYA+RRn5HjkdaIsG9GCZG0EuXTTnn2ytpxbIn2BMQNyYgEZOkg9Nr1lAi22cAS7Wkr
         6EjLvuTxaznjqFzZu9z/4knFc92Xo31PWgV1/gTtD0exCS0dlF4DyK//VlJ4Gd6+uU0O
         J6IZA3QEW7/BAD678CdiqwwsKHVsr+YEIsJpCibTzHSyTA3/k04UgKBk9VzstY5FH7OO
         Avfg==
X-Gm-Message-State: AJcUukfBOVLj31zfxrOLarF96w1GJqEWtiMuRWiFMOAdm+MR2pZ0L6k9
        QvYpLKZVHwQdi2jzXpvv1ucoNzDbK9U=
X-Google-Smtp-Source: ALg8bN7mGZUC+bIUQFb+tbjjw2gkLRF/uIGHau/BkUpfsmYiOs4swthJk0pGUT9itJ3PUExcUK7VaQ==
X-Received: by 2002:a0c:eaca:: with SMTP id y10mr26715904qvp.176.1548820239247;
        Tue, 29 Jan 2019 19:50:39 -0800 (PST)
Received: from x3200.lan ([2601:152:4302:ae1f::16e])
        by smtp.gmail.com with ESMTPSA id o129sm235909qke.5.2019.01.29.19.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 19:50:37 -0800 (PST)
From:   George Amanakis <gamanakis@gmail.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, sdf@google.com,
        netdev@vger.kernel.org, George Amanakis <gamanakis@gmail.com>
Subject: [PATCH] tun: move the call to tun_set_real_num_queues
Date:   Tue, 29 Jan 2019 22:50:13 -0500
Message-Id: <20190130035013.10820-1-gamanakis@gmail.com>
X-Mailer: git-send-email 2.20.1
Reply-To: CAKH8qBvEintAf5Dmz+8kCTW1V_BRUDxSAZy8WoYSyNoLW+JHfQ@mail.gmail.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call tun_set_real_num_queues() after the increment of tun->numqueues
since the former depends on it. Otherwise, the number of queues is not
correctly accounted for, which results to warnings similar to:
"vnet0 selects TX queue 11, but real number of TX queues is 11".

Fixes: 0b7959b62573 ("tun: publish tfile after it's fully initialized")
Reported-and-tested-by: George Amanakis <gamanakis@gmail.com>
Signed-off-by: George Amanakis <gamanakis@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/tun.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 18656c4094b3..fed298c0cb39 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -866,8 +866,6 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	if (rtnl_dereference(tun->xdp_prog))
 		sock_set_flag(&tfile->sk, SOCK_XDP);
 
-	tun_set_real_num_queues(tun);
-
 	/* device is allowed to go away first, so no need to hold extra
 	 * refcnt.
 	 */
@@ -879,6 +877,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	rcu_assign_pointer(tfile->tun, tun);
 	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
 	tun->numqueues++;
+	tun_set_real_num_queues(tun);
 out:
 	return err;
 }
-- 
2.20.1

