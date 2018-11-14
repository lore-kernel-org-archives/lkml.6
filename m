Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3075C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F7220854
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4zycAPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F7220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeKNQho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:37:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46112 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbeKNQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:37:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id s9-v6so7370472pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 22:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=a4zycAPQSIq8IwlDWCvNRb/yUaPsfFVHMk9mrdz8Fa/uEWbdzVSjTO/K/5b+/1wQmT
         nHF+MjK+Kr5rRMjiK4Q5cRGU6z505L2d1MbwzIlZHh7E8H4AdYC03AXYOqcabXPCLvd+
         +kd34zFXhsr2vw+iCy310qeCSH5y9NDZDnzqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=My0pCchSJMQgZvxQQmRzsIzMzp/HIyS6bOM/JbODrUdOYECGQjJa31lhTgLKsNi/dy
         gsQl+lSuM1DxtEK+J5yzP42AigvbosGxEsB3WFycIp54nqTO52Emq1PGTTqhts2nNvAX
         IJiM1SF0pOnLvm2u9RuaMUOegbClBf/g5ysXecCW3RwxEkrKYK/z+9K2zsZ+VYzYbsQ5
         z1VMMoadmAtnVnVG/ys+QsxzPxtZYn6Ds/LXlvkcqEHfkQMGLhXzHMgMdxxkw4yByrhY
         oa+y6h1V244b3Ug8QZump3Suuq/PTShiPsBJO/wXH2hX+esDgg3P8w/AM5+NNE03lO1c
         wxaA==
X-Gm-Message-State: AGRZ1gIT5XAG+cbJxaQDQTGp9W83ya02C5bb0u09v/YI3KnS8yWzVfYe
        jUH2H3v0tKhFE29QmWfaRO+05g==
X-Google-Smtp-Source: AJdET5foRMUwd5LbvH85DXTYpolVdmTx9fRIzdlZc7csvmQwA+UmkrlM/hbF2Yqa5yXj7R0tK3B9qw==
X-Received: by 2002:a63:ce50:: with SMTP id r16mr603407pgi.217.1542177352407;
        Tue, 13 Nov 2018 22:35:52 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id l26-v6sm39097318pfg.161.2018.11.13.22.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 22:35:51 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v7 5/5] parisc: syscalls: ignore nfsservctl for other architectures
Date:   Wed, 14 Nov 2018 12:05:01 +0530
Message-Id: <1542177301-25844-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an exception to the syscall table checking script.

nfsservctl entry is only provided on x86, and there is no
reason to add it elsewhere. However, including it on the
syscall table caused a warning for most configurations on
non-x86.

<stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 scripts/checksyscalls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ee3dfb5..cf93100 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -150,6 +150,7 @@ cat << EOF
 #define __IGNORE_uselib
 #define __IGNORE__sysctl
 #define __IGNORE_arch_prctl
+#define __IGNORE_nfsservctl
 
 /* ... including the "new" 32-bit uid syscalls */
 #define __IGNORE_lchown32
-- 
1.9.1

