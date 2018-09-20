Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84226C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C37E2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX23Ngx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C37E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbeITJLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 05:11:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35491 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731479AbeITJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 05:11:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so7809406wre.2;
        Wed, 19 Sep 2018 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2MU8pQ9tQcK95xwyoIVabcjCrav5PIKNxtLaCvfEKA=;
        b=jX23Ngx20s6cdMg00aaxULOiNlvhKJA47ZoFb6lYgFrwkWdEZvSzuFjF6MFU2T3Ul4
         A5JP32zjdLby+yrdAjIchCYG9qIvlXyVxUsoJ1snHwKAubB6E3hDMa4jmb6LR9UAoplN
         YmPzbvmkQaSoeBNeNAoeTEpO6u4QTMhpqmKBNrPXqiMMuZ1sp74u/OM6ahiQbvZZxjpl
         sYIbqOKxsmmeLWMpI4pbG+01r8eneptf0jDYC76aDFQ6mBmXLh0MAwf1MWxOy4d72TMj
         OtXA9YjBjCdRuV2K3lkoE2k3eUR+i6+OTuQjVwE18xSLoae8HTGMKZojBDvvGCG4ugpz
         1MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2MU8pQ9tQcK95xwyoIVabcjCrav5PIKNxtLaCvfEKA=;
        b=Zz+TvbbFzZBxA1+PRoh8QG6jAgKQVmKmD7OURJ23NfZbHNJT5zvtuYCR3z8Q5EJcdq
         plTXvFNL7+1BCPyezRY1XJjJZbanNckAb6Pm754//5qp40enUEOZJt3Nhsrt3Ljk8jM/
         XyVa5hS/VimxVhoyYtI1AWuOqFhU8nuAAcrBN2I/Mu7/kgQg8HD/5G4w3QBC8ApAj+Ly
         6R24viLQ6Gptq2FAXYSyGeyARFQrCq9RUgHZ1tx7qrSNvXjX3TPLNfmKkFBmvdOrUhGU
         EEFV2Y9zXtlinY/v13YmAa+W9r3YBdcKKUgCNQoqIfrwSi7ZxdmTJwF00ypA7Nukvmew
         c23w==
X-Gm-Message-State: APzg51DBuTAP0s8ueL0gF4xQXYN7N+XlP8gW3XjPHMAN4ESh54XjLYUs
        YLhEKMzcbF5k1MHNzmh+1HBVuB+mmzr4cg==
X-Google-Smtp-Source: ANB0Vdb0Onr3bfoicDZJ6encMEzH3I0E3/EPBO4VONRolQD964/QYZYLakx3uEK+OAaHBPh/SFd/lA==
X-Received: by 2002:a5d:608b:: with SMTP id w11-v6mr32455555wrt.193.1537414222817;
        Wed, 19 Sep 2018 20:30:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 88-v6sm20475796wrf.95.2018.09.19.20.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 20:30:21 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] IB/nes: Remove unnecessary parentheses
Date:   Wed, 19 Sep 2018 20:29:57 -0700
Message-Id: <20180920032956.14360-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when more than one set of parentheses are used in single
conditional statements.

drivers/infiniband/hw/nes/nes_hw.c:1446:27: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
        } while ((temp_phy_data2 == temp_phy_data));
                  ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
drivers/infiniband/hw/nes/nes_hw.c:1446:27: note: remove extraneous
parentheses around the comparison to silence this warning
        } while ((temp_phy_data2 == temp_phy_data));
                 ~               ^               ~
drivers/infiniband/hw/nes/nes_hw.c:1446:27: note: use '=' to turn this
equality comparison into an assignment
        } while ((temp_phy_data2 == temp_phy_data));
                                 ^~
                                 =

Remove the unnecessary parentheses to silence this warning.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/infiniband/hw/nes/nes_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/nes/nes_hw.c b/drivers/infiniband/hw/nes/nes_hw.c
index bd0675d8f298..5517e392bc01 100644
--- a/drivers/infiniband/hw/nes/nes_hw.c
+++ b/drivers/infiniband/hw/nes/nes_hw.c
@@ -1443,7 +1443,7 @@ static int nes_init_2025_phy(struct nes_device *nesdev, u8 phy_type, u8 phy_inde
 		mdelay(1);
 		nes_read_10G_phy_reg(nesdev, phy_index, 0x3, 0xd7ee);
 		temp_phy_data2 = (u16)nes_read_indexed(nesdev, NES_IDX_MAC_MDIO_CONTROL);
-	} while ((temp_phy_data2 == temp_phy_data));
+	} while (temp_phy_data2 == temp_phy_data);
 
 	/* wait for tracking */
 	counter = 0;
-- 
2.19.0

