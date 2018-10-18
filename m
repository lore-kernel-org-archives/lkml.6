Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7665ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D15521473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuOjgRQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D15521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeJRTlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:41:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39848 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbeJRTlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:41:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so33302906wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DX9Z10y+MqVtztFYbqbltGdZG0jqEplcAH3iRiSXDOg=;
        b=EuOjgRQ77XXk6v5xHL+fbgv83enDD/ZOcjCbZGTGR6Qoj1Nd2YeMxKTcPFZNkfXvxp
         w08np4r8JTq24b0IZ8edj99Gr/Dx/YXRBTFB4dxzbzdBKCkatDPa3xaqVkB2uwk0Wznw
         q9siEwsQlFbK/bc1NEFUbd/SKQ9lS6vfhi3Yx9K0tZIWPeeFhomuP2ZeUos08CcRNTZ8
         h6jD6675M/76z0wBi1Yg6IrNpRGqUxgF4f1iNvHkFLeLoUP8SvBSZdzItUBNR1kpp0Wd
         4e+xcE72a3xBiCVaeOFXtPq06B6xx9Gx6Ual6amcjIS12jyT3HKjBIHCCk9C48rMpeQl
         TIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DX9Z10y+MqVtztFYbqbltGdZG0jqEplcAH3iRiSXDOg=;
        b=GwOCL1ofO6TLlzNYIMzqCwXUKtSuHVBaHPUKY3L8E4TqJKuvx1dUm3Kd2foTySkg/m
         Hd93le0xq+dvj9vCVP3YRzGKP7FyfzPlRr0eeKIr11+kuqXEemPtDtamRnbNhsLv/wQD
         ImBE+TV8m0uTFhuA7f2CPcShPwpCzrYOJnG77D7J8oA3REfgJ7IzgCRXVp26mdkFdLbi
         GpU+SF9rzebBXoR/IY+URsWUyBmUhSrtA2yZqz5x3b3DuuBUx/2zrBX/lnKPHLVPqs85
         DfqU+DtjVfCvHZLXv+aw3dlAPA0kxxoe+H3cK1wkpzj4Lxtm/3o1Uhq0pkTY4EAOSlsG
         YeBw==
X-Gm-Message-State: ABuFfohr/0fvQGI07nnapVthSYT9HGry4KGWoGu9dXeBuqjP6ZuBPUJc
        RjNNIboP+Phq7ccLnZp5sIgjiG2InlU=
X-Google-Smtp-Source: ACcGV60vfTp3LKljjw0zLp84bb+qkiAqyYxlkZMNX7H+prTneFTPK/7EWDo1pwNjs3qrGzyxiLi39w==
X-Received: by 2002:adf:e681:: with SMTP id r1-v6mr14504411wrm.294.1539862863872;
        Thu, 18 Oct 2018 04:41:03 -0700 (PDT)
Received: from gmail.com ([148.252.241.226])
        by smtp.gmail.com with ESMTPSA id z185-v6sm8076560wmz.47.2018.10.18.04.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 04:41:03 -0700 (PDT)
Date:   Thu, 18 Oct 2018 12:41:01 +0100
From:   Jeeeun Evans <jeeeunevans@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ks7010: remove unnecessary blank line
Message-ID: <20181018114059.uqty7gz73ti7qgzq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup extra line found by checkpatch.pl

Signed-off-by: Jeeeun Evans <jeeeunevans@gmail.com>
---
 drivers/staging/ks7010/michael_mic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/ks7010/michael_mic.c b/drivers/staging/ks7010/michael_mic.c
index e6bd70846e98..3acd79615f98 100644
--- a/drivers/staging/ks7010/michael_mic.c
+++ b/drivers/staging/ks7010/michael_mic.c
@@ -11,7 +11,6 @@
 #include <linux/string.h>
 #include "michael_mic.h"
 
-
 // Reset the state to the empty message.
 static inline void michael_clear(struct michael_mic *mic)
 {
-- 
2.11.0

