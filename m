Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2993BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6162087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlkVY6oS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6162087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJSWbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:31:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39733 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeJSWbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:31:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id n14-v6so13531354lfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkCjE8pu3Rrp/axa8hjLiMFPIzYIMrbAkYNKWhnvSho=;
        b=BlkVY6oS9RJ9VHNcdQRjJGJGOCvp2PF2TSHD4ymh1ALl+o22jmFcByrTHg19t330H8
         gz7qnyxtsH6Mm4zV8wRzk63fmeYL9NVyzoMGhjFeu1tzTXQLvFoqYFxPshpTHIBqfUWx
         0PWUBVHqRMDkoqL5henjvmPyWnKzr31fdrGGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkCjE8pu3Rrp/axa8hjLiMFPIzYIMrbAkYNKWhnvSho=;
        b=adxUmiJRyCnXqa4Acf4DLIPVfjBv7NNGXG5D9L/MSCM3c6RyLgTnCegyspUevDKx78
         kOCr//1QNsqv/1rJeAH/YjCv9ji2ZCqWtZKygkpysxj+lw5ZT3wOE1mUeoZsAaxW5tic
         c/v+0stW6uQdXZa+cVAd/T6M36Cvh+q/T4hgaOMDBa7bIyjoLCF2pShotBAEthL59zQz
         sMggS4d73Paqo9rZghmyRnBt6u2PI/pITVqrY0TNHbGfM60epwFAaOgtJF24MUggeIKy
         Ovca6TZzy1VDuiLZtE9jMlciLRKBvS0VKsg4FBEp/vEcd6GrllWfzL2NKz3bcFqltPxu
         uKig==
X-Gm-Message-State: ABuFfojL9qRofa3WobIUDS8GqszceEeR/qIgezbpg2IQXFZCWPs+t9W5
        fxEVGFC0HPwZ3qnKk2GOmsSR5g==
X-Google-Smtp-Source: ACcGV62Y2bhKxySNwBpnoev78duw1aImsrzjqpAPV/+H0iFd4aMnKtzzAGOE8zNcBT9vRhamwz/C3w==
X-Received: by 2002:a19:6b16:: with SMTP id d22-v6mr3143230lfa.49.1539959083706;
        Fri, 19 Oct 2018 07:24:43 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id x9-v6sm2281547lfa.65.2018.10.19.07.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 07:24:42 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/bpf: add missing executables to .gitignore
Date:   Fri, 19 Oct 2018 16:24:36 +0200
Message-Id: <20181019142436.2955-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 371e4fcc9d96 ("selftests/bpf: cgroup local storage-based network counters")
Fixes: 370920c47b26 ("selftests/bpf: Test libbpf_{prog,attach}_type_by_name")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 8a60c9b9892d..1b799e30c06d 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -25,3 +25,5 @@ test_cgroup_storage
 test_select_reuseport
 test_flow_dissector
 flow_dissector_load
+test_netcnt
+test_section_names
-- 
2.19.1

