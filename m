Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5812C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD8A2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iP/y8MyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD8A2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeJQHrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:07 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:56810 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeJQHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:05 -0400
Received: by mail-io1-f73.google.com with SMTP id f9-v6so22691611iok.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aOdwwUuIBSYrb87g8bgBF5GxaXD8rfXvHJcd9fKQrvE=;
        b=iP/y8MyFsGmeSdqTp8obc/qxmgmmwf9LAObDYZtUylHVznP5XcuFzkpY8gv4WaAD0e
         L+btQwyLCtTxGnIse6dnkKY/36GGaBW9paJBnJ8t56dRi0Lza3SCKJ0ggJByY4ncyPJn
         bYFHjWGLxBoCZRo5cMXb+2ZiYOeivU7vz9Pzjh+I6QvydFhrsnz+FLlbSbSA20eL6ACz
         ROH0FnhfrLrPthtqwyxiU9xPDTs5vueFT2vNO6Wqqa/QVfkyI9LYXMrefxr0Xj+g/qkF
         vIqdH11a+uPoNd3j3DCR5mIPtRBQiSuHdaHYL8naDULXhd1L9Ljrd1ZDV/NstzLC/IXn
         UdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aOdwwUuIBSYrb87g8bgBF5GxaXD8rfXvHJcd9fKQrvE=;
        b=jyqqosTSJ1g9MX7QXwssuF6ysCJSBqN0EJ9AWssw1wlU6bYvNKLXzC/BzRmHPxgdKs
         Ts1VZ3CkYrNF2THMbe1tcaPtYCIDnABGLASRSAj98Dc4quw8x4Q9TnVDLAnkHMxXmn5Z
         ddrPhipqTfakfWtN7tdioPWKnmb19HxAQAgwDkEDtjWtTF4neLdaFEQ2Gh5464KPZJHm
         b+r5fCW24zn7RUUjkonxaZaWkxwtEhFzU6IW/OcEkcLw1pS3SHEBbFzD/EMXo2TIMvYV
         zVYY/6XU46ZCnsm4Wh06bDBRgLkXfPGC3sfdA5RRaoiJn5PHIc7VfkIXT7NDNAN9CbAW
         d4SQ==
X-Gm-Message-State: ABuFfojagv6XsfBtwHoZO1t3V/sXbRms1pmKxbG3PPC5op8tjOf0ij3S
        98sfQW6blgvA+jQvGWV1ncoSYqrxwWNSlklkUa7Yiw==
X-Google-Smtp-Source: ACcGV6200mvffJhOSAeesbf9j6TKPFpbmQQCP6h6Z/FAjTh6tgj7iDw357BsNkJb8O++l+p6080vLDr9Q7wrZbFtKCQf3Q==
X-Received: by 2002:a24:7f05:: with SMTP id r5-v6mr17838180itc.2.1539734056061;
 Tue, 16 Oct 2018 16:54:16 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:01 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 12/31] checkpatch: added support for struct MOCK(foo) syntax
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds struct MOCK(foo) as a NonptrType so that it is recognized
correctly in declarations.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 447857ffaf6be..9806f190796de 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -745,6 +745,10 @@ sub build_types {
 			(?:
 				(?:typeof|__typeof__)\s*\([^\)]*\)|
 				(?:$typeTypedefs\b)|
+				# Matching a \b breaks struct MOCK(foo) syntax,
+				# so we need to have it not lumped in with the
+				# types in @typeList.
+				(?:struct\s+MOCK\($Ident\))|
 				(?:${all}\b)
 			)
 			(?:\s+$Modifier|\s+const)*
-- 
2.19.1.331.ge82ca0e54c-goog

