Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04563C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40DA2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp/+UNHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40DA2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeI2II1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:08:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34685 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2II1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:08:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so5645991pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 18:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JPoTW8AlqZ0kmhTYynRXN7l9rZgVhvYZvQ39/SvH8pU=;
        b=mp/+UNHO9sC6UXLZg9ZUTO+eYeidMyhRG86eQLVMX5aY0DRLrhaW2JVYcgMAqqzi7o
         baF/7VMVZlWAAqS9DaiXZe7Gj3QxXMBUAtcAdjKzn/qYcamSj0LUzGQWRoRQXabP6vAM
         E1ZRH599fVAclRMy/sn6o7MrZJ6MvN4jSkzYfe5b+hLGlQjNAN9campV0lXJsZZDKIMz
         qU7jW2tpKKvp/ln3gujawFPJtIitv0J/zbMfU7U8G9/aAO/jKum/75qkP6p9fJvGBvYX
         1+shkSR7QD+R4rJ3LSytauIW5Y8xM4V9JqRkixyh3qQmTrtFhZEw3S80dumpHMBd4h+n
         PzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JPoTW8AlqZ0kmhTYynRXN7l9rZgVhvYZvQ39/SvH8pU=;
        b=aplyPZ1hHar1Z5jHBU6kRa8HVZzsxJHv1+9g/ZdDTZSG+eIJSG6weAeHHEMcMseg3D
         QuRE/5dmLdvW2LhnHN8PpDyiUaGcALTVsedGjaJfO51oWIAPjraw5YQLeLwHOQPYBZGv
         EuD/oNwOPS/4owsUyWARnhxSR6O1fvvOu4zXb07FqieujMsK5TJBDpAPlnnQCgJo4fP0
         WZObeEhuDuB+EL3v3Y629/Vw0MUbVDWyMAOv6k+jscCrKc4EjfN6MEBFx1stwzsdA+Ks
         fVVIJlLBr9q2isradHLCaQgSLepwFxJ7VgDp/E3/h9+KWk/dXV9MlNerqurvcRDnmZ6N
         5low==
X-Gm-Message-State: ABuFfohW9HADqyHXDSoAgJ1w4vNacPO++/hHIkgDx/qdKieI1O9sx36e
        ZKjx+HjMzx1czPG9walq0HK+VVJY
X-Google-Smtp-Source: ACcGV62zNfBy5+DzYEYFlecABxrqQSFxFIVqiw+umttYSAmocymBcQDs7Mgrmd8JfpKUutFH8jA7mw==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1-v6mr1128113plb.129.1538185319854;
        Fri, 28 Sep 2018 18:41:59 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id v23-v6sm8144292pfm.80.2018.09.28.18.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 18:41:59 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, gregkh@linuxfoundation.org,
        marek.belisko@gmail.com, arnd@arndb.de
Subject: [PATCH] MAINTAINERS: removed staging/ft1000 driver
Date:   Fri, 28 Sep 2018 18:41:40 -0700
Message-Id: <20180929014140.6656-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the ft1000 MAINTAINERS entry, concluding the
earlier removal of the driver in commit 6512edec48b2
("staging: ft1000: remove obsolete driver").

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c62b724bb60..6b29bc4da920 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13908,11 +13908,6 @@ L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 F:	drivers/staging/erofs/
 
-STAGING - FLARION FT1000 DRIVERS
-M:	Marek Belisko <marek.belisko@gmail.com>
-S:	Odd Fixes
-F:	drivers/staging/ft1000/
-
 STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

