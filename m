Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_PH_SUBJ_META1,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136FCC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D047B21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiBUhlcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfAXIUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:20:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41635 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXIUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:20:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so2618323pfi.8;
        Thu, 24 Jan 2019 00:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsj6j3spPPJ0/iJPDuKxehm5TMJ8UMH8zK4n1PWs5II=;
        b=tiBUhlcqaGhEy9jYu0LIfgEuPmfuktdg+4ZCfp2/mdmnmLmSK5IMHlk/X8qm3h1v4c
         HUNiw2WWSeJvPaZXK7o5sz/SzM0jJh234DFxqx0WW6hWc6WDRqxuHi95HHCUzSvMLta+
         7uH+TPoeg0C/iBigq3gyHimDhPtAZH0Jl//J3TsigmtyyszlEv1Kf/F5SAoWlOL/2wVh
         +sbpZ5p58slMK72sFVXUW8+lYGcWKu2QYrshQcxL6RCmG+gQvqMsDHN5qdqPGkDmF7nX
         lqrKWI+rvdYjyPpzlnuQaP07aCwf9dTJnQtvx81bN1U4wQL3T8wsmM6knD4MlTntu8ff
         b0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsj6j3spPPJ0/iJPDuKxehm5TMJ8UMH8zK4n1PWs5II=;
        b=dyV8S0QiR0c1uXi0iUEK1U5BmH0V/repGf1Jc88WkZpZUDtIBmgQPUAGU716bofgz9
         DN1i+owsi7N8PX2JMlOc7GbJFmQUERJ/LTzkPCkpleKs7Vy4BrUB5kyXKQrrsRrrl524
         4tkGZggNHMGP95on3zxe5qBeWgi951/iUjzEYCqT4C79rpdBm6IC6fVNHegeTzwrR3v2
         zaReAlYu4wUaGPoTJJh7PtjEEuaaYIHgre8lXl322ZX1LXTPZJpGuvoLXMT0qNBGmkYr
         hccNgv4v/6TLaPRQnTcDu5K31PY2TefbRl6nkk8G46vcvai3wa/OTOYNbc95MF6gSMc6
         e/2g==
X-Gm-Message-State: AJcUukcll5rc/344lR6vcgjTqQFq7/ANiTRX7UrSKhPS5phyfgErd9wq
        SNueRUzYf9+YfjN9pLuhjqM=
X-Google-Smtp-Source: ALg8bN4Ml8wZ8ScftKN9ySLGpez6woEOUD6OMRwrLcrPA5C3P4sj2RjB3/zyqWiJgAJiUGcEVb4+pA==
X-Received: by 2002:a62:5c1:: with SMTP id 184mr5454459pff.165.1548318051701;
        Thu, 24 Jan 2019 00:20:51 -0800 (PST)
Received: from localhost.localdomain ([147.46.240.179])
        by smtp.gmail.com with ESMTPSA id 125sm31623378pfd.124.2019.01.24.00.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 00:20:50 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 2/5] Documentation/process/howto/kr: Update Korean translation to remove outdated info about bugzilla mailing lists
Date:   Thu, 24 Jan 2019 17:20:29 +0900
Message-Id: <20190124082032.32327-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20190124082032.32327-1-sj38.park@gmail.com>
References: <20190124082032.32327-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate this commit to Korean:

  bcd3cf0855c5 ("Documentation/process/howto: Remove outdated info about bugzilla mailing lists")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/translations/ko_KR/howto.rst | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index c8b0612..e88c426 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -370,15 +370,7 @@ https://bugzilla.kernel.org 는 리눅스 커널 개발자들이 커널의 버
 다른 사람들의 버그들을 수정하기 위하여 시간을 낭비하지 않기 때문이다.
 
 이미 보고된 버그 리포트들을 가지고 작업하기 위해서 https://bugzilla.kernel.org
-를 참조하라. 여러분이 앞으로 생겨날 버그 리포트들의 조언자가 되길 원한다면
-bugme-new 메일링 리스트나(새로운 버그 리포트들만이 이곳에서 메일로 전해진다)
-bugme-janitor 메일링 리스트(bugzilla에 모든 변화들이 여기서 메일로 전해진다)
-에 등록하면 된다.
-
-      https://lists.linux-foundation.org/mailman/listinfo/bugme-new
-
-      https://lists.linux-foundation.org/mailman/listinfo/bugme-janitors
-
+를 참조하라.
 
 
 메일링 리스트들
-- 
2.10.0

