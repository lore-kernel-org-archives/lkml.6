Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D5CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D436221655
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDfGJj2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D436221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeFZP3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:29:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46801 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeFZP3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:29:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so5954011lju.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p7A1aQmfvY7GY8s6P7Kr2lz8w8Yq9WaZaNeDeX7lA+I=;
        b=UDfGJj2cRcstuXxvBuug5dNckOuHe35B/+Pc+zjiYOn3UOrno/UpFukxCIBiIAdv+O
         Jvrq73usgw+v5JJK0IlnmEF32EK0+v2WWGxD3LWtnRQkh3IOgYT/bNB1eH/44/ffkmod
         ooPOK36epeXhqf+qj+Tt4IQR8I49EfBfPFszA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p7A1aQmfvY7GY8s6P7Kr2lz8w8Yq9WaZaNeDeX7lA+I=;
        b=R6lPkUheYw1CeEr8wAsIeJVMw3nH1xzEjlfyk2gLhYWOXTIrIkZuP4bSOTvKQyC6Db
         xGUyc35Pr4Oa0YP4Iu0siSIkiW9rwVfE6FnEKkmEwNavOtxVbOeHbTcP0uUT3Xv7147x
         t1dnK3eJnpP+6Lyv/0jP/6mbQlqgb5P74lWwUT2JVXGqDxCTJLydlZcfK9eLbV49jc1F
         dtFq1YRy6dhewMuEz4F1FWS+GKj1ZSelO6RxScq6+YdINXRftxyKn9LVtHhs2jyJ22sA
         h9lO2kbFatR4OeTZTgwfwXzXuVAp5nAFHUqqExJBuLcEOX4oUefArg1GSOldSu4Cs6Ns
         qbzg==
X-Gm-Message-State: APt69E2nPC7gNCM5gTlEqqqsCk5pqc0TiUR+NAzkE5XKmZH2/sbL0Ule
        4sMXel28pXyWpOy9XCAXQ0r4/w==
X-Google-Smtp-Source: ADUXVKJuwaMmprWQ9ijmlDgkIpxp2b4p1gUa6qqj5nDg2CWlDvhtsaIlXeMtFTh3RaQVFSBiVp0FIA==
X-Received: by 2002:a2e:2f02:: with SMTP id v2-v6mr1579587ljv.113.1530026940536;
        Tue, 26 Jun 2018 08:29:00 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id n62-v6sm298504lja.32.2018.06.26.08.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 08:28:59 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     vgupta@synopsys.com
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arc: configs: remove no longer needed config option
Date:   Tue, 26 Jun 2018 17:28:51 +0200
Message-Id: <20180626152851.32674-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit eedf265aa003 ("devpts: Make each mount of devpts an
independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
in the defconfig anymore.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arc/configs/tb10x_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index 1aca2e8fd1ba..2cc87f909747 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -56,7 +56,6 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
-- 
2.18.0

