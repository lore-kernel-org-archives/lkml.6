Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA149C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7385721471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETxV/r8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7385721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbeGLQPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:15:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34368 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeGLQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:15:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so10858997plo.1;
        Thu, 12 Jul 2018 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=280g+RGAhxopkf5zYfi9U7OBxHSGkQm3DuoAW1Gjzrg=;
        b=ETxV/r8FKcaKgUk5+LMqbGdXd2DMo38UJIMZDUvLsno71eicDf5hvlKLdpcqIlB7FV
         Kl8BMQ9c9L2tdk/p/h2X4w3VunkNZLhm3Y9yAawHUi8uwOJzF86TbxSJS1qxlkPhFoK9
         l3XpBHqk2yatHuhR3KcMEXfOHjcwRDkh5kWBLy6MsgP2OYw5rLts57eziU6z14mAyRBg
         KYaVMECFF0fEcoJ8dyb6hElJZnnLrDc++ro+VDDwPksdzA87ff2mnHYHuKklTDCsN6hY
         +iOyXDb3cdHgSe6vxJR3OBrBg/dWEf3L01OXOAt7hqFlBIPSrykdMhQgt+Ez60ktuP2d
         OKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=280g+RGAhxopkf5zYfi9U7OBxHSGkQm3DuoAW1Gjzrg=;
        b=e9Km2L6Av2zfOqPxx6hWdAggCWIVmNeQlLUVx4EjNB1J0ICQB/UiDbNUb4FgD5cra2
         50CLOrD6D0EvGgghaTS4u17DzsbpJhg+S+O/Z4304Pk9/x/op2RfiKsXaK6EXTnkfOvj
         n1srMEPU+GdeHCYIHJGNlztx99YY2FaXK65H6NlhbnPnxssAZPfsrfc21VPV4iplhYPG
         oIG+MYTEAhPSG7jAMGm16hviVkwwhCRAId7DiTk9FwxTxcmJBaYO+9rVwp2jP9gqM++E
         rcAD5Zdztn+icnCmUNCFrJ0staY1PuCfzBjdUqNaAJnVqMD6dcBJYPAUHgYp0D6lgwX1
         KSPQ==
X-Gm-Message-State: AOUpUlHb44QeNqNqk7FeuL2tvaQpAzL00ca1rRqrnJwPkJ8LAoaKBb7T
        mGAGC87rYrjitt+PUhDdaNU=
X-Google-Smtp-Source: AAOMgpcyZs9Ljx8UStnE6p0RqwtoOPs4K1yyyyUPB4XPYXBUFE7l+DhHgg2KsuBdvWM3XClIT/gLfg==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3-v6mr2739641pls.322.1531411521717;
        Thu, 12 Jul 2018 09:05:21 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id o3-v6sm32641276pgp.3.2018.07.12.09.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 09:05:20 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id D0F63200465; Fri, 13 Jul 2018 01:05:18 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     corbet@lwn.net, netdev@vger.kernel.org, j.vosburgh@gmail.com,
        vfalico@gmail.com, andy@greyhouse.net, linux-kernel@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] bonding: Fix a typo in bonxing.txt
Date:   Fri, 13 Jul 2018 01:05:17 +0900
Message-Id: <20180712160517.7382-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.18.0.96.ged843436dd49
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in bonding.txt

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/networking/bonding.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/bonding.txt b/Documentation/networking/bonding.txt
index c13214d073a4..d3e5dd26db12 100644
--- a/Documentation/networking/bonding.txt
+++ b/Documentation/networking/bonding.txt
@@ -1490,7 +1490,7 @@ To remove an ARP target:
 
 To configure the interval between learning packet transmits:
 # echo 12 > /sys/class/net/bond0/bonding/lp_interval
-	NOTE: the lp_inteval is the number of seconds between instances where
+	NOTE: the lp_interval is the number of seconds between instances where
 the bonding driver sends learning packets to each slaves peer switch.  The
 default interval is 1 second.
 
-- 
2.18.0.96.ged843436dd49

