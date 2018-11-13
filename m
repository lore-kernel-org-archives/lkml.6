Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA2EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5995D20854
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkWFJlTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5995D20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbeKMSnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:43:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37901 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbeKMSnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:43:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so10527392wme.3;
        Tue, 13 Nov 2018 00:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/53gK1ipm3W8/svJPhzAx0Nvn2YXWpXGRuzZ/UGSNZ8=;
        b=MkWFJlTZA6pfKAnC7R1vGSApb2jgj1zP4146nipDrxeEfDOUb+wGknzxPT9NA8nvVE
         69cSsCKOAvt/IjuiYuUvYKTYpjK8B78XyhE8Dh42VglpXjVwZLa7aeWfMdT0V4TaCssU
         hzDaJl6Sh8Wh5DROot769GRAdYdfxlZ0T06fOL6EgStoHa+DYI4tzQWcU7P6vsylUT4q
         tSFBR34AEW6V1YK73SKew5A38oV2KsokQoNCyzBZ+7eiM8TzM7QQN20fv6X/uWlXFKj3
         Jjz2Iu+H4g41rolmHV8hZtL3u7jbT40xxySDqumUhfz6rjxw4lIRbnCa9xj2bh57TVXN
         nyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/53gK1ipm3W8/svJPhzAx0Nvn2YXWpXGRuzZ/UGSNZ8=;
        b=HAzAeDx9KHsxvwjInDhRaUhrROSNUAQY1mSezNCQs+P2dDaT9m7mTnHuH7hTf9mNhr
         6YEtGctK++P5zg90P3ujwzdnKxiTcO5shzDRheiZapN9IPc5KljAYPpqmEzf8zFSCgtZ
         jUp9ClUJ4pvRtQW+t/0ADU1iOnR7O51gOR2AGAOocz63G1JajFdgp0162eM10KHlvwQK
         6yfi15Rz0cMeDaMNXc1dv+q3S7wxnFiHJ4Cu3J45EFXM7a+G7YcGjADAwFrMhJc5n0wA
         NDkFkGZFjb+MIWy4BQ/k0TINyhAzGDMMvve7NpJ8GAki5Nwd1A1aKK+NItsyHEAbN1Lz
         uCDw==
X-Gm-Message-State: AGRZ1gLMOZb2dA2nZcyu8z5qnpbizGt7y63QUVVTWG3IzR+V+XaaVdVk
        0mMErlZPfje5AeQ8cuLmPg0=
X-Google-Smtp-Source: AJdET5djX/b4F1X7X+bcL6pLColqgObzzD997jANb6aFwNvjj7Q30iah84yMHc31t2zL5cYxTve9aA==
X-Received: by 2002:a1c:c284:: with SMTP id s126-v6mr2315699wmf.21.1542098786135;
        Tue, 13 Nov 2018 00:46:26 -0800 (PST)
Received: from localhost.localdomain ([2.236.87.61])
        by smtp.googlemail.com with ESMTPSA id 197-v6sm12935423wmh.44.2018.11.13.00.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 00:46:25 -0800 (PST)
From:   Paolo Cretaro <paolocretaro@gmail.com>
To:     kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Cretaro <paolocretaro@gmail.com>
Subject: [PATCH] vfio/mdev: add static modifier to add_mdev_supported_type
Date:   Tue, 13 Nov 2018 09:45:43 +0100
Message-Id: <20181113084543.9543-1-paolocretaro@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set add_mdev_supported_type as static since it is only used within
mdev_sysfs.c.
This fixes -Wmissing-prototypes gcc warning.

Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
---
 drivers/vfio/mdev/mdev_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
index 249472f05509..ce5dd219f2c8 100644
--- a/drivers/vfio/mdev/mdev_sysfs.c
+++ b/drivers/vfio/mdev/mdev_sysfs.c
@@ -92,8 +92,8 @@ static struct kobj_type mdev_type_ktype = {
 	.release = mdev_type_release,
 };
 
-struct mdev_type *add_mdev_supported_type(struct mdev_parent *parent,
-					  struct attribute_group *group)
+static struct mdev_type *add_mdev_supported_type(struct mdev_parent *parent,
+						 struct attribute_group *group)
 {
 	struct mdev_type *type;
 	int ret;
-- 
2.19.1

