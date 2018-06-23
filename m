Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8CEC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E7524AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqpUnpP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E7524AB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934686AbeFWCIa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:08:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38662 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934653AbeFWCI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:08:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id a1-v6so131948pfi.5;
        Fri, 22 Jun 2018 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vU/MvPt+9TYIFJx7qDogQZU54hd9iZK1XYJRUDwZa0=;
        b=GqpUnpP+J4mPz/Znhvk06l5fdQtLNPORKCBMl2fubcXlTMw3/AGg0glI98KqbcBGVE
         q5dwr+MDcZcaAv7QkjX/WB1bkpTgh4Gs3YXI4EFS7Cy71FiNThvdKPYlzwI7JqKpfSkE
         G94xKU75G7jiJZibWCg/VCvnsFvo48K6HNy7gtmVYX5Qe++o8H4S96pBKkTUmLf5EL1h
         40jvINp5BKYUllrweLrHJ35YhAuganKsJj2+7zTAljHIhg4qgkVUx+cfT8JV0aqpU338
         PVDdwc8WX+MPRCMoqWOTmRyk3Fex4gUCmC2MwzMGlf2ba+gslJovtCRWKL/KJE+mP4iN
         MAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vU/MvPt+9TYIFJx7qDogQZU54hd9iZK1XYJRUDwZa0=;
        b=Ys2ifHLZM9nOiOACMefXZdbbQA2pX7rQsGQ36ogqvsZZKS/+2TG3FJ9A/yj95cI6mh
         tYLWd0kW1I31+QDYIagqSAs7mYxOJ6J3aeE4SGWZ4VrWsJizEYdPOTh86LLwypPq96et
         Ksnq7bGD3WCqx3trYcAZWC50R7ZHTwT3Ny/xQjfLGobQhMCTbYLDunMEyY8/1XZArWG1
         IwGdDSTnEUs7HNrQJIN4xUFAtgTQm/bqQi4MgMRzz1m9/XrEki3ajecZlX7cmaJ+UbIy
         gT4DL+xTdK7/cX90toEAtV/TzllrVq5q6iq04uBYoLCU/ptRaRrpGdI+GXMAKUR+qUBV
         ZNeg==
X-Gm-Message-State: APt69E0iiVCcB3I2hug1RE8kFtU/XBM28HlNA20sZ+2Q8Im0jt81aVIC
        57lRrNLL2Html/d1v1cihAQs6WbV
X-Google-Smtp-Source: ADUXVKKOOUvFtS/2Gq7tUxBaejTRvEvh591+50Wqy4J+x9I2g4seQ/M40R2ba2s8I+Q0mdkDVF8oBg==
X-Received: by 2002:a65:4d08:: with SMTP id i8-v6mr3364460pgt.427.1529719706248;
        Fri, 22 Jun 2018 19:08:26 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id t6-v6sm10796978pgp.3.2018.06.22.19.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 19:08:25 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-crypto@vger.kernel.org, Stafford Horne <shorne@gmail.com>
Subject: [RFC PATCH 2/2] kobject: Fix -Wstringop-truncation warning
Date:   Sat, 23 Jun 2018 11:07:53 +0900
Message-Id: <20180623020753.27266-3-shorne@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623020753.27266-1-shorne@gmail.com>
References: <20180623020753.27266-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with GCC 9.0.0 I am seeing the following warning:

    In function ‘fill_kobj_path’,
	inlined from ‘kobject_get_path’ at lib/kobject.c:155:2:
    lib/kobject.c:128:3: warning: ‘strncpy’ output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
       strncpy(path + length, kobject_name(parent), cur);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    lib/kobject.c: In function ‘kobject_get_path’:
    lib/kobject.c:125:13: note: length computed here
       int cur = strlen(kobject_name(parent));
		 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is pointing out a bug that the strncpy limit is the source string not the
destination buffer remaining length.  Fix it.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 lib/kobject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 18989b5b3b56..15338e5a96f2 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -125,7 +125,7 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
 		int cur = strlen(kobject_name(parent));
 		/* back up enough to print this name with '/' */
 		length -= cur;
-		strncpy(path + length, kobject_name(parent), cur);
+		strncpy(path + length, kobject_name(parent), length);
 		*(path + --length) = '/';
 	}
 
-- 
2.17.0

