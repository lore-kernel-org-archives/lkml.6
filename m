Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FACC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3098420672
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocQJN3yO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3098420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeKTXb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:31:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeKTXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:31:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so977166pfi.5;
        Tue, 20 Nov 2018 05:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qA2M3gyf7tWKriE7DGWPlyQR3HbBH/LFqU20I/0lZ7Y=;
        b=ocQJN3yOFfwfAM1tLaNVhHZmBaZjETYvg9ZlSUAB+CbJF5R1XzJK5BapiybDV6A10L
         6r8wTkG0sfRysnAhznW8DcmuMxspDT7AdVA2PDQGSZhoGLorqWvAWMK5j5ghzLxSFxBt
         wucSjnLLgo+Ljy3F5HaNt/nsDuAR1WcsdU9xXsPelpG7DynFf10u5VD/iCOooS07XMCO
         CuXkPDhTo+DLWBrmXjXWejPuSEKSHFIWuUJsO+Cy1SgoUkPWD+vxaes3PTBiMwHm9fx1
         wS2fZqEtacLiwpBiO4lt4Jh3H5+Ldtw2z+W2ax6zFBNPPOlMtG4aHnqx+VWQhMInfctb
         RqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qA2M3gyf7tWKriE7DGWPlyQR3HbBH/LFqU20I/0lZ7Y=;
        b=ZyRxhekv4bHZjaKQvcZL9minRGYAGxUNuIH9aGRBZfQ9WrSQrf0LYw4WssAvNTYd8G
         q9DjKXqwS/9VI+NMxu5tgKe6Hr1yq9PhRv7MayCdhdY3G1EasanXQXQ9YRu98oX75dLS
         sQZJg+eU8Tixy3Xo25FXAjBSRQNZixRDp2VgOCGy6Gks87aTAFcgXfnNM9muak9M5mAw
         JDjgrd3J+saIUa4YuO34yIZ3K4teGBuT8BcVuDikjw4WOGVLDOkMYBg1bAo+cdjDRj5F
         XsECzoqIrkmkvhaolPKLqDlTPKnNU3lWjPHxU8kLURATT4JKxbyMhqK7NIDN42r6pOrp
         9RDg==
X-Gm-Message-State: AA+aEWbfRWzLbKHzHlj7/VQKSq9EfSI8dPBe5/pxTcXsMmfEiKHo5/Ft
        eQxCHxKAquVkdW6AzK1brsY=
X-Google-Smtp-Source: AFSGD/VlrcFE7tKbovFzf8N2e2W6bQVF/n8iGcfWP/uKWTpZjlNssWFtWOF/cQz4icLx6y+Uyz3zxw==
X-Received: by 2002:a63:200e:: with SMTP id g14mr1809566pgg.235.1542718973563;
        Tue, 20 Nov 2018 05:02:53 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id i189-v6sm70021706pfc.16.2018.11.20.05.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:02:52 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Cc:     linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ide: pmac: add of_node_put()
Date:   Tue, 20 Nov 2018 08:02:49 -0500
Message-Id: <20181120130249.19525-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/ide/pmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index c5b902b86b44..203ed4adc04a 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -920,6 +920,7 @@ static u8 pmac_ide_cable_detect(ide_hwif_t *hwif)
 	struct device_node *root = of_find_node_by_path("/");
 	const char *model = of_get_property(root, "model", NULL);
 
+	of_node_put(root);
 	/* Get cable type from device-tree. */
 	if (cable && !strncmp(cable, "80-", 3)) {
 		/* Some drives fail to detect 80c cable in PowerBook */
-- 
2.17.0

