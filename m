Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46F2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8009F208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnVAeZuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8009F208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeIYAXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:23:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50480 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeIYAXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:23:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so10762667wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osPdFj+6z7qk7EiqhmErk/SA8lAP0sfo6EwqLFqd/Kw=;
        b=LnVAeZuOBRmPOaSbqKCVLxNc2B47igUSqQytZYh56cSu8j0bC3dvfmq8kF9T+LytQP
         0QimpmG1XAwyCrKT6q7s9CNZ1ms7JmymaNIziRZfpOfolYFJf7AASePlRgEfn7HcDZ7J
         ydvLqDl4+Uy5Mi4mEvH9u/9wMPrR3xZmhsleqdX+zKpcMMgVpRfUWChspSNW51h0GASA
         uvP5TPx9yvKBqxek+/K0pGqQqJjW0vP97eXUJY9UdT60GKWhCLC4lAUOWFJNnmhs32wk
         Vfx3NGdZ1NfwvPVXF0lXgX+/0bWZhxJHvrNR8bK6jQF6jkJ58bcEdzRN7LMYf4MLBRkR
         qQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osPdFj+6z7qk7EiqhmErk/SA8lAP0sfo6EwqLFqd/Kw=;
        b=pyobg2tlc1/XPpKLNxKr6CUVBKCM+Z++TUgUeQuQFKezrlGIbh72l7JOFyoSVXAuhC
         YOyVWWI+sixrMQFeT9AhV1CC2RVJsl69L60KzF0WMYqNl59AuI6wLgYCtJ7X32LqObx4
         A+zdDkSLU7O72BgpwUykn8hGw9L5mXyt0K02HEQ5lybnJRwrylFszsQ3fJjj6co5RCpJ
         sLEMNl/JHt0qz5i9gKtIh1uwCJutzXqrJXC6R7VNJYgpajWYs1kL0ANE7ovLu2IeypNX
         fR+H/TWOxcYyg7kLQeyqyDpV+ITgv7Bdg5pRka0+kxEZCaHx9F6FKcvgzR4HR1eGcah+
         44Yw==
X-Gm-Message-State: APzg51CxuTwLTEt5623HwjLI5iFd4mfqCgQDL5+E0UAv5RjexLxXfAak
        0GrCfFJ1AwwrTs3EnJU9keCJsS2ozr7pbw==
X-Google-Smtp-Source: ACcGV63DYgKEDtvb1KuDOpRG9GDkA303scgCfQC/culYNWneIlZJJARbujDQtTRd3SG5ohFLuXdVXg==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr8105576wmd.18.1537813191567;
        Mon, 24 Sep 2018 11:19:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b74-v6sm24046510wma.8.2018.09.24.11.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 11:19:50 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH RESEND] ocfs2/dlm: Remove unnecessary parentheses
Date:   Mon, 24 Sep 2018 11:19:30 -0700
Message-Id: <20180924181929.6853-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when more than one set of parentheses is used for a
single conditional statement:

fs/ocfs2/dlm/dlmthread.c:534:18: warning: equality comparison with extraneous
      parentheses [-Wparentheses-equality]
        if ((res->owner == dlm->node_num)) {
             ~~~~~~~~~~~^~~~~~~~~~~~~~~~
fs/ocfs2/dlm/dlmthread.c:534:18: note: remove extraneous parentheses around the
      comparison to silence this warning
        if ((res->owner == dlm->node_num)) {
            ~           ^               ~

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 fs/ocfs2/dlm/dlmthread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index 838a06d4066a..074d5de17bb2 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -531,7 +531,7 @@ void __dlm_dirty_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
 	assert_spin_locked(&res->spinlock);
 
 	/* don't shuffle secondary queues */
-	if ((res->owner == dlm->node_num)) {
+	if (res->owner == dlm->node_num) {
 		if (res->state & (DLM_LOCK_RES_MIGRATING |
 				  DLM_LOCK_RES_BLOCK_DIRTY))
 		    return;
-- 
2.19.0

