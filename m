Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CDDC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D74420846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdrW3JTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D74420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeGZLKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:10:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43855 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbeGZLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:10:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so996562edt.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Byz9eo2wHQBZGeVMjgDYvXmPE1aBYOaOC2QoavAWl00=;
        b=YdrW3JTHaN4hKlEDWDnwccjxZO4lK6ws67G/8xszoNZTh5UGBFLt5T+CaCHaqf1cRd
         gWvalMPcMKIerhS5t1+CYFb0uzKr8+S4f+YxK89MNzto85k82CBRui4UllarlX8SaIY9
         FVLDwFM65I1TnJUgg6GvCqwUHQXlxKA/63a1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Byz9eo2wHQBZGeVMjgDYvXmPE1aBYOaOC2QoavAWl00=;
        b=D/4BdNp4IWgnKqtjMxSrHIjpIuPHzZe7N/za5KVQTn/WT/dJ01Dby6p4URdHjkmQ6h
         xC5bxLvq/sgCLs2hKjFuyLsTr1Sg3AhbUUqngIvey+nJtqc8V2hXZxiU5X9S0MizM08o
         IyAEWEgTQbd0MHr9XdRxp1Vt3MkYz7S7CpU72GZtvgDqVwej8aQ4g3dCRO8JOHaBxjag
         6xz1FwNKAj03OVZAOcufN5zwEJDrl/PlHntSrOBDHmHhbBoTO7TfdJMTit50K83VYlvj
         aUjsbKGP/ePoyAKs39MhXsksD0RgjB8OCwCUiCQGR14iAbxOPXkMOxaQwTNkq7RzFSUJ
         xBvw==
X-Gm-Message-State: AOUpUlF4tHYU0YoltmiP0DUkZXXcnVQSI6JLewqXVfrHzIv5KJfcKNDA
        Y1NzpJoNWxc99Kcbc8XUTMEA4g==
X-Google-Smtp-Source: AAOMgpdz+GYsQfKHvit3VPwz4ZLMIB7TIQMGBLDU0qYMX5tEDiOMSuB5ihtqqq3DVuMGFmYbdS+DNQ==
X-Received: by 2002:a50:a666:: with SMTP id d93-v6mr2026688edc.244.1532598847378;
        Thu, 26 Jul 2018 02:54:07 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id i15-v6sm642316edq.56.2018.07.26.02.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 02:54:06 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, shuah@kernel.org, davejwatson@fb.com
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/net: add tls to .gitignore
Date:   Thu, 26 Jul 2018 11:53:58 +0200
Message-Id: <20180726095358.30534-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the tls binary to .gitignore

Fixes: 7f657d5bf507 ("selftests: tls: add selftests for TLS sockets")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 1a0ac3a29ec5..78b24cf76f40 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -13,3 +13,4 @@ udpgso
 udpgso_bench_rx
 udpgso_bench_tx
 tcp_inq
+tls
-- 
2.18.0

