Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA000C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD732145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="LwmCSvIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBJUkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:40:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40638 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfBJUkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:40:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id q21so13058372wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 12:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kMlm4HooTv+GyLTPfGIznx4zs0ZqaH0SmXHaoP7Df0=;
        b=LwmCSvIAdJa70xR3s+/JbmIA5lYNVr5TUrJxx5a9/OLJKECeDIC2pnQndlN2Wqf2Tl
         XqKmsHn5DM6tVDp/gj9KSnbOp8psjrV5HTk7D9Rl2e1Te0gAFCrqK8Qs8K7KdyvmhksR
         ZL/VhK61xb1t2mVSdw2sBHtNSIJoQFI0GwosnYyAuSCXc7FQxek4PGZHfl5F67hF+HhG
         3s0u5rXEmu7x/Y4aDFaRBoWDPAfygOsQYyjR0RdAOCrb8w5z51YF5eRktOWXwxs2Po7z
         Q+Ej25BCVOyaMh/EoGbNonYFZkfk4OKecyROHU2SbCrWKaJZw1wdajFpCmGil7Dl6F0B
         fcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kMlm4HooTv+GyLTPfGIznx4zs0ZqaH0SmXHaoP7Df0=;
        b=X8BOKX6l05Q9a0UQqaiX/xKu2JsVtEwnCI9FrEYY9nQ0OqsTgRnr07YlXbMA1hRFqO
         sYRA6TPbmyFvC2PsHCiNQq/OSOIpavV8/3KzsdVIn6zB2bIsEFSNyLbClCzFLbZZnCIM
         elvTdJwzp4wdjZiPQUzMV7FjQWNFtoHeX5D9paueS63/Uj7JDRmz53bCDxoUHUC0/QQR
         2vDWmIJFymEditz59jDMV6qbkpHlUVm5474CRDYkv/YTzuq/Wpq0TvM2Xd/a76KJeOJw
         xec3BBe15Sg+YC662MJTGOAKkfXJYubXnvOb74sXE0aeAshQfOZMhTQgeW7fEpp38zAJ
         MZqw==
X-Gm-Message-State: AHQUAuZ1ZNbAJVauL0x3EMr+E7rAsydyxjI7Sq/MOYRc0TuiVYgzk4ez
        lyh9bI1cUiyXeV5LCikQGlacL9b3fhfoOw==
X-Google-Smtp-Source: AHgI3IYy7pi/JBx8I1qEUyavKg6omCWZ3EJKOHYuufY465ucFv8RQnwb/CmbSJwSnYjYuW2VuNXp0Q==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr13170961wrr.175.1549831202564;
        Sun, 10 Feb 2019 12:40:02 -0800 (PST)
Received: from localhost.localdomain (p200300EA6F14665209EDE1AF663E9C0B.dip0.t-ipconnect.de. [2003:ea:6f14:6652:9ed:e1af:663e:9c0b])
        by smtp.gmail.com with ESMTPSA id l20sm16469784wrb.93.2019.02.10.12.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 12:40:02 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [RFC PATCH v4 3/3] sysctl: return -EINVAL if val violates minmax
Date:   Sun, 10 Feb 2019 21:39:43 +0100
Message-Id: <20190210203943.8227-4-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210203943.8227-1-christian@brauner.io>
References: <20190210203943.8227-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when userspace gives us a values that overflow e.g. file-max and
other callers of __do_proc_doulongvec_minmax() we simply
ignore the new value and leave the current value untouched. This can be
problematic as it gives the illusion that the limit has indeed be bumped
when in fact it failed.
This commit makes sure to return EINVAL when an overflow is detected.
Please note that this is a userspace facing change.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
/* Changelog */
v4:
- patch introduced

v1-v3:
- patch not present
---
 kernel/sysctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c4a44b7ccb8a..516bc8a2812d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2846,8 +2846,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
 			if (neg)
 				continue;
 			val = convmul * val / convdiv;
-			if ((min && val < *min) || (max && val > *max))
-				continue;
+			if ((min && val < *min) || (max && val > *max)) {
+				err = -EINVAL;
+				break;
+			}
 			*i = val;
 		} else {
 			val = convdiv * (*i) / convmul;
-- 
2.20.1

