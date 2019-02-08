Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC532147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bL5jgRox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfBHIEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:04:52 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:34773 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfBHIEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:04:52 -0500
Received: by mail-it1-f182.google.com with SMTP id x124so7928788itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 00:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ufDAy2oAX/EqvaxJnTOOBml597qgVOQCxkiW7B+Jgo=;
        b=bL5jgRoxD8+hLoZj5dVoJP4VoABqt8Zc0M8ElyPaqVuYlc/718/fCGzHZs0+8UNxug
         hcATpfBF279df+iwr1i5zcM1Q7doH39YMkNxiPu0uZm9Db61MbRoqOJdcrwIp+AuGlCL
         hcBynm9jv6QrA4J4PYQMO/RHfv6dNE/yaY3XH04eGc1erNsUTjUnXy+fCeCSKl2HQghF
         9NW9bYk4e6zXLEZSVRIYY8jdNn+0zP8TGvqbQiVx7YpxcW7lu/hJvY6sfBOBNdmmKFqk
         wV697YSajeZ4PDD/vE9f/Hr7YUDx4RNin05TWDMbFn83VisZPn+fAGF0L6gVhgct0qUb
         MTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ufDAy2oAX/EqvaxJnTOOBml597qgVOQCxkiW7B+Jgo=;
        b=NvnDKlxPFicz84YkbNVqL/ueumnoWXzRK5ser91msWFGKEVMpK+IW6234AHjPc+DSq
         +GAUetHt8LaXx8L3vqMd4qCsIN4VV8a5q60AM197XjMu5kEb5mxRekGnNU7RpeSsjm4m
         RJgxOS6owrQIqqn0uPIKQt4F7uwXLOPnMdTOCd6asZpgiury8NOh6wct9jOdff/vehuh
         m3h/wDU+in1tv/U8bYApnREZcz53gt4OLRIwJThcS/tqZJw8rF0TRBq5QREsd8ciPmWc
         SOYBWh3uNQc3xrNOFYnqanPH8VOMIcIltMiUDig9ZWBfh5UVl9pcLHL/34QNJXqUNcRC
         ufjA==
X-Gm-Message-State: AHQUAuZJOJAZQtrSmIzW9bUtNxMLJU/X3IR+rUND4DWNrY2Q4U5xtWCK
        q/ON4D1xWbOqZZrqn/tMgzu1ig==
X-Google-Smtp-Source: AHgI3Ibyi0G2GFUw+SfUbtJczpANr+GcvVeioZspaqeLqe0lPqZy2bWkse/YzGdmiCHi09vlK7CnNg==
X-Received: by 2002:a6b:dd16:: with SMTP id f22mr10548331ioc.148.1549613091568;
        Fri, 08 Feb 2019 00:04:51 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id t64sm978446itb.5.2019.02.08.00.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 00:04:50 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm: fix potential build error in compaction.h
Date:   Fri,  8 Feb 2019 01:04:37 -0700
Message-Id: <20190208080437.253322-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaration of struct node is required regardless. On UMA system,
including compaction.h without proceeding node.h shouldn't cause
build error.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/compaction.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 68250a57aace..be165b220996 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -220,22 +220,22 @@ static inline int kcompactd_run(int nid)
 static inline void kcompactd_stop(int nid)
 {
 }
 
 static inline void wakeup_kcompactd(pg_data_t *pgdat, int order, int classzone_idx)
 {
 }
 
 #endif /* CONFIG_COMPACTION */
 
-#if defined(CONFIG_COMPACTION) && defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
 struct node;
+#if defined(CONFIG_COMPACTION) && defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
 extern int compaction_register_node(struct node *node);
 extern void compaction_unregister_node(struct node *node);
 
 #else
 
 static inline int compaction_register_node(struct node *node)
 {
 	return 0;
 }
 
-- 
2.20.1.791.gb4d0f1c61a-goog

