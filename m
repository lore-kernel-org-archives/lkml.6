Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AEAECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA1D208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEnuogFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA1D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeGMJ3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:29:41 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:48589 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbeGMJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:29:41 -0400
Received: by mail-qt0-f202.google.com with SMTP id o6-v6so33848219qtp.15
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=1Gt4tI+JHXDXKvbQHGRN/CnUgXAHIlyTa4h78DrHUEc=;
        b=IEnuogFbzqWXp/6eCbUFw8wFgvOOEwAFcu5fAIDqjisriV+o7F980CC7hax8ZPNhtu
         mK76JVIK1xfcbxRNyhCDmpd8v4YXiSuWyNUnCmC83kVo1YXYZvVgaQ/5l1j4zD/5orpp
         DxjOmTyQrqIzp3uU6DrXgwrsacLdxtNifUXoXUl9XSmpEXG9eEOtR1txeSF2Su5piZRo
         NF4JkVwPr6reeaU2SGVfvn0AyYc+F2uEEbVoR3bBLp33YYws31FMlBL2zO9K4To1O1E9
         fqdL53XRxEZnb8i2gSm6SqSjIoXUrc9H1vpiQOsovm8rqhDZtK7AquBJXkgmKnWmp0p1
         Me8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=1Gt4tI+JHXDXKvbQHGRN/CnUgXAHIlyTa4h78DrHUEc=;
        b=okFUECzm7UALDIwHL4VJ3Pn08PhMTikMt11gBd6nUNVhB48LCzFu1W53JjquLDN4kR
         bcVL1Bviu2HrTFHVsUPoN0cQU7upJZt+enFkZ437iVKir9bbEAtJmw/Q/H3soy+tPq5K
         SRzet3f8GPL4FgmZV62i+sg4iMcZavCHlMH6Z51Hpi87rcQx7VujFB5BjrS9eBAOGLO5
         nYCJnkETCaCsqwCe9szlN+xZwFBbhO/kiXJrQEi4nPa4+SWiAp3KxgwKlIi70unQhJBN
         YnrpSC6BOBmXudrz4SJTPiWS012sEOJYihI+H1BaGFn0SRoSHoP4RczKgVGvlKYaMQTv
         jURQ==
X-Gm-Message-State: AOUpUlF7vOUZZjAWRHZaf+Sm46hUVnOup8yePco1sArTAlFpc+2KMuX/
        67T9nbPCBoU2GIKWWb+gAX0ac+cNEI4=
X-Google-Smtp-Source: AAOMgpdqGXOe2oMv5CCKKux9I6WoQ8JHWkWSdburxNoQUsuiRzZMamZFGUwoS3EjbQz7h066zGJhGxHL+WY=
MIME-Version: 1.0
X-Received: by 2002:a37:a647:: with SMTP id p68-v6mr3028138qke.7.1531473354629;
 Fri, 13 Jul 2018 02:15:54 -0700 (PDT)
Date:   Fri, 13 Jul 2018 18:15:47 +0900
Message-Id: <20180713091547.231108-1-uekawa@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] ext4: fix warning message to output correct type.
From:   Junichi Uekawa <uekawa@google.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junichi Uekawa <uekawa@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output the warning message before we clobber type and be -1 all the time.
The error message would now be

[    1.519791] EXT4-fs warning (device vdb): ext4_enable_quotas:5402:
Failed to enable quota tracking (type=0, err=-3). Please run e2fsck to fix.

Signed-off-by: Junichi Uekawa <uekawa@google.com>
---
 fs/ext4/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ba2396a7bd04..1b90f619663c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5670,13 +5670,13 @@ static int ext4_enable_quotas(struct super_block *sb)
 				DQUOT_USAGE_ENABLED |
 				(quota_mopt[type] ? DQUOT_LIMITS_ENABLED : 0));
 			if (err) {
-				for (type--; type >= 0; type--)
-					dquot_quota_off(sb, type);
-
 				ext4_warning(sb,
 					"Failed to enable quota tracking "
 					"(type=%d, err=%d). Please run "
 					"e2fsck to fix.", type, err);
+				for (type--; type >= 0; type--)
+					dquot_quota_off(sb, type);
+
 				return err;
 			}
 		}
-- 
2.18.0.203.gfac676dfb9-goog

