Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EC8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0BB208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wms9i64O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0BB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbeGQCko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33736 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732175AbeGQCkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:42 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so16091664plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AdYEwXDGkNEwJ0tqYsKpIFDGS3s4cMRgcqWzdwqu4Yc=;
        b=Wms9i64OOAPUJHPY3eUQmww9qQ5JCWbob+TwA93R+jqwgcLaDO4f9YjojH3VWXdBGf
         V9jboDWumkQheH5aNTkqqx6MKWtfmfp55Ufb0kABhGqXAHtC80LgiZmIKv568y/X/x3C
         qcAK65H+LkdaEG/l8lYfRhSBB5U6NqDMbVQclpKh6GepZ5Z8DWo3sGCKdQeXJS+kQntd
         PXtzj8a/ylUPOuJoL97XPdPFkQAGKvu7PphS/BOVj9qSzH9SG4rvaCBL07It06z+ho0G
         31rIO4Pr4ETXuEIq/gr6z+j66bBMB61kBNFdJ/72vZBQ5Tsjw9VH65oB+P9sgbBVb2SP
         YCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AdYEwXDGkNEwJ0tqYsKpIFDGS3s4cMRgcqWzdwqu4Yc=;
        b=htLXynnR3NCTuyVP9l6mtQ6nkfsA8CittzuJA5+BC0QhBeCMv5DA8PWXTBGunNPcLx
         LVYj+0KOQ8uOcDBDiLN6018mP7z2SOkeaogQvXD6wWik2Fy9g60XxMOp20gt6JtV1PhF
         I3A2Qe6i/EtgBuffCgRgE/v9n8bkfJwPR/OrhooqRQ8I9BN9SzVX+1vTecDmFV+mEoXj
         uMhwM4THCvSQAUnUw6s0yJoIOge1rQqnTYdUNkWv5F+DiqXMvE02dt8+GMQrzePb4wrt
         9AuamG2bgm/LBQHvRD5rFH2wHmG0QkNvd/AplgMSapRnHS/13HwhuhQFtjNfyQHIbax6
         ebOA==
X-Gm-Message-State: AOUpUlGg7iHMTju9BcAwuhndE28MkvcOOJlbBibuBiLpDHitagArrZUZ
        2+aBjobumPr3ytwvbF+WBGQ=
X-Google-Smtp-Source: AAOMgpe+8H9xQ/uPL6EAiGCMgz32AZFHtf1ZOczRMxQlT7LUk9pFhhAv1+MTPgaEv6mlLQ2zr4YLRg==
X-Received: by 2002:a17:902:d70d:: with SMTP id w13-v6mr19114482ply.40.1531793432283;
        Mon, 16 Jul 2018 19:10:32 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:31 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 32/32] staging: gasket: fix multi-line comment syntax in gasket_core.h
Date:   Mon, 16 Jul 2018 19:09:26 -0700
Message-Id: <20180717020926.176408-33-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use consistent kernel-style multi-line comment syntax.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 68b4d2ac9fd6c..c23764e8b8d91 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -54,7 +54,8 @@ enum gasket_interrupt_type {
 	PLATFORM_WIRE = 2,
 };
 
-/* Used to describe a Gasket interrupt. Contains an interrupt index, a register,
+/*
+ * Used to describe a Gasket interrupt. Contains an interrupt index, a register,
  * and packing data for that interrupt. The register and packing data
  * fields are relevant only for PCI_MSIX interrupt type and can be
  * set to 0 for everything else.
-- 
2.18.0.203.gfac676dfb9-goog

