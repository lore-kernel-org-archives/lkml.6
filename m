Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCAAC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D227420856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b958H3Dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfAXV4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:56:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42290 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfAXV4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:56:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so3668471pfr.9;
        Thu, 24 Jan 2019 13:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=epowUddj/jIwys53qu7/D5Bgdy2RfPX8yRH4tLWbNbA=;
        b=b958H3Dc2nge99o3IS0Z6Ne4zm+U59aXC6y2ODuAHO0/rV3bMsYicNWKiYsoaTejWp
         8mf/2PxDFDKfVsS1f6cpIhnVMMNzlQ9PED01ZyHVO/bwQX3WOJJD6XAKzroCxuEgjauT
         vH7BfqOuvpaQ7J7g+EF+CPAdtkg0xVaFdXnwXxrzN6yjqBO8lOaoNllVCw1rf72dFTfC
         uDahsBOqAUDmBmWbl9+jLOWahTCswDfNNcV/Y6GnSROvD6MyP5Ri6MQX1TLRqbqCyZUv
         I4WFLXKJBLpWxkYoLn48FRD2ObbKgEWkVP5AopiWHuNwkcN+LN4Hc3LGvPOnPF3mb93i
         3RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=epowUddj/jIwys53qu7/D5Bgdy2RfPX8yRH4tLWbNbA=;
        b=bpK1cGdsrPi6nTamNK8+yI0qGYyNMMXRd1+Pz+oaUU7n9lk18ZCBzR2LBfGutDUIqW
         4+JMbt6PE40bJBYH2zjPkI6q+xdqyHeV86XpibFgKuFTKMFUIXG+5R77P40mTiF4iE6a
         MqAAo2cLPYGWgCq3Be04xB4mL9Jy4xbkObqfM015wx2211EOrr2oRtlp33VwIcD/N6do
         8Gmn7YrKIElYP6qZJITpiL4gdCUdx0MaPw7iCCrd/Z5KvtNhvw2LogreZhdpQenuON6n
         dor6VN78X1htsYECziR3rRy2n9NuNk/nKaEVzpaE0Nalq+nlSGvJpIN++6O28j17yScd
         0HAQ==
X-Gm-Message-State: AJcUukffLhe0fXoa5MsHp1mpvQNw6CpBXYSIfp+Crf57aTq16fHUxu1A
        hlE+thtGo6fbv6oKHGF5ww4=
X-Google-Smtp-Source: ALg8bN46lgnLptKO0PL8uXC+aYgsxh6XR6PvmhoFyMLnGEri2BNCu19wGdJspAhNEOHB4SAG70xbyQ==
X-Received: by 2002:a65:6417:: with SMTP id a23mr7569675pgv.236.1548366967617;
        Thu, 24 Jan 2019 13:56:07 -0800 (PST)
Received: from localhost.localdomain ([147.46.240.179])
        by smtp.gmail.com with ESMTPSA id g26sm29122593pfh.61.2019.01.24.13.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 13:56:06 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 1/2] sched/Documentation/kokr: Update Korean translation to update wake_up() & co. memory-barrier guarantees
Date:   Fri, 25 Jan 2019 06:55:47 +0900
Message-Id: <20190124215548.4991-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20190124215548.4991-1-sj38.park@gmail.com>
References: <20190124215548.4991-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate this commit to Korean:

  7696f9910a9a ("sched/Documentation: Update wake_up() & co. memory-barrier guarantees")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt         | 43 +++++++++++++---------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 7f01fb1..4a6cf4d 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -2146,33 +2146,40 @@ set_current_state() 는 다음의 것들로 감싸질 수도 있습니다:
 	event_indicated = 1;
 	wake_up_process(event_daemon);
 
