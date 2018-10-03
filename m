Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1238AC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5FB20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GapjXN/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5FB20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJDAH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:29 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:57731 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:29 -0400
Received: by mail-it1-f201.google.com with SMTP id y142-v6so7779997itb.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0hc8fhyue6sTc8tk9WAxfdwnupZM459lyFxspzuX6jI=;
        b=GapjXN/4M4iCFk8Iudi2qUSGHCGS7cGPTcLgDhavuHS1bUP5Kp8pjLvAr6Ow6kY4b4
         8IYctgpfK06itqGpfGWKh1nldw4cl/krG+eLQhY4XEKB5Khhb0effIqjieI9osrI/gpg
         AJ0M2QlYiOCCeS1hyQ96QBlHBw8JuAIbmvSGi6tzOgyglFUPCmI0V6AhKZt4HstBjw3B
         6H2T5KsTdUTrng+NWGX6f4ZJmkccosFPc2RWp1qy3p4Jmcyrrc/pvZuZV34RoLvy3Obj
         sqTh+swMf7CcYUX1snElBCZG6MFsa9xP0kUCEsOEDvKQVhNeeKzZStwJJImdYCcWLd/7
         KSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0hc8fhyue6sTc8tk9WAxfdwnupZM459lyFxspzuX6jI=;
        b=qGL5JqndUryUrbcCvdvIXRSLMXCN54rudsanV9GrhHpjnhpfgiCOFHzeYMhS+LGKAX
         y4eJcdxXXbBY3eProlvYZEeL+zxfjrW1xXFEc4mfoM57TlT0g0GnOYHB77VUt+qvIdJo
         0LyFM2069jsbUaUcRQgMyb2lCKIRYmn73OmRZXfFlL81MSiB9tZFlRMNzZ1TYCZDoxXu
         vytDG4Us+i+rwEJoXpKOSMw7vVTJTMuz4RUTHZu7y9JYDTBezfpvOLsLij9Nq+DsyF6b
         OcciEbjeFdqgRK+gsUWYIm09nRbMVHh0rzw2zIxYDbDfaRAmJC8jFACXycQQnJG/aV++
         xlXQ==
X-Gm-Message-State: ABuFfohdgcFqr7JWAKSdo+cx9E3e4IsrUJmjIhYAYlMREUB/sOGCu8QV
        ELd5tcWWwQPyhlrkXvPdDkVwVn5R
X-Google-Smtp-Source: ACcGV61cfUvVGzSNKJbvOz48vKEPcSq/JCJGjL3yS76qXbVXC6gZFgSs9Ea+WX3jGg7bOWvjjVFdHMBm
X-Received: by 2002:a24:7f05:: with SMTP id r5-v6mr1983914itc.2.1538587090672;
 Wed, 03 Oct 2018 10:18:10 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:14 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-9-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 09/15] platform: goldfish: pipe: Move goldfish_pipe to goldfish_pipe_v2
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

This is the v2 driver. v1 will be added later.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/Makefile                              | 2 +-
 .../platform/goldfish/{goldfish_pipe.c => goldfish_pipe_v2.c}   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/platform/goldfish/{goldfish_pipe.c => goldfish_pipe_v2.c} (100%)

diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
index e0c202df9674..81f899a987a2 100644
--- a/drivers/platform/goldfish/Makefile
+++ b/drivers/platform/goldfish/Makefile
@@ -1,4 +1,4 @@
 #
 # Makefile for Goldfish platform specific drivers
 #
-obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe.o
+obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe_v2.o
diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
similarity index 100%
rename from drivers/platform/goldfish/goldfish_pipe.c
rename to drivers/platform/goldfish/goldfish_pipe_v2.c
-- 
2.19.0.605.g01d371f741-goog

