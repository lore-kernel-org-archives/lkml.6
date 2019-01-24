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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F953C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6639B21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJhLi//E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfAXIVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:21:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34968 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:21:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so2636035pfi.2;
        Thu, 24 Jan 2019 00:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iorhLZLLsDhB9f5MxmkkDeb5s5PTZdyzV1OFU+XfKTM=;
        b=OJhLi//EDnvLThksOJ/bpjQiXbEjm5iL5/b+RmrYOWMPDLPihRbO9FBPedEb35Nbdb
         oeEZzJJyptVEWW6x+I/4wk+RV8KAL1W7NrJn/Wxx7+LIe2aimuwNJui0nrUziDBo8pHn
         a40z6/zZD22qJXR74V/THkVpyYkDyOxT9oppIya2npNUw1p81LWTE8k47hukNyQbPqmz
         F9N5U2yDKVkZ+nO3tYmoKshuucEH0rcNoLFf3Z1jdnWd40cIwppYG8gDd/1RJsQWbQB9
         gzqrRW3cfyXioLRkSr4xVgDuWsctTOxADRHwQxW1Yo+roTTZwjlF+R3fz+RATVYE0sVf
         q/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iorhLZLLsDhB9f5MxmkkDeb5s5PTZdyzV1OFU+XfKTM=;
        b=UbGnjMvEW2gJkS9NGfmOz1y1wRKD1tIYCEBgFVx3DaZA4ocPSVG7XKBvS0Zb9tzySJ
         kEvQkMpB1Lcet5LqfRm/RFvAPQK0Yias304900ZnycavusA4aVpv7hFKugUQwQe8lN6m
         pmPDKn4gAg6XsVss47mKBiZB8VxxLA/o9RBe6tB93DT3Qh04TvQT7+8uehLvvtSnicu6
         70pDbQXP6/gy0oL6WCX40BHDpuvNiBJHbnnheoGkKHSXZ1Hgr6r6qfI2XbNRljS2hc4T
         lnOsL60Dm8ZqpESdfun3x+tF2sAYMW2ot0fHZE+Y3b9gsBeaLvtKHFr8AJ6ye49f5AJc
         fRqg==
X-Gm-Message-State: AJcUukdabtALL1eiqk0ReBDDdvN2kQCfefEEMZFkGtlGuofHVEgLo4sl
        w4t2F4WUJTNUZ6ddh17JtCs=
X-Google-Smtp-Source: ALg8bN47eqTW532eRkneGhF2lNCAX5Uqp3RDSKZcBU2Oa6uSiusb/gO5SlrH3JyOd+cfthENX4yMnQ==
X-Received: by 2002:a62:c583:: with SMTP id j125mr5573281pfg.37.1548318073448;
        Thu, 24 Jan 2019 00:21:13 -0800 (PST)
Received: from localhost.localdomain ([147.46.240.179])
        by smtp.gmail.com with ESMTPSA id 125sm31623378pfd.124.2019.01.24.00.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 00:21:12 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 4/5] docs/kokr: Update Korean translation to tidy up TOCs and refs to license-rules.rst
Date:   Thu, 24 Jan 2019 17:20:31 +0900
Message-Id: <20190124082032.32327-4-sj38.park@gmail.com>
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

Transalte this commit to Korean:

  9799445af124 ("docs: tidy up TOCs and refs to license-rules.rst")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/translations/ko_KR/howto.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index bda7a4f..cfd6a42 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -77,10 +77,12 @@ Documentation/process/howto.rst
 
 리눅스 커널 소스 코드는 GPL로 배포(release)되었다. 소스트리의 메인
 디렉토리에 있는 라이센스에 관하여 상세하게 쓰여 있는 COPYING이라는
-파일을 봐라. 여러분이 라이센스에 관한 더 깊은 문제를 가지고 있다면
-리눅스 커널 메일링 리스트에 묻지말고 변호사와 연락하라. 메일링
-리스트들에 있는 사람들은 변호사가 아니기 때문에 법적 문제에 관하여
-그들의 말에 의지해서는 안된다.
+파일을 봐라. 리눅스 커널 라이센싱 규칙과 소스 코드 안의 `SPDX
+<https://spdx.org/>`_ 식별자 사용법은
+:ref:`Documentation/process/license-rules.rst <kernel_licensing>` 에 설명되어
+있다. 여러분이 라이센스에 관한 더 깊은 문제를 가지고 있다면 리눅스 커널 메일링
+리스트에 묻지말고 변호사와 연락하라. 메일링 리스트들에 있는 사람들은 변호사가
+아니기 때문에 법적 문제에 관하여 그들의 말에 의지해서는 안된다.
 
 GPL에 관한 잦은 질문들과 답변들은 다음을 참조하라.
 
-- 
2.10.0