-wake_up() 류에 의해 쓰기 메모리 배리어가 내포됩니다.  만약 그것들이 뭔가를
-깨운다면요.  이 배리어는 태스크 상태가 지워지기 전에 수행되므로, 이벤트를
-알리기 위한 STORE 와 태스크 상태를 TASK_RUNNING 으로 설정하는 STORE 사이에
-위치하게 됩니다.
+wake_up() 이 무언가를 깨우게 되면, 이 함수는 범용 메모리 배리어를 수행합니다.
+이 함수가 아무것도 깨우지 않는다면 메모리 배리어는 수행될 수도, 수행되지 않을
+수도 있습니다; 이 경우에 메모리 배리어를 수행할 거라 오해해선 안됩니다.  이
+배리어는 태스크 상태가 접근되기 전에 수행되는데, 자세히 말하면 이 이벤트를
+알리기 위한 STORE 와 TASK_RUNNING 으로 상태를 쓰는 STORE 사이에 수행됩니다:
 
-	CPU 1				CPU 2
+	CPU 1 (Sleeper)			CPU 2 (Waker)
 	===============================	===============================
 	set_current_state();		STORE event_indicated
 	  smp_store_mb();		wake_up();
-	    STORE current->state	  <쓰기 배리어>
-	    <범용 배리어>		  STORE current->state
-	LOAD event_indicated
+	    STORE current->state	  ...
+	    <범용 배리어>		  <범용 배리어>
+	LOAD event_indicated		  if ((LOAD task->state) & TASK_NORMAL)
+					    STORE task->state
 
-한번더 말합니다만, 이 쓰기 메모리 배리어는 이 코드가 정말로 뭔가를 깨울 때에만
-실행됩니다.  이걸 설명하기 위해, X 와 Y 는 모두 0 으로 초기화 되어 있다는 가정
-하에 아래의 이벤트 시퀀스를 생각해 봅시다:
+여기서 "task" 는 깨어나지는 쓰레드이고 CPU 1 의 "current" 와 같습니다.
+
+반복하지만, wake_up() 이 무언가를 정말 깨운다면 범용 메모리 배리어가 수행될
+것이 보장되지만, 그렇지 않다면 그런 보장이 없습니다.  이걸 이해하기 위해, X 와
+Y 는 모두 0 으로 초기화 되어 있다는 가정 하에 아래의 이벤트 시퀀스를 생각해
+봅시다:
 
 	CPU 1				CPU 2
 	===============================	===============================
-	X = 1;				STORE event_indicated
+	X = 1;				Y = 1;
 	smp_mb();			wake_up();
-	Y = 1;				wait_event(wq, Y == 1);
-	wake_up();			  load from Y sees 1, no memory barrier
-					load from X might see 0
+	LOAD Y				LOAD X
+
+정말로 깨우기가 행해졌다면, 두 로드 중 (최소한) 하나는 1 을 보게 됩니다.
+반면에, 실제 깨우기가 행해지지 않았다면, 두 로드 모두 0을 볼 수도 있습니다.
 
-위 예제에서의 경우와 달리 깨우기가 정말로 행해졌다면, CPU 2 의 X 로드는 1 을
-본다고 보장될 수 있을 겁니다.
+wake_up_process() 는 항상 범용 메모리 배리어를 수행합니다.  이 배리어 역시
+태스크 상태가 접근되기 전에 수행됩니다.  특히, 앞의 예제 코드에서 wake_up() 이
+wake_up_process() 로 대체된다면 두 로드 중 하나는 1을 볼 것이 보장됩니다.
 
 사용 가능한 깨우기류 함수들로 다음과 같은 것들이 있습니다:
 
@@ -2192,6 +2199,8 @@ wake_up() 류에 의해 쓰기 메모리 배리어가 내포됩니다.  만약 
 	wake_up_poll();
 	wake_up_process();
 
+메모리 순서규칙 관점에서, 이 함수들은 모두 wake_up() 과 같거나 보다 강한 순서
+보장을 제공합니다.
 
 [!] 잠재우는 코드와 깨우는 코드에 내포되는 메모리 배리어들은 깨우기 전에
 이루어진 스토어를 잠재우는 코드가 set_current_state() 를 호출한 후에 행하는
-- 
2.10.0

