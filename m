Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C718DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EAF2083C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPsH4Baf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EAF2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeHaCjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:39:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43316 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:39:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so8448320lfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c+y/4qDLh4Q3MH4efnGn89I4nTvNhxVoS8FHIzB7G3w=;
        b=tPsH4BafkT6QVNQAIbmbE3qCxVycHK9DLiGBqR7FGKErQ0DxGy3wEM3UgwUIwnk83d
         5IXc2qD8m6G/SXcN9K70LOixp/16O6oMdyx/8Z4ayBWoSkn5D8u+XK/8lLhVaQ+1j9QY
         Uv3HzOmTFONsRf61/TJbx8Hr8fmi4es09kiScaGnECBe9G7Mj8CdPYZlsa+0BTCFBqEv
         alrInLphhErrTofh3aykDTh8tewQ0AAVMxPi7rG5edl3oqBwmZ13bsjgg4UDYqVjzb/W
         MgDEPtzaBNtzJaZ75PE4Mn6IpJpTYMX61yyCZQDDkPCRfF7F9OGOj+3O0bx5GgJRxkb8
         H4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c+y/4qDLh4Q3MH4efnGn89I4nTvNhxVoS8FHIzB7G3w=;
        b=dmWcFsKngZUDmqox5gb0/j4yvK9+373cMXwzngrQGQrml9ubdkY9n6JaH7b9o9jrzf
         HELGS4+CL1vWg17T0oCrNly8Pae02SowKkCKXrljdOE+LJI6eTf18YDFeWGDtDR0YjS1
         ZNO62GdmCSNQwSIxoYC015YcF1bBjZG62zHiPxWJSgVlKqUMiK+y8m0HyGI2pMpPaieG
         FynwFTXtJEJiFnURLUKy4jO96NQFK76F20Z59fohHf2pdJvrJ06J5PM7Wx49dDgg2FHW
         aE/7U0ACfhOuMgi6sqBPE5lkkukJkL1CgrOzmb6txh6ciFEk/5LmqkhcocDLDOxluuLr
         5FPg==
X-Gm-Message-State: APzg51CGqt2ldncdpYFHoGqVxyTC/At7mR1p6IoKHsgIgU0R7BfVhOx9
        +swgQiz9+qHQu/6P3Wo7obKtn0pUcdw=
X-Google-Smtp-Source: ANB0VdZSb8QW7E7gdlkL/HOiuEqQCKrzfzgm75SR28QB/iZynpE1VPjv0rfphmcx1yhN+aduI+Nr8Q==
X-Received: by 2002:a19:7515:: with SMTP id y21-v6mr8562758lfe.100.1535668525601;
        Thu, 30 Aug 2018 15:35:25 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:24 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 05/23] selftest: vm: add unlikely() to BUG_ON()
Date:   Fri, 31 Aug 2018 01:34:11 +0300
Message-Id: <20180830223429.30051-6-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() is unlikely() to BUG()

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/vm/map_populate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/map_populate.c b/tools/testing/selftests/vm/map_populate.c
index 6b8aeaa0bf7a..ca3f54765897 100644
--- a/tools/testing/selftests/vm/map_populate.c
+++ b/tools/testing/selftests/vm/map_populate.c
@@ -23,7 +23,7 @@
 
 #define BUG_ON(condition, description)					\
 	do {								\
-		if (condition) {					\
+		if (unlikely(condition)) {				\
 			fprintf(stderr, "[FAIL]\t%s:%d\t%s:%s\n", __func__, \
 				__LINE__, (description), strerror(errno)); \
 			exit(1);					\
-- 
2.17.1

