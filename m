Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A059C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180F921B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHZTGnrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440405AbfBNVjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:39:12 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:40672 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440388AbfBNVjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:39:08 -0500
Received: by mail-qk1-f202.google.com with SMTP id 203so6095032qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dpMyNLjbaEoBN2fIt+0XMlt5wSIklA/mX/UHQ1WvfMQ=;
        b=tHZTGnrRF6tZNdOyIbQW15sL1g+Qw3v7vALbKugbns0kuMvcT5DKYt7ydUYMn+U2Np
         Nk+L+f9RxHcktbClu4h5LhOuMWL3KCLjrUW2cVARNa9SLGwOdcMcLWkczCB1Sj4N+4VN
         AXiNi+MR3bnEdrzw1VQuWc9V625xRsZYJWdui5Ct3RhMUBILk7Chcvh2c5471w3kJO0D
         QECkjtRxYxlaxzMT30nTuHpHlXW/ZdYN4e+lqi/6W8dyAP7rQTVV9UUcmgZjmSCi2H49
         fNpejBhDBa4DnumoPCUajGfQZAfgRxxh/FB3aaDdRxduSPES7ShJsInA7bW6LQ5xbEfv
         8d7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dpMyNLjbaEoBN2fIt+0XMlt5wSIklA/mX/UHQ1WvfMQ=;
        b=eKOVUYptn1DEPcdf7zoTxKyRiwq0Ywh1NP4uIe4xAyyjEA9nDZzYFwWacDjnOXzrgJ
         Ojr7P7eoZlqpLkXoZLsidnPJ4lyz/qnuzXxAM5SJG41/adbPWUjMIBZj8/VeDtYi8nSd
         4630GIpVUqyc1PhWDisBdB981S7owxtmo4UjEMFWJEtfCFiEHLr0JdhyrPsdg/OBEG1p
         RdkWgRvq0cY+ruQTTKL2iZeBTpwRWfjtgEgG/2qe6G9ggZGAl6Dfactbw7Skv5x4/tk3
         blxrkFFrm6QNeZixTzXrlcWfFx50XV1EYLw8fKEuqRiktcZXsFUR9IlPGZftCbcflRCY
         BPHw==
X-Gm-Message-State: AHQUAuaDReWR3OG2gkiW9R0Si4VWiI3YcSBArguMhF/f6brPTX9xG6Yj
        qK6t4kyU9+2fTb5gVWBelxMUNLcDLE4rcwyIVEJcAQ==
X-Google-Smtp-Source: AHgI3Ib96SBAmaHj0hccf6Xwyo7GzGo8ekoaCNzOP60dVFW5l3gJ8yVzrFenYf29uVbJ1/FHiSJ2kSpq4Bk4SqiXNSoajQ==
X-Received: by 2002:aed:23fd:: with SMTP id k58mr3493988qtc.39.1550180346797;
 Thu, 14 Feb 2019 13:39:06 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:37:26 -0800
In-Reply-To: <20190214213729.21702-1-brendanhiggins@google.com>
Message-Id: <20190214213729.21702-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [RFC v4 14/17] MAINTAINERS: add entry for KUnit the unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     keescook@google.com, mcgrof@kernel.org, shuah@kernel.org,
        robh@kernel.org, kieran.bingham@ideasonboard.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, knut.omang@oracle.com,
        devicetree@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c68de3cfd80e..ff2cc9fcb49ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8267,6 +8267,16 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.21.0.rc0.258.g878e2cd30e-goog

