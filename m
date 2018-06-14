Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 57A46C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A3A208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sc6CRvCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A3A208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754821AbeFNJ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:57:27 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42345 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbeFNJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:57:25 -0400
Received: by mail-lf0-f67.google.com with SMTP id v135-v6so8440078lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yAsqvOE4YE4eGK8LdxFdK1v7y2AA9dYScZLkNbVtZSA=;
        b=Sc6CRvCM9XhIBM5E/9m9KzqmB8UTIqaJ/YKhc1BM6/5FhaS0lvry47+8IOpxbMf6vB
         PuvrXahlsyPDDbL0/M9n6VzxzzRbHd8txOxXh7AZDqlb8j7+KfKxTsHGm3oEJMnCn/sv
         VnHXt4cPCT1mLRa2oEp4QJsvRke0oCd2SHeBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yAsqvOE4YE4eGK8LdxFdK1v7y2AA9dYScZLkNbVtZSA=;
        b=Qjb5sU1s01om3K/+THsOB9dxqGT42YYzSpxl+UKn23jPobqUFEomo4aPe/RUshWFDE
         Ha6H3KFH1Z4NjY8KLkoO7Bci1Y20pkmrxkCTkwjY0rU3Cqob02UL5yGDLCfaTeSMesiP
         bcC/70MNqXqNsSoXR1eDcJvDgygJgp4n4Ve6mIRDTrOz+hhgO6czrtM8L8Vz9QmP45fa
         l9vM9AadU9tt4rygyUbbyW6e1xoKkYxEvvKUOotC1lSBGT8etMyd6W4SI6Mm6qdKUdn3
         kQkz+UoyPWPjhRigL8t7wg668IdiiOyNwRN8HGAUSLXCZ8CpQgvCN/cHvUXOY6ffU5Fq
         2g/Q==
X-Gm-Message-State: APt69E3S/Lm2wOv63Nrwir2CgukfLXGYMw3sWsArQ8SY4BcmnKxs0HTh
        ooBfE3fFG0MnQMnuYDCl7JwE6Q==
X-Google-Smtp-Source: ADUXVKL65mbBi3rXsES3lcTZfFpL8M1H2lJaS5UT/yKDDKcFbjKgE24cv6Ilv1onWG69f1PbAsWueQ==
X-Received: by 2002:a19:1460:: with SMTP id k93-v6mr5820380lfi.23.1528970243860;
        Thu, 14 Jun 2018 02:57:23 -0700 (PDT)
Received: from localhost (c-4c3770d5.07-21-73746f28.bbcust.telenor.se. [213.112.55.76])
        by smtp.gmail.com with ESMTPSA id c20-v6sm884892lji.82.2018.06.14.02.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 02:57:22 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Fathi Boudra <fathi.boudra@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: sync: add config fragment for testing sync framework
Date:   Thu, 14 Jun 2018 11:57:08 +0200
Message-Id: <20180614095708.27645-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fathi Boudra <fathi.boudra@linaro.org>

Unless the software synchronization objects (CONFIG_SW_SYNC) is enabled,
the sync test will be skipped:

TAP version 13
1..0 # Skipped: Sync framework not supported by kernel

Add a config fragment file to be able to run "make kselftest-merge" to
enable relevant configuration required in order to run the sync test.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Link: https://lkml.org/lkml/2017/5/5/14
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/sync/config | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/sync/config

diff --git a/tools/testing/selftests/sync/config b/tools/testing/selftests/sync/config
new file mode 100644
index 000000000000..1ab7e8130db2
--- /dev/null
+++ b/tools/testing/selftests/sync/config
@@ -0,0 +1,4 @@
+CONFIG_STAGING=y
+CONFIG_ANDROID=y
+CONFIG_SYNC=y
+CONFIG_SW_SYNC=y
-- 
2.11.0

