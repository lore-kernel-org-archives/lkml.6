Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E47ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6596A21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiDQgk+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6596A21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJTCo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:44:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35636 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeJTCo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:44:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id o17-v6so3846882wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bTHMIRClwb/9goA4wnqST/WKKieWtcODHSlUE79uNU=;
        b=qiDQgk+LDYyp5kGsKOXiI22Pyt3uK9VGYfjexoPVCHOrQA9TpTgu907AaIgPohhOkZ
         rpCPq90GnLIbMqiT2HyCiQyZDFSR+AN1MH1vMl0ik3SlIThWITQAs1efMerLScUQbZNb
         yxyAJBqJhaOugFnQVV0W98f3vpI0MGNgwQj/nYXUmZLGk07qDhiXnX7zh2nFk9vdHvYz
         5pXlmFWgfeKNjVPHCYiyIkRmCVh9Y33Ynd69Fb7xlKfHlpDPGg2N1QPmnb8YxVpJuX7C
         KkeLOXCDsWAZ27+V0PED2cLAzhJQtIp+/0Acaop6CJdbRqq7AQssuXfAjORNjqxKeDso
         Kp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bTHMIRClwb/9goA4wnqST/WKKieWtcODHSlUE79uNU=;
        b=CNNAqCRmk+Afl8YR8JcX8a3zU36O43DVwW7pcQx87z1ssHpGJr+bOnnNLoRElPPUCb
         e4di8LAWMZ19xs940OqujERNAIpmxOSPCJOhZ6MPBI+/+5OjuRlDNua+1HR6DX3EfVh/
         qqFrB2NLQnDbDiMZV2vvo4S9ysdjc39xxCoaBW3tyTiQHoXjYwo9nktTgucOy1JTiPuj
         zNEu1snW7t5LNQ9YgP9u91TYBktsD6TtK+jTxpK9eb+6tLn+Dk8WnPi+SNmd0gqJhcic
         B0X2k+V7EDeyzONmizkodUzq6rgl3Hrjm6d4pVVlYMymPjC3JxlH04E5RANbYJvTOSMQ
         j7hg==
X-Gm-Message-State: ABuFfohGojTPq1crsmBWyOOHJDIYop63Ub6dT8xFtfChy7hO0iVV6SaO
        84ECIkl0yugxM8PkIX33o9E=
X-Google-Smtp-Source: ACcGV60LEbXyjyBfCQ6/o7s12jHUmNWQXmKIVQadp0+lB03tpQ7IoFcgkwxotsU508M5ZCiNnGAU/g==
X-Received: by 2002:a1c:b20b:: with SMTP id b11-v6mr6030470wmf.64.1539974261630;
        Fri, 19 Oct 2018 11:37:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id i6-v6sm23993597wrq.4.2018.10.19.11.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:37:40 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pstore: Fix annotation on declaration of pstore_exit_fs
Date:   Fri, 19 Oct 2018 11:37:29 -0700
Message-Id: <20181019183729.27684-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns (trimmed for brevity):

fs/pstore/inode.c:504:6: error: section does not match previous
declaration [-Werror,-Wsection]
void __exit pstore_exit_fs(void)
     ^
fs/pstore/internal.h:42:6: note: previous attribute is here
void __init     pstore_exit_fs(void);
     ^

Fixes: a4fb3d2fefd2 ("pstore: Centralize init/exit routines")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 fs/pstore/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 98bb4fa6e6a7..7062ea4bc57c 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -39,6 +39,6 @@ extern void	pstore_record_init(struct pstore_record *record,
 
 /* Called during pstore init/exit. */
 int __init	pstore_init_fs(void);
-void __init	pstore_exit_fs(void);
+void __exit	pstore_exit_fs(void);
 
 #endif
-- 
2.19.1

