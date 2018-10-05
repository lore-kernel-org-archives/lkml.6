Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67EEC64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C10F20854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aSNanqPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C10F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeJEIqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:46:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40334 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeJEIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:46:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id 1-v6so6044160plv.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLzqjhrd/hviNj2aRoQB7KJohhgS1IQRcvo/+tI+tGo=;
        b=aSNanqPY41Rw1bghUJ+hr1PwtEZt9PFXAYHc5EfyWzwdtF8zk+hDmBwvkvOKCBDy4V
         VZFsQyLyOoZLVt2dL2aL05qMw3261lXq0BfOGSMNoNkYSuzodKtyPI1pPsfpsKTh7KaK
         YqTIghIL68cItdOb/AiYFIIew5cCaPJS0wEFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLzqjhrd/hviNj2aRoQB7KJohhgS1IQRcvo/+tI+tGo=;
        b=bLvWR/G6e+bYid6Ho9WH0vQXXu6pTGdIP5FB+n2P814ZBjhX4cFdTMHaTVmoxf7PjS
         EADixwvtgZCQFy8nIQdJas8W/jRcd2YCVE7nbYMafioVb9apq2bWUHiYpStQpFdAbgvj
         qJNj2kfduElgF77hfWCYYiIPAppxwbP3JQfjgJlc9vDZaiTj/Cilz0e7ThkalQwTJqI/
         Pj04Lc8SqESWOI8vaROYjvNbBLF2gW8QETMx+av3o1EjB6YCnsPhxZUjRlF3J6BgyMer
         xgt32JzLGfTgcHqapdHcnnFJ/vmtxot60Rg95BiJL6vU/O/T1vzi4e11ZEMwCleQF0rR
         MnNA==
X-Gm-Message-State: ABuFfoj0HtJZoAzzQOZlXpuP2aLoGr5CiZp1TtM91vugziHKE+Pee2k1
        OXC/65vV6asfnMDr+ryqt5lQ+X0+r44=
X-Google-Smtp-Source: ACcGV61ZP8VxYqsriiV43bcOSPyyqcnV00SPu22uHJ7cFqxfZP7jnmuNm6VwPSCExsyovds99hMtyQ==
X-Received: by 2002:a17:902:850b:: with SMTP id bj11-v6mr9380502plb.107.1538704211709;
        Thu, 04 Oct 2018 18:50:11 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm6086758pgm.79.2018.10.04.18.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 18:50:10 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        tkjos@google.com, gregkh@linuxfoundation.org
Subject: [PATCH] MAINTAINERS: Add me to Android drivers
Date:   Thu,  4 Oct 2018 18:49:52 -0700
Message-Id: <20181005014952.255266-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am one of the main engineers working on ashmem. I have been fixing
bugs in the driver and have been involved in the memfd conversion
discussions and sending patches about that. I also have an understanding
of the binder driver and was involved with some of the development on
finer grained locking. So I would like to be added to the MAINTAINERS
file for android drivers for review and maintenance of ashmem and other
Android drivers.

Cc: tkjos@google.com
Cc: gregkh@linuxfoundation.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac829cf4..d639c4d04438 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -894,6 +894,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>
 M:	Todd Kjos <tkjos@android.com>
 M:	Martijn Coenen <maco@android.com>
+M:	Joel Fernandes <joel@joelfernandes.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 L:	devel@driverdev.osuosl.org
 S:	Supported
-- 
2.19.0.605.g01d371f741-goog

