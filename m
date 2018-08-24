Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E44C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1742157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKGIFuaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1742157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeHXQYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:24:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43955 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHXQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:24:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so5102720lfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aUrzlsm/ss0bHaBksWaZFn9p8BJboQx64si7fCltcB0=;
        b=SKGIFuaBBSK7B6rzo95RLiC68fzeLMAEbAbCtUz6H6jS4s7H32TneXxhNMFK2TZ9uT
         HqYOg3jfiiIkFBFO5F6bFnZ5B5MX3dnnkIPxB66XY69UaNe9YV1ZAtamDU2GcHd+JOks
         EQT4NOPSm/2OWMEdMFGf9grnvMMSdxVyTmEUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aUrzlsm/ss0bHaBksWaZFn9p8BJboQx64si7fCltcB0=;
        b=gYb8WFCs+ujaR0QQtUqhf8dBp2PPG+1jzReTgo7TP5igTSTDFuluCM0IWUJNJ//OjU
         NILDitLhM5yExN/QkFJ4EJDFu0o+HIpwWJXii/0wQguULhGFn0NlEVBQP8DzXHCpNAIs
         QEmHPFD7XZhBccvT4mLf9CJy7NexsAHKt+UDF8mhn4Pn5sr/5nZxfP7fyeCc9OmnhVsY
         GA+35m3d3OLWsPyy8SZFfq3ouQk4ML7Bx0V4Xd4K1apRrux1yC7FQV7jhD6HFMECkoya
         yFa4LKTDYzLMlSxZQK2/Db05Swz9pNrRqhl2h8z+IY0ZCXHGBRtq5ZXy//RoWaX4Q5bt
         rsYQ==
X-Gm-Message-State: APzg51A8UJ4uS/QzYQCUadOGClXA0eGCQNFNqv0g4OTDkqWGdhJnEpbb
        tTsBt6EFN+gc8q4GQbyqMdG0lw==
X-Google-Smtp-Source: ANB0VdYYRBG6uEYSr9VSZTx7jviqZr6nNoaHD8E9bJzB7KDdu1khqFe167S2JVDk6S3NBF92ojLRzw==
X-Received: by 2002:a19:5353:: with SMTP id h80-v6mr1348081lfb.9.1535114985099;
        Fri, 24 Aug 2018 05:49:45 -0700 (PDT)
Received: from localhost (c-4c3770d5.07-21-73746f28.bbcust.telenor.se. [213.112.55.76])
        by smtp.gmail.com with ESMTPSA id m12-v6sm1195533ljh.24.2018.08.24.05.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 05:49:44 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests: android: move config up a level
Date:   Fri, 24 Aug 2018 14:49:41 +0200
Message-Id: <20180824124941.10146-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make kselftest-merge' assumes that the config files for the tests are
located under the 'main' test dir, like tools/testing/selftests/android/
and not in a subdir to android.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/android/{ion => }/config | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/testing/selftests/android/{ion => }/config (100%)

diff --git a/tools/testing/selftests/android/ion/config b/tools/testing/selftests/android/config
similarity index 100%
rename from tools/testing/selftests/android/ion/config
rename to tools/testing/selftests/android/config
-- 
2.11.0

