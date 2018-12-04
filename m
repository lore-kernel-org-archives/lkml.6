Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9912CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C25320850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kae8pN6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C25320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeLDVsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:48:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42469 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeLDVsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:48:31 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so13124806lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 13:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vj6GT3eveI27j/Bj9yewPJUZgNmPQCpJLb+Kzh1op4M=;
        b=kae8pN6qIQf7+C8xB1YKuHzOVRK0ji3JfwVU2JHASb/GJHSYGOMBTaJdpmGqxnOb+s
         7+hXv2+fanc40KJrN2oniSVCIcj7S5pGsuPXWO5vNiOLVKaQXbb3iv7o9qbeqz+gjx7o
         FVqq+Rk+J3s1qf9LubyutMW+ui1sZm7ZaUPXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vj6GT3eveI27j/Bj9yewPJUZgNmPQCpJLb+Kzh1op4M=;
        b=ktnQQgf9+NPGqYva9iOoxgEuqs+pDn1qwnMDFYHtJ2/7vD4BT9SMX888IWxlJMPTJ6
         BzsUkrUyd6yUB5uP7Jx+qjtDKO4tAEhzNtcnbHDMeBGZxjG/7GbmqzCz2E5y+jOcyKaF
         IHmYTyJHb9H+HVijIhBjvBTRFTjiba0MTU6tsXnK6uL+50kT0A6aWdJWin8yeIac+Zlm
         dcFzISazlevJjuAr8kFFLVuWA85UyWgRkD5P53rC28rTYQbTn/q90fQ5fL6lOeCf9A/t
         NdvCTx8jbs9B/6y+yc3OzQdknVyDab0fPQI9VsWwcY+58omOWyCOpkIIF09F+Q7RHYrZ
         R+yQ==
X-Gm-Message-State: AA+aEWaoHK8X5LPPiHBJHsg1nRCKIYavWkCLM+uokPmrDSmfLhxGIJUr
        2aoZ26lwfX4EsEySXtXHsKwowA==
X-Google-Smtp-Source: AFSGD/WhXuusn9Nmd/jf2kT6fJya2Cd9tSpVPZWBzgKj4rVw2bnAw4dmUc3wLlM03+M7KjpCn+BfbQ==
X-Received: by 2002:a19:f89:: with SMTP id 9mr12577610lfp.10.1543960109427;
        Tue, 04 Dec 2018 13:48:29 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id f20-v6sm3393640ljk.33.2018.12.04.13.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 13:48:28 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     will.deacon@arm.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] scripts/atomic: change 'fold' to 'grep'
Date:   Tue,  4 Dec 2018 22:47:13 +0100
Message-Id: <20181204214713.5812-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some distibutions and build systems doesn't include 'fold' from
coreutils default.

.../scripts/atomic/atomic-tbl.sh: line 183: fold: command not found

Rework to use 'grep' instead of 'fold' to use a dependency that is
already used a lot in the kernel.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 scripts/atomic/atomic-tbl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
index 9d6be538a987..81d5c32039dd 100755
--- a/scripts/atomic/atomic-tbl.sh
+++ b/scripts/atomic/atomic-tbl.sh
@@ -180,7 +180,7 @@ gen_proto_variants()
 #gen_proto(meta, ...)
 gen_proto() {
 	local meta="$1"; shift
-	for m in $(echo "${meta}" | fold -w1); do
+	for m in $(echo "${meta}" | grep -o .); do
 		gen_proto_variants "${m}" "$@"
 	done
 }
-- 
2.19.2

