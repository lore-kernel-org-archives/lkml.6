Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F74C282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87CA20873
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4GgAGyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBJS7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:59:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37715 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBJS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:59:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so7431210wmg.2;
        Sun, 10 Feb 2019 10:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+eMmTfwODzLvEzByWZTx/8AnGc8y+MNL0RRcXP1LEg8=;
        b=M4GgAGyULVPB7dmqx5J9Pp/R/mIN6X+hENLJV4/it7SZFvW72YYTEgyu3d/kHb+GuZ
         8QSrZshLy/eJcdZc3H8gQme5/mqutxfLZmNLjZoVwK7MqnFePiGvJ8DpPLUWXlg4qnb6
         sJMT+wqhtivzPYXCKsQZO8Na0Cp80KBQQLoilt8tcnyhQVGhrUem8LgMDkdhVfXoeekz
         x+RuhkgAUX0j1+mWFmJt+64174ZuwjM+pGdGASEjlXTmS4Rd/UvfRHQ31OOYVx5bq4Jy
         uSf93Uwqkj7dyPcgGF4fovNfnWDRlEtRW195b/WE46//w/qeuocjpr0LurRf56/Ex5Rl
         Fn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+eMmTfwODzLvEzByWZTx/8AnGc8y+MNL0RRcXP1LEg8=;
        b=Rog5KU7ncsM5vyY5j3egd5I4GLFT7Fi6CdmKoDmtxLIE3Omdrsymj+yAM/mKdtqoSg
         BYH6sz6F6Xy/B65Lcnn0uQ70qxxZ8T4ujxZSrfxPh/C3n4XvK51s4fSRN1U0V4kqeBdS
         rlgQ3j0os9dfKjLqrOYZrlcXHfj0rlxrPUtjNssITrAn9Sie7f+EUU3ReVMtu6/pqpro
         //Y5A+OwORo0qDk+6sznSWmkTRN2jTshQv143ePQbWJpCUZiLq5ZFikpcveD3m5X7Klj
         MA6HMBAwplaeQegXojm0jSzGnTsH4PIg/BNzvqBWSIU9BXZqlI1F5sSV+g+/c6/ONOL3
         ObGQ==
X-Gm-Message-State: AHQUAuaIqo0wqMPx01PS6y+yRg937pfbNsRX+1kRIcfdzh8XEsI3BCOY
        uSJILRwgO8BENl4u6wLtlKg=
X-Google-Smtp-Source: AHgI3IbI4PbHMUGf/R5I2VipxwbYk+lDXfL3lyiwh1DePK0lhELgY9/37yADQOpiNIy/gHBYugMpHw==
X-Received: by 2002:adf:dd4b:: with SMTP id u11mr13872385wrm.307.1549825171187;
        Sun, 10 Feb 2019 10:59:31 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dee:9f00:2436:5653:8de5:2886])
        by smtp.gmail.com with ESMTPSA id k23sm7234584wmj.32.2019.02.10.10.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 10:59:30 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>
Cc:     paulmck@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify two issues in KEYS-TRUSTED entry
Date:   Sun, 10 Feb 2019 19:59:16 +0100
Message-Id: <20190210185916.9915-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
further maintainer to the KEYS-TRUSTED section entry. Paul McKenney also
introduced a typo in Mimi Zohar's email address in the KEYS-TRUSTED section
entry.

The two issues were detected when writing a script that parses MAINTAINERS.

Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
Fixes: 1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mimi, please pick up this patch instead of
  "[PATCH] MAINTAINERS: use tab instead of spaces". Thanks.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf4965d6d5de..b4b62ea78eeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8405,8 +8405,8 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-M:	Mimi Zohar <zohar@linuxibm.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
-- 
2.17.1

