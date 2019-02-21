Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD78CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED332081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="HHFOU6Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfBUUaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:30:35 -0500
Received: from mx.kolabnow.com ([95.128.36.41]:28528 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUUad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:30:33 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 29542F87;
        Thu, 21 Feb 2019 21:30:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1550781030; x=1552595431; bh=4Fil7S3rxLkb6iSxt8dE1yoZYF+gUBuL+gX
        +VPDsKRc=; b=HHFOU6FmCZm4q5YQfDnoqsIFuHUlCpuwE6jXKWOMeNm+q5gMF4x
        9XzW1cPiqzLbqhuyHKChkE0QVepUbVpOf3MYtWdvNWGgCNp0+5+PENYW57M+QMaZ
        pjd30QQ6Gq8JIQOyuRoc8ZVlSJLwbXtKwrqLR2ViYUH5zMCpmHzKwBprQh/3SU4N
        lD4WhsSMZEL10ePw04SUKTb7e488NNfq1PSZw6vCb2s931DFiGQGjWDRYoZQ6sVm
        WXfVfvMi1fopugblDnOzWmf/jB6USpn2eb5C8h9icHE7au3p87X1pk8gNADf9vZR
        1luL75eR3upZ2o1+o2CTmJsfVZlpf3ALKYQo02EcYMdNfsqwr+f1f+rmhPwnQI6v
        qLg7eOfewkacfBnakT4Ydbc3tkCYf9mBYM2iMouWK1KIes0uQlmK8b5uDDVm25n/
        x9VJNr/DCn1yuSOf3/YyR4Erkfk/KF75IdbtSySBQzfJlJNlALP99mNZXDug26CT
        /wLHksE0JmhVrK9NU9vZrTyq09BMl1tAmuP2eJyFmoH1mfXJttXR+fyu29Wb7nhq
        pS5jp2lf/lFGnjOTP+YXt52QTBBf6emj7g4iD5Qm4We2UHiTulzpTglgTScH4IU0
        PzVCUgpA5UdERjRGjvrt7LgsGTjurncncZYp2RN5UF8SEXRnId6d6b8A=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mx46i5R0eAYe; Thu, 21 Feb 2019 21:30:30 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 1A02B179;
        Thu, 21 Feb 2019 21:30:30 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 3591925F5;
        Thu, 21 Feb 2019 21:30:28 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        SeongJae Park <sj38.park@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@zh-kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v2 2/2] doc: process: complete removal of info about -git patches
Date:   Thu, 21 Feb 2019 21:30:00 +0100
Message-Id: <20190221203000.10194-2-federico.vaga@vaga.pv.it>
In-Reply-To: <20190221203000.10194-1-federico.vaga@vaga.pv.it>
References: <20190221203000.10194-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch forgot to remove a reference to the -git
patches

commit 2c71d305caf9 ("docs: process: Remove outdated info about -git patches")

This patch complete the removal and update all translations

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/process/howto.rst                    | 1 -
 Documentation/translations/it_IT/process/howto.rst | 1 -
 Documentation/translations/ja_JP/howto.rst         | 1 -
 Documentation/translations/ko_KR/howto.rst         | 1 -
 Documentation/translations/zh_CN/HOWTO             | 1 -
 5 files changed, 5 deletions(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index bdd2eda81a1c..80488a5e6738 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -237,7 +237,6 @@ branches.  These different branches are:
 
   - main 4.x kernel tree
   - 4.x.y -stable kernel tree
-  - 4.x -git kernel patches
   - subsystem specific kernel trees and patches
   - the 4.x -next kernel tree for integration tests
 
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 15199aa5b4df..9903ac7c566b 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -244,7 +244,6 @@ e di molti altri rami per specifici sottosistemi. Questi rami sono:
 
   - I sorgenti kernel 4.x
   - I sorgenti stabili del kernel 4.x.y -stable
-  - Le modifiche in 4.x -git
   - Sorgenti dei sottosistemi del kernel e le loro modifiche
   - Il kernel 4.x -next per test d'integrazione
 
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 4fbf40552728..2621b770a745 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -256,7 +256,6 @@ Linux カーネルの開発プロセスは現在幾つかの異なるメイン
 
   - メインの 4.x カーネルツリー
   - 4.x.y -stable カーネルツリー
-  - 4.x -git カーネルパッチ
   - サブシステム毎のカーネルツリーとパッチ
   - 統合テストのための 4.x -next カーネルツリー
 
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index d8acf255ac5f..bcd63731b80a 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -242,7 +242,6 @@ ReST 마크업을 사용하는 문서들은 Documentation/output 에 생성된
 
   - main 4.x 커널 트리
   - 4.x.y - 안정된 커널 트리
-  - 4.x -git 커널 패치들
   - 서브시스템을 위한 커널 트리들과 패치들
   - 4.x - 통합 테스트를 위한 next 커널 트리
 
diff --git a/Documentation/translations/zh_CN/HOWTO b/Documentation/translations/zh_CN/HOWTO
index 8e7dee80a087..7a00a8a4eb15 100644
--- a/Documentation/translations/zh_CN/HOWTO
+++ b/Documentation/translations/zh_CN/HOWTO
@@ -192,7 +192,6 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 些分支包括：
   - 2.6.x主内核源码树
   - 2.6.x.y -stable内核源码树
-  - 2.6.x -git内核补丁集
   - 2.6.x -mm内核补丁集
   - 子系统相关的内核源码树和补丁集
 
-- 
2.20.1

