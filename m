Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45EFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6547220817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="XoArkwD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6547220817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeK0GiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:38:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35574 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeK0GiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:38:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so6645292pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=EPWuUd+x2kPCIYsDK0Z2g80+/62NeqJ7EF+4nwKQImc=;
        b=XoArkwD1xjJwiFan0yApqRw5lioRtizbjj0IEn0nIncZva3PjRro07l2HzCu796anP
         ISTH5jBQNJj08q/MVRITGJVdrcCnbS6aJK7AaiqyLI2GgWxV42PYzF7H3XXxnfqWqKj3
         AtfQcuIxKslRDtk7PJ1crJ5mxe45PgHInQeWeQrqIA+HAcIfZ+fcKmgD1DHtCT7S2Hn7
         fgccbRffKGzU6NEnjjZixR75T3lj82MBeLh/J6Z8d3LVLz5UXgKyVtTwbgvhYfnwyZ5p
         nK53bTcKaML7MjFxmWyMDCaLZyAL0XIp6l2i72kjIT6iXUsGY+O5X+bDb+F56wbj9TH5
         MXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EPWuUd+x2kPCIYsDK0Z2g80+/62NeqJ7EF+4nwKQImc=;
        b=swbiGY26B8KNq0/NNoiMQcT9662QbFpiNoRE/mJuds+FmbYyCv7wBRQgzsEt8Rw026
         ak6pxuR4EaKa2z/ZBPkV79qNrDDyrmRdZy/ZQbFX5Pr61J0H3mtUFlyViPcL/VbfgX9h
         zBxy+cyP7j26uCFRweieW7n/CY88hVFm/U7wSHlPHKIFQ83dJlUdOhTFr4IE45FwPACD
         jvoa1j7FQcHVjIyLP11jOdYfdj8kLmnWGXYZeBf1G1AlqXSVIaOfC3SeuWyZC3cfoAvF
         /Cuc7X4kuHaofJXyzTd0U3hy1MNl6r3SwRAns/e9tc0ivbBWqsFpQrD1bcQin73Ieu9i
         iu9g==
X-Gm-Message-State: AA+aEWbBzZsUCuy8ixAlFPrsZwhHobAC827TegdQu5m6MykM2UAV7ulT
        5UxOtRhyN1TvcPfaXgqjS05aqQ==
X-Google-Smtp-Source: AFSGD/VdkOTlWPWlGhQL68hH+hs4dFy4kJOeSGQnL7jH4ZgMvw9+yqkPhuO5lhgfgaAM/Eo89GUksQ==
X-Received: by 2002:a63:594d:: with SMTP id j13mr26128595pgm.210.1543261387874;
        Mon, 26 Nov 2018 11:43:07 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id g15sm4782167pfj.131.2018.11.26.11.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:43:06 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH] MAINTAINERS: platform/chrome: remove myself as maintainer
Date:   Mon, 26 Nov 2018 11:42:59 -0800
Message-Id: <20181126194259.2026-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benson has been maintaining this together with the rest of the kernel
team for a while now, so remove myself from the entry.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5a72848a3af..57764aa57437 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3547,7 +3547,6 @@ F:	drivers/input/touchscreen/chipone_icn8505.c
 
 CHROME HARDWARE PLATFORM SUPPORT
 M:	Benson Leung <bleung@chromium.org>
-M:	Olof Johansson <olof@lixom.net>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
 F:	drivers/platform/chrome/
-- 
2.11.0

