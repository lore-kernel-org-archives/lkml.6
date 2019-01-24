Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18088C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82E021855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLBgtPhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfAXIUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:20:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46129 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXIUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:20:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so2603629pfe.13;
        Thu, 24 Jan 2019 00:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7+0rLgas8mzKJJDakwIpFKNN1Y9X2cNHTlvkHgqjDc=;
        b=PLBgtPhGwJGVwlxb2DfqY3kneg7JBOwmuAh9J5fxzTJU16jjwtBJgbaMoqqxoOZQXT
         n6rUnurQ8SjG6arRIrE1xJnVgH4WxLzWGEy0Vyo5oD6sAUHn/IR8eAk98zNY1EJyGZN+
         U6tJMehaOcqgRLtfCEAR9pFi1zclg+VRd2BOOQUxKtmj7PDLvmaG7T6+2s2fWoBtK91a
         l8BDrtaeF+lZ7dntY7L/1N5J31zbnfXwKWGLllAQX6/D8d7Z2G5u3DkNMmDN4eXqFQDr
         V6TQHXurfySjsT6sd46QNJgQ7WfN9CgLq3WmrG6yZp3vgjFt903dQeJa+CUCx0njPLZd
         Xycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7+0rLgas8mzKJJDakwIpFKNN1Y9X2cNHTlvkHgqjDc=;
        b=rqW3EIwLUa/jVCEal1/vkuNrRm0RjAhb6HXG0oLPsnPaLjzIw80E61jZFjN5aoafst
         58IZ2DJSVx/cOZpxCXDEsQuPcmpOeSbOnYjmLJM4ai0V+PNTlFEwgZBukj/U+qz3RLNQ
         OPM9TcbseFP1HUSmbTweTLGWl2RzzICwOSI4x+t8xYM9NuOOr0CSssrHe/2YLdG0/6wh
         hyR6yw6cT6rqbA0e1GvwHxaES+D4xayvi/tL8nX0E/EbpfdZHOw/F5Lpb0aIa9yklodW
         g/Y5CwEdjwWImoQPkRoO62H1rJuhjN+d7yrUWClFlt85xEaY6Frg7KAdNgZaWbZ4pYPf
         TY6g==
X-Gm-Message-State: AJcUukeiIMWaXmS4wqPa1O/zI7HHk0ant3M/r78JqV3zegkxBXgHS0AH
        1kpIpS6yXNB9vdRsJSKf2XxilYCi
X-Google-Smtp-Source: ALg8bN6WTg32Sjq0WtiIzmpaSokJrOft3k9VEVSdBXCfbf+l+OKHytuLoT2xdwl3+LhakWWAXqBGCA==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr5698027pfd.40.1548318049685;
        Thu, 24 Jan 2019 00:20:49 -0800 (PST)
Received: from localhost.localdomain ([147.46.240.179])
        by smtp.gmail.com with ESMTPSA id 125sm31623378pfd.124.2019.01.24.00.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 00:20:48 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 1/5] Documentation/kr: Update Korean translation to delete reference to the kernel-mentors mailing list
Date:   Thu, 24 Jan 2019 17:20:28 +0900
Message-Id: <20190124082032.32327-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate this commit to Korean:

  bc0ef4a7e4c3 ("Documentation: Delete reference to the kernel-mentors mailing list")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/translations/ko_KR/howto.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index a8197e0..c8b0612 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -220,13 +220,6 @@ ReST 마크업을 사용하는 문서들은 Documentation/output 에 생성된
 가지고 있지 않다면 다음에 무엇을 해야할지에 관한 방향을 배울 수 있을
 것이다.
 
-여러분들이 이미 커널 트리에 반영하길 원하는 코드 묶음을 가지고 있지만
-올바른 포맷으로 포장하는데 도움이 필요하다면 그러한 문제를 돕기 위해
-만들어진 kernel-mentors 프로젝트가 있다. 그곳은 메일링 리스트이며
-다음에서 참조할 수 있다.
-
-         https://selenic.com/mailman/listinfo/kernel-mentors
-
 리눅스 커널 코드에 실제 변경을 하기 전에 반드시 그 코드가 어떻게
 동작하는지 이해하고 있어야 한다. 코드를 분석하기 위하여 특정한 툴의
 도움을 빌려서라도 코드를 직접 읽는 것보다 좋은 것은 없다(대부분의
-- 
2.10.0

