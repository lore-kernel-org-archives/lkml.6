Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0606BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C3A2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ib4mNsZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfBDN3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:29:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42660 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfBDN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:29:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so10324924lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 05:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XGjf/4n/g7by+tKFc+fyDkehnnu/w7heG4AKutSXqE=;
        b=Ib4mNsZMtrqb9oI20M0ZlQ3ReAQY02BecRC1PDYBbdyi0Ia+B3BfGVLonOKcj4m6V+
         a6ZxSlkexzd6g94hfsPd1bQm7px3T+MD73S4TbZ1inWLjOQTf4cQj3AlwpSF5iGbvgt5
         EvC+l/mzqWCJRocYiH87484GvM5gubltkpapo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XGjf/4n/g7by+tKFc+fyDkehnnu/w7heG4AKutSXqE=;
        b=Ij+R10gv2Mp3CM8EUUtX6cP8aGDt//ReaJfJTg/CnQlnfMjFSYKJz0en0n73E7BqWD
         m4ccwm8LksY6w7hia79wiDv6Spe3aqABZsQH79wAKleoXgTXD/svmZp4ixnWZoHZ+Qte
         TbqYddFE9kX/QqqR5ozDEkYSE735LftE8gZhdw2Br2Wf6kawG4lZbd7JPV6cNz5ZZkdY
         gsobqeP46czLcWGGS6bt1VWV18g1fCUWdwshH7eDNxPLRyzjsmxAkXqmgLPDSJhPo43y
         xspwWtIwsvnD+xYKQgSg0aukGqPWZKsQKm2Kf058Jp8fWYBZaXNYp/JjH4VTcj88J0sY
         hSrw==
X-Gm-Message-State: AJcUukchmwqR9BvbzXI1DQdlERU1NuFW4ZwuGb9EbLIxdM/jAkQaNfi/
        V2Z0ikhELv4/bxtY0LHBZk1Nig==
X-Google-Smtp-Source: ALg8bN7uwO76EGFPzUvKY58W/qs3Quup3OOdWHThXNu3/RgyKW6aXr5LfWMPUzZTETd15qzMxMVL2w==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr34794845lfe.154.1549286950276;
        Mon, 04 Feb 2019 05:29:10 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id w9sm3124861lfc.66.2019.02.04.05.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 05:29:09 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ard.biesheuvel@linaro.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] firmware: efi: arm-runtime: fix build error void value not ignored
Date:   Mon,  4 Feb 2019 14:29:04 +0100
Message-Id: <20190204132904.9288-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e2a2e56e4082 ("arm64: dump: no need to check return value of debugfs_create functions")
changed the return value from 'int' to 'void'.

../drivers/firmware/efi/arm-runtime.c: In function ‘ptdump_init’:
../drivers/firmware/efi/arm-runtime.c:52:9: error: void value not ignored as it ought to be
  return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/firmware/efi/arm-runtime.c:53:1: warning: control reaches end of non-void function [-Wreturn-type]
 }
 ^

Rework so that function 'ptdump_init' doesn't 'return
ptdump_debug_fs_register(...' since the function can work or not, but
the code logic should never do something different based on this.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/firmware/efi/arm-runtime.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 352bd2473162..b9ae798192d6 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -49,7 +49,8 @@ static int __init ptdump_init(void)
 	if (!efi_enabled(EFI_RUNTIME_SERVICES))
 		return 0;
 
-	return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
+	ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
+	return 0;
 }
 device_initcall(ptdump_init);
 
-- 
2.20.1

