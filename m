Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5801FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FAE206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPnWPuCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FAE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeGQVjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:16 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45734 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id 94-v6so979437ple.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9R0fZXHvA6dRO6rGipkhbtrhhMhUZV5bWtE9katZt4A=;
        b=XPnWPuCmT3qbnQFkLgLu/kxq2zcyRKLsxPKm6y8AWJIesTotjAdMcwToaucuQRm1ao
         IOSxvOw78ONIsIBr+UsNe0ZJkV8C+nRcp89HMXusMzku4NiET1+fgsCjIsmlW4oPmw1l
         95aDEQ24W8cycMzXN3x64/B/WwMUd3vR3ly7sUHBM313bDyneoQWWjMWzfOMmJk4tm0t
         0RYjUvQ5nnJG1KKCmnm253/IX+0cA0/+nXsi2r3oMOS3BFi4lTunt5YBQv0wbacKuE+3
         E7P694ngECD4H81Fwz4Lq/3O7T8kJlOgOgLxbqsHTYYpPIzRUzhyT27J6CtdaCsAmAY6
         sssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9R0fZXHvA6dRO6rGipkhbtrhhMhUZV5bWtE9katZt4A=;
        b=Wfoycq7NJHldsglGKVO0kiwfVr+K4tnXJ1Hu/O/7TGIpSccf1YBzoEgqzyHY5B4M6I
         tp1Rdb0V/FsnM7SMZQgpn3519ISgbnwZC8BB2hzoYJZ9tjVrKXbWFc3l5zGLToqMJZ4d
         i8I/ziZxjBe6acWxNVofw/+yRfH6itjCD5NSitVJFOzphrtTzuIsDqmr0D/QzIpRzH5v
         tuvnhSuyt2TYV3717Yeul3TQCyuNu2Kaa1GAxKPQJJ/NOS8Xzz5vQa4l/9hGL8/MJ31y
         CuC/4SegmjV9VdJaq+Ov6VBuKlsktRLqCMJI0o6ZzewXPUJ9dRO73M+43aLIz/RoN8b2
         2VSQ==
X-Gm-Message-State: AOUpUlHiRAKdEGX3XYylRSz0Eh2N7wZRrg0jJdoVeWtH/FVg/rmOTWsz
        3cUJMgpH75cxhf+7T6A3+Go=
X-Google-Smtp-Source: AAOMgpeXx97IUmvv53Y/qNMxCtXkRyL+Jf0sVMItGpkoG47Spt6osp8E1sryEsFxYwDHfVHWbbpIDw==
X-Received: by 2002:a17:902:be07:: with SMTP id r7-v6mr3219681pls.124.1531861488429;
        Tue, 17 Jul 2018 14:04:48 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:47 -0700 (PDT)
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
Subject: [PATCH 03/32] staging: gasket: fix typo in gasket_core.h comments
Date:   Tue, 17 Jul 2018 13:56:43 -0700
Message-Id: <20180717205712.29495-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Grammar fixup in gasket_core.h comments describing struct
gasket_interrupt_desc.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index e51acadc0fc4f..94a5537bff2c2 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -56,7 +56,7 @@ enum gasket_interrupt_type {
 
 /* Used to describe a Gasket interrupt. Contains an interrupt index, a register,
  * and packing data for that interrupt. The register and packing data
- * fields is relevant only for PCI_MSIX interrupt type and can be
+ * fields are relevant only for PCI_MSIX interrupt type and can be
  * set to 0 for everything else.
  */
 struct gasket_interrupt_desc {
-- 
2.18.0.203.gfac676dfb9-goog

