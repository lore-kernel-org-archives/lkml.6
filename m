Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAC6214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RESx+qTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAC6214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbeKVB3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38824 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730863AbeKVB3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so5113899ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LsJkGUqaixNZVE0nAmISN888bhxEVX8D0M13TuQ0X1c=;
        b=RESx+qTbp7/T9Su3NMyyX3gFB6C+5ICaF2vE9ZhlIcHl605KA4m13Cn23e3By6TAsP
         kjcGrMVgfm6AfSMb5FH/Y/xH8M5E0QeM/6gOtQcmXFTBiAYe75e97VlPjGgTGb6YpZH/
         PWMZQe8ikFSQV/4piFRHtaYOZvOwZBmiSfH7BYkcPSlGsC6MjtKHtfyFheLtuAniD/Tl
         7ajgCMkuQnlTkI0XlLkQdqpfKE7UkX5HSSKvu0wzmQepOmVTFHJiHdolji+70CVoIp76
         zQVKdjDrLhcJW5ZBdXpXHXo1txptfUKjiS7ovLHRxPLgbEepHm0tji5Niq+eWQ7a4Kmk
         TFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LsJkGUqaixNZVE0nAmISN888bhxEVX8D0M13TuQ0X1c=;
        b=p7TDODYIQInCLDeu8qXYfC3olFYAZZvUOOcD1vjfQsYmvE5xX8tZC1gEWemE3CZO+u
         Oe1d/Co5kB/SlOPI4lF9ZM3DEr294wndUWZUhaRVYgzVsQPlcIxTyEIwvQhedMo5mLcU
         RQIEahd9YcYOnZrqAYIXWqW/LXYdzIaEJRjYYt29U11nK39TiLZ6Hcqd7cAM08hNeuK5
         7mCh6LKZu3FYqLMxSb9y6cO8Zy2MpAi3DVjgs2GiDYwBTBRbx+3Rj+aKNWLfFXkshmPg
         /FZgy3UbpVz1BRX24ETlxuJk/hQcSPzsrt9P7oBgh970hv7zytK5uQQGr9ko7oGaTIb4
         nWDw==
X-Gm-Message-State: AGRZ1gIAUC383POJBaiv09AAo7TjY8mj34WqTtmdIFc1FI1ajKI4H7p5
        TbfpDwICUEM29B0KAemm9Q7I2RyU
X-Google-Smtp-Source: AJdET5dnsixJG3vae66GC+OkCoOrSJ/y+7JueQQq+np0mTfgg/GvhX95fdAvt8UYTHacxa6bSNsfCQ==
X-Received: by 2002:a17:906:90d9:: with SMTP id v25-v6mr5283945ejw.214.1542812091976;
        Wed, 21 Nov 2018 06:54:51 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id a38sm4884648edd.44.2018.11.21.06.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:51 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 14/19] mailbox: omap: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:24 +0100
Message-Id: <20181121145429.7582-15-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121145429.7582-1-thierry.reding@gmail.com>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/omap-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index db66e952a871..7e54ebb7defe 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -486,7 +486,7 @@ static int omap_mbox_register(struct omap_mbox_device *mdev)
 	list_add(&mdev->elem, &omap_mbox_devices);
 	mutex_unlock(&omap_mbox_devices_lock);
 
-	ret = mbox_controller_register(&mdev->controller);
+	ret = devm_mbox_controller_register(&mdev->controller);
 
 err_out:
 	if (ret) {
@@ -508,8 +508,6 @@ static int omap_mbox_unregister(struct omap_mbox_device *mdev)
 	list_del(&mdev->elem);
 	mutex_unlock(&omap_mbox_devices_lock);
 
-	mbox_controller_unregister(&mdev->controller);
-
 	mboxes = mdev->mboxes;
 	for (i = 0; mboxes[i]; i++)
 		device_unregister(mboxes[i]->dev);
-- 
2.19.1

