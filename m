Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B99C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05812064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4KgFOeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05812064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeG0OlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:41:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35073 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730953AbeG0OlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:41:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so4416819ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=s/nhDr4DwkbALX3c2VZV0SuNSzciSZ6CaI3u8/fyaNE=;
        b=P4KgFOeHOwR0El6MQPFVyUQ6clrrVIyHxVwN7yFZ69zH2LlF05TUHbTjQEfsIt+RfW
         LbbHz5xZNTN8vCr6+AyIrbx8DyUwtcBNwXFOT0w4RjL6NAEsNCTXCOD/31UcQFxk/hiq
         xtQLfw6w9hXnleA8aZIPE3u/9L4QSUuX2DJjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s/nhDr4DwkbALX3c2VZV0SuNSzciSZ6CaI3u8/fyaNE=;
        b=SOoS1s06RfXxuS8wlav3bDMZrGJp5pR5BhF9jncn3CofAo9ateLImat/VpiuSEQgbg
         waE8wIdJTnOq76TWn1/XTXTbfT5kHLgFNrhg23dYvfl7vCnfebQ/dpxEQb1xfCYFgMvA
         Ijum0foBNmqo50LvmirE/aHRP8R70U7NB1Y7/U+pM/HSjyA3uT15urQHFZCmRcWLrZyd
         zADOuxmPLn7ofQrfBX2ojIRtO/8nLF9YoDKSz3o8keOemJ7SpD7cUKl3wpnyoVEfxa2h
         TpOXmusoz82gMCVslOBeH0h7u7LEgacJCbfJl4rjvyNsslLT/M4BTnMASMDg9rFuZslX
         YckA==
X-Gm-Message-State: AOUpUlEip9U+MYc/PDfiGpLeEUfBruNNXmgH/WEImczE94pFOBqWnIbC
        h9Mr0Dkfn0dRAf3Sdx1p9b8pMA==
X-Google-Smtp-Source: AAOMgpfqH911XOH9uRgxN2aVmisKoSo0Kx3sC2m6FBXw2mn1PjC1JyFHm0TE0KkS6asimsJB5EseLg==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr5147689ljc.145.1532697561845;
        Fri, 27 Jul 2018 06:19:21 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id k10-v6sm677450ljh.5.2018.07.27.06.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 06:19:21 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     santosh.shilimkar@oracle.com, davem@davemloft.net,
        eric.dumazet@gmail.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] net/rds/Kconfig: Correct the RDS depends
Date:   Fri, 27 Jul 2018 15:18:49 +0200
Message-Id: <20180727131849.18488-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove prefix 'CONFIG_' from CONFIG_IPV6

Fixes: ba7d7e2677c0 ("net/rds/Kconfig: RDS should depend on IPV6")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 net/rds/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index 607128f10bcd..4c7f2595d919 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -1,7 +1,7 @@
 
 config RDS
 	tristate "The RDS Protocol"
-	depends on INET && CONFIG_IPV6
+	depends on INET && IPV6
 	---help---
 	  The RDS (Reliable Datagram Sockets) protocol provides reliable,
 	  sequenced delivery of datagrams over Infiniband or TCP.
-- 
2.18.0

