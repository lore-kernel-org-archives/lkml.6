Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6919020675
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U7iXYpNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfAHVmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:42:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36664 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbfAHVmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:42:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so2311597pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Cw0/EpUkh9KIoCMrbNUz1HGkKPdSPNaGkVe871n5XU8=;
        b=U7iXYpNRREIOeW2oMzWP/kHPPqpauR1697z+P23GO8OuazXmxtXT+FxACGGmT8RS1v
         qq/4uxyhsInTB+btOSN1CjaFQFHJqkp25IGrOkeD2P9knjoZE3F+asO9crDQhl6mBFQj
         1vMXkXVpN2H4BXc5n8K3Ujn1aMDe3jfx9J4fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Cw0/EpUkh9KIoCMrbNUz1HGkKPdSPNaGkVe871n5XU8=;
        b=GUDWpa026bY80FrnXBfKscPWcji/gUZiutz8q2ehIlB/l6ZCrtW6zgbUJnDjw/ESiW
         3ALG00h2mbqlbB+Yt5T+50juB/mfkRmgke+to4yPyfjzWLMYqamRk5Ty13e34a/fqGHz
         1UemZlvvuKXmdHU8jJcBep/A2ta44D20dRxLhkN6uMuXj5IqekxW+5ODwEng+jEKrMgE
         hzmdM3a92eZ3wIPd6TP88c6+wS+atrocDlUr8krPCiRmxdKTVrVLmNcpVeYo26EMlNpM
         16Fg2yK4hXCZ0JNQHbtoMhgZ4BI3ZXxdGWEtJgoxkxw76LZWGsieBvUBMzO9oEmQwhcV
         hdbw==
X-Gm-Message-State: AJcUukdbzGx8AK30gnEWaYuFKNx49CHFcC+B0DW/P5e7sL94S9UWxX91
        c620PoXCUzjQQVaPiK5pEl9jQg==
X-Google-Smtp-Source: ALg8bN4YvvVcTD7TFj49sk/jzPzNo/ABtxkSzfr5SUgPIKvI3MHCdbt4PU/bBJ3xtZoFCTuVBPvtpg==
X-Received: by 2002:a62:c683:: with SMTP id x3mr3337449pfk.10.1546983721478;
        Tue, 08 Jan 2019 13:42:01 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k15sm115945904pfb.147.2019.01.08.13.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:42:00 -0800 (PST)
Date:   Tue, 8 Jan 2019 13:41:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Dave Watson <davejwatson@fb.com>
Subject: [PATCH] selftests/tls: Add {} to avoid static checker warning
Message-ID: <20190108214159.GA33292@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This silences a static checker warning due to the unusual macro
construction of EXPECT_*() by adding explicit {}s around the enclosing
while loop.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 7f657d5bf507 ("selftests: tls: add selftests for TLS sockets")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I think this will fix it?
---
 tools/testing/selftests/net/tls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index fac68d710f35..e1472b8b53f3 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -202,8 +202,9 @@ TEST_F(tls, sendmsg_large)
 		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
 	}
 
-	while (recvs++ < sends)
+	while (recvs++ < sends) {
 		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
+	}
 
 	free(mem);
 }
-- 
2.17.1


-- 
Kees Cook
