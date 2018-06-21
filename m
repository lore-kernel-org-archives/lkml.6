Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23227C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B759421746
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDATeKRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B759421746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeFURAo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:00:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44505 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbeFURAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:00:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id h12-v6so1822414pfk.11;
        Thu, 21 Jun 2018 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IJ3aT0MdDAiuGvRCjSjjEY3q2fim+Hm+RnUZWux4p1g=;
        b=TDATeKRWGrE/z23bCdFi//soLQ6AwtYLUqNvooobhDV+4lqo5fgDdFpsStGn9HHmBz
         teRGGmG5EcaISC8PF6tC+dw65zElbN3+xlAl7Q/34jP5HenJDPAstJr3iazayDVHTpHq
         7iDov0x65wwdY1NeVxPd08ywgXVSdR5F90b7GMLPxo48iD/9TK2DTeVUNhrrQPQ8Wd0N
         A4wDY3pDsJMsnExjqFv3vjLyTVD4ULI0JDwhXmGtgx3Hb9aorOGIZHBsnrSVveyFqws8
         TZ+qteuvxUWzpEUY2H0AmWSeD7OAGyEVuvJAm+OWPVxWE/2fJlBKSq2/iibumhn4cQi0
         nWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IJ3aT0MdDAiuGvRCjSjjEY3q2fim+Hm+RnUZWux4p1g=;
        b=CzgB6nlKsJzlHseIjTmrHT617uSfzmO284lmyMmIcp/EVOs9Gd2okD+DeOco17nA3G
         Yz38UETGNCJpepoE1K0ZHzpAsUq66LmoS8AgPfr6Z7YFUHU6jpDW+Fch/LoF4jPJn6z7
         Vv0H2wuwNHF2cbFV197jk/D7bygtboJBX7DujJ5E9EwdDSrjStUMMJXnt/UQgAbt5KDD
         F9XQRfEpQJUefnXRhZYOrWWvvvbql/7UYXaTs0Q25JTBxwqe4sf8aepSJ26yVoHyaM83
         MdohODdPZY4dYDjquH8vS+ZUT82Wo3b3791Cj6Lj5aksXzOAjhViRaZPEEn/TLSzPHM8
         T44w==
X-Gm-Message-State: APt69E2EqUeSsC2pcQ+raSjQBzweI6tNSc/mD77TkHzNae+s3+N5gjA2
        amYfavcJfu5Pbtb5tMqcZ98H5QCC3ac=
X-Google-Smtp-Source: ADUXVKIOpYuvcHuG6zaPzNuvWkxUpHD5m+8HgyUjMgrkDwJvLoSWICVc3/7VTVwivwO9wlLVajjcSg==
X-Received: by 2002:a65:5cc8:: with SMTP id b8-v6mr23241183pgt.85.1529600442604;
        Thu, 21 Jun 2018 10:00:42 -0700 (PDT)
Received: from localhost.localdomain ([122.174.189.32])
        by smtp.gmail.com with ESMTPSA id z18-v6sm7233182pgc.0.2018.06.21.10.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:00:42 -0700 (PDT)
From:   Jeffrin Jose T <ahiliation@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jeffrin Jose T <ahiliation@gmail.com>
Subject: [PATCH] selftests: bpf: notification about privilege required to run test_kmod.sh testing script
Date:   Thu, 21 Jun 2018 22:30:20 +0530
Message-Id: <20180621170020.9073-1-ahiliation@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_kmod.sh script require root privilege for the successful
execution of the test.

This patch is to notify the user about the privilege the script
demands for the successful execution of the test.

Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>
---
 tools/testing/selftests/bpf/test_kmod.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_kmod.sh b/tools/testing/selftests/bpf/test_kmod.sh
index 35669ccd4d23..378ccc512ad3 100755
--- a/tools/testing/selftests/bpf/test_kmod.sh
+++ b/tools/testing/selftests/bpf/test_kmod.sh
@@ -1,6 +1,15 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+msg="skip all tests:"
+if [ "$(id -u)" != "0" ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
 SRC_TREE=../../../../
 
 test_run()
-- 
2.17.0

