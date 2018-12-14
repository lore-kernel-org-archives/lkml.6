Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5444C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB414206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2IL3MPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbeLNRfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:35:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36677 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbeLNRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:35:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so5241102wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVkhk/Z1tu1I1J0fx7xAnMt3CsRblPaCM9dkJ6Q4lss=;
        b=V2IL3MPF0gQSTTvMydtYyz28oi1/hyykGeEY+HJKM67wRQO/6RGCIdMd0qyUvIB5Gn
         SBsIwhOVG5N5SpSB07ZKpc42bSr0Yr1ZoUyDCoZsRT7GAm/k3ze/PR2ylEKF2TVxmgwJ
         99pUCHsFSJDHCV1kZJaIdmEkoVmhu3n7zGsW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rVkhk/Z1tu1I1J0fx7xAnMt3CsRblPaCM9dkJ6Q4lss=;
        b=LlVosTItH0RhfJic5CizbkiTBUXBsHC9qeTRcstzUyx4JVWFLkW/Pt1c5imrzEclqR
         umJqBoTXbrpVWeAeE8v8bpWVAVtQ33XD0iD9eszdThjwzlv6bApLauXtVMHzL5xZGILJ
         xW5bw3iujz06pqhyLPBS6mRmYixqDQpSusWF6HCkMNGSaSNsW/EYjwq8cAfqpWZvYsAX
         8rdapLaSzsaK/brCH3uoEHpIuhax5Bg78k93924Wpy+JNkG9gzt+a3qf0z3r2mQD9N1a
         LUHr+M7c+V1fpGLNBuZd0QQ/9OO1s2th726+uL3vlio4hpnbQj12oOhLvE6XyuhsmrCm
         sIEA==
X-Gm-Message-State: AA+aEWYS9c3otGix3sTPOwzqSwY6VYiB2Ha+ttRJK3Uc+6WTTVJNavrG
        Zq/PX/sOzzv5B7YXmIgV2gjs2dML0Go=
X-Google-Smtp-Source: AFSGD/V14GNqkZIYJnapMht0DqmjjEE1Cwx8t1R1c6e/YFW0o3szWeHuvXSy6A5jt0xVf/5nf6YTUQ==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr3447521wrc.168.1544808934344;
        Fri, 14 Dec 2018 09:35:34 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id 199sm6259772wmh.21.2018.12.14.09.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 09:35:33 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, joe@perches.com,
        gregkh@linuxfoundation.org, himanshujha199640@gmail.com
Cc:     apw@canonical.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] docs: fix Co-Developed-by docs
Date:   Fri, 14 Dec 2018 18:35:27 +0100
Message-Id: <1544808928-20002-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544808928-20002-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1544808928-20002-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accepted terminology will be Co-developed-by therefore losing the
capital letter from now on.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 Documentation/process/submitting-patches.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index c091710..30dc00a 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -510,7 +510,7 @@ tracking your trees, and to people trying to troubleshoot bugs in your
 tree.
 
 
-12) When to use Acked-by:, Cc:, and Co-Developed-by:
+12) When to use Acked-by:, Cc:, and Co-developed-by:
 -------------------------------------------------------
 
 The Signed-off-by: tag indicates that the signer was involved in the
@@ -543,7 +543,7 @@ person it names - but it should indicate that this person was copied on the
 patch.  This tag documents that potentially interested parties
 have been included in the discussion.
 
-A Co-Developed-by: states that the patch was also created by another developer
+A Co-developed-by: states that the patch was also created by another developer
 along with the original author.  This is useful at times when multiple people
 work on a single patch.  Note, this person also needs to have a Signed-off-by:
 line in the patch as well.
-- 
2.7.4

