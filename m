Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD223C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A32321855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbQkg16P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfAXIVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:21:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34972 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:21:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so2636117pfi.2;
        Thu, 24 Jan 2019 00:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0y1ezL9X/SIUgFdkrB4elxMQTqNblnhcJB9m76gUSaM=;
        b=EbQkg16PB7kARzTvW1R18r0nA/Lt1GH1mks3yVpOr/PnsKgva6Og/9uDWG5/XvpE3X
         Lf8dJpMLKUQqklA1zqu9lyz35HoLMPqa2cR9R9K/mYnT20kKWf0lANEbl66y6PcZvw7w
         MeOCzPDkQNEE/Od4Jg0H7AP3b8Jb7Rje8DQWTAvDwrpp4vFdnFh7WPchO4CloARQ7hLP
         dKuA9B7N75n5jiAvJdqOBugJJvhn3EhNc6EYmLdUSEQCe/rJWCJwmmd1pD0MPKBEtatQ
         6JpGJ+WWq/PF8zWblbwA8SwhPTYikN+HtbAe8ZzJuhn3JXnKnaOoKbxBd/NAIlnbW5/R
         MFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0y1ezL9X/SIUgFdkrB4elxMQTqNblnhcJB9m76gUSaM=;
        b=h4Xve+/vHYpWPEB7QXHmiU40+yD0nWUNdiC5ak0IwhZf8JmWQLSrD5SVBDlKpVLV66
         0YJKFt2jfPEjpEohxZc6CnP4+dzxwvm8iGzHLpb9/b6tvTvcHxtk6QxajVLuiImXTXDk
         gGgSXoUpLBA65fHs6VMLSVyUQEUYLtRoyHKqYrPccQXZPmbGAsTLA1Wz4RdmyA57dET/
         ETnHcJ50nDYejxnK0n8CF1v3az54LrWp2qJya8vrmeQmZN4wx9lkjoVMO7Hc6ifwmB9m
         ds/Lok+wRLfqszOqOlJe6O7xF5Y/vJMhdpJsKMuNsIW1DVy938NmZTVG3b2wxRkGjpvp
         b8UQ==
X-Gm-Message-State: AJcUukcN+dblp0MkZ0mYJGv5KlyP7WxfqfrZQpu1mHRo4SuEiZGEl6ez
        3eLtkr28ZqK9cjQiuIi/9CI=
X-Google-Smtp-Source: ALg8bN5a3L74lBlg1shkQDMc7YrpzWADC4QopioNqMdCSQmhtdS8pZaMn7ZlJXg/tA+ZxIupGXifbg==
X-Received: by 2002:a62:d885:: with SMTP id e127mr5473236pfg.197.1548318075589;
        Thu, 24 Jan 2019 00:21:15 -0800 (PST)
Received: from localhost.localdomain ([147.46.240.179])
        by smtp.gmail.com with ESMTPSA id 125sm31623378pfd.124.2019.01.24.00.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 00:21:14 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 5/5] doc:process:kokr: Update Korean translation to add links where missing
Date:   Thu, 24 Jan 2019 17:20:32 +0900
Message-Id: <20190124082032.32327-5-sj38.park@gmail.com>
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

  f77af637f29d ("doc:process: add links where missing")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/translations/ko_KR/howto.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index cfd6a42..1525243 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -298,9 +298,9 @@ Andrew Morton의 글이 있다.
 4.x.y는 "stable" 팀<stable@vger.kernel.org>에 의해 관리되며 거의 매번 격주로
 배포된다.
 
-커널 트리 문서들 내에 Documentation/process/stable-kernel-rules.rst 파일은 어떤
-종류의 변경들이 -stable 트리로 들어왔는지와 배포 프로세스가 어떻게
-진행되는지를 설명한다.
+커널 트리 문서들 내의 :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
+파일은 어떤 종류의 변경들이 -stable 트리로 들어왔는지와
+배포 프로세스가 어떻게 진행되는지를 설명한다.
 
 4.x -git 패치들
 ~~~~~~~~~~~~~~~
@@ -355,9 +355,10 @@ https://bugzilla.kernel.org 는 리눅스 커널 개발자들이 커널의 버
 
     https://bugzilla.kernel.org/page.cgi?id=faq.html
 
-메인 커널 소스 디렉토리에 있는 admin-guide/reporting-bugs.rst 파일은 커널 버그라고 생각되는
-것을 보고하는 방법에 관한 좋은 템플릿이며 문제를 추적하기 위해서 커널
-개발자들이 필요로 하는 정보가 무엇들인지를 상세히 설명하고 있다.
+메인 커널 소스 디렉토리에 있는 :ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
+파일은 커널 버그라고 생각되는 것을 보고하는 방법에 관한 좋은 템플릿이며 문제를
+추적하기 위해서 커널 개발자들이 필요로 하는 정보가 무엇들인지를 상세히 설명하고
+있다.
 
 
 버그 리포트들의 관리
@@ -417,7 +418,8 @@ https://bugzilla.kernel.org 는 리눅스 커널 개발자들이 커널의 버
 "John 커널해커는 작성했다...."를 유지하며 여러분들의 의견을 그 메일의 윗부분에
 작성하지 말고 각 인용한 단락들 사이에 넣어라.
 
-여러분들이 패치들을 메일에 넣는다면 그것들은 Documentation/process/submitting-patches.rst에
+여러분들이 패치들을 메일에 넣는다면 그것들은
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>` 에
 나와있는데로 명백히(plain) 읽을 수 있는 텍스트여야 한다. 커널 개발자들은
 첨부파일이나 압축된 패치들을 원하지 않는다. 그들은 여러분들의 패치의
 각 라인 단위로 코멘트를 하길 원하며 압축하거나 첨부하지 않고 보내는 것이
-- 
2.10.0

