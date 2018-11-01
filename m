Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D70AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADD3205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlXUmHHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADD3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeKBA6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:58:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37949 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBA6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:58:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id p7-v6so9150083plk.5;
        Thu, 01 Nov 2018 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gJYXUIiVU6VHe/DW0AFyzQDGYTSy34LRbMEV9eEYE7o=;
        b=ZlXUmHHQVH4qJ5pMbaCMt03Nn9u6RIHc1Tw5awP1Gj0IOC8Ew2jjYHU7lMp+CzhCbk
         xAk6oWWQ7C4vj5rx2dfetYjdVSUHlvO15ozZTEEAROIqO0WipWTG1WSfn7/s2E4bP5gx
         dZmCDSOoEx/gwyGZ6mZBud4lkjlBq0Nfx//1rOSd87ItkSduryAKQ4eBTOrOO++P9SFn
         3SLt7HwVnyGZK8sFAn4zFDUug4gynnceuA2dkVRa4zrzrWFMb1RO7gdTeZSH12IYLOt0
         dfD+ankDpN/U/NERum2ZLGNTSQziXFdipDIO7v4ZqSdUERn77BOeKYogtkJpbWn+MMdf
         sosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gJYXUIiVU6VHe/DW0AFyzQDGYTSy34LRbMEV9eEYE7o=;
        b=aKgCQtVPjLidpslh49pBUHzeufGmMT8EVO+1LCZs3OROj9qbjWXRm2c6EODfTOEHio
         dhknECshoEw441QkmmaamApJs8X36OBGh5BIberPrlNsUr+pwJvwfoEQ2SWcpJ18K016
         7Zy3WlIyqa72gQzCM5wJG3SFHk8xFIMzdmZc/BqzdwuAmUl8qW7eMVD/6c2/+OdW69Hc
         F/HBqQzSXMcHq7Q7PrTNkz1ySDceRqz0Xe7XhHXjsWwTV5/X9vwrSnZ5DR8SpUwlnCaU
         Qs+JD/+YW+N3wBp8T6H03W7BqQeXK1tNi0AjXPMCCiEbmx0o5P2GluXdt6SMGifqJ5vT
         mdPQ==
X-Gm-Message-State: AGRZ1gIY4BfCcKS9r6FoRsWF6h1CFN/X3Z93zUBlrjforFyZGM83MoqS
        FDFwPx9t1+N1ZzfQZ/b/sws=
X-Google-Smtp-Source: AJdET5dhS+ZJk6+Ph+atIfCC4jhqmzwxqFsmBTo29fKQWD3+vLs1+QzdlCK9BYW6rvR9Bf4i5Dj7Gw==
X-Received: by 2002:a17:902:82ca:: with SMTP id u10-v6mr7856554plz.146.1541087713442;
        Thu, 01 Nov 2018 08:55:13 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 196-v6sm65262004pfc.71.2018.11.01.08.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:55:12 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] tomoyo: fix small typo
Date:   Thu,  1 Nov 2018 11:55:08 -0400
Message-Id: <20181101155508.23383-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 security/tomoyo/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index d3d9d9f1edb0..badffc8271c8 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -106,7 +106,7 @@ void tomoyo_convert_time(time64_t time64, struct tomoyo_time *stamp)
  * @string: String representation for permissions in foo/bar/buz format.
  * @keyword: Keyword to find from @string/
  *
- * Returns ture if @keyword was found in @string, false otherwise.
+ * Returns true if @keyword was found in @string, false otherwise.
  *
  * This function assumes that strncmp(w1, w2, strlen(w1)) != 0 if w1 != w2.
  */
-- 
2.17.0

