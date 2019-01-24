Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2934D218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjgdqPfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfAXIVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:21:12 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:36739 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXIVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:21:12 -0500
Received: by mail-pf1-f181.google.com with SMTP id b85so2634005pfc.3;
        Thu, 24 Jan 2019 00:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZqSg3FLQvq8zQAX5OOhRSRqEPsnNMNre/T1/V7/m58=;
        b=BjgdqPfLgfjBNULlnSHrzZ5NL/LJNBx+Pf54h6qNDJ3DL2yDIKEgfU+v+glQGFyXG8
         GR8Ib6JHtwKsALfILN6T0Oi+mZ9ybDwaXBhD5khz0Fzz6CokSrW9VKwfV/t5FDHuNBTL
         GABWk0phazrlleGEdmD6o7jdimaqvJf43hUHaDfdxMynpLHV3p2g5jGdtd/EymjivdhL
         1qK5qFg1eqylAsfZZPmFaQF+Gtjx29gfRVuGpNXV1UvQmASPyeZVTsLgxEyD7SWEnOJZ
         xv4ZV/WS3irvKJdjUYfSjuxCcL5iB04Qe3En3niPWetXBLtUnhK1amkq6+BwJSOimWAL
         Dm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZqSg3FLQvq8zQAX5OOhRSRqEPsnNMNre/T1/V7/m58=;
        b=g/34qjnSUDfHlYhZWZ/nlbF98rXDrwz+uaksCxBw26VDWqbP+/Z48jBOejv3Ii+v6S
         WZ8cufjgNb4tCS1WXloUKcNQAg38qTbDRg7CIJw2Qp5RSSl2xBe0VD5BjDq/VQg8VFKt
         oyQ+OBqkXsdtPeceNIXU40nQbjgPXY0IZN2PqR0XKgnOyCa4UJknX2qjXSclPyCBbvU/
         cYF+bnvEioQ82ZsChNYbwukZvCYewQOY7m8M3JnyeofUV0ZKmQyUgQMH6L45xaimNwaP
         g0PjgY7plF2D9GVYynWJdbFccsVAZzkIru654h5xlJ0m4qKlRCzW1V4ACCkgDfzyW+7K
         B9zg==
X-Gm-Message-State: AJcUukdcid9o36qHbLcmFvTbxihxwkMSUCT0NwIwgooGwhgCzbGMcHR1
        D9A/oigUDXbO36N+ydrj5hI=
X-Google-Smtp-Source: ALg8bN7FAd6xxv3MSPaTsdsStJeL9WyH3srWMniCcZ7FB077ve19tpKJ7UWrhUXol4+h/SE2O5kpxg==
X-Received: by 2002:a63:66c6:: with SMTP id a189mr5092496pgc.167.1548318064228;
        Thu, 24 Jan 2019 00:21:04 -0800 (PST)
Received: from localhost.localdomain ([147.46.240.179])
        by smtp.gmail.com with ESMTPSA id 125sm31623378pfd.124.2019.01.24.00.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 00:20:53 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 3/5] Documentation/process/howto.rst/kokr: Update Korean translation to add a missing cross-reference
Date:   Thu, 24 Jan 2019 17:20:30 +0900
Message-Id: <20190124082032.32327-3-sj38.park@gmail.com>
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

  dad051395413 ("Documentation/process/howto.rst: add a missing cross-reference")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/translations/ko_KR/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index e88c426..bda7a4f 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -99,7 +99,7 @@ mtk.manpages@gmail.com의 메인테이너에게 보낼 것을 권장한다.
 
 다음은 커널 소스 트리에 있는 읽어야 할 파일들의 리스트이다.
 
-  README
+  :ref:`Documentation/admin-guide/README.rst <readme>`
     이 파일은 리눅스 커널에 관하여 간단한 배경 설명과 커널을 설정하고
     빌드하기 위해 필요한 것을 설명한다. 커널에 입문하는 사람들은 여기서
     시작해야 한다.
-- 
2.10.0

