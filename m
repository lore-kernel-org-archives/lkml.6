Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185B0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39E1206A2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp/te5gK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeLOI3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:29:22 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:42172 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbeLOI3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:29:22 -0500
Received: by mail-pg1-f169.google.com with SMTP id d72so3764870pga.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 00:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4C9O30ph4iDhXHzn6duFRQH5JuyzpQn9LSFeNwvHKoE=;
        b=Cp/te5gKn6WwOimL58R4oeWk/9JJi5tC+LzbfDlRSxEAZ0PIvGJ3Ub+wSohd/zhLY8
         ZM074wU5LP4pwIhXliDcznBjznL/kmIRJ9ctveVM8lpnFuKZYKoyF2czJoa+du7U347j
         EKxrW/M1n9SY5DIU0w2yvfMDzcagnjSGlMDp5FFEksh75S2SBrXvZCgjgaKgB6kcnM80
         r2BvPcQcepnyueBds1bkliSQC0ge+0GfwP/56bj0kLLoSRdEqYiRbn22TuC4WhIZzLCu
         f+mhIsn8uTdUu+qkDqTr0VsFeUnVPpLp2UJL29ImObdrnA+GDoI39gyIS+TOG/GKcsVu
         VZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4C9O30ph4iDhXHzn6duFRQH5JuyzpQn9LSFeNwvHKoE=;
        b=MADsAjr3qpRNZJ3Wx3b/jmWCDHx0t++wjAtFYJ94StYlaDViSYbMdbz5kI+UQFWYci
         UGX35tbwQj4seWnSGwbOMSFvfeu6xC6nqsszHLZQ6czxVkXlsZewdSlPvT2ugiv7eslL
         ofFaVLOeRTmd97qDgDTRA8yTLuFYGox225y786tC4QHlIf/bqMGNgF81xMb3s/SogeO/
         DmvBusbN6n9ix8ebi5iE2TkoQPjoKnXptqLrhsmow5EJ9GxMe/a38QZcjG+tB4i64XZy
         HgmSikXH+pYZ9Ghvl/U4NwQ2CwhyAyaZSdm++5P0ZG5cGm/cSPQvXNzjnIRGSmiDQ9P6
         BckQ==
X-Gm-Message-State: AA+aEWY2zkpeX8jtlkv6Wj1xIS/h+F9vV4u0yvPMXIhMuIPlkAz+0tMj
        dP5qpm7Imcjdk0Z7hKX5aoU=
X-Google-Smtp-Source: AFSGD/V9M0hm/gXwcxGx9fAQp2JZtZ/7Xcad7fT2wGBkhU+/qvFTTTpWEURMOB3xN2mnpEb98kG21A==
X-Received: by 2002:a63:f444:: with SMTP id p4mr5381734pgk.124.1544862561676;
        Sat, 15 Dec 2018 00:29:21 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 125sm15607454pfd.124.2018.12.15.00.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 00:29:21 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] mfd: rave-sp: fix typo in rave_sp_checksum comment
Date:   Sat, 15 Dec 2018 03:29:18 -0500
Message-Id: <20181215082918.26613-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caculated -> Calculated

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/mfd/rave-sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 2a8369657e38..26c7b63e008a 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -109,7 +109,7 @@ struct rave_sp_reply {
 /**
  * struct rave_sp_checksum - Variant specific checksum implementation details
  *
- * @length:	Caculated checksum length
+ * @length:	Calculated checksum length
  * @subroutine:	Utilized checksum algorithm implementation
  */
 struct rave_sp_checksum {
-- 
2.17.0

