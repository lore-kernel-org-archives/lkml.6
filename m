Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC99C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2082085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mixsi0JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2082085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJHS4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:56:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36206 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeJHS4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:56:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id y11-v6so6815396plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e1UAtIHpi4w8tEkO6JrCDClMRYFR5dXlaEji33/glAo=;
        b=mixsi0JDwTCttqu8Qbf+PD7xiISeZqdWbWceY588Ixx+mDLqyOduyuaMrkawYs/X/q
         oSBup+UoN6JFpoyICoWdgDIJLPCGIuRp6WBuuDh+yHvuJcIxXTlRV1sz+8prpJ0aCnVR
         VJe0TsYP7+zcLr0Y3C25NrNDeG5So/If4gzGZW8YlBHQ5APvYszOxcp/KUhZjNo+daTD
         iZkpcaG/t2aA3fHWdNEyiqipGYACHPM3oBHGFwB66x3IzOhhSjn8SPJj6MNZOSmonAsh
         eB8tuggfez9efSb/SJB/iyqDyLjQRvbylVOThuPZmnuK5emq7Im4poqsptV9gskO6/np
         NULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e1UAtIHpi4w8tEkO6JrCDClMRYFR5dXlaEji33/glAo=;
        b=qIY1dhqbaIafEqwB5sfNOSgJ440yr4M1UjF83sBv/8e3lcmF+svStX0fF56o0BY8hs
         qrtH/qjjDYyvdzNXIbEwd/nnQfW7No3Fbm7pyx0ICFy+kQ1uqi/BzGStKjEWQO/+zONx
         TFmTzSuBzQyug9fDYDBNDL/vUzWCjFI3hNmuccZ7kcDYtfZnrWy4YUMyiRHzNVuHB0rj
         nRh3NW5rZr6bqm2hjO73+3Q48L4cq6N/MhoSXoUEpDc+NHFLDJ99zLur8XdlJ50UANCt
         FdsrgtlchVlHVHJd8jv9QQcy9FbHg7oAn3XcfaSjMpPJPAIOxCaJ0uEJVyGPBYuUoB/b
         MDWw==
X-Gm-Message-State: ABuFfoi+7qhW1TLU7XwbwUdq73qriQ+ysAepag0Ycm/Da3fFqkD6x7nU
        pRGShiO6NTemGmCCuS+xkWk=
X-Google-Smtp-Source: ACcGV625GUl3T3lA3WK7wAtGQ/5FdIrIPkZKTnVkIQ4YVO24DfX1n9FPZa8sJnaBR6Pb7y2zYkXU+A==
X-Received: by 2002:a17:902:6a:: with SMTP id 97-v6mr22572087pla.276.1538999127200;
        Mon, 08 Oct 2018 04:45:27 -0700 (PDT)
Received: from AD01277334 ([211.249.70.54])
        by smtp.gmail.com with ESMTPSA id b29-v6sm25517256pfj.183.2018.10.08.04.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 04:45:26 -0700 (PDT)
Date:   Mon, 8 Oct 2018 20:45:18 +0900
From:   Daeseok Youn <daeseok.youn@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: adds a space around '*'
Message-ID: <20181008114518.GA2475@AD01277334>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl error:
ERROR: need consistent spacing around '*' (ctx:WxV)
+                       memcpy(vin + PAGE_SIZE *i, t, PAGE_SIZE);

Signed-off-by: Daeseok Youn <daeseok.youn@gmail.com>
---
 drivers/staging/erofs/unzip_vle_lz4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index f5b665f..501cfe0 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -181,7 +181,7 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 		for (i = 0; i < clusterpages; ++i) {
 			void *t = kmap_atomic(compressed_pages[i]);
 
-			memcpy(vin + PAGE_SIZE *i, t, PAGE_SIZE);
+			memcpy(vin + PAGE_SIZE * i, t, PAGE_SIZE);
 			kunmap_atomic(t);
 		}
 	} else if (clusterpages == 1)
-- 
2.7.4

